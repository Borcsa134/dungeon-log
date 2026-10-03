local UI = {}
DungeonLog.modules.UI = UI

local logFrame

local LEFT_WIDTH = 190
local ROW_HEIGHT = 28
local LOOT_ROW_HEIGHT = 26

function UI:Initialize()
    self:CreateUI()
end

function UI:CreateUI()
    logFrame = CreateFrame("Frame", "DungeonLogFrame", UIParent, "PortraitFrameTemplate")
    logFrame:SetSize(600, 400)
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

    local leftScroll = CreateFrame("ScrollFrame", "DungeonLogLeftScroll", logFrame, "UIPanelScrollFrameTemplate")
    leftScroll:SetPoint("TOPLEFT", logFrame, "TOPLEFT", 14, -64)
    leftScroll:SetPoint("BOTTOMLEFT", logFrame, "BOTTOMLEFT", 14, 10)
    leftScroll:SetWidth(LEFT_WIDTH)
    logFrame.leftScroll = leftScroll

    local leftContent = CreateFrame("Frame", nil, leftScroll)
    leftContent:SetSize(LEFT_WIDTH, 1)
    leftScroll:SetScrollChild(leftContent)
    logFrame.leftContent = leftContent

    local divider = logFrame:CreateTexture(nil, "ARTWORK")
    divider:SetColorTexture(1, 1, 1, 0.12)
    divider:SetWidth(1)
    divider:SetPoint("TOPLEFT", leftScroll, "TOPRIGHT", 14, 0)
    divider:SetPoint("BOTTOMLEFT", leftScroll, "BOTTOMRIGHT", 14, 0)

    local rightScroll = CreateFrame("ScrollFrame", "DungeonLogRightScroll", logFrame, "UIPanelScrollFrameTemplate")
    rightScroll:SetPoint("TOPLEFT", leftScroll, "TOPRIGHT", 24, 0)
    rightScroll:SetPoint("BOTTOMRIGHT", logFrame, "BOTTOMRIGHT", -30, 10)
    logFrame.rightScroll = rightScroll

    logFrame.emptyLabel = logFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    logFrame.emptyLabel:SetPoint("CENTER", rightScroll, "CENTER")
    logFrame.emptyLabel:SetText("No dungeons discovered yet.\nExplore Azeroth to begin your journey.")
    logFrame.emptyLabel:SetTextColor(0.6, 0.6, 0.6)
    logFrame.emptyLabel:SetJustifyH("CENTER")

    local rightContent = CreateFrame("Frame", nil, rightScroll)
    rightContent:SetSize(rightScroll:GetWidth(), 1)
    rightScroll:SetScrollChild(rightContent)
    logFrame.rightContent = rightContent

    logFrame.detailHeader = rightContent:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    logFrame.detailHeader:SetPoint("TOPLEFT", rightContent, "TOPLEFT", 4, -4)
    logFrame.detailHeader:SetTextColor(1, 0.82, 0)
    logFrame.detailHeader:SetJustifyH("LEFT")

    logFrame.detailLabel = rightContent:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    logFrame.detailLabel:SetPoint("TOPLEFT", rightContent, "TOPLEFT", 4, -34)
    logFrame.detailLabel:SetWidth(340)
    logFrame.detailLabel:SetTextColor(0.6, 0.6, 0.6)
    logFrame.detailLabel:SetJustifyH("LEFT")

    logFrame.dungeonRows = {}
    logFrame.detailRows = {}

    logFrame.selectedDungeon = nil
    logFrame.selectedBossID = nil
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
        logFrame.selectedDungeon = nil
        logFrame.selectedBossID = nil
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
    row:RegisterForClicks("LeftButtonUp")
    row.icon:SetSize(height - 8, height - 8)
    row:Show()
    return row
end

local function hideFrom(pool, startIndex)
    for i = startIndex, #pool do
        if pool[i] then pool[i]:Hide() end
    end
end

function UI:Refresh()
    local hasDungeons = next(DungeonLogDB.dungeons) ~= nil
    logFrame.emptyLabel:SetShown(not hasDungeons)
    logFrame.leftScroll:SetShown(hasDungeons)
    logFrame.rightScroll:SetShown(hasDungeons)

    if not hasDungeons then
        hideFrom(logFrame.dungeonRows, 1)
        hideFrom(logFrame.detailRows, 1)
        return
    end

    self:RefreshDungeonList()
    self:RefreshDetail()
end

function UI:RefreshDungeonList()
    local content = logFrame.leftContent
    local names = {}
    for name in pairs(DungeonLogDB.dungeons) do
        names[#names + 1] = name
    end
    table.sort(names)

    local y = 0
    for i, name in ipairs(names) do
        local row = acquireRow(logFrame.dungeonRows, content, i, ROW_HEIGHT)
        row:SetWidth(LEFT_WIDTH)
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 0, -y)

        row.icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
        row.label:SetText(name)
        row.label:SetTextColor(1, 0.82, 0)
        row.right:SetText("")

        if name == logFrame.selectedDungeon then
            row.bg:SetColorTexture(1, 0.82, 0, 0.18)
        elseif i % 2 == 0 then
            row.bg:SetColorTexture(1, 1, 1, 0.04)
        else
            row.bg:SetColorTexture(0, 0, 0, 0)
        end

        row:SetScript("OnClick", function()
            logFrame.selectedDungeon = name
            logFrame.selectedBossID = nil
            UI:Refresh()
        end)

        y = y + ROW_HEIGHT
    end

    hideFrom(logFrame.dungeonRows, #names + 1)
    content:SetHeight(math.max(y, 1))
end

function UI:RefreshDetail()
    local content = logFrame.rightContent
    local dungeonName = logFrame.selectedDungeon

    if not dungeonName then
        logFrame.detailHeader:SetText("")
        logFrame.detailLabel:SetText("Select a dungeon to view its bosses and loot.")
        logFrame.detailLabel:Show()
        hideFrom(logFrame.detailRows, 1)
        content:SetHeight(1)
        return
    end

    local dungeon = DungeonLogDB.dungeons[dungeonName]
    if logFrame.selectedBossID and dungeon and dungeon.bosses[logFrame.selectedBossID] then
        self:RefreshBossLoot(dungeon, dungeon.bosses[logFrame.selectedBossID])
    else
        self:RefreshBossList(dungeonName, dungeon)
    end
end

function UI:RefreshBossList(dungeonName, dungeon)
    local content = logFrame.rightContent
    logFrame.detailHeader:SetText(dungeonName)

    local bosses = {}
    for id, boss in pairs(dungeon.bosses) do
        bosses[#bosses + 1] = { id = id, boss = boss }
    end
    table.sort(bosses, function(a, b)
        return (a.boss.name or "") < (b.boss.name or "")
    end)

    if #bosses == 0 then
        logFrame.detailLabel:SetText("No bosses encountered here yet.")
        logFrame.detailLabel:Show()
        hideFrom(logFrame.detailRows, 1)
        content:SetHeight(60)
        return
    end
    logFrame.detailLabel:Hide()

    local y = 34
    for i, entry in ipairs(bosses) do
        local boss = entry.boss
        local row = acquireRow(logFrame.detailRows, content, i, ROW_HEIGHT)
        row:SetWidth(content:GetWidth() - 8)
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 4, -y)

        row.icon:SetTexture(boss.killed and "Interface\\Icons\\Ability_Warrior_Challange"
            or "Interface\\Icons\\Spell_Shadow_SummonImp")
        row.label:SetText(boss.name or ("Encounter " .. tostring(entry.id)))
        if boss.killed then
            row.label:SetTextColor(1, 1, 1)
            row.right:SetText(string.format("%d kills", boss.killCount or 0))
            row.right:SetTextColor(0.6, 0.9, 0.6)
        else
            row.label:SetTextColor(0.7, 0.7, 0.7)
            row.right:SetText("not slain")
            row.right:SetTextColor(0.7, 0.5, 0.5)
        end

        if i % 2 == 0 then
            row.bg:SetColorTexture(1, 1, 1, 0.04)
        else
            row.bg:SetColorTexture(0, 0, 0, 0)
        end

        local bossID = entry.id
        row:SetScript("OnClick", function()
            logFrame.selectedBossID = bossID
            UI:Refresh()
        end)

        y = y + ROW_HEIGHT
    end

    hideFrom(logFrame.detailRows, #bosses + 1)
    content:SetHeight(math.max(y, 1))
end

function UI:RefreshBossLoot(dungeon, boss)
    local content = logFrame.rightContent
    logFrame.detailHeader:SetText(boss.name or "Encounter")

    local killCount = boss.killCount or 0
    local header = string.format("%d kill%s", killCount, killCount == 1 and "" or "s")
    logFrame.detailLabel:SetText(header)
    logFrame.detailLabel:SetTextColor(0.8, 0.8, 0.8)
    logFrame.detailLabel:Show()

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

    local y = 58
    local rowIndex = 0

    rowIndex = rowIndex + 1
    local back = acquireRow(logFrame.detailRows, content, rowIndex, ROW_HEIGHT)
    back:SetWidth(content:GetWidth() - 8)
    back:SetPoint("TOPLEFT", content, "TOPLEFT", 4, -y)
    back.icon:SetTexture("Interface\\Buttons\\UI-RefreshButton")
    back.label:SetText("Back to bosses")
    back.label:SetTextColor(0.8, 0.8, 1)
    back.right:SetText("")
    back.bg:SetColorTexture(0, 0, 0, 0)
    back:SetScript("OnClick", function()
        logFrame.selectedBossID = nil
        UI:Refresh()
    end)
    y = y + ROW_HEIGHT

    if #items == 0 then
        rowIndex = rowIndex + 1
        local row = acquireRow(logFrame.detailRows, content, rowIndex, ROW_HEIGHT)
        row:SetWidth(content:GetWidth() - 8)
        row:SetPoint("TOPLEFT", content, "TOPLEFT", 4, -y)
        row.icon:SetTexture(nil)
        row.label:SetText(killCount > 0 and "No loot recorded yet." or "Not slain yet \226\128\148 no loot.")
        row.label:SetTextColor(0.6, 0.6, 0.6)
        row.right:SetText("")
        row.bg:SetColorTexture(0, 0, 0, 0)
        row:SetScript("OnClick", nil)
        y = y + ROW_HEIGHT
        hideFrom(logFrame.detailRows, rowIndex + 1)
        content:SetHeight(math.max(y, 1))
        return
    end

    for _, entry in ipairs(items) do
        local item = entry.item
        rowIndex = rowIndex + 1
        local row = acquireRow(logFrame.detailRows, content, rowIndex, LOOT_ROW_HEIGHT)
        row:SetWidth(content:GetWidth() - 8)
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

    hideFrom(logFrame.detailRows, rowIndex + 1)
    content:SetHeight(math.max(y, 1))
end
