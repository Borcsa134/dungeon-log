local UI = {}
DungeonLog.modules.UI = UI

local logFrame

local ROW_HEIGHT = 28
local SECTION_HEIGHT = 24
local LOOT_ROW_HEIGHT = 26
local TILE_W = 150
local TILE_H = 72
local TILE_PAD = 10

function UI:Initialize()
    self:CreateUI()
end

function UI:CreateUI()
    logFrame = CreateFrame("Frame", "DungeonLogFrame", UIParent, "PortraitFrameTemplate")
    logFrame:SetSize(680, 500)
    logFrame:SetPoint("CENTER")
    logFrame:SetMovable(true)
    logFrame:EnableMouse(true)
    logFrame:RegisterForDrag("LeftButton")
    logFrame:SetScript("OnDragStart", logFrame.StartMoving)
    logFrame:SetScript("OnDragStop", logFrame.StopMovingOrSizing)
    logFrame:SetToplevel(true)
    logFrame:Hide()

    if logFrame.PortraitContainer.portrait then
        logFrame.PortraitContainer.portrait:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    end

    logFrame.title = logFrame.TitleContainer:CreateFontString(nil, "OVERLAY")
    logFrame.title:SetFontObject("GameFontNormal")
    logFrame.title:SetPoint("TOP", 0, -6)
    logFrame.title:SetText("Dungeon Log")
    logFrame.title:SetTextColor(1, 0.82, 0)

    logFrame.CloseButton:SetScript("OnClick", function()
        logFrame:Hide()
    end)

    logFrame.backButton = CreateFrame("Button", nil, logFrame, "UIPanelButtonTemplate")
    logFrame.backButton:SetSize(70, 22)
    logFrame.backButton:SetPoint("TOPRIGHT", logFrame, "TOPRIGHT", -56, -32)
    logFrame.backButton:SetText("Back")
    logFrame.backButton:Hide()

    logFrame.header = logFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    logFrame.header:SetPoint("TOPLEFT", logFrame, "TOPLEFT", 94, -34)
    logFrame.header:SetTextColor(1, 0.82, 0)
    logFrame.header:SetJustifyH("LEFT")

    logFrame.subtitle = logFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    logFrame.subtitle:SetPoint("TOPLEFT", logFrame, "TOPLEFT", 94, -54)
    logFrame.subtitle:SetTextColor(0.7, 0.7, 0.7)
    logFrame.subtitle:SetJustifyH("LEFT")

    local scroll = CreateFrame("ScrollFrame", "DungeonLogScroll", logFrame, "UIPanelScrollFrameTemplate")
    scroll:SetPoint("TOPLEFT", logFrame, "TOPLEFT", 14, -72)
    scroll:SetPoint("BOTTOMRIGHT", logFrame, "BOTTOMRIGHT", -32, 12)
    logFrame.scroll = scroll

    local content = CreateFrame("Frame", nil, scroll)
    content:SetSize(1, 1)
    scroll:SetScrollChild(content)
    logFrame.content = content

    logFrame.tilePool = {}
    logFrame.bossPool = {}
    logFrame.lootPool = {}

    logFrame.view = "grid"
    logFrame.gridTab = "dungeons"
    logFrame.selectedCatalogKey = nil
    logFrame.selectedEncounterID = nil

    self:CreateTabs()
end

function UI:CreateTabs()
    local function makeTab(id, text)
        local tab = CreateFrame("Button", "DungeonLogFrameTab" .. id, logFrame, "PanelTabButtonTemplate")
        tab:SetID(id)
        tab:SetText(text)
        if PanelTemplates_TabResize then PanelTemplates_TabResize(tab, 0) end
        tab:SetScript("OnClick", function(self)
            logFrame.gridTab = (self:GetID() == 1) and "dungeons" or "raids"
            logFrame.view = "grid"
            logFrame.selectedCatalogKey = nil
            logFrame.selectedEncounterID = nil
            UI:Refresh()
        end)
        return tab
    end

    logFrame.tabs = {
        makeTab(1, "Dungeons"),
        makeTab(2, "Raids"),
    }
    logFrame.numTabs = 2
    logFrame.tabs[1]:SetPoint("TOPLEFT", logFrame, "BOTTOMLEFT", 10, 2)
    logFrame.tabs[2]:SetPoint("LEFT", logFrame.tabs[1], "RIGHT", 4, 0)
end

function UI:UpdateTabs()
    if not logFrame.tabs then return end
    local active = (logFrame.gridTab == "raids") and 2 or 1
    if PanelTemplates_SetTab then
        PanelTemplates_SetTab(logFrame, active)
        return
    end
    for id, tab in ipairs(logFrame.tabs) do
        if id == active then tab:Disable() else tab:Enable() end
    end
end

function UI:SetTabsShown(shown)
    if not logFrame.tabs then return end
    for _, tab in ipairs(logFrame.tabs) do
        if shown then tab:Show() else tab:Hide() end
    end
end

function UI:ShowUI()
    if logFrame then
        self:Refresh()
        logFrame:Show()
    end
end

function UI:RefreshIfShown()
    if logFrame and logFrame:IsShown() then
        self:Refresh()
    end
end

function UI:ClearSelection()
    if logFrame then
        logFrame.view = "grid"
        logFrame.gridTab = "dungeons"
        logFrame.selectedCatalogKey = nil
        logFrame.selectedEncounterID = nil
    end
end

local function hideFrom(pool, startIndex)
    for i = startIndex, #pool do
        if pool[i] then pool[i]:Hide() end
    end
end

local function acquireRow(pool, parent, index, height)
    local row = pool[index]
    if not row then
        row = CreateFrame("Button", nil, parent)
        row:SetHeight(height)

        row.bg = row:CreateTexture(nil, "BACKGROUND")
        row.bg:SetAllPoints()

        row.highlight = row:CreateTexture(nil, "HIGHLIGHT")
        row.highlight:SetAllPoints()
        row.highlight:SetColorTexture(1, 1, 1, 0.08)

        row.icon = row:CreateTexture(nil, "ARTWORK")
        row.icon:SetSize(height - 8, height - 8)
        row.icon:SetPoint("LEFT", row, "LEFT", 4, 0)

        row.label = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
        row.label:SetJustifyH("LEFT")

        row.right = row:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        row.right:SetPoint("RIGHT", row, "RIGHT", -6, 0)
        row.right:SetJustifyH("RIGHT")

        pool[index] = row
    end
    row:SetParent(parent)
    row:SetHeight(height)
    row:SetScript("OnEnter", nil)
    row:SetScript("OnLeave", nil)
    row:SetScript("OnClick", nil)
    row:RegisterForClicks("LeftButtonUp")
    row.icon:SetSize(height - 8, height - 8)
    row.icon:SetDesaturated(false)
    row.icon:SetVertexColor(1, 1, 1)
    row.icon:Show()
    row.label:ClearAllPoints()
    row.label:SetPoint("LEFT", row.icon, "RIGHT", 6, 0)
    row:Show()
    return row
end

local function acquireTile(pool, parent, index)
    local tile = pool[index]
    if not tile then
        tile = CreateFrame("Button", nil, parent)
        tile:SetSize(TILE_W, TILE_H)

        tile.bg = tile:CreateTexture(nil, "BACKGROUND")
        tile.bg:SetAllPoints()

        tile.highlight = tile:CreateTexture(nil, "HIGHLIGHT")
        tile.highlight:SetAllPoints()
        tile.highlight:SetColorTexture(1, 1, 1, 0.1)

        tile.icon = tile:CreateTexture(nil, "ARTWORK")
        tile.icon:SetSize(40, 40)
        tile.icon:SetPoint("TOP", tile, "TOP", 0, -6)

        tile.title = tile:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        tile.title:SetPoint("TOP", tile.icon, "BOTTOM", 0, -4)
        tile.title:SetWidth(TILE_W - 8)
        tile.title:SetJustifyH("CENTER")

        tile.sub = tile:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
        tile.sub:SetPoint("TOP", tile.title, "BOTTOM", 0, -2)
        tile.sub:SetWidth(TILE_W - 8)
        tile.sub:SetJustifyH("CENTER")

        pool[index] = tile
    end
    tile:SetParent(parent)
    tile:SetScript("OnEnter", nil)
    tile:SetScript("OnLeave", nil)
    tile:SetScript("OnClick", nil)
    tile:RegisterForClicks("LeftButtonUp")
    tile.icon:SetDesaturated(false)
    tile.icon:SetVertexColor(1, 1, 1)
    tile:Show()
    return tile
end

function UI:Refresh()
    self:SetTabsShown(true)
    self:UpdateTabs()
    local view = logFrame.view
    if view == "dungeon" then
        hideFrom(logFrame.tilePool, 1)
        hideFrom(logFrame.lootPool, 1)
        logFrame.backButton:Show()
        logFrame.backButton:SetScript("OnClick", function()
            logFrame.view = "grid"
            logFrame.selectedCatalogKey = nil
            logFrame.selectedEncounterID = nil
            UI:Refresh()
        end)
        self:RefreshDungeonPage()
    elseif view == "loot" then
        hideFrom(logFrame.tilePool, 1)
        hideFrom(logFrame.bossPool, 1)
        logFrame.backButton:Show()
        logFrame.backButton:SetScript("OnClick", function()
            logFrame.view = "dungeon"
            logFrame.selectedEncounterID = nil
            UI:Refresh()
        end)
        self:RefreshLootPage()
    else
        hideFrom(logFrame.bossPool, 1)
        hideFrom(logFrame.lootPool, 1)
        logFrame.backButton:Hide()
        self:RefreshGrid()
    end
end

function UI:RefreshGrid()
    local isRaid = (logFrame.gridTab == "raids")
    if isRaid then
        logFrame.header:SetText("Raids")
        logFrame.subtitle:SetText("All raids, by level")
    else
        logFrame.header:SetText("Dungeons")
        logFrame.subtitle:SetText("All dungeons, by level")
    end

    local content = logFrame.content
    local entries = DungeonLog.modules.Catalog:GetEntriesByKind(isRaid)

    local contentW = logFrame.scroll:GetWidth()
    if not contentW or contentW < TILE_W then
        contentW = 634
    end
    local columns = math.max(1, math.floor((contentW + TILE_PAD) / (TILE_W + TILE_PAD)))

    for i, entry in ipairs(entries) do
        local tile = acquireTile(logFrame.tilePool, content, i)
        local col = (i - 1) % columns
        local row = math.floor((i - 1) / columns)
        tile:SetPoint("TOPLEFT", content, "TOPLEFT", col * (TILE_W + TILE_PAD), -(row * (TILE_H + TILE_PAD)))

        local liveKey = DungeonLog.modules.Catalog:GetLiveDBKey(entry)
        local discovered = DungeonLogDB.dungeons[liveKey] ~= nil

        tile.icon:SetTexture(entry.icon)
        local levelText = string.format("Levels %d-%d", entry.minLevel, entry.maxLevel)
        if entry.isRaid then
            levelText = levelText .. " (Raid)"
        end
        tile.sub:SetText(levelText)

        if discovered then
            tile.title:SetText(entry.name)
            tile.title:SetTextColor(1, 0.82, 0)
            tile.sub:SetTextColor(0.6, 0.6, 0.6)
            tile.bg:SetColorTexture(1, 1, 1, 0.05)
            tile.highlight:SetColorTexture(1, 1, 1, 0.1)
            local key = entry.name
            tile:SetScript("OnClick", function()
                logFrame.view = "dungeon"
                logFrame.selectedCatalogKey = key
                logFrame.selectedEncounterID = nil
                UI:Refresh()
            end)
        else
            tile.title:SetText("Undiscovered")
            tile.title:SetTextColor(0.5, 0.5, 0.5)
            tile.sub:SetTextColor(0.4, 0.4, 0.4)
            tile.bg:SetColorTexture(0, 0, 0, 0.25)
            tile.highlight:SetColorTexture(0, 0, 0, 0)
            tile.icon:SetDesaturated(true)
            tile.icon:SetVertexColor(0.4, 0.4, 0.4)
        end
    end

    hideFrom(logFrame.tilePool, #entries + 1)
    local rows = math.ceil(#entries / columns)
    content:SetHeight(math.max(rows * (TILE_H + TILE_PAD), 1))
end

function UI:RefreshDungeonPage()
    local content = logFrame.content
    local entry = DungeonLog.modules.Catalog:GetEntryByKey(logFrame.selectedCatalogKey)
    if not entry then
        hideFrom(logFrame.bossPool, 1)
        return
    end

    logFrame.header:SetText(entry.name)
    local levelText = string.format("Levels %d-%d", entry.minLevel, entry.maxLevel)
    if entry.isRaid then
        levelText = levelText .. " (Raid)"
    end
    logFrame.subtitle:SetText(levelText)

    local liveKey = DungeonLog.modules.Catalog:GetLiveDBKey(entry)
    local width = logFrame.scroll:GetWidth() - 8

    local index = 0
    local y = 0

    local function addSectionHeader(wing)
        index = index + 1
        local row = acquireRow(logFrame.bossPool, content, index, SECTION_HEIGHT)
        row:SetWidth(width)
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 4, -y)
        row.icon:SetTexture(nil)
        row.icon:Hide()
        row.label:ClearAllPoints()
        row.label:SetPoint("LEFT", row, "LEFT", 8, 0)
        row.label:SetText(string.format("%s (%d-%d)", wing.name, wing.minLevel, wing.maxLevel))
        row.label:SetTextColor(1, 0.82, 0)
        row.right:SetText("")
        row.bg:SetColorTexture(0, 0, 0, 0.35)
        y = y + SECTION_HEIGHT
    end

    local function addBossRow(bossDef)
        index = index + 1
        local row = acquireRow(logFrame.bossPool, content, index, ROW_HEIGHT)
        row:SetWidth(width)
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 4, -y)

        local dungeon = DungeonLogDB.dungeons[liveKey]
        local liveBoss = (dungeon and bossDef.encounterID) and dungeon.bosses[bossDef.encounterID] or nil
        if liveBoss and liveBoss.discovered then
            row.icon:SetTexture(liveBoss.killed and "Interface\\Icons\\Ability_Warrior_Challange"
                or "Interface\\Icons\\Spell_Shadow_SummonImp")
            row.label:SetText(liveBoss.name or bossDef.name)
            if liveBoss.killed then
                row.label:SetTextColor(1, 1, 1)
                row.right:SetText(string.format("%d kills", liveBoss.killCount or 0))
                row.right:SetTextColor(0.6, 0.9, 0.6)
            else
                row.label:SetTextColor(0.7, 0.7, 0.7)
                row.right:SetText("not slain")
                row.right:SetTextColor(0.7, 0.5, 0.5)
            end
            local encID = bossDef.encounterID
            row:SetScript("OnClick", function()
                logFrame.view = "loot"
                logFrame.selectedEncounterID = encID
                UI:Refresh()
            end)
        else
            row.icon:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
            row.icon:SetDesaturated(true)
            row.icon:SetVertexColor(0.5, 0.5, 0.5)
            row.label:SetText("Undiscovered Boss")
            row.label:SetTextColor(0.5, 0.5, 0.5)
            row.right:SetText("")
        end

        if index % 2 == 0 then
            row.bg:SetColorTexture(1, 1, 1, 0.04)
        else
            row.bg:SetColorTexture(0, 0, 0, 0)
        end

        y = y + ROW_HEIGHT
    end

    if entry.wings then
        for _, wing in ipairs(entry.wings) do
            addSectionHeader(wing)
            for _, bossDef in ipairs(wing.bosses) do
                addBossRow(bossDef)
            end
        end
    else
        for _, bossDef in ipairs(entry.bosses) do
            addBossRow(bossDef)
        end
    end

    hideFrom(logFrame.bossPool, index + 1)
    content:SetHeight(math.max(y, 1))
end

function UI:RefreshLootPage()
    local content = logFrame.content
    local entry = DungeonLog.modules.Catalog:GetEntryByKey(logFrame.selectedCatalogKey)
    if not entry then
        hideFrom(logFrame.lootPool, 1)
        return
    end

    local liveKey = DungeonLog.modules.Catalog:GetLiveDBKey(entry)
    local dungeon = DungeonLogDB.dungeons[liveKey]
    local boss = (dungeon and logFrame.selectedEncounterID) and dungeon.bosses[logFrame.selectedEncounterID] or nil

    local bossLabel = (boss and boss.name) or "Encounter"
    logFrame.header:SetText(entry.name .. " - " .. bossLabel)
    local killCount = (boss and boss.killCount) or 0
    logFrame.subtitle:SetText(string.format("%d kill%s", killCount, killCount == 1 and "" or "s"))

    local width = logFrame.scroll:GetWidth() - 8
    local y = 0

    if not boss or not boss.loot or next(boss.loot) == nil then
        local row = acquireRow(logFrame.lootPool, content, 1, ROW_HEIGHT)
        row:SetWidth(width)
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 4, -y)
        row.icon:SetTexture(nil)
        row.label:SetText(killCount > 0 and "No loot recorded yet." or "Not slain yet \226\128\148 no loot.")
        row.label:SetTextColor(0.6, 0.6, 0.6)
        row.right:SetText("")
        row.bg:SetColorTexture(0, 0, 0, 0)
        hideFrom(logFrame.lootPool, 2)
        content:SetHeight(ROW_HEIGHT)
        return
    end

    local items = {}
    for id, item in pairs(boss.loot) do
        items[#items + 1] = { id = id, item = item }
    end
    table.sort(items, function(a, b)
        local ra = killCount > 0 and (a.item.seen / killCount) or 0
        local rb = killCount > 0 and (b.item.seen / killCount) or 0
        if ra ~= rb then return ra > rb end
        return (a.item.name or "") < (b.item.name or "")
    end)

    local rowIndex = 0
    for _, entry2 in ipairs(items) do
        local item = entry2.item
        rowIndex = rowIndex + 1
        local row = acquireRow(logFrame.lootPool, content, rowIndex, LOOT_ROW_HEIGHT)
        row:SetWidth(width)
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 4, -y)

        row.icon:SetTexture(item.icon or "Interface\\Icons\\INV_Misc_QuestionMark")
        row.label:SetText(item.name or "(loading...)")

        local q = item.quality
        local color = q and ITEM_QUALITY_COLORS and ITEM_QUALITY_COLORS[q]
        if color then
            row.label:SetTextColor(color.r, color.g, color.b)
        else
            row.label:SetTextColor(1, 1, 1)
        end

        local rate = killCount > 0 and (item.seen / killCount * 100) or 0
        row.right:SetText(string.format("%d/%d \226\128\148 %.0f%%", item.seen or 0, killCount, rate))
        row.right:SetTextColor(0.8, 0.8, 0.8)

        row.bg:SetColorTexture(0, 0, 0, 0)

        local link = item.link
        row:SetScript("OnEnter", function(self)
            if link then
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(link)
                GameTooltip:Show()
            end
        end)
        row:SetScript("OnLeave", function()
            GameTooltip:Hide()
        end)
        row:RegisterForClicks("AnyUp")
        row:SetScript("OnClick", function()
            if link then
                HandleModifiedItemClick(link)
            end
        end)

        y = y + LOOT_ROW_HEIGHT
    end

    hideFrom(logFrame.lootPool, rowIndex + 1)
    content:SetHeight(math.max(y, 1))
end
