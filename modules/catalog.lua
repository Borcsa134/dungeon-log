local Catalog = {}
DungeonLog.modules.Catalog = Catalog

Catalog.entries = {
    { name = "Ragefire Chasm", parentName = nil, minLevel = 13, maxLevel = 18, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_Fire", bosses = {
        { order = 1, name = "Oggleflint" },
        { order = 2, name = "Taragaman the Hungerer" },
        { order = 3, name = "Jergosh the Invoker" },
        { order = 4, name = "Bazzalan" },
    }},
    { name = "The Deadmines", parentName = nil, minLevel = 17, maxLevel = 26, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Map_01", bosses = {
        { order = 1, name = "Rhahk'Zor" },
        { order = 2, name = "Sneed's Shredder" },
        { order = 3, name = "Gilnid" },
        { order = 4, name = "Mr. Smite" },
        { order = 5, name = "Captain Greenskin" },
        { order = 6, name = "Edwin VanCleef" },
        { order = 7, name = "Cookie" },
    }},
    { name = "Wailing Caverns", parentName = nil, minLevel = 17, maxLevel = 24, isRaid = false,
      icon = "Interface\\Icons\\Ability_Hunter_Pet_Raptor", bosses = {
        { order = 1, name = "Lady Anacondra" },
        { order = 2, name = "Lord Cobrahn" },
        { order = 3, name = "Lord Pythas" },
        { order = 4, name = "Kresh" },
        { order = 5, name = "Skum" },
        { order = 6, name = "Lord Serpentis" },
        { order = 7, name = "Verdan the Everliving" },
        { order = 8, name = "Mutanus the Devourer" },
    }},
    { name = "Shadowfang Keep", parentName = nil, minLevel = 22, maxLevel = 30, isRaid = false,
      icon = "Interface\\Icons\\Ability_Mount_WhiteDireWolf", bosses = {
        { order = 1, name = "Rethilgore" },
        { order = 2, name = "Razorclaw the Butcher" },
        { order = 3, name = "Baron Silverlaine" },
        { order = 4, name = "Commander Springvale" },
        { order = 5, name = "Odo the Blindwatcher" },
        { order = 6, name = "Fenrus the Devourer" },
        { order = 7, name = "Wolf Master Nandos" },
        { order = 8, name = "Archmage Arugal" },
    }},
    { name = "Blackfathom Deeps", parentName = nil, minLevel = 24, maxLevel = 32, isRaid = false,
      icon = "Interface\\Icons\\Spell_Frost_SummonWaterElemental", bosses = {
        { order = 1, name = "Ghamoo-ra" },
        { order = 2, name = "Lady Sarevess" },
        { order = 3, name = "Gelihast" },
        { order = 4, name = "Lorgus Jett" },
        { order = 5, name = "Baron Aquanis" },
        { order = 6, name = "Twilight Lord Kelris" },
        { order = 7, name = "Aku'mai" },
    }},
    { name = "Stormwind Stockade", parentName = nil, minLevel = 24, maxLevel = 32, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Key_11", bosses = {
        { order = 1, name = "Targorr the Dread" },
        { order = 2, name = "Kam Deepfury" },
        { order = 3, name = "Hamhock" },
        { order = 4, name = "Dextren Ward" },
        { order = 5, name = "Bazil Thredd" },
    }},
    { name = "Gnomeregan", parentName = nil, minLevel = 29, maxLevel = 38, isRaid = false,
      icon = "Interface\\Icons\\INV_Gizmo_02", bosses = {
        { order = 1, name = "Grubbis" },
        { order = 2, name = "Viscous Fallout" },
        { order = 3, name = "Electrocutioner 6000" },
        { order = 4, name = "Crowd Pummeler 9-60" },
        { order = 5, name = "Mekgineer Thermaplugg" },
    }},
    { name = "Razorfen Kraul", parentName = nil, minLevel = 30, maxLevel = 40, isRaid = false,
      icon = "Interface\\Icons\\Ability_Hunter_Pet_Boar", bosses = {
        { order = 1, name = "Roogug" },
        { order = 2, name = "Aggem Thorncurse" },
        { order = 3, name = "Death Speaker Jargba" },
        { order = 4, name = "Overlord Ramtusk" },
        { order = 5, name = "Agathelos the Raging" },
        { order = 6, name = "Charlga Razorflank" },
    }},
    { name = "Scarlet Monastery - Graveyard", parentName = "Scarlet Monastery",
      minLevel = 26, maxLevel = 36, isRaid = false, icon = "Interface\\Icons\\Spell_Holy_PrayerOfHealing",
      bosses = {
        { order = 1, name = "Interrogator Vishas" },
        { order = 2, name = "Bloodmage Thalnos" },
    }},
    { name = "Scarlet Monastery - Library", parentName = "Scarlet Monastery",
      minLevel = 29, maxLevel = 39, isRaid = false, icon = "Interface\\Icons\\Spell_Holy_MindVision",
      bosses = {
        { order = 1, name = "Houndmaster Loksey" },
        { order = 2, name = "Arcanist Doan" },
    }},
    { name = "Scarlet Monastery - Armory", parentName = "Scarlet Monastery",
      minLevel = 32, maxLevel = 42, isRaid = false, icon = "Interface\\Icons\\INV_Chest_Plate04",
      bosses = {
        { order = 1, name = "Herod" },
    }},
    { name = "Scarlet Monastery - Cathedral", parentName = "Scarlet Monastery",
      minLevel = 35, maxLevel = 45, isRaid = false, icon = "Interface\\Icons\\Spell_Holy_HolySmite",
      bosses = {
        { order = 1, name = "High Inquisitor Fairbanks" },
        { order = 2, name = "Scarlet Commander Mograine" },
        { order = 3, name = "High Inquisitor Whitemane" },
    }},
    { name = "Razorfen Downs", parentName = nil, minLevel = 37, maxLevel = 46, isRaid = false,
      icon = "Interface\\Icons\\Ability_Creature_Cursed_01", bosses = {
        { order = 1, name = "Tuten'kash" },
        { order = 2, name = "Mordresh Fire Eye" },
        { order = 3, name = "Glutton" },
        { order = 4, name = "Ragglesnout" },
        { order = 5, name = "Amnennar the Coldbringer" },
    }},
    { name = "Uldaman", parentName = nil, minLevel = 41, maxLevel = 51, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Idol_03", bosses = {
        { order = 1, name = "Revelosh" },
        { order = 2, name = "Baelog" },
        { order = 3, name = "Ironaya" },
        { order = 4, name = "Ancient Stone Keeper" },
        { order = 5, name = "Galgann Firehammer" },
        { order = 6, name = "Grimlok" },
        { order = 7, name = "Archaedas" },
    }},
    { name = "Zul'Farrak", parentName = nil, minLevel = 44, maxLevel = 54, isRaid = false,
      icon = "Interface\\Icons\\Ability_Rogue_Sprint", bosses = {
        { order = 1, name = "Gahz'rilla" },
        { order = 2, name = "Antu'sul" },
        { order = 3, name = "Theka the Martyr" },
        { order = 4, name = "Witch Doctor Zum'rah" },
        { order = 5, name = "Nekrum Gutchewer" },
        { order = 6, name = "Shadowpriest Sezz'ziz" },
        { order = 7, name = "Chief Ukorz Sandscalp" },
    }},
    { name = "Maraudon", parentName = nil, minLevel = 46, maxLevel = 55, isRaid = false,
      icon = "Interface\\Icons\\Spell_Nature_Thorns", bosses = {
        { order = 1, name = "Noxxion" },
        { order = 2, name = "Razorlash" },
        { order = 3, name = "Lord Vyletongue" },
        { order = 4, name = "Celebras the Cursed" },
        { order = 5, name = "Landslide" },
        { order = 6, name = "Tinkerer Gizlock" },
        { order = 7, name = "Rotgrip" },
        { order = 8, name = "Princess Theradras" },
    }},
    { name = "Temple of Atal'Hakkar", parentName = nil, minLevel = 50, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Nature_Sleep", bosses = {
        { order = 1, name = "Atal'alarion" },
        { order = 2, name = "Jammal'an the Prophet" },
        { order = 3, name = "Dreamscythe" },
        { order = 4, name = "Weaver" },
        { order = 5, name = "Hazzas" },
        { order = 6, name = "Morphaz" },
        { order = 7, name = "Shade of Eranikus" },
    }},
    { name = "Blackrock Depths", parentName = nil, minLevel = 52, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_Incinerate", bosses = {
        { order = 1, name = "High Interrogator Gerstahn" },
        { order = 2, name = "Lord Roccor" },
        { order = 3, name = "Houndmaster Grebmar" },
        { order = 4, name = "Ring of Law" },
        { order = 5, name = "Pyromancer Loregrain" },
        { order = 6, name = "Lord Incendius" },
        { order = 7, name = "Warder Stilgiss" },
        { order = 8, name = "Fineous Darkvire" },
        { order = 9, name = "Bael'Gar" },
        { order = 10, name = "General Angerforge" },
        { order = 11, name = "Golem Lord Argelmach" },
        { order = 12, name = "Hurley Blackbreath" },
        { order = 13, name = "Phalanx" },
        { order = 14, name = "Ribbly Screwspigot" },
        { order = 15, name = "Plugger Spazzring" },
        { order = 16, name = "Ambassador Flamelash" },
        { order = 17, name = "The Seven" },
        { order = 18, name = "Magmus" },
        { order = 19, name = "Emperor Dagran Thaurissan" },
    }},
    { name = "Lower Blackrock Spire", parentName = nil, minLevel = 55, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_FlameShock", bosses = {
        { order = 1, name = "Highlord Omokk" },
        { order = 2, name = "Shadow Hunter Vosh'gajin" },
        { order = 3, name = "War Master Voone" },
        { order = 4, name = "Mother Smolderweb" },
        { order = 5, name = "Urok Doomhowl" },
        { order = 6, name = "Quartermaster Zigris" },
        { order = 7, name = "Gizrul the Slavener" },
        { order = 8, name = "Halycon" },
        { order = 9, name = "Overlord Wyrmthalak" },
    }},
    { name = "Upper Blackrock Spire", parentName = nil, minLevel = 55, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_SelfDestruct", bosses = {
        { order = 1, name = "Pyroguard Emberseer" },
        { order = 2, name = "Solakar Flamewreath" },
        { order = 3, name = "Goraluk Anvilcrack" },
        { order = 4, name = "Jed Runewatcher" },
        { order = 5, name = "Warchief Rend Blackhand" },
        { order = 6, name = "Gyth" },
        { order = 7, name = "The Beast" },
        { order = 8, name = "General Drakkisath" },
    }},
    { name = "Dire Maul - East", parentName = "Dire Maul",
      minLevel = 36, maxLevel = 46, isRaid = false, icon = "Interface\\Icons\\Spell_Nature_NatureTouchGrow",
      bosses = {
        { order = 1, name = "Pusillin" },
        { order = 2, name = "Zevrim Thornhoof" },
        { order = 3, name = "Hydrospawn" },
        { order = 4, name = "Lethtendris" },
        { order = 5, name = "Alzzin the Wildshaper" },
    }},
    { name = "Dire Maul - West", parentName = "Dire Maul",
      minLevel = 54, maxLevel = 60, isRaid = false, icon = "Interface\\Icons\\Spell_Arcane_PortalDarnassus",
      bosses = {
        { order = 1, name = "Tendris Warpwood" },
        { order = 2, name = "Illyanna Ravenoak" },
        { order = 3, name = "Magister Kalendris" },
        { order = 4, name = "Immol'thar" },
        { order = 5, name = "Prince Tortheldrin" },
    }},
    { name = "Dire Maul - North", parentName = "Dire Maul",
      minLevel = 56, maxLevel = 60, isRaid = false, icon = "Interface\\Icons\\INV_Crown_01",
      bosses = {
        { order = 1, name = "Guard Mol'dar" },
        { order = 2, name = "Stomper Kreeg" },
        { order = 3, name = "Guard Fengus" },
        { order = 4, name = "Guard Slip'kik" },
        { order = 5, name = "Captain Kromcrush" },
        { order = 6, name = "Cho'Rush the Observer" },
        { order = 7, name = "King Gordok" },
    }},
    { name = "Scholomance", parentName = nil, minLevel = 58, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Shadow_RaiseDead", bosses = {
        { order = 1, name = "Kirtonos the Herald" },
        { order = 2, name = "Jandice Barov" },
        { order = 3, name = "Rattlegore" },
        { order = 4, name = "Marduk Blackpool" },
        { order = 5, name = "Vectus" },
        { order = 6, name = "Ras Frostwhisper" },
        { order = 7, name = "Instructor Malicia" },
        { order = 8, name = "Doctor Theolen Krastinov" },
        { order = 9, name = "Lorekeeper Polkelt" },
        { order = 10, name = "The Ravenian" },
        { order = 11, name = "Lord Alexei Barov" },
        { order = 12, name = "Lady Illucia Barov" },
        { order = 13, name = "Darkmaster Gandling" },
    }},
    { name = "Stratholme", parentName = nil, minLevel = 58, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Shadow_DeathPact", bosses = {
        { order = 1, name = "Hearthsinger Forresten" },
        { order = 2, name = "The Unforgiven" },
        { order = 3, name = "Timmy the Cruel" },
        { order = 4, name = "Malor the Zealous" },
        { order = 5, name = "Cannon Master Willey" },
        { order = 6, name = "Archivist Galford" },
        { order = 7, name = "Balnazzar" },
        { order = 8, name = "Magistrate Barthilas" },
        { order = 9, name = "Stonespine" },
        { order = 10, name = "Nerub'enkan" },
        { order = 11, name = "Baroness Anastari" },
        { order = 12, name = "Maleki the Pallid" },
        { order = 13, name = "Ramstein the Gorger" },
        { order = 14, name = "Baron Rivendare" },
    }},
    { name = "Onyxia's Lair", parentName = nil, minLevel = 60, maxLevel = 60, isRaid = true,
      icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Black", bosses = {
        { order = 1, name = "Onyxia" },
    }},
}

local sortedCache

function Catalog:Initialize()
end

function Catalog:GetSortedEntries()
    if sortedCache then return sortedCache end
    local list = {}
    for i = 1, #self.entries do
        list[i] = self.entries[i]
    end
    table.sort(list, function(a, b)
        if a.minLevel ~= b.minLevel then return a.minLevel < b.minLevel end
        if a.maxLevel ~= b.maxLevel then return a.maxLevel < b.maxLevel end
        return a.name < b.name
    end)
    sortedCache = list
    return sortedCache
end

function Catalog:GetEntryByKey(name)
    for i = 1, #self.entries do
        if self.entries[i].name == name then
            return self.entries[i]
        end
    end
    return nil
end

function Catalog:GetLiveDBKey(entry)
    return entry.parentName or entry.name
end
