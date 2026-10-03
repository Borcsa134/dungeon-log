local Log = {}
DungeonLog.modules.Log = Log

-- DungeonLogDB.dungeons schema:
-- {
--   ["Deadmines"] = {
--     discovered   = true,
--     firstEntered = <unix ts>,
--     bosses = {
--       [<encounterID>] = {               -- numeric key = authoritative
--         name       = "Edwin VanCleef",  -- encounterName, for display
--         discovered = true,              -- true on first ENCOUNTER_END (kill OR wipe)
--         killed     = false,             -- true once success==1 at least once
--         killCount  = 3,                 -- increments only on success==1
--         firstKill  = <unix ts>,
--         loot = {
--           [<itemID>] = {
--             link    = "|cff...|Hitem:...|h[...]|h|r",
--             name    = "Cruel Barb",
--             quality = 3,
--             icon    = 135289,
--             seen    = 2,                 -- # of KILLS this item was observed in
--           },
--         },
--       },
--     },
--   },
-- }

local lootWindows = {}

local pendingItems = {}

local debugEnabled = false
local function dprint(...)
    if debugEnabled then
        print("|cff66ccffDungeonLog:|r", ...)
    end
end

local function getItemInfo(itemIDorLink)
    local fn = (C_Item and C_Item.GetItemInfo) or GetItemInfo
    if not fn then return nil end
    local name, link, quality, _, _, _, _, _, _, icon = fn(itemIDorLink)
    return name, link, quality, icon
end

local function normName(s)
    return (s or ""):gsub("^%s+", ""):gsub("%s+$", ""):lower()
end

function Log:Initialize()
    debugEnabled = DungeonLog.modules.Config and DungeonLog.modules.Config:GetSetting("debug") or false
    self:RegisterEvents()
end

function Log:SetDebug(enabled)
    debugEnabled = enabled and true or false
end

function Log:RegisterEvents()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    frame:RegisterEvent("ENCOUNTER_END")
    frame:RegisterEvent("ENCOUNTER_LOOT_RECEIVED")
    frame:RegisterEvent("GET_ITEM_INFO_RECEIVED")
    frame:SetScript("OnEvent", function(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            Log:OnEnterWorld()
        elseif event == "ENCOUNTER_END" then
            Log:OnEncounterEnd(...)
        elseif event == "ENCOUNTER_LOOT_RECEIVED" then
            Log:OnEncounterLoot(...)
        elseif event == "GET_ITEM_INFO_RECEIVED" then
            Log:OnItemInfoReceived(...)
        end
    end)
end

function Log:GetCurrentDungeonName()
    local inInstance, instanceType = IsInInstance()
    if not inInstance then return nil end
    if instanceType ~= "party" and instanceType ~= "raid" then return nil end
    local name = GetInstanceInfo()
    return name
end

function Log:OnEnterWorld()
    local name = self:GetCurrentDungeonName()
    if name and not DungeonLogDB.dungeons[name] then
        DungeonLogDB.dungeons[name] = {
            discovered = true,
            firstEntered = time(),
            bosses = {},
        }
        DungeonLog.modules.UI:RefreshIfShown()
    end
end

function Log:EnsureBoss(encounterID, encounterName)
    local dungeonName = self:GetCurrentDungeonName()
    if not dungeonName then return nil end

    local dungeon = DungeonLogDB.dungeons[dungeonName]
    if not dungeon then
        dungeon = { discovered = true, firstEntered = time(), bosses = {} }
        DungeonLogDB.dungeons[dungeonName] = dungeon
    end

    local boss = dungeon.bosses[encounterID]
    if not boss then
        boss = {
            name = encounterName,
            discovered = true,
            killed = false,
            killCount = 0,
            loot = {},
        }
        dungeon.bosses[encounterID] = boss
    end
    if encounterName and encounterName ~= "" then
        boss.name = encounterName
    end
    return boss
end

function Log:OnEncounterEnd(encounterID, encounterName, difficultyID, groupSize, success)
    dprint("ENCOUNTER_END", encounterID, encounterName, "success="..tostring(success))

    local boss = self:EnsureBoss(encounterID, encounterName)
    if not boss then return end

    boss.discovered = true

    if success == 1 then
        boss.killCount = (boss.killCount or 0) + 1
        boss.killed = true
        boss.firstKill = boss.firstKill or time()
        lootWindows[encounterID] = {}
    end

    DungeonLog.modules.UI:RefreshIfShown()
end

function Log:OnEncounterLoot(encounterID, itemID, itemLink, quantity, playerName, classFileName)
    dprint("ENCOUNTER_LOOT_RECEIVED", encounterID, itemID, itemLink, playerName)
    if not itemID then return end

    local boss = self:EnsureBoss(encounterID, nil)
    if not boss then return end

    self:RecordLoot(boss, encounterID, itemID, itemLink)

    DungeonLog.modules.UI:RefreshIfShown()
end

function Log:RecordLoot(boss, encounterID, itemID, itemLink)
    local item = boss.loot[itemID]
    if not item then
        item = { link = itemLink, seen = 0 }
        boss.loot[itemID] = item
    elseif itemLink then
        item.link = itemLink
    end

    local name, _, quality, icon = getItemInfo(itemLink or itemID)
    if name then
        item.name = name
        item.quality = quality
        item.icon = icon
        pendingItems[itemID] = nil
    else
        if itemLink and not item.name then
            item.name = itemLink:match("%[(.-)%]")
        end
        pendingItems[itemID] = true
    end

    local window = lootWindows[encounterID]
    if not window then
        window = {}
        lootWindows[encounterID] = window
    end
    if not window[itemID] then
        window[itemID] = true
        item.seen = (item.seen or 0) + 1
    end
end

function Log:OnItemInfoReceived(itemID, success)
    if success == false then return end

    local name, _, quality, icon = getItemInfo(itemID)
    if not name then return end

    for _, dungeon in pairs(DungeonLogDB.dungeons) do
        for _, boss in pairs(dungeon.bosses) do
            local item = boss.loot[itemID]
            if item then
                item.name = name
                item.quality = quality
                item.icon = icon
            end
        end
    end
    pendingItems[itemID] = nil

    DungeonLog.modules.UI:RefreshIfShown()
end

function Log:GetDropRate(boss, itemID)
    local item = boss.loot[itemID]
    if not item then return 0 end
    return boss.killCount and boss.killCount > 0 and (item.seen / boss.killCount * 100) or 0
end

function Log:NormalizeName(s)
    return normName(s)
end

function Log:FindBossByName(liveDBKey, bossName)
    local dungeon = liveDBKey and DungeonLogDB.dungeons[liveDBKey]
    if not dungeon then return nil, nil end
    local target = normName(bossName)
    for id, boss in pairs(dungeon.bosses) do
        if normName(boss.name) == target then
            return boss, id
        end
    end
    return nil, nil
end

function Log:ResetAll()
    DungeonLogDB.dungeons = {}
    wipe(lootWindows)
    wipe(pendingItems)
    DungeonLog.modules.UI:ClearSelection()
    DungeonLog.modules.UI:RefreshIfShown()
end
