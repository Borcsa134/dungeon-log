local addonName = "DungeonLog"

DungeonLog = DungeonLog or {}
DungeonLog.modules = {}

local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGOUT")

frame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == addonName then
        DungeonLogDB = DungeonLogDB or {}
        DungeonLogDB.settings = DungeonLogDB.settings or {}
        DungeonLogDB.dungeons = DungeonLogDB.dungeons or {}

        if DungeonLog.modules.Config then
            DungeonLog.modules.Config:Initialize()
        end

        for name, module in pairs(DungeonLog.modules) do
            if module.Initialize and name ~= "Config" then
                module:Initialize()
            end
        end
    elseif event == "PLAYER_LOGOUT" then
        for name, module in pairs(DungeonLog.modules) do
            if module.OnLogout then
                module:OnLogout()
            end
        end
    end
end)
