local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local hrp = character:WaitForChild("HumanoidRootPart")
local libraryFolder = game.Workspace:WaitForChild("Library"):WaitForChild("Books")
local bookVolumeCounts = {}
for _, obj in pairs(libraryFolder:GetChildren()) do
    local baseName = obj.Name:match("^(.-)_%d+$") or obj.Name
    bookVolumeCounts[baseName] = (bookVolumeCounts[baseName] or 0) + 1
end
local RunService = game:GetService("RunService")

local DISPLAY_NAMES = {
	-- Studio (1A)
	["TheHiddenGridAllMapsFollow"] = "The Hidden Grid All Maps Follow",
	["FolderThatBrokeTheGame"] = "Folder That Broke The Game",
	["WhyPartsSometimesRefusetoCollide"] = "Why Parts Sometimes Refuse to Collide",
	["ReplicationDelay:TheSpaceBetweenTruths"] = "Replication Delay: The Space Between Truths",
	["WhatHappensWhenAScriptThinksFirst"] = "What Happens When A Script Thinks First",
	["WhySomePartsFloatWhenNobodyIsWatching"] = "Why Some Parts Float When Nobody Is Watching",
	["TerrainGenerationThatRegretsItself"] = "Terrain Generation That Regrets Itself",
	["ModelHierarchyandEmotionalStability"] = "Model Hierarchy and Emotional Stability",
	["HowtheWorkspaceDecidesWhatExists"] = "How the Workspace Decides What Exists",
	["TheTruthAboutPhysicsOwnership"] = "The Truth About Physics Ownership",
	["TheInvisibleUpdateThatChangedEverything"] = "The Invisible Update That Changed Everything",
	["AnchoredvsUnanchored"] = "Anchored vs Unanchored",

	-- Simulators (1B)
	["Rebirth#10,000:WhenProgressStopsFeelingReal"] = "Rebirth #10,000: When Progress Stops Feeling Real",
	["HowEverySimulatorEventuallyAddsRebirths"] = "How Every Simulator Eventually Adds Rebirths",
	["TheInfiniteTycoonExpansionStrategy"] = "The Infinite Tycoon Expansion Strategy",
	["PetSimulatorEconomicsforBeginners"] = "Pet Simulator Economics for Beginners",
	["AFKGrindingandtheDeathofAttentionSpan"] = "AFK Grinding and the Death of Attention Span",
	["ThePsychologyofClickingFaster"] = "The Psychology of Clicking Faster",
	["WhySimulatorPlayersLoveBiggerNumbers"] = "Why Simulator Players Love Bigger Numbers",
	["Auto-FarmTechnologyandItsConsequences"] = "Auto-Farm Technology and Its Consequences",
	["FromOneCointoOneQuintillion:ScalingSystemsExplained"] = "From One Coin to One Quintillion: Scaling Systems Explained",
	["TheSimulatorMapThatNeverTrulyEnds"] = "The Simulator Map That Never Truly Ends",
	["UpgradeButtonsDesignedtoDrainYourCurrency"] = "Upgrade Buttons Designed to Drain Your Currency",
	["TheSecretFormulaBehindAddictiveProgressBars"] = "The Secret Formula Behind Addictive Progress Bars",

	-- Avatar (1C)
	["LimitedKnockoffsYouShouldBuy"] = "Limited Knockoffs You Should Buy",
	["LimitedU:TheRiseAndFallOfRareHats"] = "Limited U: The Rise And Fall Of Rare Hats",
	["TheRTHROExperiment"] = "The RTHRO Experiment",
	["HowToLookRichWith5Robux"] = "How To Look Rich With 5 Robux",
	["ReportCatalogOfCursedFaces"] = "Report Catalog Of Cursed Faces",
	["ShirtTemplatesThatRuinedFriendships"] = "Shirt Templates That Ruined Friendships",
	["HowToChangeAvatarColor"] = "How To Change Avatar Color",
	["WearingAccessories"] = "Wearing Accessories",
	["FashionIdeasForGuests"] = "Fashion Ideas For Guests",
	["TheDayHeadlessBecameAPersonalityTrait"] = "The Day Headless Became A Personality Trait",
	["HowToMakeUGC"] = "How To Make UGC",
	["TheFedoraIndentityCrisis"] = "The Fedora Identity Crisis",

	-- Myths (1D)
	["AdminCommandsTheySayDon'tExist"] = "Admin Commands They Say Don't Exist",
	["TheHiddenSword"] = "The Hidden Sword",
	["MythSightingsTheLastGuest"] = "Myth Sightings: The Last Guest",
	["MythSightingsBuilderman"] = "Myth Sightings: Builderman",
	["TheAdminWhoNeverAppearedonPlayerLists"] = "The Admin Who Never Appeared on Player Lists",
	["MythSightings1x1x1x1"] = "Myth Sightings: 1x1x1x1",
	["ThePlayerWithNoRecordInChatLog"] = "The Player With No Record In Chat Log",
	["TheServerThatKicksTheOwner"] = "The Server That Kicks The Owner",
	["BanWavesThatTargetedNobodySpecific"] = "Ban Waves That Targeted Nobody Specific",
	["TheGuestThatBypassedDeletion"] = "The Guest That Bypassed Deletion",
	["MythSightings:JohnDoe"] = "Myth Sightings: John Doe",
	["TheInvisibleServer"] = "The Invisible Server",

	-- DevEx (1E)
	["GetRich"] = "Get Rich",
	["WhatToBuyAfterDevEx"] = "What To Buy After Dev Ex",
	["RobuxRentMoney"] = "Robux Rent Money",
	["RiseOfFullTimeDevs"] = "Rise Of Full Time Devs",
	["MakeMillionsDoingNothing"] = "Make Millions Doing Nothing",
	["DevExWhatAreTaxes"] = "Dev Ex: What Are Taxes",
	["WonderfulWorldofGroupPayouts"] = "Wonderful World of Group Payouts",
	["DevExOrLimiteds"] = "Dev Ex Or Limiteds",
	["WhyMostDevsGoBroke"] = "Why Most Devs Go Broke",
	["TheBiggestDevExEver"] = "The Biggest Dev Ex Ever",
	["DevExMyths"] = "Dev Ex Myths",
	["IsDevExSustainable"] = "Is Dev Ex Sustainable",

	-- Rules (1F)
	["TheBanAndWhyYouDeservedIt"] = "The Ban And Why You Deserved It",
	["ChatFilter"] = "Chat Filter",
	["What'sROBLOXSuspiciousActivity"] = "What's ROBLOX Suspicious Activity",
	["TheAppealProcess"] = "The Appeal Process",
	["ModerationNotes"] = "Moderation Notes",
	["ListOfForbiddenEmotes"] = "List Of Forbidden Emotes",
	["ReportSystemTimeStudy"] = "Report System Time Study",
	["HowWarningsStack"] = "How Warnings Stack",
	["BeingAutomicallyMuted"] = "Being Automatically Muted",
	["FalseReports"] = "False Reports",
	["ReviewedTextures"] = "Reviewed Textures",
	["ChangingRules"] = "Changing Rules",

	-- Obby (1G)
	["SpeedCoilAbuse"] = "Speed Coil Abuse",
	["CaseFilesInvisibleKillBrick"] = "Case Files: Invisible Kill Brick",
	["TheLavaFloorsAlwaysRising"] = "The Lava Floors Always Rising",
	["CheckpointPlacementPsychology"] = "Checkpoint Placement Psychology",
	["EscapingBarky"] = "Escaping Barky",
	["EscapingScratch"] = "Escaping Scratch",
	["EscapingBees"] = "Escaping Bees",
	["ObbyWithACar"] = "Obby With A Car",
	["KillBricks"] = "Kill Bricks",
	["100WaystoMissaJump"] = "100 Ways to Miss a Jump",
	["WaysToDie"] = "Ways To Die",
	["YouBeatTheObby"] = "You Beat The Obby",

	-- Horror (1H)
	["TheGameThatLoadsButHasNoSpawns"] = "The Game That Loads But Has No Spawns",
	["TheAudioFileThatOnlyPlayersAfterLogout"] = "The Audio File That Only Plays After Logout",
	["TheLobbyThatRefusestoLoad"] = "The Lobby That Refuses to Load",
	["WhenYourFriendBecomesAnNPC"] = "When Your Friend Becomes An NPC",
	["TheGuestThatKeepAppearing"] = "The Guest That Keeps Appearing",
	["TheLobbyWhereYourNameIsTaken"] = "The Lobby Where Your Name Is Taken",
	["ShadowPlayerInIdleAnimation"] = "Shadow Player In Idle Animation",
	["ThePlayerWhoNeverLeftTheTutorial"] = "The Player Who Never Left The Tutorial",
	["MissingKnifeTexture"] = "Missing Knife Texture",
	["Server0"] = "Server 0",
	["SoundOfOOF"] = "Sound Of OOF",
	["AnimatroFRFromADeletedAccountnicDesign"] = "Animatronic Design From A Deleted Account",

	-- Economy (1I)
	["RobuxInflationCrisisReport"] = "Robux Inflation Crisis Report",
	["TheArtOfScammingLimiteds"] = "The Art Of Scamming Limiteds",
	["TheRiseOfThe1RapEmpire"] = "The Rise Of The 1 Rap Empire",
	["TheHiddenCostOfFlexingRareItems"] = "The Hidden Cost Of Flexing Rare Items",
	["LimitedItemPumpandDumpTactics"] = "Limited Item Pump and Dump Tactics",
	["ThePsychologyofOverpayinginTradeRequests"] = "The Psychology of Overpaying in Trade Requests",
	["WhyEveryoneSuddenlyBecameaCollector"] = "Why Everyone Suddenly Became a Collector",
	["FakeValueListsandTheirRealConsequences"] = "Fake Value Lists and Their Real Consequences",
	["HowTradeBotsBroketheEconomyTwice"] = "How Trade Bots Broke the Economy Twice",
	["InflationofVirtualHats"] = "Inflation of Virtual Hats",
	["HowtoSpotaScammerIn3Seconds"] = "How to Spot a Scammer In 3 Seconds",
	["TheDeclineOfFairTrade"] = "The Decline Of Fair Trade",
	['TheMythof"Underpay"'] = 'The Myth of "Underpay"',
	["DuplicateItemCrisisReport"] = "Duplicate Item Crisis Report",
	["WhyEveryServerHasRichKid"] = "Why Every Server Has A Rich Kid",
	["TheRiseofFakeRichPlayers"] = "The Rise of Fake Rich Players",
	["TradeRequestSpamStudies"] = "Trade Request Spam Studies",
	["ValueList:TrustNoOneEdition"] = "Value List: Trust No One Edition",
	["WhyEveryoneIsSuddenlyBroke"] = "Why Everyone Is Suddenly Broke",
	["TheRobloxBMThatDoesn't Exist"] = "The Roblox BM That Doesn't Exist",

	-- History (1J)
	["EggHunt"] = "Egg Hunt",
	["DefaultNoob"] = "Default Noob",
	["TheDayOfFreeModels"] = "The Day Of Free Models",
	["CatalogWars"] = "Catalog Wars",
	["GuestModeRemoved"] = "Guest Mode Removed",
	["TheGreatOofEra"] = "The Great Oof Era",
	["TheForgottenForumWar"] = "The Forgotten Forum War",
	["EnginePatchNotes"] = "Engine Patch Notes",
	["RiseOfTheBuildersClub"] = "Rise Of The Builders Club",
	["TheFirstPlaceThatEverCrashed"] = "The First Place That Ever Crashed",
	["TheRiseoftheBrickTextureEmpire"] = "The Rise of the Brick Texture Empire",
	["WhenFreeModelsWereStillTrustworthy"] = "When Free Models Were Still Trustworthy",
	["BuildersClubRemoval"] = "Builders Club Removal",
	["EvolutionOfTheRobloxSpawnPoint"] = "Evolution Of The Roblox Spawn Point",
	["TheGreatCatalogPurge"] = "The Great Catalog Purge",
	["TheFirstRobloxEvent"] = "The First Roblox Event",
	["ClassicDeathSounds"] = "Classic Death Sounds",
	["HistoryOfOldWebsite"] = "History Of Old Website",
	["HistoryOfBanHammer"] = "History Of Ban Hammer",
	["RobloxPremiumRemoval"] = "Roblox Premium Removal",

	-- Magic (2A)
	["BeginnerSpellcasting"] = "Beginner Spellcasting",
	["ArcaneTheory"] = "Arcane Theory",
	["PotionBrewing"] = "Potion Brewing",
	["EnchantedArtifacts"] = "Enchanted Artifacts",
	["SummoningRituals"] = "Summoning Rituals",
	["ElementalMastery"] = "Elemental Mastery",
	["ForbiddenTomes"] = "Forbidden Tomes",
	["WandCrafting"] = "Wand Crafting",
	["IllusionMagic"] = "Illusion Magic",
	["NecromancyStudies"] = "Necromancy Studies",
	["GrandWizardArchives"] = "Grand Wizard Archives",
	["DimensionalPortals"] = "Dimensional Portals",

	-- Anime (2B)
	["NinjaChronicles"] = "Ninja Chronicles",
	["MechaWarfare"] = "Mecha Warfare",
	["Top10Anime"] = "Top 10 Anime",
	["LegendaryAnimeFighters"] = "Legendary Anime Fighters",
	["TournamentArcs"] = "Tournament Arcs",
	["DemonHunters"] = "Demon Hunters",
	["HeroAcademies"] = "Hero Academies",
	["VillainOrigins"] = "Villain Origins",
	["SpiritHunters"] = "Spirit Hunters",
	["MonsterTamers"] = "Monster Tamers",
	["AnimeSoundTracks"] = "Anime Sound Tracks",
	["DragonBallads"] = "Dragon Ballads",

	-- Meditation (2C)
	["MindfulnessBasics"] = "Mindfulness Basics",
	["BreathingTechniques"] = "Breathing Techniques",
	["ZenPhilosophy"] = "Zen Philosophy",
	["NatureMeditation"] = "Nature Meditation",
	["FocusTraining"] = "Focus Training",
	["GuidedRelaxation"] = "Guided Relaxation",
	["StressManagement"] = "Stress Management",
	["SleepImprovement"] = "Sleep Improvement",
	["PositiveThinking"] = "Positive Thinking",
	["InnerBalance"] = "Inner Balance",
	["AdvancedMeditation"] = "Advanced Meditation",
	["PeacefulLiving"] = "Peaceful Living",

	-- Military (2D)
	["FamousClans"] = "Famous Clans",
	["MilitaryTechnology"] = "Military Technology",
	["Commander'sHandbook"] = "Commander's Handbook",
	["TankOperations"] = "Tank Operations",
	["NoobArmies"] = "Noob Armies",
	["OperatingSubmarines"] = "Operating Submarines",
	["AvoidingMines"] = "Avoiding Mines",
	["AncientWarfare"] = "Ancient Warfare",
	["NavalFleets"] = "Naval Fleets",
	["AirCombat"] = "Air Combat",
	["ColdWar"] = "Cold War",
	["FutureWarfare"] = "Future Warfare",

	-- Brainrot (2E)
	["SkibidiResearch"] = "Skibidi Research",
	["OhioMysteries"] = "Ohio Mysteries",
	["SigmaStudies"] = "Sigma Studies",
	["ItalianBrainrot"] = "Italian Brainrot",
	["AuraFarming"] = "Aura Farming",
	["NPCBehavior"] = "NPC Behavior",
	["RizzTechniques"] = "Rizz Techniques",
	["CoreCoreArchives"] = "Core Core Archives",
	["MemeEvolution"] = "Meme Evolution",
	["ViralSoundEffects"] = "Viral Sound Effects",
	["InternetOddities"] = "Internet Oddities",
	["UltimateBrainrots"] = "Ultimate Brainrots",

	-- ThemeParks (2F)
	["RollerCoasterEngineering"] = "Roller Coaster Engineering",
	["DarkRideAdventures"] = "Dark Ride Adventures",
	["WaterAttractions"] = "Water Attractions",
	["ThemeParkHistory"] = "Theme Park History",
	["RideSafetyStandards"] = "Ride Safety Standards",
	["FamousThemePark"] = "Famous Theme Park",
	["HauntedAttractions"] = "Haunted Attractions",
	["AnimatronicDesign"] = "Animatronic Design",
	["ThrillRideRecords"] = "Thrill Ride Records",
	["ParkOperations"] = "Park Operations",
	["QueueLineSecrets"] = "Queue Line Secrets",
	["CoasterEnthusiastArchives"] = "Coaster Enthusiast Archives",
}

local function formatBookName(name)
	local raw = name:match("^(.-)_%d+$") or name
	if DISPLAY_NAMES[raw] then return DISPLAY_NAMES[raw] end
	raw = raw:gsub("(%l)(%u)", "%1 %2")
	raw = raw:gsub("(%a)(%d)", "%1 %2")
	raw = raw:gsub("(%d)(%a)", "%1 %2")
	raw = raw:gsub("([:#])", "%1 ")
	raw = raw:gsub("%s+", " ")
	return raw:match("^%s*(.-)%s*$")
end

-- =====================
-- BOOK CATEGORIES
-- =====================
local CATEGORIES = {
	{ name = "Studio", icon = "🔧(1A)", books = {
		"TheHiddenGridAllMapsFollow", "FolderThatBrokeTheGame", "WhyPartsSometimesRefusetoCollide",
		"ReplicationDelay:TheSpaceBetweenTruths", "WhatHappensWhenAScriptThinksFirst",
		"WhySomePartsFloatWhenNobodyIsWatching", "TerrainGenerationThatRegretsItself",
		"ModelHierarchyandEmotionalStability", "HowtheWorkspaceDecidesWhatExists",
		"TheTruthAboutPhysicsOwnership", "TheInvisibleUpdateThatChangedEverything",
		"AnchoredvsUnanchored",
	}},
	{ name = "Simulators", icon = "🔁(1B)", books = {
		"Rebirth#10,000:WhenProgressStopsFeelingReal", "HowEverySimulatorEventuallyAddsRebirths",
		"TheInfiniteTycoonExpansionStrategy", "PetSimulatorEconomicsforBeginners",
		"AFKGrindingandtheDeathofAttentionSpan", "ThePsychologyofClickingFaster",
		"WhySimulatorPlayersLoveBiggerNumbers", "Auto-FarmTechnologyandItsConsequences",
		"FromOneCointoOneQuintillion:ScalingSystemsExplained", "TheSimulatorMapThatNeverTrulyEnds",
		"UpgradeButtonsDesignedtoDrainYourCurrency", "TheSecretFormulaBehindAddictiveProgressBars",
	}},
	{ name = "Avatar", icon = "👤(1C)", books = {
		"LimitedKnockoffsYouShouldBuy", "LimitedU:TheRiseAndFallOfRareHats",
		"TheRTHROExperiment", "HowToLookRichWith5Robux", "ReportCatalogOfCursedFaces",
		"ShirtTemplatesThatRuinedFriendships", "HowToChangeAvatarColor",
		"WearingAccessories", "FashionIdeasForGuests", "TheDayHeadlessBecameAPersonalityTrait",
		"HowToMakeUGC", "TheFedoraIndentityCrisis",
	}},
	{ name = "Myths", icon = "👻(1D)", books = {
		"AdminCommandsTheySayDon'tExist", "TheHiddenSword", "MythSightingsTheLastGuest",
		"MythSightingsBuilderman", "TheAdminWhoNeverAppearedonPlayerLists",
		"MythSightings1x1x1x1", "ThePlayerWithNoRecordInChatLog",
		"TheServerThatKicksTheOwner", "BanWavesThatTargetedNobodySpecific",
		"TheGuestThatBypassedDeletion", "MythSightings:JohnDoe", "TheInvisibleServer",
	}},
	{ name = "DevEx", icon = "💸(1E)", books = {
		"GetRich", "WhatToBuyAfterDevEx", "RobuxRentMoney", "RiseOfFullTimeDevs",
		"MakeMillionsDoingNothing", "DevExWhatAreTaxes", "WonderfulWorldofGroupPayouts",
		"DevExOrLimiteds", "WhyMostDevsGoBroke", "TheBiggestDevExEver",
		"DevExMyths", "IsDevExSustainable",
	}},
	{ name = "Rules", icon = "📜(1F)", books = {
		"TheBanAndWhyYouDeservedIt", "ChatFilter", "What'sROBLOXSuspiciousActivity",
		"TheAppealProcess", "ModerationNotes", "ListOfForbiddenEmotes",
		"ReportSystemTimeStudy", "HowWarningsStack", "BeingAutomicallyMuted",
		"FalseReports", "ReviewedTextures", "ChangingRules",
	}},
	{ name = "Obby", icon = "🏃(1G)", books = {
		"SpeedCoilAbuse", "CaseFilesInvisibleKillBrick", "TheLavaFloorsAlwaysRising",
		"CheckpointPlacementPsychology", "EscapingBarky", "EscapingScratch",
		"EscapingBees", "ObbyWithACar", "KillBricks", "100WaystoMissaJump",
		"WaysToDie", "YouBeatTheObby",
	}},
	{ name = "Horror", icon = "🕯️(1H)", books = {
		"TheGameThatLoadsButHasNoSpawns", "TheAudioFileThatOnlyPlayersAfterLogout",
		"TheLobbyThatRefusestoLoad", "WhenYourFriendBecomesAnNPC",
		"TheGuestThatKeepAppearing", "TheLobbyWhereYourNameIsTaken",
		"ShadowPlayerInIdleAnimation", "ThePlayerWhoNeverLeftTheTutorial",
		"MissingKnifeTexture", "Server0", "SoundOfOOF", "AnimatroFRFromADeletedAccountnicDesign",
	}},
	{ name = "Economy", icon = "📈(1I)", books = {
		"RobuxInflationCrisisReport", "TheArtOfScammingLimiteds", "TheRiseOfThe1RapEmpire",
		"TheHiddenCostOfFlexingRareItems", "LimitedItemPumpandDumpTactics",
		"ThePsychologyofOverpayinginTradeRequests", "WhyEveryoneSuddenlyBecameaCollector",
		"FakeValueListsandTheirRealConsequences", "HowTradeBotsBroketheEconomyTwice",
		"InflationofVirtualHats", "HowtoSpotaScammerIn3Seconds", "TheDeclineOfFairTrade",
		"TheMythof\"Underpay\"", "DuplicateItemCrisisReport", "WhyEveryServerHasRichKid",
		"TheRiseofFakeRichPlayers", "TradeRequestSpamStudies", "ValueList:TrustNoOneEdition",
		"WhyEveryoneIsSuddenlyBroke", "TheRobloxBMThatDoesn't Exist",
	}},
	{ name = "History", icon = "🏛️(1J)", books = {
		"EggHunt", "DefaultNoob", "TheDayOfFreeModels", "CatalogWars",
		"GuestModeRemoved", "TheGreatOofEra", "TheForgottenForumWar",
		"EnginePatchNotes", "RiseOfTheBuildersClub", "TheFirstPlaceThatEverCrashed",
		"TheRiseoftheBrickTextureEmpire", "WhenFreeModelsWereStillTrustworthy",
		"BuildersClubRemoval", "EvolutionOfTheRobloxSpawnPoint", "TheGreatCatalogPurge",
		"TheFirstRobloxEvent", "ClassicDeathSounds", "HistoryOfOldWebsite",
		"HistoryOfBanHammer", "RobloxPremiumRemoval",
	}},
	{ name = "Magic", icon = "🔮(2A)", books = {
		"BeginnerSpellcasting", "ArcaneTheory", "PotionBrewing", "EnchantedArtifacts",
		"SummoningRituals", "ElementalMastery", "ForbiddenTomes", "WandCrafting",
		"IllusionMagic", "NecromancyStudies", "GrandWizardArchives", "DimensionalPortals",
	}},
	{ name = "Anime", icon = "⛩️(2B)", books = {
		"NinjaChronicles", "MechaWarfare", "Top10Anime", "LegendaryAnimeFighters",
		"TournamentArcs", "DemonHunters", "HeroAcademies", "VillainOrigins",
		"SpiritHunters", "MonsterTamers", "AnimeSoundTracks", "DragonBallads",
	}},
	{ name = "Meditation", icon = "🧘(2C)", books = {
		"MindfulnessBasics", "BreathingTechniques", "ZenPhilosophy", "NatureMeditation",
		"FocusTraining", "GuidedRelaxation", "StressManagement", "SleepImprovement",
		"PositiveThinking", "InnerBalance", "AdvancedMeditation", "PeacefulLiving",
	}},
	{ name = "Military", icon = "🪖(2D)", books = {
		"FamousClans", "MilitaryTechnology", "Commander'sHandbook", "TankOperations",
		"NoobArmies", "OperatingSubmarines", "AvoidingMines", "AncientWarfare",
		"NavalFleets", "AirCombat", "ColdWar", "FutureWarfare",
	}},
	{ name = "Brainrot", icon = "🧠(2E)", books = {
		"SkibidiResearch", "OhioMysteries", "SigmaStudies", "ItalianBrainrot",
		"AuraFarming", "NPCBehavior", "RizzTechniques", "CoreCoreArchives",
		"MemeEvolution", "ViralSoundEffects", "InternetOddities", "UltimateBrainrots",
	}},
	{ name = "ThemeParks", icon = "🎢(2F)", books = {
		"RollerCoasterEngineering", "DarkRideAdventures", "WaterAttractions",
		"ThemeParkHistory", "RideSafetyStandards", "FamousThemePark",
		"HauntedAttractions", "AnimatronicDesign", "ThrillRideRecords",
		"ParkOperations", "QueueLineSecrets", "CoasterEnthusiastArchives",
	}},
}

-- =====================
-- SHELVES DATA
-- =====================
local SHELVES = {
	{ label = "1A", pos = Vector3.new(-50, 7, -97) },
	{ label = "2A", pos = Vector3.new(-52, 21, -96) },
	{ label = "1B", pos = Vector3.new(-11, 6, -96) },
	{ label = "2B", pos = Vector3.new(-3, 21, -99) },
	{ label = "1C", pos = Vector3.new(-54, 7, -121) },
	{ label = "2C", pos = Vector3.new(-57, 21, -121) },
	{ label = "1D", pos = Vector3.new(-6, 6, -121) },
	{ label = "2D", pos = Vector3.new(-2, 21, -123) },
	{ label = "1E", pos = Vector3.new(-50, 7, -146) },
	{ label = "2E", pos = Vector3.new(-55, 21, -145) },
	{ label = "1F", pos = Vector3.new(-6, 6, -145) },
	{ label = "2F", pos = Vector3.new(-3, 21, -148) },
	{ label = "1G", pos = Vector3.new(-55, 7, -169) },
	{ label = "1H", pos = Vector3.new(-6, 6, -169) },
	{ label = "1I", pos = Vector3.new(-47, 6, -193) },
	{ label = "1J", pos = Vector3.new(-7, 6, -195) },
}

-- =====================
-- ESP STATE
-- =====================
local activeHighlights = {}
local activeTags = {}
local activeBeams = {}
local currentTeleportIndex = 0
local walkSpeedLoop = nil

local function clearESP()
	currentTeleportIndex = 0
	for _, h in pairs(activeHighlights) do pcall(function() h:Destroy() end) end
	for _, t in pairs(activeTags) do pcall(function() t:Destroy() end) end
	for _, b in pairs(activeBeams) do pcall(function() b:Destroy() end) end
	activeHighlights, activeTags, activeBeams = {}, {}, {}
end

local function espSingleObject(obj)
	local highlight = Instance.new("Highlight")
	highlight.FillColor = Color3.fromRGB(255, 50, 50)
	highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
	highlight.FillTransparency = 0.2
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Parent = obj
	table.insert(activeHighlights, highlight)

	local billboard = Instance.new("BillboardGui")
	billboard.Size = UDim2.new(0, 200, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.Parent = obj
	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = obj.Name
	label.TextColor3 = Color3.fromRGB(255, 255, 0)
	label.TextScaled = true
	label.TextStrokeTransparency = 0
	label.Parent = billboard
	table.insert(activeTags, billboard)

	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if root then
		local a0 = Instance.new("Attachment") a0.Parent = root
		local a1 = Instance.new("Attachment") a1.Parent = obj
		local beam = Instance.new("Beam")
		beam.FaceCamera = true
		beam.Width0 = 0.15
		beam.Width1 = 0.15
		beam.Color = ColorSequence.new(Color3.fromRGB(255, 255, 0))
		beam.Transparency = NumberSequence.new(0)
		beam.Attachment0 = a0
		beam.Attachment1 = a1
		beam.Parent = root
		table.insert(activeBeams, beam)
		table.insert(activeBeams, a0)
		table.insert(activeBeams, a1)
	end
end

local function espBook(bookName)
	clearESP()
	local found = false
	for _, obj in pairs(libraryFolder:GetChildren()) do
		local baseName = obj.Name:match("^(.-)_%d+$") or obj.Name
		if baseName == bookName then espSingleObject(obj) found = true end
	end
	return found
end

local function espCategory(bookList)
	clearESP()
	local count = 0
	local bookSet = {}
	for _, name in ipairs(bookList) do bookSet[name] = true end
	for _, obj in pairs(libraryFolder:GetChildren()) do
		local baseName = obj.Name:match("^(.-)_%d+$") or obj.Name
		if bookSet[baseName] then espSingleObject(obj) count += 1 end
	end
	return count
end

local function getSortedESPTargets()
	local targets = {}
	for _, obj in ipairs(activeBeams) do
		if obj:IsA("Attachment") and obj.Name == "Attachment" and obj.Parent ~= hrp then
			local parent = obj.Parent
			if parent and parent.Parent then
				local indexNum = tonumber(parent.Name:match("_(%d+)$")) or 0
				local pos = parent:IsA("BasePart") and parent.Position
					or (parent:FindFirstChildWhichIsA("BasePart") and parent:FindFirstChildWhichIsA("BasePart").Position)
				if pos then
					table.insert(targets, { obj = parent, pos = pos, idx = indexNum })
				end
			end
		end
	end
	table.sort(targets, function(a, b)
		local ai = a.idx == 0 and math.huge or a.idx
		local bi = b.idx == 0 and math.huge or b.idx
		return ai < bi
	end)
	return targets
end

-- =====================
-- MAIN UI (single window)
-- =====================
local mainGui = Instance.new("ScreenGui")
mainGui.Name = "LibraryESP"
mainGui.ResetOnSpawn = false
mainGui.Parent = player.PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 400, 0, 530)
mainFrame.Position = UDim2.new(0.5, -170, 0.5, -280)
mainFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = mainGui
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 10)

-- Title bar
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 10)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -50, 1, 0)
titleLabel.Position = UDim2.new(0, 12, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "📚 Library ESP  ·  [G] cycle books"
titleLabel.TextColor3 = Color3.fromRGB(200, 210, 255)
titleLabel.TextSize = 14
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 5)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 60, 60)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.new(1, 1, 1)
closeBtn.TextSize = 14
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() mainGui:Destroy() end)

-- Drag
local dragging, dragStart, startPos
titleBar.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true; dragStart = input.Position; startPos = mainFrame.Position
	end
end)
titleBar.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local d = input.Position - dragStart
		mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
	end
end)
titleBar.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

-- =====================
-- MODE TABS (Books / Shelves)
-- =====================
local MODE_TAB_BG      = Color3.fromRGB(28, 28, 42)
local MODE_TAB_TEXT    = Color3.fromRGB(130, 130, 180)
local MODE_ACTIVE_BG   = Color3.fromRGB(50, 35, 110)
local MODE_ACTIVE_TEXT = Color3.fromRGB(210, 190, 255)

local modeTabRow = Instance.new("Frame")
modeTabRow.Size = UDim2.new(1, -16, 0, 30)
modeTabRow.Position = UDim2.new(0, 8, 0, 46)
modeTabRow.BackgroundTransparency = 1
modeTabRow.Parent = mainFrame

local modeTabLayout = Instance.new("UIListLayout")
modeTabLayout.FillDirection = Enum.FillDirection.Horizontal
modeTabLayout.SortOrder = Enum.SortOrder.LayoutOrder
modeTabLayout.Padding = UDim.new(0, 6)
modeTabLayout.Parent = modeTabRow

local function makeModeTab(text, order)
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, 120, 1, 0)
	btn.BackgroundColor3 = MODE_TAB_BG
	btn.TextColor3 = MODE_TAB_TEXT
	btn.Text = text
	btn.TextSize = 13
	btn.Font = Enum.Font.GothamBold
	btn.BorderSizePixel = 0
	btn.LayoutOrder = order
	btn.Parent = modeTabRow
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
	return btn
end

local booksTab  = makeModeTab("📚 Books", 1)
local shelvesTab = makeModeTab("🗺️ TP - Shelves", 2)
local statsTab = makeModeTab("🎮 Player Stats", 3)

-- =====================
-- BOOKS PANEL
-- =====================
local booksPanel = Instance.new("Frame")
booksPanel.Size = UDim2.new(1, -16, 0, 460)
booksPanel.Position = UDim2.new(0, 8, 0, 82)
booksPanel.BackgroundTransparency = 1
booksPanel.BorderSizePixel = 0
booksPanel.Parent = mainFrame

-- Search box
local searchBox = Instance.new("TextBox")
searchBox.Size = UDim2.new(1, 0, 0, 30)
searchBox.Position = UDim2.new(0, 0, 0, 0)
searchBox.BackgroundColor3 = Color3.fromRGB(38, 38, 55)
searchBox.TextColor3 = Color3.fromRGB(220, 220, 255)
searchBox.PlaceholderText = "🔍  Search all books..."
searchBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 140)
searchBox.Text = ""
searchBox.TextSize = 13
searchBox.Font = Enum.Font.Gotham
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.Parent = booksPanel
Instance.new("UICorner", searchBox).CornerRadius = UDim.new(0, 7)

-- Category tab row
local catTabScroll = Instance.new("ScrollingFrame")
catTabScroll.Size = UDim2.new(1, 0, 0, 32)
catTabScroll.Position = UDim2.new(0, 0, 0, 36)
catTabScroll.BackgroundTransparency = 1
catTabScroll.ScrollBarThickness = 0
catTabScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
catTabScroll.AutomaticCanvasSize = Enum.AutomaticSize.X
catTabScroll.ScrollingDirection = Enum.ScrollingDirection.X
catTabScroll.Parent = booksPanel

local catTabLayout = Instance.new("UIListLayout")
catTabLayout.FillDirection = Enum.FillDirection.Horizontal
catTabLayout.SortOrder = Enum.SortOrder.LayoutOrder
catTabLayout.Padding = UDim.new(0, 4)
catTabLayout.Parent = catTabScroll

-- Status + ESP All
local catStatus = Instance.new("TextLabel")
catStatus.Size = UDim2.new(1, -108, 0, 20)
catStatus.Position = UDim2.new(0, 0, 0, 72)
catStatus.BackgroundTransparency = 1
catStatus.TextColor3 = Color3.fromRGB(110, 120, 160)
catStatus.TextSize = 11
catStatus.Font = Enum.Font.Gotham
catStatus.TextXAlignment = Enum.TextXAlignment.Left
catStatus.Text = "Select a category tab above"
catStatus.Parent = booksPanel

local espAllBtn = Instance.new("TextButton")
espAllBtn.Size = UDim2.new(0, 100, 0, 22)
espAllBtn.Position = UDim2.new(1, -100, 0, 71)
espAllBtn.BackgroundColor3 = Color3.fromRGB(55, 35, 100)
espAllBtn.TextColor3 = Color3.fromRGB(190, 150, 255)
espAllBtn.Text = "⚡ ESP All"
espAllBtn.TextSize = 11
espAllBtn.Font = Enum.Font.GothamBold
espAllBtn.BorderSizePixel = 0
espAllBtn.Visible = false
espAllBtn.Parent = booksPanel
Instance.new("UICorner", espAllBtn).CornerRadius = UDim.new(0, 6)

-- Book list
local bookScroll = Instance.new("ScrollingFrame")
bookScroll.Size = UDim2.new(1, 0, 0, 330)
bookScroll.Position = UDim2.new(0, 0, 0, 96)
bookScroll.BackgroundColor3 = Color3.fromRGB(16, 16, 24)
bookScroll.BorderSizePixel = 0
bookScroll.ScrollBarThickness = 4
bookScroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 180)
bookScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
bookScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
bookScroll.Parent = booksPanel
Instance.new("UICorner", bookScroll).CornerRadius = UDim.new(0, 8)

local bookListLayout = Instance.new("UIListLayout")
bookListLayout.SortOrder = Enum.SortOrder.LayoutOrder
bookListLayout.Padding = UDim.new(0, 3)
bookListLayout.Parent = bookScroll

local bookListPadding = Instance.new("UIPadding")
bookListPadding.PaddingTop = UDim.new(0, 5)
bookListPadding.PaddingLeft = UDim.new(0, 5)
bookListPadding.PaddingRight = UDim.new(0, 5)
bookListPadding.Parent = bookScroll

-- =====================
-- SHELVES PANEL
-- =====================
local shelvesPanel = Instance.new("Frame")
shelvesPanel.Size = UDim2.new(1, -16, 0, 460)
shelvesPanel.Position = UDim2.new(0, 8, 0, 82)
shelvesPanel.BackgroundTransparency = 1
shelvesPanel.BorderSizePixel = 0
shelvesPanel.Visible = false
shelvesPanel.Parent = mainFrame

local shelfHint = Instance.new("TextLabel")
shelfHint.Size = UDim2.new(1, 0, 0, 16)
shelfHint.Position = UDim2.new(0, 0, 0, 0)
shelfHint.BackgroundTransparency = 1
shelfHint.TextColor3 = Color3.fromRGB(100, 110, 140)
shelfHint.TextSize = 11
shelfHint.Font = Enum.Font.Gotham
shelfHint.Text = "1 = Floor 1  ·  2 = Floor 2  ·  A–J = Section"
shelfHint.Parent = shelvesPanel

local shelfGrid = Instance.new("ScrollingFrame")
shelfGrid.Size = UDim2.new(1, 0, 0, 430)
shelfGrid.Position = UDim2.new(0, 0, 0, 20)
shelfGrid.BackgroundColor3 = Color3.fromRGB(18, 18, 28)
shelfGrid.BorderSizePixel = 0
shelfGrid.ScrollBarThickness = 4
shelfGrid.ScrollBarImageColor3 = Color3.fromRGB(80, 100, 200)
shelfGrid.CanvasSize = UDim2.new(0, 0, 0, 0)
shelfGrid.AutomaticCanvasSize = Enum.AutomaticSize.Y
shelfGrid.Parent = shelvesPanel
Instance.new("UICorner", shelfGrid).CornerRadius = UDim.new(0, 8)

local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0, 60, 0, 46)
gridLayout.CellPadding = UDim2.new(0, 6, 0, 6)
gridLayout.SortOrder = Enum.SortOrder.LayoutOrder
gridLayout.Parent = shelfGrid

local gridPadding = Instance.new("UIPadding")
gridPadding.PaddingTop = UDim.new(0, 6)
gridPadding.PaddingLeft = UDim.new(0, 6)
gridPadding.PaddingRight = UDim.new(0, 6)
gridPadding.Parent = shelfGrid

-- =====================
-- STATS PANEL
-- =====================
local statsPanel = Instance.new("Frame")
statsPanel.Size = UDim2.new(1, -16, 0, 460)
statsPanel.Position = UDim2.new(0, 8, 0, 82)
statsPanel.BackgroundTransparency = 1
statsPanel.BorderSizePixel = 0
statsPanel.Visible = false
statsPanel.Parent = mainFrame

local function makeStatRow(parent, labelText, default, max, yPos, applyFn, resetFn)
	local lbl = Instance.new("TextLabel")
	lbl.Size = UDim2.new(1, 0, 0, 18)
	lbl.Position = UDim2.new(0, 0, 0, yPos)
	lbl.BackgroundTransparency = 1
	lbl.TextColor3 = Color3.fromRGB(180, 190, 230)
	lbl.TextSize = 13
	lbl.Font = Enum.Font.GothamBold
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.Text = labelText
	lbl.Parent = parent

	local slider = Instance.new("Frame")
	slider.Size = UDim2.new(1, -140, 0, 8)
	slider.Position = UDim2.new(0, 0, 0, yPos + 26)
	slider.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
	slider.BorderSizePixel = 0
	slider.Parent = parent
	Instance.new("UICorner", slider).CornerRadius = UDim.new(1, 0)

	local fill = Instance.new("Frame")
	fill.Size = UDim2.new(default / max, 0, 1, 0)
	fill.BackgroundColor3 = Color3.fromRGB(100, 140, 255)
	fill.BorderSizePixel = 0
	fill.Parent = slider
	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

	local numBox = Instance.new("TextBox")
	numBox.Size = UDim2.new(0, 52, 0, 26)
	numBox.Position = UDim2.new(1, -134, 0, yPos + 18)
	numBox.BackgroundColor3 = Color3.fromRGB(38, 38, 55)
	numBox.TextColor3 = Color3.fromRGB(220, 220, 255)
	numBox.Text = tostring(default)
	numBox.TextSize = 13
	numBox.Font = Enum.Font.Gotham
	numBox.BorderSizePixel = 0
	numBox.ClearTextOnFocus = false
	numBox.Parent = parent
	Instance.new("UICorner", numBox).CornerRadius = UDim.new(0, 6)

	local resetBtn = Instance.new("TextButton")
	resetBtn.Size = UDim2.new(0, 48, 0, 26)
	resetBtn.Position = UDim2.new(1, -75, 0, yPos + 18)
	resetBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 18)
	resetBtn.TextColor3 = Color3.fromRGB(255, 110, 90)
	resetBtn.Text = "Reset"
	resetBtn.TextSize = 11
	resetBtn.Font = Enum.Font.GothamBold
	resetBtn.BorderSizePixel = 0
	resetBtn.Parent = parent
	Instance.new("UICorner", resetBtn).CornerRadius = UDim.new(0, 6)

	local currentVal = default
	local draggingSlider = false

	local function setValue(v)
		v = math.clamp(math.floor(v + 0.5), 0, max)
		currentVal = v
		fill.Size = UDim2.new(v / max, 0, 1, 0)
		numBox.Text = tostring(v)
		applyFn(v)
	end

	slider.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			draggingSlider = true
			local rel = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
			setValue(rel * max)
		end
	end)
	slider.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then draggingSlider = false end
	end)
	UIS.InputChanged:Connect(function(input)
		if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
			local rel = (input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X
			setValue(rel * max)
		end
	end)

	numBox.FocusLost:Connect(function()
		local v = tonumber(numBox.Text)
		if v then setValue(v) end
	end)

	resetBtn.MouseButton1Click:Connect(function()
		setValue(default)
		resetFn()
	end)

	setValue(default)
end

makeStatRow(statsPanel, "🚶 Walk Speed  (default 16, max 100)", 16, 100, 10,
	function(v)
		if walkSpeedLoop then walkSpeedLoop:Disconnect() end
		walkSpeedLoop = RunService.Heartbeat:Connect(function()
			local char = player.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			if hum then hum.WalkSpeed = v end
		end)
	end,
	function()
		if walkSpeedLoop then walkSpeedLoop:Disconnect() walkSpeedLoop = nil end
	end
)

makeStatRow(statsPanel, "🦘 Jump Height  (default 7.2, max 25)", 7, 25, 80,
	function(v)
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum.JumpHeight = v end
	end,
	function()
		local char = player.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then hum.JumpHeight = 7.2 end
	end
)


-- =====================
-- SHARED STATUS BAR (bottom of window)
-- =====================
local statusBar = Instance.new("TextLabel")
statusBar.Size = UDim2.new(1, -120, 0, 22)
statusBar.Position = UDim2.new(0, 8, 1, -28)
statusBar.BackgroundTransparency = 1
statusBar.TextColor3 = Color3.fromRGB(100, 200, 130)
statusBar.TextSize = 12
statusBar.Font = Enum.Font.Gotham
statusBar.TextXAlignment = Enum.TextXAlignment.Left
statusBar.Text = ""
statusBar.Parent = mainFrame

local clearESPBtn = Instance.new("TextButton")
clearESPBtn.Size = UDim2.new(0, 100, 0, 22)
clearESPBtn.Position = UDim2.new(1, -108, 1, -28)
clearESPBtn.BackgroundColor3 = Color3.fromRGB(55, 18, 18)
clearESPBtn.TextColor3 = Color3.fromRGB(255, 110, 90)
clearESPBtn.Text = "🧹 Clear ESP"
clearESPBtn.TextSize = 11
clearESPBtn.Font = Enum.Font.GothamBold
clearESPBtn.BorderSizePixel = 0
clearESPBtn.Parent = mainFrame
Instance.new("UICorner", clearESPBtn).CornerRadius = UDim.new(0, 6)
clearESPBtn.MouseButton1Click:Connect(function()
	clearESP()
	statusBar.TextColor3 = Color3.fromRGB(110, 120, 160)
	statusBar.Text = "ESP cleared"
end)

-- =====================
-- MODE SWITCH LOGIC
-- =====================
-- change the if/else to:
local function setMode(mode)
	booksPanel.Visible   = mode == "books"
	shelvesPanel.Visible = mode == "shelves"
	statsPanel.Visible   = mode == "stats"

	booksTab.BackgroundColor3   = mode == "books"   and MODE_ACTIVE_BG  or MODE_TAB_BG
	booksTab.TextColor3         = mode == "books"   and MODE_ACTIVE_TEXT or MODE_TAB_TEXT
	shelvesTab.BackgroundColor3 = mode == "shelves" and MODE_ACTIVE_BG  or MODE_TAB_BG
	shelvesTab.TextColor3       = mode == "shelves" and MODE_ACTIVE_TEXT or MODE_TAB_TEXT
	statsTab.BackgroundColor3   = mode == "stats"   and MODE_ACTIVE_BG  or MODE_TAB_BG
	statsTab.TextColor3         = mode == "stats"   and MODE_ACTIVE_TEXT or MODE_TAB_TEXT
end

booksTab.MouseButton1Click:Connect(function() setMode("books") end)
shelvesTab.MouseButton1Click:Connect(function() setMode("shelves") end)
statsTab.MouseButton1Click:Connect(function() setMode("stats") end)
setMode("books") -- default

-- =====================
-- CATEGORY TAB + BOOK LIST LOGIC
-- =====================
local CAT_TAB_BG         = Color3.fromRGB(32, 32, 48)
local CAT_TAB_TEXT       = Color3.fromRGB(150, 150, 195)
local CAT_TAB_ACTIVE_BG  = Color3.fromRGB(65, 48, 130)
local CAT_TAB_ACTIVE_TEXT= Color3.fromRGB(220, 200, 255)

local activeTabBtn   = nil
local activeCatBooks = {}
local activeCatIndex = nil
local tabButtons     = {}

local function clearBookList()
	for _, c in pairs(bookScroll:GetChildren()) do
		if c:IsA("TextButton") then c:Destroy() end
	end
end

local function populateBookList(filter)
	clearBookList()
	local query = filter and filter:lower() or ""
	local count = 0

	if query ~= "" then
		espAllBtn.Visible = false
		for _, cat in ipairs(CATEGORIES) do
			for _, bookName in ipairs(cat.books) do
				if bookName:lower():find(query, 1, true) then
					count += 1
					local row = Instance.new("TextButton")
					row.Size = UDim2.new(1, 0, 0, 32)
					row.BackgroundColor3 = Color3.fromRGB(26, 26, 40)
					row.TextColor3 = Color3.fromRGB(190, 190, 225)
					row.Text = "  " .. formatBookName(bookName) .. "  [" .. cat.icon .. "]  (×" .. (bookVolumeCounts[bookName] or 0) .. ")"
					row.TextSize = 11
					row.Font = Enum.Font.Gotham
					row.TextXAlignment = Enum.TextXAlignment.Left
					row.BorderSizePixel = 0
					row.LayoutOrder = count
					row.Parent = bookScroll
					Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

					local localCat, localBook = cat, bookName
					row.MouseEnter:Connect(function() row.BackgroundColor3 = Color3.fromRGB(48, 48, 72) end)
					row.MouseLeave:Connect(function() row.BackgroundColor3 = Color3.fromRGB(26, 26, 40) end)
					row.MouseButton1Click:Connect(function()
						if activeTabBtn then
							activeTabBtn.BackgroundColor3 = CAT_TAB_BG
							activeTabBtn.TextColor3 = CAT_TAB_TEXT
						end
						for i, cat2 in ipairs(CATEGORIES) do
							if cat2 == localCat then
								activeTabBtn = tabButtons[i]
								activeCatIndex = i
								break
							end
						end
						if activeTabBtn then
							activeTabBtn.BackgroundColor3 = CAT_TAB_ACTIVE_BG
							activeTabBtn.TextColor3 = CAT_TAB_ACTIVE_TEXT
						end
						activeCatBooks = localCat.books
						local found = espBook(localBook)
						statusBar.TextColor3 = found and Color3.fromRGB(100, 200, 130) or Color3.fromRGB(220, 80, 80)
						statusBar.Text = found
							and ("✓ ESPing: " .. localBook .. "  [" .. localCat.icon .. "]")
							or  ("✗ Not found: " .. localBook)
						searchBox.Text = ""
					end)
				end
			end
		end
		catStatus.TextColor3 = Color3.fromRGB(130, 140, 180)
		catStatus.Text = count > 0 and (count .. " result(s) across all categories") or "No results found"
	else
		if not activeCatIndex then return end
		local cat = CATEGORIES[activeCatIndex]
		activeCatBooks = cat.books
		espAllBtn.Visible = true
		catStatus.TextColor3 = Color3.fromRGB(130, 140, 180)
		catStatus.Text = cat.icon .. " " .. cat.name .. "  ·  " .. #cat.books .. " books"

local sortedBooks = {}
for _, bookName in ipairs(cat.books) do
    table.insert(sortedBooks, bookName)
end
table.sort(sortedBooks, function(a, b)
    return (bookVolumeCounts[a] or 0) < (bookVolumeCounts[b] or 0)
end)

		for i, bookName in ipairs(sortedBooks) do
			local row = Instance.new("TextButton")
			row.Size = UDim2.new(1, 0, 0, 30)
			row.BackgroundColor3 = Color3.fromRGB(26, 26, 40)
			row.TextColor3 = Color3.fromRGB(190, 190, 225)
			row.Text = "  " .. formatBookName(bookName) .. "  (×" .. (bookVolumeCounts[bookName] or 0) .. ")"
			row.TextSize = 12
			row.Font = Enum.Font.Gotham
			row.TextXAlignment = Enum.TextXAlignment.Left
			row.BorderSizePixel = 0
			row.LayoutOrder = i
			row.Parent = bookScroll
			Instance.new("UICorner", row).CornerRadius = UDim.new(0, 6)

			local localBook = bookName
			row.MouseEnter:Connect(function() row.BackgroundColor3 = Color3.fromRGB(48, 48, 72) end)
			row.MouseLeave:Connect(function() row.BackgroundColor3 = Color3.fromRGB(26, 26, 40) end)
			row.MouseButton1Click:Connect(function()
				local found = espBook(localBook)
				statusBar.TextColor3 = found and Color3.fromRGB(100, 200, 130) or Color3.fromRGB(220, 80, 80)
				statusBar.Text = found and ("✓ ESPing: " .. localBook) or ("✗ Not found: " .. localBook)
			end)
		end
	end
end

-- Build category tabs
for i, cat in ipairs(CATEGORIES) do
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(0, 0, 1, 0)
	tab.AutomaticSize = Enum.AutomaticSize.X
	tab.BackgroundColor3 = CAT_TAB_BG
	tab.TextColor3 = CAT_TAB_TEXT
	tab.Text = cat.icon .. " " .. cat.name
	tab.TextSize = 11
	tab.Font = Enum.Font.GothamBold
	tab.BorderSizePixel = 0
	tab.LayoutOrder = i
	tab.Parent = catTabScroll
	Instance.new("UICorner", tab).CornerRadius = UDim.new(0, 6)
	local p = Instance.new("UIPadding")
	p.PaddingLeft = UDim.new(0, 8) p.PaddingRight = UDim.new(0, 8) p.Parent = tab
	tabButtons[i] = tab

	tab.MouseButton1Click:Connect(function()
		if activeTabBtn and activeTabBtn ~= tab then
			activeTabBtn.BackgroundColor3 = CAT_TAB_BG
			activeTabBtn.TextColor3 = CAT_TAB_TEXT
		end
		activeTabBtn = tab
		activeCatIndex = i
		tab.BackgroundColor3 = CAT_TAB_ACTIVE_BG
		tab.TextColor3 = CAT_TAB_ACTIVE_TEXT
		searchBox.Text = ""
		populateBookList("")
	end)
end

searchBox:GetPropertyChangedSignal("Text"):Connect(function()
	populateBookList(searchBox.Text)
end)

espAllBtn.MouseButton1Click:Connect(function()
	if #activeCatBooks == 0 then return end
	local count = espCategory(activeCatBooks)
	statusBar.TextColor3 = Color3.fromRGB(255, 200, 80)
	statusBar.Text = "⚡ ESPing all " .. count .. " found book(s) in category"
end)

-- =====================
-- BUILD SHELF BUTTONS
-- =====================

-- Layout: rows of labels, nil = empty cell (gap between odd/even columns)
local SHELF_LAYOUT = {
	-- Floor 1
	{ label = "1F", floor = 1 }, -- row header
	{ rows = {
		{ "1A", "1C", "1E", "1G", "1I" },
		{ "1B", "1D", "1F", "1H", "1J" },
	}},
	-- Floor 2
	{ rows = {
		{ "2A", "2C", "2E" },
		{ "2B", "2D", "2F" },
	}},
}

-- Index SHELVES by label for O(1) lookup
local shelfByLabel = {}
for _, shelf in ipairs(SHELVES) do
	shelfByLabel[shelf.label] = shelf
end

local function getFloorColors(label)
	return label:sub(1,1) == "1"
		and { Color3.fromRGB(55, 40, 20),  Color3.fromRGB(200, 155, 80)  }
		or  { Color3.fromRGB(20, 30, 55),  Color3.fromRGB(90,  150, 230) }
end

local function makeShelfBtn(label)
	local shelf = shelfByLabel[label]
	if not shelf then return end

	local colors  = getFloorColors(label)
	local bgColor = colors[1]
	local txtColor= colors[2]

	local btn = Instance.new("TextButton")
	btn.Size             = UDim2.new(0, 58, 0, 44)
	btn.BackgroundColor3 = bgColor
	btn.TextColor3       = txtColor
	btn.Text             = label
	btn.TextSize         = 15
	btn.Font             = Enum.Font.GothamBold
	btn.BorderSizePixel  = 0
	btn.Parent           = shelfGrid
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

	local stroke = Instance.new("UIStroke")
	stroke.Color        = txtColor
	stroke.Thickness    = 1
	stroke.Transparency = 0.6
	stroke.Parent       = btn

	btn.MouseEnter:Connect(function()
		btn.BackgroundColor3 = Color3.new(
			math.clamp(bgColor.R + 0.12, 0, 1),
			math.clamp(bgColor.G + 0.12, 0, 1),
			math.clamp(bgColor.B + 0.12, 0, 1)
		)
		stroke.Transparency = 0.1
	end)
	btn.MouseLeave:Connect(function()
		btn.BackgroundColor3 = bgColor
		stroke.Transparency  = 0.6
	end)
	btn.MouseButton1Click:Connect(function()
		local char = player.Character
		local root = char and char:FindFirstChild("HumanoidRootPart")
		if not root then return end
		root.CFrame = CFrame.new(shelf.pos)
		statusBar.TextColor3 = Color3.fromRGB(100, 200, 130)
		statusBar.Text = "✓ Jumped to shelf " .. label
		task.delay(3, function()
			if statusBar then statusBar.Text = "" end
		end)
	end)
end

-- Replace UIGridLayout with a vertical list layout
gridLayout:Destroy()

local shelfListLayout = Instance.new("UIListLayout")
shelfListLayout.FillDirection = Enum.FillDirection.Vertical
shelfListLayout.SortOrder     = Enum.SortOrder.LayoutOrder
shelfListLayout.Padding       = UDim.new(0, 6)
shelfListLayout.Parent        = shelfGrid

local function makeFloorHeader(text)
	local lbl = Instance.new("TextLabel")
	lbl.Size               = UDim2.new(1, -12, 0, 18)
	lbl.BackgroundTransparency = 1
	lbl.TextColor3         = Color3.fromRGB(140, 150, 190)
	lbl.TextSize           = 11
	lbl.Font               = Enum.Font.GothamBold
	lbl.TextXAlignment     = Enum.TextXAlignment.Left
	lbl.Text               = text
	lbl.Parent             = shelfGrid
	return lbl
end

local function makeRow(labels)
	local row = Instance.new("Frame")
	row.Size                = UDim2.new(1, -12, 0, 44)
	row.BackgroundTransparency = 1
	row.Parent              = shelfGrid

	local rowLayout = Instance.new("UIListLayout")
	rowLayout.FillDirection = Enum.FillDirection.Horizontal
	rowLayout.SortOrder     = Enum.SortOrder.LayoutOrder
	rowLayout.Padding       = UDim.new(0, 6)
	rowLayout.Parent        = row

	for _, label in ipairs(labels) do
		local shelf = shelfByLabel[label]
		if not shelf then continue end

		local colors   = getFloorColors(label)
		local bgColor  = colors[1]
		local txtColor = colors[2]

		local btn = Instance.new("TextButton")
		btn.Size             = UDim2.new(0, 58, 1, 0)
		btn.BackgroundColor3 = bgColor
		btn.TextColor3       = txtColor
		btn.Text             = label
		btn.TextSize         = 15
		btn.Font             = Enum.Font.GothamBold
		btn.BorderSizePixel  = 0
		btn.Parent           = row
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

		local stroke = Instance.new("UIStroke")
		stroke.Color        = txtColor
		stroke.Thickness    = 1
		stroke.Transparency = 0.6
		stroke.Parent       = btn

		btn.MouseEnter:Connect(function()
			btn.BackgroundColor3 = Color3.new(
				math.clamp(bgColor.R + 0.12, 0, 1),
				math.clamp(bgColor.G + 0.12, 0, 1),
				math.clamp(bgColor.B + 0.12, 0, 1)
			)
			stroke.Transparency = 0.1
		end)
		btn.MouseLeave:Connect(function()
			btn.BackgroundColor3 = bgColor
			stroke.Transparency  = 0.6
		end)
		btn.MouseButton1Click:Connect(function()
			local char2 = player.Character
			local root  = char2 and char2:FindFirstChild("HumanoidRootPart")
			if not root then return end
			root.CFrame = CFrame.new(shelf.pos)
			statusBar.TextColor3 = Color3.fromRGB(100, 200, 130)
			statusBar.Text = "✓ Jumped to shelf " .. label
			task.delay(3, function()
				if statusBar then statusBar.Text = "" end
			end)
		end)
	end
end

-- Floor 1
makeFloorHeader("── Floor 1 ──────────────────────")
makeRow({ "1A", "1C", "1E", "1G", "1I" })
makeRow({ "1B", "1D", "1F", "1H", "1J" })

-- Spacer between floors
local spacer = Instance.new("Frame")
spacer.Size                = UDim2.new(1, 0, 0, 4)
spacer.BackgroundTransparency = 1
spacer.Parent              = shelfGrid

-- Floor 2
makeFloorHeader("── Floor 2 ──────────────────────")
makeRow({ "2A", "2C", "2E" })
makeRow({ "2B", "2D", "2F" })


-- =====================
-- G KEYBIND (cycle ESP'd books by index)
-- =====================
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode ~= Enum.KeyCode.G then return end

	local char = player.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end

	local targets = getSortedESPTargets()
	if #targets == 0 then return end

	currentTeleportIndex = (currentTeleportIndex % #targets) + 1
	local target = targets[currentTeleportIndex]
	root.CFrame = CFrame.new(target.pos + Vector3.new(0, 4, 0))

	statusBar.TextColor3 = Color3.fromRGB(150, 230, 255)
	statusBar.Text = "⚡ [G] → " .. target.obj.Name .. " (" .. currentTeleportIndex .. "/" .. #targets .. ")"
	task.delay(2, function()
		if statusBar then statusBar.Text = "" end
	end)
end)
