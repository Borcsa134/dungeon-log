local Debug = {}
DungeonLog.modules.Debug = Debug

local function getItemInfo(itemIDorLink)
    local fn = (C_Item and C_Item.GetItemInfo) or GetItemInfo
    if not fn then return nil end
    local name, link, quality, _, _, _, _, _, _, icon = fn(itemIDorLink)
    return name, link, quality, icon
end

local function requestItemLoad(itemID)
    if C_Item and C_Item.RequestLoadItemDataByID then
        C_Item.RequestLoadItemDataByID(itemID)
    end
end

local DUMMY_DUNGEONS = {
    ["The Deadmines"] = {
        bosses = {
            [63] = { name = "Rhahk'Zor", killCount = 8, loot = {
                [1931] = 5,
                [4942] = 2,
            } },
            [64] = { name = "Sneed's Shredder", killCount = 0, loot = {} },
            [66] = { name = "Mr. Smite", killCount = 6, loot = {
                [7005] = 6,
                [871]  = 1,
                [1986] = 3,
            } },
            [71] = { name = "Edwin VanCleef", killCount = 4, loot = {
                [1951] = 4,
                [2277] = 2,
                [2278] = 1,
            } },
        },
    },
    ["Scarlet Monastery"] = {
        bosses = {
            [161] = { name = "Arcanist Doan", killCount = 3, loot = {
                [10758] = 2,
            } },
            [166] = { name = "Herod", killCount = 2, loot = {
                [6625] = 1,
                [10410] = 2,
            } },
        },
    },
}

function Debug:Initialize()
end

function Debug:ToggleDebug()
    local Config = DungeonLog.modules.Config
    local enabled = not Config:GetSetting("debug")
    Config:SetSetting("debug", enabled)
    DungeonLog.modules.Log:SetDebug(enabled)
    print("|cff66ccffDungeonLog:|r debug logging " .. (enabled and "ON" or "OFF"))
end

function Debug:ToggleDummyData()
    if self:HasDummyData() then
        self:ClearDummyData()
        print("|cff66ccffDungeonLog:|r dummy data cleared")
    else
        self:LoadDummyData()
        DungeonLog.modules.UI:ShowUI()
        print("|cff66ccffDungeonLog:|r dummy data loaded (run /dl dummy again to clear)")
    end
end

function Debug:LoadDummyData()
    for dungeonName, data in pairs(DUMMY_DUNGEONS) do
        local dungeon = {
            discovered = true,
            firstEntered = time(),
            dummy = true,
            bosses = {},
        }
        for encounterID, b in pairs(data.bosses) do
            local boss = {
                name = b.name,
                discovered = true,
                killed = (b.killCount or 0) > 0,
                killCount = b.killCount or 0,
                firstKill = time(),
                loot = {},
            }
            for itemID, seen in pairs(b.loot) do
                local name, link, quality, icon = getItemInfo(itemID)
                boss.loot[itemID] = {
                    link = link or ("item:" .. itemID),
                    name = name or ("Item " .. itemID),
                    quality = quality,
                    icon = icon,
                    seen = seen,
                }
                if not name then
                    requestItemLoad(itemID)
                end
            end
            dungeon.bosses[encounterID] = boss
        end
        DungeonLogDB.dungeons[dungeonName] = dungeon
    end
    DungeonLog.modules.UI:RefreshIfShown()
end

function Debug:ClearDummyData()
    for name, dungeon in pairs(DungeonLogDB.dungeons) do
        if dungeon.dummy then
            DungeonLogDB.dungeons[name] = nil
        end
    end
    DungeonLog.modules.UI:ClearSelection()
    DungeonLog.modules.UI:RefreshIfShown()
end

function Debug:HasDummyData()
    for _, dungeon in pairs(DungeonLogDB.dungeons) do
        if dungeon.dummy then return true end
    end
    return false
end

function Debug:FindEntryByFuzzyName(query)
    local Catalog = DungeonLog.modules.Catalog
    local Log = DungeonLog.modules.Log
    local q = Log:NormalizeName(query)
    if q == "" then return nil end
    local exact
    local partials = {}
    for i = 1, #Catalog.entries do
        local entry = Catalog.entries[i]
        local n = Log:NormalizeName(entry.name)
        if n == q then
            exact = entry
            break
        elseif n:find(q, 1, true) then
            partials[#partials + 1] = entry
        end
    end
    if exact then return exact end
    if #partials == 1 then return partials[1] end
    return nil, partials
end

function Debug:Unlock(entry)
    local Catalog = DungeonLog.modules.Catalog
    local Log = DungeonLog.modules.Log
    local liveKey = Catalog:GetLiveDBKey(entry)
    local dungeon = DungeonLogDB.dungeons[liveKey]
    if not dungeon then
        dungeon = { discovered = true, firstEntered = time(), bosses = {} }
        DungeonLogDB.dungeons[liveKey] = dungeon
    end
    dungeon.discovered = true
    for _, boss in ipairs(entry.bosses) do
        if not Log:FindBossByName(liveKey, boss.name) then
            dungeon.bosses["name:" .. Log:NormalizeName(boss.name)] = {
                name = boss.name,
                discovered = true,
                killed = false,
                killCount = 0,
                loot = {},
            }
        end
    end
end

function Debug:UnlockByName(query)
    if query == "" then
        print("|cff66ccffDungeonLog:|r usage: /dl unlock <dungeon or raid name>")
        return
    end
    local entry, partials = self:FindEntryByFuzzyName(query)
    if entry then
        self:Unlock(entry)
        DungeonLog.modules.UI:ClearSelection()
        DungeonLog.modules.UI:ShowUI()
        print("|cff66ccffDungeonLog:|r unlocked " .. entry.name)
    elseif partials and #partials > 1 then
        print("|cff66ccffDungeonLog:|r multiple matches for '" .. query .. "':")
        for _, e in ipairs(partials) do
            print("  - " .. e.name)
        end
    else
        print("|cff66ccffDungeonLog:|r no dungeon or raid matching '" .. query .. "'")
    end
end
