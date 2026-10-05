local Config = {}
DungeonLog.modules.Config = Config

local configFrame
local minimapButton

function Config:Initialize()
    self:SetDefaults()
    self:CreateUI()
    self:CreateMinimapButton()
    self:RegisterSlashCommand()
end

function Config:SetDefaults()
end

function Config:GetSetting(key)
    return DungeonLogDB.settings[key]
end

function Config:SetSetting(key, value)
    DungeonLogDB.settings[key] = value
end

function Config:CreateUI()
    configFrame = CreateFrame("Frame", "DungeonLogConfigFrame", UIParent, "PortraitFrameTemplate")
    configFrame:SetSize(400, 200)
    configFrame:SetPoint("CENTER")
    configFrame:SetMovable(true)
    configFrame:EnableMouse(true)
    configFrame:RegisterForDrag("LeftButton")
    configFrame:SetScript("OnDragStart", configFrame.StartMoving)
    configFrame:SetScript("OnDragStop", configFrame.StopMovingOrSizing)
    configFrame:SetToplevel(true)
    configFrame:Hide()

    if configFrame.PortraitContainer.portrait then
        configFrame.PortraitContainer.portrait:SetTexture("Interface\\Icons\\INV_Misc_Map_01")
    end

    configFrame.title = configFrame.TitleContainer:CreateFontString(nil, "OVERLAY")
    configFrame.title:SetFontObject("GameFontNormal")
    configFrame.title:SetPoint("TOP", 0, -6)
    configFrame.title:SetText("Dungeon Log Settings")
    configFrame.title:SetTextColor(1, 0.82, 0)

    configFrame.CloseButton:SetScript("OnClick", function()
        configFrame:Hide()
    end)

    configFrame.closeButton = CreateFrame("Button", nil, configFrame, "UIPanelButtonTemplate")
    configFrame.closeButton:SetSize(80, 22)
    configFrame.closeButton:SetPoint("BOTTOMRIGHT", configFrame, "BOTTOMRIGHT", -10, 10)
    configFrame.closeButton:SetText("Close")
    configFrame.closeButton:SetScript("OnClick", function()
        configFrame:Hide()
    end)
end

function Config:ShowUI()
    if configFrame then
        configFrame:Show()
    end
end

function Config:RegisterSlashCommand()
    StaticPopupDialogs["DUNGEONLOG_RESET"] = {
        text = "Reset Dungeon Log?\nThis permanently clears all recorded dungeons, bosses, and loot.",
        button1 = YES,
        button2 = NO,
        OnAccept = function()
            DungeonLog.modules.Log:ResetAll()
            print("|cff66ccffDungeonLog:|r all data has been reset")
        end,
        timeout = 0,
        whileDead = true,
        hideOnEscape = true,
        showAlert = true,
        preferredIndex = 3,
    }

    SLASH_DUNGEONLOG1 = "/dungeonlog"
    SLASH_DUNGEONLOG2 = "/dl"
    SlashCmdList["DUNGEONLOG"] = function(msg)
        msg = (msg or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
        if msg == "config" then
            Config:ShowUI()
        elseif msg == "reset" then
            StaticPopup_Show("DUNGEONLOG_RESET")
        elseif msg == "debug" then
            local enabled = not Config:GetSetting("debug")
            Config:SetSetting("debug", enabled)
            DungeonLog.modules.Log:SetDebug(enabled)
            print("|cff66ccffDungeonLog:|r debug " .. (enabled and "enabled" or "disabled"))
        else
            DungeonLog.modules.UI:ShowUI()
        end
    end
end

function Config:CreateMinimapButton()
    minimapButton = CreateFrame("Button", "DungeonLogMinimapButton", Minimap)
    minimapButton:SetSize(31, 31)
    minimapButton:SetFrameStrata("MEDIUM")
    minimapButton:SetFrameLevel(8)
    minimapButton:SetHighlightTexture("Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight")

    local icon = minimapButton:CreateTexture(nil, "BACKGROUND")
    icon:SetSize(20, 20)
    icon:SetPoint("CENTER", 0, 1)
    icon:SetTexture("Interface\\Icons\\INV_Misc_Map_01")

    local overlay = minimapButton:CreateTexture(nil, "OVERLAY")
    overlay:SetSize(53, 53)
    overlay:SetPoint("TOPLEFT")
    overlay:SetTexture("Interface\\Minimap\\MiniMap-TrackingBorder")

    minimapButton:SetScript("OnClick", function()
        DungeonLog.modules.UI:ShowUI()
    end)

    minimapButton:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_LEFT")
        GameTooltip:AddLine("Dungeon Log")
        GameTooltip:AddLine("Click to open", 1, 1, 1)
        GameTooltip:Show()
    end)

    minimapButton:SetScript("OnLeave", function()
        GameTooltip:Hide()
    end)

    DungeonLogDB.minimapAngle = DungeonLogDB.minimapAngle or 45
    self:UpdateMinimapPosition()

    minimapButton:RegisterForDrag("LeftButton")
    minimapButton:SetScript("OnDragStart", function(self)
        self:SetScript("OnUpdate", Config.OnMinimapDrag)
    end)
    minimapButton:SetScript("OnDragStop", function(self)
        self:SetScript("OnUpdate", nil)
    end)
end

function Config.OnMinimapDrag()
    local mx, my = Minimap:GetCenter()
    local px, py = GetCursorPosition()
    local scale = Minimap:GetEffectiveScale()
    px, py = px / scale, py / scale

    local angle = math.deg(math.atan2(py - my, px - mx))
    DungeonLogDB.minimapAngle = angle
    Config:UpdateMinimapPosition()
end

function Config:UpdateMinimapPosition()
    local angle = math.rad(DungeonLogDB.minimapAngle or 45)
    local radius = (Minimap:GetWidth() / 2) + 5
    local x = math.cos(angle) * radius
    local y = math.sin(angle) * radius
    minimapButton:SetPoint("CENTER", Minimap, "CENTER", x, y)
end
