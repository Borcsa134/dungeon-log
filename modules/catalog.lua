local Catalog = {}
DungeonLog.modules.Catalog = Catalog

Catalog.entries = {
    { name = "Ragefire Chasm", minLevel = 13, maxLevel = 18, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_Fire", bosses = {
        { order = 1, name = "Oggleflint", encounterID = 2732 },
        { order = 2, name = "Taragaman the Hungerer", encounterID = 2733 },
        { order = 3, name = "Jergosh the Invoker", encounterID = 2734 },
        { order = 4, name = "Bazzalan", encounterID = 2735 },
    }},
    { name = "Ruins of Lordaeron", minLevel = 15, maxLevel = 20, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Bone_HumanSkull_01", bosses = {
        { order = 1, name = "Witherfang", encounterID = 3353 },
        { order = 2, name = "The Baron", encounterID = 3355 },
        { order = 3, name = "Viktor the Vile", encounterID = 3411 },
        { order = 4, name = "The Abandoned", encounterID = 3357 },
        { order = 5, name = "Bjork", encounterID = 3412 },
        { order = 6, name = "Rath'Mael", encounterID = 3354 },
    }},
    { name = "The Hall of Thanes", minLevel = 13, maxLevel = 18, isRaid = false,
      icon = "Interface\\Icons\\INV_Hammer_05", bosses = {
        { order = 1, name = "Faldrim Anvilmar", encounterID = 3493 },
        { order = 2, name = "Magmatus", encounterID = 3495 },
        { order = 3, name = "Plunder", encounterID = 3494 },
        { order = 4, name = "Dirgen Dirgehammer", encounterID = 3496 },
    }},
    { name = "Excavation Site: Wetlands", minLevel = 26, maxLevel = 31, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Shovel_01", bosses = {
        { order = 1, name = "Saltspine", encounterID = 3480 },
        { order = 2, name = "Shadetooth", encounterID = 3481 },
        { order = 3, name = "Relic Guardian", encounterID = 3482 },
    }},
    { name = "City of Dalaran", minLevel = 28, maxLevel = 33, isRaid = false,
      icon = "Interface\\Icons\\Spell_Arcane_TeleportDalaran", bosses = {
        { order = 1, name = "Atrexis the Grave Knight", encounterID = 3311 },
        { order = 2, name = "Arcane Anomaly", encounterID = 3298 },
        { order = 3, name = "Arcanic Enigma", todo = "missing encounterID" },
        { order = 4, name = "Unstable Sentinel", encounterID = 3302 },
        { order = 5, name = "Fel Ancient", encounterID = 3299 },
        { order = 6, name = "Lyn the Ignored", encounterID = 3310 },
        { order = 7, name = "Shade of the Archmage", encounterID = 3303 },
    }},
    { name = "Deadmines", minLevel = 17, maxLevel = 26, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Map_01", bosses = {
        { order = 1, name = "Rhahk'Zor", encounterID = 2741 },
        { order = 2, name = "Sneed's Shredder", encounterID = 2742 },
        { order = 3, name = "Gilnid", encounterID = 2743 },
        { order = 4, name = "Mr. Smite", encounterID = 2745 },
        { order = 5, name = "Captain Greenskin", encounterID = 2744 },
        { order = 6, name = "Edwin VanCleef", encounterID = 2747 },
        { order = 7, name = "Cookie", encounterID = 2746 },
    }},
    { name = "Wailing Caverns", minLevel = 17, maxLevel = 24, isRaid = false,
      icon = "Interface\\Icons\\Ability_Hunter_Pet_Raptor", bosses = {
        { order = 1, name = "Lady Anacondra", encounterID = 585 },
        { order = 2, name = "Lord Cobrahn", encounterID = 586 },
        { order = 3, name = "Lord Pythas", encounterID = 588 },
        { order = 4, name = "Kresh", encounterID = 587 },
        { order = 5, name = "Skum", encounterID = 589 },
        { order = 6, name = "Lord Serpentis", encounterID = 590 },
        { order = 7, name = "Verdan the Everliving", encounterID = 591 },
        { order = 8, name = "Mutanus the Devourer", encounterID = 592 },
    }},
    { name = "Shadowfang Keep", minLevel = 22, maxLevel = 30, isRaid = false,
      icon = "Interface\\Icons\\Ability_Mount_WhiteDireWolf", bosses = {
        { order = 1, name = "Rethilgore", encounterID = 2748 },
        { order = 2, name = "Razorclaw the Butcher", encounterID = 2749 },
        { order = 3, name = "Baron Silverlaine", encounterID = 2750 },
        { order = 4, name = "Commander Springvale", encounterID = 2751 },
        { order = 5, name = "Odo the Blindwatcher", encounterID = 2752 },
        { order = 6, name = "Fenrus the Devourer", encounterID = 2753 },
        { order = 7, name = "Wolf Master Nandos", encounterID = 2754 },
        { order = 8, name = "Archmage Arugal", encounterID = 2755 },
    }},
    { name = "Blackfathom Deeps", minLevel = 24, maxLevel = 32, isRaid = false,
      icon = "Interface\\Icons\\Spell_Frost_SummonWaterElemental", bosses = {
        { order = 1, name = "Ghamoo-ra", encounterID = 2697 },
        { order = 2, name = "Lady Sarevess", encounterID = 2699 },
        { order = 3, name = "Gelihast", encounterID = 2704 },
        { order = 4, name = "Lorgus Jett", encounterID = 2710 },
        { order = 5, name = "Baron Aquanis", encounterID = 2694 },
        { order = 6, name = "Twilight Lord Kelris", encounterID = 2825 },
        { order = 7, name = "Aku'mai", encounterID = 2891 },
    }},
    { name = "Stormwind Stockade", minLevel = 24, maxLevel = 32, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Key_11", bosses = {
        { order = 1, name = "Targorr the Dread", encounterID = 2756 },
        { order = 2, name = "Kam Deepfury", encounterID = 2757 },
        { order = 3, name = "Hamhock", encounterID = 2758 },
        { order = 4, name = "Dextren Ward", encounterID = 2759 },
        { order = 5, name = "Bazil Thredd", encounterID = 2760 },
    }},
    { name = "Gnomeregan", minLevel = 29, maxLevel = 38, isRaid = false,
      icon = "Interface\\Icons\\INV_Gizmo_02", bosses = {
        { order = 1, name = "Grubbis", encounterID = 2768 },
        { order = 2, name = "Viscous Fallout", encounterID = 2769 },
        { order = 3, name = "Electrocutioner 6000", encounterID = 2770 },
        { order = 4, name = "Crowd Pummeler 9-60", encounterID = 2771 },
        { order = 5, name = "Mekgineer Thermaplugg", encounterID = 2772 },
    }},
    { name = "Razorfen Kraul", minLevel = 29, maxLevel = 38, isRaid = false,
      icon = "Interface\\Icons\\Ability_Hunter_Pet_Boar", bosses = {
        { order = 1, name = "Roogug", encounterID = 2773 },
        { order = 2, name = "Aggem Thorncurse", encounterID = 2774 },
        { order = 3, name = "Death Speaker Jargba", encounterID = 2775 },
        { order = 4, name = "Overlord Ramtusk", encounterID = 2776 },
        { order = 5, name = "Agathelos the Raging", encounterID = 2777 },
        { order = 6, name = "Charlga Razorflank", encounterID = 2778 },
    }},
    { name = "Scarlet Monastery", minLevel = 30, maxLevel = 46, isRaid = false,
      icon = "Interface\\Icons\\Spell_Holy_HolySmite", wings = {
        { name = "Graveyard", minLevel = 30, maxLevel = 38, bosses = {
            { order = 1, name = "Interrogator Vishas", encounterID = 444 },
            { order = 2, name = "Bloodmage Thalnos", encounterID = 2779 },
        }},
        { name = "Library", minLevel = 33, maxLevel = 41, bosses = {
            { order = 1, name = "Houndmaster Loksey", encounterID = 446 },
            { order = 2, name = "Arcanist Doan", encounterID = 447 },
        }},
        { name = "Armory", minLevel = 36, maxLevel = 44, bosses = {
            { order = 1, name = "Herod", encounterID = 448 },
        }},
        { name = "Cathedral", minLevel = 38, maxLevel = 46, bosses = {
            { order = 1, name = "High Inquisitor Fairbanks", encounterID = 449 },
            { order = 2, name = "Scarlet Commander Mograine", todo = "missing encounterID" },
            { order = 3, name = "High Inquisitor Whitemane", encounterID = 450 },
        }},
    }},
    { name = "Razorfen Downs", minLevel = 37, maxLevel = 46, isRaid = false,
      icon = "Interface\\Icons\\Ability_Creature_Cursed_01", bosses = {
        { order = 1, name = "Tuten'kash", encounterID = 2780 },
        { order = 2, name = "Mordresh Fire Eye", encounterID = 2782 },
        { order = 3, name = "Glutton", encounterID = 2784 },
        { order = 4, name = "Ragglesnout", encounterID = 2783 },
        { order = 5, name = "Amnennar the Coldbringer", encounterID = 2785 },
    }},
    { name = "Uldaman", minLevel = 41, maxLevel = 51, isRaid = false,
      icon = "Interface\\Icons\\INV_Misc_Idol_03", bosses = {
        { order = 1, name = "Revelosh", encounterID = 547 },
        { order = 2, name = "Baelog", encounterID = 548 },
        { order = 3, name = "Ironaya", encounterID = 549 },
        { order = 4, name = "Ancient Stone Keeper", encounterID = 551 },
        { order = 5, name = "Galgann Firehammer", encounterID = 552 },
        { order = 6, name = "Grimlok", encounterID = 553 },
        { order = 7, name = "Archaedas", encounterID = 554 },
    }},
    { name = "Zul'Farrak", minLevel = 44, maxLevel = 54, isRaid = false,
      icon = "Interface\\Icons\\Ability_Rogue_Sprint", bosses = {
        { order = 1, name = "Gahz'rilla", encounterID = 594 },
        { order = 2, name = "Antu'sul", encounterID = 595 },
        { order = 3, name = "Theka the Martyr", encounterID = 596 },
        { order = 4, name = "Witch Doctor Zum'rah", encounterID = 597 },
        { order = 5, name = "Nekrum Gutchewer", encounterID = 598 },
        { order = 6, name = "Shadowpriest Sezz'ziz", encounterID = 599 },
        { order = 7, name = "Chief Ukorz Sandscalp", encounterID = 600 },
    }},
    { name = "Maraudon", minLevel = 46, maxLevel = 55, isRaid = false,
      icon = "Interface\\Icons\\Spell_Nature_Thorns", bosses = {
        { order = 1, name = "Noxxion", encounterID = 422 },
        { order = 2, name = "Razorlash", encounterID = 423 },
        { order = 3, name = "Lord Vyletongue", encounterID = 424 },
        { order = 4, name = "Celebras the Cursed", encounterID = 425 },
        { order = 5, name = "Landslide", encounterID = 426 },
        { order = 6, name = "Tinkerer Gizlock", encounterID = 427 },
        { order = 7, name = "Rotgrip", encounterID = 428 },
        { order = 8, name = "Princess Theradras", encounterID = 429 },
    }},
    { name = "Sunken Temple", minLevel = 50, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Nature_Sleep", bosses = {
        { order = 1, name = "Atal'alarion", encounterID = 2814 },
        { order = 2, name = "Jammal'an the Prophet", encounterID = 488 },
        { order = 3, name = "Dreamscythe", encounterID = 486 },
        { order = 4, name = "Weaver", encounterID = 487 },
        { order = 5, name = "Hazzas", encounterID = 491 },
        { order = 6, name = "Morphaz", encounterID = 490 },
        { order = 7, name = "Shade of Eranikus", encounterID = 493 },
    }},
    { name = "Blackrock Depths", minLevel = 52, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_Incinerate", bosses = {
        { order = 1, name = "High Interrogator Gerstahn", encounterID = 227 },
        { order = 2, name = "Lord Roccor", encounterID = 228 },
        { order = 3, name = "Houndmaster Grebmar", encounterID = 229 },
        { order = 4, name = "Ring of Law", encounterID = 230 },
        { order = 5, name = "Pyromancer Loregrain", encounterID = 231 },
        { order = 6, name = "Lord Incendius", encounterID = 232 },
        { order = 7, name = "Warder Stilgiss", encounterID = 233 },
        { order = 8, name = "Fineous Darkvire", encounterID = 234 },
        { order = 9, name = "Bael'Gar", encounterID = 235 },
        { order = 10, name = "General Angerforge", encounterID = 236 },
        { order = 11, name = "Golem Lord Argelmach", encounterID = 237 },
        { order = 12, name = "Hurley Blackbreath", encounterID = 238 },
        { order = 13, name = "Phalanx", encounterID = 239 },
        { order = 14, name = "Ribbly Screwspigot", encounterID = 240 },
        { order = 15, name = "Plugger Spazzring", encounterID = 241 },
        { order = 16, name = "Ambassador Flamelash", encounterID = 242 },
        { order = 17, name = "The Seven", encounterID = 243 },
        { order = 18, name = "Magmus", encounterID = 244 },
        { order = 19, name = "Emperor Dagran Thaurissan", encounterID = 2790 },
    }},
    { name = "Lower Blackrock Spire", minLevel = 55, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_FlameShock", bosses = {
        { order = 1, name = "Highlord Omokk", encounterID = 267 },
        { order = 2, name = "Shadow Hunter Vosh'gajin", encounterID = 268 },
        { order = 3, name = "War Master Voone", encounterID = 269 },
        { order = 4, name = "Mother Smolderweb", encounterID = 270 },
        { order = 5, name = "Urok Doomhowl", encounterID = 271 },
        { order = 6, name = "Quartermaster Zigris", encounterID = 272 },
        { order = 7, name = "Gizrul the Slavener", encounterID = 273 },
        { order = 8, name = "Halycon", encounterID = 274 },
        { order = 9, name = "Overlord Wyrmthalak", encounterID = 275 },
    }},
    { name = "Upper Blackrock Spire", minLevel = 59, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Fire_SelfDestruct", bosses = {
        { order = 1, name = "Pyroguard Emberseer", encounterID = 3062 },
        { order = 2, name = "Solakar Flamewreath", todo = "missing encounterID" },
        { order = 3, name = "Goraluk Anvilcrack", todo = "missing encounterID" },
        { order = 4, name = "Jed Runewatcher", todo = "missing encounterID" },
        { order = 5, name = "Warchief Rend Blackhand", encounterID = 3063 },
        { order = 6, name = "Gyth", todo = "missing encounterID" },
        { order = 7, name = "The Beast", encounterID = 3068 },
        { order = 8, name = "General Drakkisath", encounterID = 3069 },
    }},
    { name = "Dire Maul", minLevel = 54, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\INV_Crown_01", wings = {
        { name = "East", minLevel = 54, maxLevel = 60, bosses = {
            { order = 1, name = "Pusillin", encounterID = 2792 },
            { order = 2, name = "Zevrim Thornhoof", encounterID = 343 },
            { order = 3, name = "Hydrospawn", encounterID = 344 },
            { order = 4, name = "Lethtendris", encounterID = 345 },
            { order = 5, name = "Alzzin the Wildshaper", encounterID = 346 },
        }},
        { name = "West", minLevel = 56, maxLevel = 60, bosses = {
            { order = 1, name = "Tendris Warpwood", encounterID = 350 },
            { order = 2, name = "Illyanna Ravenoak", encounterID = 347 },
            { order = 3, name = "Magister Kalendris", encounterID = 348 },
            { order = 4, name = "Immol'thar", encounterID = 349 },
            { order = 5, name = "Prince Tortheldrin", encounterID = 361 },
        }},
        { name = "North", minLevel = 56, maxLevel = 60, bosses = {
            { order = 1, name = "Guard Mol'dar", encounterID = 362 },
            { order = 2, name = "Stomper Kreeg", encounterID = 363 },
            { order = 3, name = "Guard Fengus", encounterID = 364 },
            { order = 4, name = "Guard Slip'kik", encounterID = 365 },
            { order = 5, name = "Captain Kromcrush", encounterID = 366 },
            { order = 6, name = "Cho'Rush the Observer", encounterID = 367 },
            { order = 7, name = "King Gordok", encounterID = 368 },
        }},
    }},
    { name = "Scholomance", minLevel = 58, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Shadow_RaiseDead", bosses = {
        { order = 1, name = "Kirtonos the Herald", encounterID = 2805 },
        { order = 2, name = "Jandice Barov", encounterID = 2804 },
        { order = 3, name = "Rattlegore", encounterID = 2811 },
        { order = 4, name = "Marduk Blackpool", encounterID = 2809 },
        { order = 5, name = "Vectus", encounterID = 2813 },
        { order = 6, name = "Ras Frostwhisper", encounterID = 2810 },
        { order = 7, name = "Instructor Malicia", encounterID = 2803 },
        { order = 8, name = "Doctor Theolen Krastinov", encounterID = 2802 },
        { order = 9, name = "Lorekeeper Polkelt", encounterID = 2808 },
        { order = 10, name = "The Ravenian", encounterID = 2812 },
        { order = 11, name = "Lord Alexei Barov", encounterID = 2807 },
        { order = 12, name = "Lady Illucia Barov", encounterID = 2806 },
        { order = 13, name = "Darkmaster Gandling", encounterID = 2801 },
    }},
    { name = "Stratholme", minLevel = 58, maxLevel = 60, isRaid = false,
      icon = "Interface\\Icons\\Spell_Shadow_DeathPact", bosses = {
        { order = 1, name = "Hearthsinger Forresten", encounterID = 473 },
        { order = 2, name = "The Unforgiven", encounterID = 472 },
        { order = 3, name = "Timmy the Cruel", encounterID = 474 },
        { order = 4, name = "Malor the Zealous", encounterID = 476 },
        { order = 5, name = "Cannon Master Willey", encounterID = 475 },
        { order = 6, name = "Archivist Galford", encounterID = 477 },
        { order = 7, name = "Balnazzar", encounterID = 478 },
        { order = 8, name = "Magistrate Barthilas", encounterID = 482 },
        { order = 9, name = "Stonespine", encounterID = 2800 },
        { order = 10, name = "Nerub'enkan", encounterID = 480 },
        { order = 11, name = "Baroness Anastari", encounterID = 479 },
        { order = 12, name = "Maleki the Pallid", encounterID = 481 },
        { order = 13, name = "Ramstein the Gorger", encounterID = 483 },
        { order = 14, name = "Baron Rivendare", encounterID = 484 },
    }},
    { name = "Onyxia's Lair", minLevel = 60, maxLevel = 60, isRaid = true,
      icon = "Interface\\Icons\\INV_Misc_Head_Dragon_Black", bosses = {
        { order = 1, name = "Onyxia", encounterID = 1084 },
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

function Catalog:GetEntriesByKind(isRaid)
    local sorted = self:GetSortedEntries()
    local list = {}
    for i = 1, #sorted do
        if (sorted[i].isRaid and true or false) == (isRaid and true or false) then
            list[#list + 1] = sorted[i]
        end
    end
    return list
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
    return entry.name
end
