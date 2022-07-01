local _G = _G
local ipairs = ipairs
local hooksecurefunc = hooksecurefunc

local MovAny = _G.MovAny
local MOVANY = _G.MOVANY

local cats = {
	{name = "Achievements & Quests", displayName = MOVANY.CAT_ACHIEVEMENTS_QUESTS},
	{name = "Arena", displayName = MOVANY.CAT_ARENA},
	{name = "Blizzard Action Bars", displayName = MOVANY.CAT_BLIZZARD_ACTION_BARS},
	{name = "Blizzard Bags", displayName = MOVANY.CAT_BLIZZARD_BAGS},
	{name = "Blizzard Bank and VoidStorage", displayName = MOVANY.CAT_BLIZZARD_BANK_AND_VOID_STORAGE},
	{name = "Blizzard Bottom Bar", displayName = MOVANY.CAT_BLIZZARD_BOTTOM_BAR},
	{name = "Battlegrounds & PvP", displayName = MOVANY.CAT_BATTLEGROUNDS_PVP},
	{name = "Class Specific", displayName = MOVANY.CAT_CLASS_SPECIFIC},
	{name = "Dungeons & Raids", displayName = MOVANY.CAT_DUNGEONS_RAIDS},
	{name = "Boss Specific Frames", displayName = MOVANY.CAT_BOSS_SPECIFIC_FRAMES},
	{name = "Game Menu", displayName = MOVANY.CAT_GAME_MENU},
	{name = "Garrison", displayName = MOVANY.CAT_GARRISON},
	{name = "Shipyard", displayName = MOVANY.CAT_SHIPYARD},
	{name = "Order Hall", displayName = MOVANY.CAT_ORDER_HALL},
	{name = "Guild", displayName = MOVANY.CAT_GUILD},
	{name = "Info Panels", displayName = MOVANY.CAT_INFO_PANELS},
	{name = "Loot", displayName = MOVANY.CAT_LOOT},
	{name = "Map", displayName = MOVANY.CAT_MAP},
	{name = "Minimap", displayName = MOVANY.CAT_MINIMAP},
	{name = "Miscellaneous", displayName = MOVANY.CAT_MISCELLANEOUS},
	{name = "MoveAnything", displayName = MOVANY.CAT_MOVE_ANYTHING},
	{name = "Unit: Focus", displayName = MOVANY.CAT_UNIT_FOCUS},
	{name = "Unit: Party", displayName = MOVANY.CAT_UNIT_PARTY},
	{name = "Unit: Pet", displayName = MOVANY.CAT_UNIT_PET},
	{name = "Unit: Player", displayName = MOVANY.CAT_UNIT_PLAYER},
	{name = "Unit: Target", displayName = MOVANY.CAT_UNIT_TARGET},
	{name = "Vehicle", displayName = MOVANY.CAT_VEHICLE},
	{name = "PetBattle", displayName = MOVANY.CAT_PET_BATTLE},
	{name = "Store", displayName = MOVANY.CAT_STORE},
}

local API

local m = {
	Enable = function(self)
		API = MovAny.API
		self:LoadList()
		MovAny:DeleteModule(self)
		API = nil
		--m = nil
	end,
	LoadList = function(self)
		API.default = true
		for i, c in ipairs(cats) do
			API:AddCategory(c)
		end
		cats = nil
		local c, e
		c = API:GetCategory("Achievements & Quests")
		API:AddElement({name = "AchievementFrame", displayName = MOVANY.EL_ACHIEVEMENTS}, c)
		local gcaf
		if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
			API:AddElement({name = "AchievementAlertFrame1", displayName = MOVANY.EL_ACHIEVEMENT_ALERT_1, runOnce = AchievementFrame_LoadUI, create = "AchievementAlertFrameTemplate"}, c)
			API:AddElement({name = "AchievementAlertFrame2", displayName = MOVANY.EL_ACHIEVEMENT_ALERT_2, runOnce = AchievementFrame_LoadUI, create = "AchievementAlertFrameTemplate"}, c)
			API:AddElement({name = "CriteriaAlertFrame1", displayName = MOVANY.EL_CRITERIA_ALERT_1, create = "CriteriaAlertFrameTemplate"}, c)
			API:AddElement({name = "CriteriaAlertFrame2", displayName = MOVANY.EL_CRITERIA_ALERT_2, create = "CriteriaAlertFrameTemplate"}, c)
			gcaf = API:AddElement({name = "GuildChallengeAlertFrame", displayName = MOVANY.EL_GUILD_CHALLENGE_ACHIEVEMENT_ALERT}, c)
		end
		API:AddElement({name = "ObjectiveTrackerFrameMover", displayName = MOVANY.EL_OBJECTIVES_WINDOW, scaleWH = 1}, c)
		API:AddElement({name = "ObjectiveTrackerFrameScaleMover", displayName = MOVANY.EL_OBJECTIVES_WINDOW_SCALE}, c)
		API:AddElement({name = "ObjectiveTrackerBonusBannerFrame", displayName = MOVANY.EL_OBJECTIVES_BANNER_FRAME}, c)
		--[[local qldf = API:AddElement({name = "QuestLogDetailFrame", displayName = MOVANY.EL_QUEST_DETAILS, runOnce = function()
			if not QuestLogDetailFrame:IsShown() then
				ShowUIPanel(QuestLogDetailFrame)
				HideUIPanel(QuestLogDetailFrame)
			end
		end}, c)]]
		if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
			API:AddElement({name = "QuestLogPopupDetailFrame", displayName = MOVANY.EL_QUEST_DETAILS}, c)
		end
		API:AddElement({name = "QuestNPCModel", displayName = MOVANY.EL_QUEST_LOG_NPC_MODEL}, c)
		local qf = API:AddElement({name = "QuestFrame", displayName = MOVANY.EL_QUEST_OFFER_RETURN, runOnce = function()
			hooksecurefunc(WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC and QuestFrame or QuestLogFrame, "Show", function()
				if MovAny:IsModified("QuestFrame") then
					HideUIPanel(GossipFrame)
				end
			end)
			hooksecurefunc("DeclineQuest", function()
				HideUIPanel(GossipFrame)
			end)
		end}, c)
		API:AddElement({name = "QuestChoiceFrame", displayName = MOVANY.EL_QUEST_CHOICE_FRAME}, c)
		API:AddElement({name = "WorldQuestCompleteAlertFrame", displayName = MOVANY.EL_WORLD_QUEST_COMPLETE_ALERT}, c)
		API:AddElement({name = "TalkingHeadFrame", displayName = MOVANY.EL_QUEST_TALKING_HEAD_FRAME, runOnce = TalkingHead_LoadUI}, c)
		--API:AddElement({name = "QuestTimerFrame", displayName = MOVANY.EL_QUEST_TIMER}, c)
		c = API:GetCategory("Arena")
		--API:AddElement({name = "ArenaEnemyFrames", displayName = MOVANY.EL_ARENA_ENEMY_FRAMES, noScale = 1}, c)
		--API:AddElement({name = "ArenaPrepFrames", displayName = MOVANY.EL_ARENA_PREP_FRAMES, noScale = 1}, c)
		API:AddElement({name = "ArenaEnemyFrame1", displayName = MOVANY.EL_ARENA_ENEMY_1, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame2", displayName = MOVANY.EL_ARENA_ENEMY_2, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame3", displayName = MOVANY.EL_ARENA_ENEMY_3, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame4", displayName = MOVANY.EL_ARENA_ENEMY_4, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame5", displayName = MOVANY.EL_ARENA_ENEMY_5, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		local ttt1 = API:AddElement({name = "TimerTrackerTimer1", displayName = MOVANY.EL_TIMER_TRACKER}, c)
		API:AddElement({name = "ArenaEnemyFrame1PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_PET_1, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame2PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_PET_2, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame3PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_PET_3, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame4PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_PET_4, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame5PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_PET_5, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame1CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_CASTING_BAR_1, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame2CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_CASTING_BAR_2, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame3CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_CASTING_BAR_3, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame4CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_CASTING_BAR_4, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame5CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_CASTING_BAR_5, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		--API:AddElement({name = "PVPTeamDetails", displayName = MOVANY.EL_ARENA_TEAM_DETAILS}, c)
		--API:AddElement({name = "ArenaFrame", displayName = MOVANY.EL_ARENA_QUEUE_LIST}, c)
		--API:AddElement({name = "ArenaRegistrarFrame", displayName = MOVANY.EL_ARENA_REGISTRAR}, c)
		--API:AddElement({name = "PVPBannerFrame", displayName = MOVANY.EL_ARENA_BANNER}, c)
		API:AddElement({name = "ArenaPrepFrame1", displayName = MOVANY.EL_ARENA_PREP_1, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame2", displayName = MOVANY.EL_ARENA_PREP_2, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame3", displayName = MOVANY.EL_ARENA_PREP_3, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame4", displayName = MOVANY.EL_ARENA_PREP_4, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame5", displayName = MOVANY.EL_ARENA_PREP_5, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		c = API:GetCategory("Battlegrounds & PvP")
		local pvpf = API:AddElement({name = "PVPUIFrame", displayName = MOVANY.EL_PVP_WINDOW}, c)
		API:AddElement({name = "PVPReadyDialog", displayName = MOVANY.EL_PVP_READY_DIALOG}, c)
		API:AddElement({name = "PVPReadyPopup", displayName = MOVANY.EL_PVP_READY_POPUP}, c)
		ttt1:AddCategory(c)
		--API:AddElement({name = "BattlefieldMinimap", displayName = MOVANY.EL_BATTLEFIELD_MINI_MAP}, c)
		--API:AddElement({name = "MiniMapBattlefieldFrame", displayName = MOVANY.EL_BATTLEGROUND_MINIMAP_BUTTON}, c)
		API:AddElement({name = "QueueStatusMinimapButton", displayName = MOVANY.EL_BATTLEGROUND_MINIMAP_BUTTON}, c)
		API:AddElement({name = "QueueStatusFrame", displayName = MOVANY.EL_BATTLEGROUND_MINIMAP_BUTTON_TOOLTIP}, c)
		--API:AddElement({name = "BattlefieldFrame", displayName = MOVANY.EL_BATTLEGROUND_QUEUE}, c)
		API:AddElement({name = "UIWidgetTopCenterContainerFrame", displayName = MOVANY.EL_BATTLEGROUND_SCOREBOARD}, c)
		API:AddElement({name = "UIWidgetBelowMinimapContainerFrame", displayName = MOVANY.EL_FLAG_CAPTURE_TIMER_BAR, onlyOnceCreated = 1}, c)
		local wsauf = API:AddElement({name = "WorldStateAlwaysUpFrame", displayName = MOVANY.EL_TOP_CENTER_STATUS_DISPLAY, noUnanchorRelatives = 1}, c)
		API:AddElement({name = "AlwaysUpFrame1", displayName = MOVANY.EL_ALWAYS_UP_FRAME_1, create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)
		API:AddElement({name = "AlwaysUpFrame2", displayName = MOVANY.EL_ALWAYS_UP_FRAME_2, create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)
		API:AddElement({name = "AlwaysUpFrame3", displayName = MOVANY.EL_ALWAYS_UP_FRAME_3, create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)
		API:AddElement({name = "PrestigeLevelUpBanner", displayName = MOVANY.EL_PRESTIGE_BANNER}, c)
		c = API:GetCategory("Blizzard Bags")
		API:AddElement({name = "BagsMover", displayName = MOVANY.EL_ALL_BAGS, noHide = 1}, c)
		API:AddElement({name = "BagButtonsVerticalMover", displayName = MOVANY.EL_BAG_BUTTONS_VERTICAL}, c)
		API:AddElement({name = "BagItemSearchBox", displayName = MOVANY.EL_BAG_ITEM_SEARCH}, c)
		API:AddElement({name = "BagItemAutoSortButton", displayName = MOVANY.EL_CLEAN_UP_BAGS}, c)
		API:AddElement({name = "BagFrame1", displayName = MOVANY.EL_BACKPACK}, c)
		API:AddElement({name = "BagFrame2", displayName = MOVANY.EL_BAG_1}, c) --refuseSync = 1
		API:AddElement({name = "BagFrame3", displayName = MOVANY.EL_BAG_2}, c)
		API:AddElement({name = "BagFrame4", displayName = MOVANY.EL_BAG_3}, c)
		API:AddElement({name = "BagFrame5", displayName = MOVANY.EL_BAG_4}, c)
		--API:AddElement({name = "KeyRingFrame", displayName = MOVANY.EL_KEY_RING}, c)
		API:AddElement({name = "MainMenuBarBackpackButton", displayName = MOVANY.EL_BACKPACK_BUTTON}, c)
		API:AddElement({name = "CharacterBag0Slot", displayName = MOVANY.EL_BAG_BUTTON_1}, c)
		API:AddElement({name = "CharacterBag1Slot", displayName = MOVANY.EL_BAG_BUTTON_2}, c)
		API:AddElement({name = "CharacterBag2Slot", displayName = MOVANY.EL_BAG_BUTTON_3}, c)
		API:AddElement({name = "CharacterBag3Slot", displayName = MOVANY.EL_BAG_BUTTON_4}, c)
		--API:AddElement({name = "KeyRingButton", displayName = MOVANY.EL_KEY_RING_BUTTON}, c)
		c = API:GetCategory("Blizzard Action Bars")
		API:AddElement({name = "BasicActionButtonsMover", displayName = MOVANY.EL_ACTION_BAR, --[[linkedScaling = {"ActionBarDownButton", "ActionBarUpButton"}--]]}, c)
		API:AddElement({name = "BasicActionButtonsVerticalMover", displayName = MOVANY.EL_ACTION_BAR_VERTICAL}, c)
		API:AddElement({name = "MultiBarBottomLeft", displayName = MOVANY.EL_BOTTOM_LEFT_ACTION_BAR}, c)
		API:AddElement({name = "MultiBarBottomRight", displayName = MOVANY.EL_BOTTOM_RIGHT_ACTION_BAR}, c)
		--[[API:AddElement({name = "MultiBarRightMovert", displayName = MOVANY.EL_RIGHT_ACTION_BAR, run = function()
			if MovAny:IsModified("MultiBarRightHorizontalMover") then
				MovAny:ResetFrame("MultiBarRightHorizontalMover")
			end
		end}, c)]]
		API:AddElement({name = "MultiBarRightMover", displayName = MOVANY.EL_RIGHT_ACTION_BAR}, c)
		API:AddElement({name = "MultiBarRightHorizontalMover", displayName = MOVANY.EL_RIGHT_ACTION_BAR_HORIZONTAL}, c)
		--[[API:AddElement({name = "MultiBarLeft", displayName = MOVANY.EL_RIGHT_ACTION_BAR_2, run = function()
			if MovAny:IsModified("MultiBarLeftHorizontalMover") then
				MovAny:ResetFrame("MultiBarLeftHorizontalMover")
			end
		end}, c)]] --MultiBarLeftMover
		API:AddElement({name = "MultiBarLeftMover", displayName = MOVANY.EL_RIGHT_ACTION_BAR_2}, c)
		API:AddElement({name = "MultiBarLeftHorizontalMover", displayName = MOVANY.EL_RIGHT_ACTION_BAR_2_HORIZONTAL}, c)
		--API:AddElement({name = "MainMenuBarPageNumber", displayName = MOVANY.EL_ACTION_BAR_PAGE_NUMBER}, c)
		API:AddElement({name = "MainMenuBarPageNumberMover", displayName = MOVANY.EL_ACTION_BAR_PAGE_NUMBER}, c)
		API:AddElement({name = "ActionBarUpButton", displayName = MOVANY.EL_ACTION_BAR_PAGE_UP}, c)
		API:AddElement({name = "ActionBarDownButton", displayName = MOVANY.EL_ACTION_BAR_PAGE_DOWN}, c)
		API:AddElement({name = "ExtraAbilityContainer", displayName = MOVANY.EL_EXTRA_ABILITY_BAR}, c)
		API:AddElement({name = "UIWidgetPowerBarContainerFrame", displayName = MOVANY.EL_POWER_ABILITY_BAR}, c)
		API:AddElement({name = "PetActionButtonsMover", displayName = MOVANY.EL_PET_ACTION_BAR}, c)
		API:AddElement({name = "PetActionButtonsVerticalMover", displayName = MOVANY.EL_PET_ACTION_BAR_VERTICAL}, c)
		API:AddElement({name = "StanceButtonsMover", displayName = MOVANY.EL_STANCE_BUTTONS}, c)
		API:AddElement({name = "StanceButtonsVerticalMover", displayName = MOVANY.EL_STANCE_BUTTONS_VERTICAL}, c)
		c = API:GetCategory("Blizzard Bank and VoidStorage")
		local bf = API:AddElement({name = "BankFrame", displayName = MOVANY.EL_BANK}, c)
		API:AddElement({name = "BankItemSearchBox", displayName = MOVANY.EL_BANK_ITEM_SEARCH}, c)
		API:AddElement({name = "BankItemAutoSortButton", displayName = MOVANY.EL_BANK_CLEANUP}, c)
		API:AddElement({name = "BankBagItemsMover", displayName = MOVANY.EL_BANK_BAG_ITEMS}, c)
		API:AddElement({name = "BankBagSlotsMover", displayName = MOVANY.EL_BANK_BAG_SLOTS}, c)
		--[[API:AddElement({name = "BankFrameBag1", displayName = MOVANY.EL_BANK_BAG_SLOT_1}, c)
		API:AddElement({name = "BankFrameBag2", displayName = MOVANY.EL_BANK_BAG_SLOT_2}, c)
		API:AddElement({name = "BankFrameBag3", displayName = MOVANY.EL_BANK_BAG_SLOT_3}, c)
		API:AddElement({name = "BankFrameBag4", displayName = MOVANY.EL_BANK_BAG_SLOT_4}, c)
		API:AddElement({name = "BankFrameBag5", displayName = MOVANY.EL_BANK_BAG_SLOT_5}, c)
		API:AddElement({name = "BankFrameBag6", displayName = MOVANY.EL_BANK_BAG_SLOT_6}, c)
		API:AddElement({name = "BankFrameBag7", displayName = MOVANY.EL_BANK_BAG_SLOT_7}, c)]]
		API:AddElement({name = "BankFrameMoneyFrame", displayName = MOVANY.EL_BANK_MONEY}, c)
		API:AddElement({name = "BankFrameMoneyFrameGoldButton", displayName = MOVANY.EL_BANK_MONEY_GOLD}, c)
		API:AddElement({name = "BankFrameMoneyFrameSilverButton", displayName = MOVANY.EL_BANK_MONEY_SILVER}, c)
		API:AddElement({name = "BankFrameMoneyFrameCopperButton", displayName = MOVANY.EL_BANK_MONEY_COPPER}, c)
		--API:AddElement({name = "BankFrameMoneyFrameBorder", displayName = MOVANY.EL_BANK_MONEY_BORDER}, c)
		--API:AddElement({name = "BankFrameMoneyFrameInset", displayName = MOVANY.EL_BANK_MONEY_INSET}, c)
		API:AddElement({name = "BankBagFrame1", displayName = MOVANY.EL_BANK_BAG_1}, c)
		API:AddElement({name = "BankBagFrame2", displayName = MOVANY.EL_BANK_BAG_2}, c)
		API:AddElement({name = "BankBagFrame3", displayName = MOVANY.EL_BANK_BAG_3}, c)
		API:AddElement({name = "BankBagFrame4", displayName = MOVANY.EL_BANK_BAG_4}, c)
		API:AddElement({name = "BankBagFrame5", displayName = MOVANY.EL_BANK_BAG_5}, c)
		API:AddElement({name = "BankBagFrame6", displayName = MOVANY.EL_BANK_BAG_6}, c)
		API:AddElement({name = "BankBagFrame7", displayName = MOVANY.EL_BANK_BAG_7}, c)
		local gbf = API:AddElement({name = "GuildBankFrame", displayName = MOVANY.EL_GUILD_BANK}, c)
		local gbt1 = API:AddElement({name = "GuildBankTab1", displayName = MOVANY.EL_GUILD_BANK_TAB_1}, c)
		local gbt2 = API:AddElement({name = "GuildBankTab2", displayName = MOVANY.EL_GUILD_BANK_TAB_2}, c)
		local gbt3 = API:AddElement({name = "GuildBankTab3", displayName = MOVANY.EL_GUILD_BANK_TAB_3}, c)
		local gbt4 = API:AddElement({name = "GuildBankTab4", displayName = MOVANY.EL_GUILD_BANK_TAB_4}, c)
		local gbt5 = API:AddElement({name = "GuildBankTab5", displayName = MOVANY.EL_GUILD_BANK_TAB_5}, c)
		local gbt6 = API:AddElement({name = "GuildBankTab6", displayName = MOVANY.EL_GUILD_BANK_TAB_6}, c)
		local gbt7 = API:AddElement({name = "GuildBankTab7", displayName = MOVANY.EL_GUILD_BANK_TAB_7}, c)
		local gbt8 = API:AddElement({name = "GuildBankTab8", displayName = MOVANY.EL_GUILD_BANK_TAB_8}, c)
		local gisb = API:AddElement({name = "GuildItemSearchBox", displayName = MOVANY.EL_GUILD_BANK_ITEM_SEACH}, c)
		local gbis = API:AddElement({name = "GuildBankInfoSaveButton", displayName = MOVANY.EL_GUILD_BANK_SAVE_BUTTON}, c)
		local gbfw = API:AddElement({name = "GuildBankFrameWithdrawButton", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_BUTTON}, c)
		local gbfd = API:AddElement({name = "GuildBankFrameDepositButton", displayName = MOVANY.EL_GUILD_BANK_DEPOSIT_BUTTON}, c)
		local gbwm = API:AddElement({name = "GuildBankWithdrawMoneyFrame", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY}, c)
		local gbwmg = API:AddElement({name = "GuildBankWithdrawMoneyFrameGoldButton", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY_GOLD}, c)
		local gbwms = API:AddElement({name = "GuildBankWithdrawMoneyFrameSilverButton", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY_SILVER}, c)
		local gbwmc = API:AddElement({name = "GuildBankWithdrawMoneyFrameCopperButton", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY_COPPER}, c)
		local gbmf = API:AddElement({name = "GuildBankMoneyFrame", displayName = MOVANY.EL_GUILD_BANK_MONEY}, c)
		local gbmfg = API:AddElement({name = "GuildBankMoneyFrameGoldButton", displayName = MOVANY.EL_GUILD_BANK_MONEY_GOLD}, c)
		local gbmfs = API:AddElement({name = "GuildBankMoneyFrameSilverButton", displayName = MOVANY.EL_GUILD_BANK_MONEY_SILVER}, c)
		local gbmfc = API:AddElement({name = "GuildBankMoneyFrameCopperButton", displayName = MOVANY.EL_GUILD_BANK_MONEY_COPPER}, c)
		API:AddElement({name = "VoidStorageFrame", displayName = MOVANY.EL_VOID_STORAGE}, c) --refuseSync = MOVANY.FRAME_ONLY_WHEN_VOIDSTORAGE_IS_OPEN
		c = API:GetCategory("Blizzard Bottom Bar")
		--[[API:AddElement({name = "MainMenuBar", displayName = MOVANY.EL_MAIN_BAR, run = function ()
			if not MovAny:IsModified(OverrideActionBar) then
				local v = _G["OverrideActionBar"]
				v:ClearAllPoints()
				v:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", (UIParentGetWidth() / 2) - (v:GetWidth() / 2), 0)
			end
		end, hideList = {
				{"MainMenuBarArtFrameBackground", "BACKGROUND", "ARTWORK"},
				{"MainMenuBarArtFrame", "BACKGROUND", "ARTWORK"},
				{"PetActionBarFrame", "OVERLAY"},
				{"StanceBarFrame", "OVERLAY"},
				{"MainMenuBar", "DISABLEMOUSE"},
			}
		}, c)
		API:AddElement({name = "MainMenuBarArtFrameLeftEndCapMover", displayName = MOVANY.EL_LEFT_GRYPHON, noScale = 1}, c)
		API:AddElement({name = "MainMenuBarArtFrameRightEndCapMover", displayName = MOVANY.EL_RIGHT_GRYPHON, noScale = 1}, c)
		API:AddElement({name = "MainMenuExpBar", displayName = MOVANY.EL_EXPERIENCE_BAR, scaleWH = 1, hideOnScale = {
			MainMenuXPBarTexture0,
			MainMenuXPBarTexture1,
			MainMenuXPBarTexture2,
			MainMenuXPBarTexture3,
			ExhaustionTick,
			ExhaustionTickNormal,
			ExhaustionTickHighlight,
			ExhaustionLevelFillBar,
			MainMenuXPBarTextureLeftCap,
			MainMenuXPBarTextureRightCap,
			MainMenuXPBarTextureMid,
			MainMenuXPBarDiv1,
			MainMenuXPBarDiv2,
			MainMenuXPBarDiv3,
			MainMenuXPBarDiv4,
			MainMenuXPBarDiv5,
			MainMenuXPBarDiv6,
			MainMenuXPBarDiv7,
			MainMenuXPBarDiv8,
			MainMenuXPBarDiv9,
			MainMenuXPBarDiv10,
			MainMenuXPBarDiv11,
			MainMenuXPBarDiv12,
			MainMenuXPBarDiv13,
			MainMenuXPBarDiv14,
			MainMenuXPBarDiv15,
			MainMenuXPBarDiv16,
			MainMenuXPBarDiv17,
			MainMenuXPBarDiv18,
			MainMenuXPBarDiv19,
			}, runOnce = function()
				hooksecurefunc("MainMenuExpBar_SetWidth", function()
					MovAny.API:SyncElement("MainMenuExpBar")
				end)
			end
		}, c)--]]
		--API:AddElement({name = "HonorWatchBar", displayName = MOVANY.EL_HONOR_BAR}, c)
		--API:AddElement({name = "ArtifactWatchBar", displayName = MOVANY.EL_ARTIFACT_BAR}, c)
		--API:AddElement({name = "MainMenuBarMaxLevelBar", displayName = MOVANY.EL_MAX_LEVEL_BAR_FILLER, noFE = 1, noScale = 1}, c)
		--[[API:AddElement({name = "ReputationWatchBar", displayName = MOVANY.EL_REPUTATION_TRACKER_BAR, runOnce = function()
			if ReputationWatchBar_Update then
				hooksecurefunc("ReputationWatchBar_Update", MovAny.hReputationWatchBar_Update)
			end
		end, scaleWH = 1, linkedScaling = {"ReputationWatchStatusBar"}, hideOnScale = {
				ReputationWatchBarTexture0,
				ReputationWatchBarTexture1,
				ReputationWatchBarTexture2,
				ReputationWatchBarTexture3,
				ReputationXPBarTexture0,
				ReputationXPBarTexture1,
				ReputationXPBarTexture2,
				ReputationXPBarTexture3,
			}
		}, c)--]]
		API:AddElement({name = "MicroButtonAndBagsBar", displayName = MOVANY.EL_MICRO_BAGS_BAR}, c)
		API:AddElement({name = "BagButtonsMover", displayName = MOVANY.EL_BAG_BUTTONS}, c)
		API:AddElement({name = "MicroButtonsMover", displayName = MOVANY.EL_MICRO_MENU}, c)
		--API:AddElement({name = "MicroButtonsSplitMover", displayName = MOVANY.EL_MICRO_MENU_SPLIT}, c)
		--API:AddElement({name = "MicroButtonsVerticalMover", displayName = MOVANY.EL_MICRO_MENU_VERTICAL}, c)
		API:AddElement({name = "MainMenuBarVehicleLeaveButton", displayName = MOVANY.EL_LEAVE_VEHICLE_BUTTON}, c)
		c = API:GetCategory("Class Specific")
		API:AddElement({name = "PlayerFrameAlternateManaBar", displayName = MOVANY.EL_ALTERNATE_MANA_BAR}, c)
		API:AddElement({name = "ComboPointPlayerFrame", displayName = MOVANY.EL_COMBO_POINT_FRAME}, c)
		API:AddElement({name = "RuneFrame", displayName = MOVANY.EL_DEATHKNIGHT_RUNE_FRAME}, c)
		API:AddElement({name = "PaladinPowerBarFrame", displayName = MOVANY.EL_PALADIN_POWER_FRAME}, c)
		API:AddElement({name = "MageArcaneChargesFrame", displayName = MOVANY.EL_MAGE_ARCANE_CHARGES_POWER_FRAME}, c)
		API:AddElement({name = "WarlockPowerFrame", displayName = MOVANY.EL_WARLOCK_POWER_FRAME}, c)
		API:AddElement({name = "MonkHarmonyBarFrameMover", displayName = MOVANY.EL_MONK_CHI_FRAME}, c)
		API:AddElement({name = "MonkStaggerBar", displayName = MOVANY.EL_MONK_STAGGER_FRAME}, c)
		API:AddElement({name = "MultiCastActionBarFrame", displayName = MOVANY.EL_SHAMAN_TOTEM_FRAME}, c)
		API:AddElement({name = "TotemFrame", displayName = MOVANY.EL_TOTEM_FRAME}, c)
		c = API:GetCategory("Dungeons & Raids")
		API:AddElement({name = "PVEFrame", displayName = MOVANY.EL_DUNGEON_FINDER}, c)
		API:AddElement({name = "EncounterJournal", displayName = MOVANY.EL_DUNGEON_JOURNAL}, c)
		--API:AddElement({name = "LFGSearchStatus", displayName = MOVANY.EL_DUNGEON_RAID_FINDER_QUEUE_STATUS}, c)
		API:AddElement({name = "ChallengesKeystoneFrame", displayName = MOVANY.EL_CHALLENGE_KEYSTONE}, c)
		API:AddElement({name = "DungeonCompletionAlertFrame1", displayName = MOVANY.EL_DUNGEON_COMPLETION_ALERT}, c)
		API:AddElement({name = "ScenarioAlertFrame1", displayName = MOVANY.EL_SCENARIO_COMPLETION_ALERT_1}, c)
		API:AddElement({name = "ScenarioAlertFrame2", displayName = MOVANY.EL_SCENARIO_COMPLETION_ALERT_2}, c)
		API:AddElement({name = "LevelUpDisplay", displayName = MOVANY.EL_LEVEL_UP_DISPLAY}, c)
		API:AddElement({name = "QueueStatusMinimapButton", displayName = MOVANY.EL_DUNGEON_STATUS_BUTTON}, c)
		API:AddElement({name = "QueueStatusFrame", displayName = MOVANY.EL_DUNGEON_STATUS_BUTTON_TOOLTIP}, c)
		API:AddElement({name = "LFGDungeonReadyDialog", displayName = MOVANY.EL_DUNGEON_READY_DIALOG}, c)
		API:AddElement({name = "LFGDungeonReadyPopup", displayName = MOVANY.EL_DUNGEON_READY_POPUP}, c)
		API:AddElement({name = "LFGDungeonReadyStatus", displayName = MOVANY.EL_DUNGEON_READY_STATUS}, c)
		API:AddElement({name = "LFDRoleCheckPopup", displayName = MOVANY.EL_DUNGEON_ROLE_CHECK_POPUP}, c)
		API:AddElement({name = "RaidBossEmoteFrame", displayName = MOVANY.EL_RAID_BOSS_EMOTE_DISPLAY}, c)
		API:AddElement({name = "Boss1TargetFrame", displayName = MOVANY.EL_RAID_BOSS_HEALTH_BAR_1, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss1TargetFramePowerBarAlt", displayName = MOVANY.EL_RAID_BOSS_POWER_BAR_1}, c)
		API:AddElement({name = "Boss2TargetFrame", displayName = MOVANY.EL_RAID_BOSS_HEALTH_BAR_2, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss2TargetFramePowerBarAlt", displayName = MOVANY.EL_RAID_BOSS_POWER_BAR_2}, c)
		API:AddElement({name = "Boss3TargetFrame", displayName = MOVANY.EL_RAID_BOSS_HEALTH_BAR_3, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss3TargetFramePowerBarAlt", displayName = MOVANY.EL_RAID_BOSS_POWER_BAR_3}, c)
		API:AddElement({name = "Boss4TargetFrame", displayName = MOVANY.EL_RAID_BOSS_HEALTH_BAR_4, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss4TargetFramePowerBarAlt", displayName = MOVANY.EL_RAID_BOSS_POWER_BAR_4}, c)
		API:AddElement({name = "Boss5TargetFrame", displayName = MOVANY.EL_RAID_BOSS_HEALTH_BAR_5, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss5TargetFramePowerBarAlt", displayName = MOVANY.EL_RAID_BOSS_POWER_BAR_5}, c)
		API:AddElement({name = "RaidBrowserFrame", displayName = MOVANY.EL_OTHER_RAIDS}, c)
		--API:AddElement({name = "RaidParentFrame", displayName = MOVANY.EL_RAID_FINDER}, c)
		API:AddElement({name = "CompactRaidGroup1", displayName = MOVANY.EL_RAID_GROUP_1}, c)
		API:AddElement({name = "CompactRaidGroup2", displayName = MOVANY.EL_RAID_GROUP_2}, c)
		API:AddElement({name = "CompactRaidGroup3", displayName = MOVANY.EL_RAID_GROUP_3}, c)
		API:AddElement({name = "CompactRaidGroup4", displayName = MOVANY.EL_RAID_GROUP_4}, c)
		API:AddElement({name = "CompactRaidGroup5", displayName = MOVANY.EL_RAID_GROUP_5}, c)
		API:AddElement({name = "CompactRaidGroup6", displayName = MOVANY.EL_RAID_GROUP_6}, c)
		API:AddElement({name = "CompactRaidGroup7", displayName = MOVANY.EL_RAID_GROUP_7}, c)
		API:AddElement({name = "CompactRaidGroup8", displayName = MOVANY.EL_RAID_GROUP_8}, c)
		API:AddElement({name = "CompactRaidFrameManager", displayName = MOVANY.EL_RAID_MANAGER}, c)
		API:AddElement({name = "CompactRaidFrameManagerToggleButton", displayName = MOVANY.EL_RAID_MANAGER_TOGGLE_BUTTON, onlyOnceCreated = 1}, c)
		API:AddElement({name = "CompactRaidFrameBuffTooltipsMover", displayName = MOVANY.EL_RAID_FRAME_BUFF_TOOLTIPS}, c)
		API:AddElement({name = "CompactRaidFrameDebuffTooltipsMover", displayName = MOVANY.EL_RAID_FRAME_DEBUFF_TOOLTIPS}, c)
		API:AddElement({name = "RolePollPopup", displayName = MOVANY.EL_RAID_ROLE_POPUP}, c)
		API:AddElement({name = "RaidUnitFramesMover", displayName = MOVANY.EL_RAID_UNIT_FRAMES}, c)
		API:AddElement({name = "RaidWarningFrame", displayName = MOVANY.EL_RAID_WARNINGS}, c)
		API:AddElement({name = "ReadyCheckFrame", displayName = MOVANY.EL_READY_CHECK}, c)
		c = API:GetCategory("Boss Specific Frames")
		API:AddElement({name = "BossBanner", displayName = MOVANY.EL_BOSS_BANNER}, c)
		local pbab = API:AddElement({name = "PlayerPowerBarAltMover", displayName = MOVANY.EL_PLAYER_ALTERNATIVE_POWER_BAR}, c)
		local tbab = API:AddElement({name = "TargetFramePowerBarAltMover", displayName = MOVANY.EL_TARGET_ALTERNATIVE_POWER_BAR}, c)
		c = API:GetCategory("Game Menu")
		API:AddElement({name = "GameMenuFrame", displayName = MOVANY.EL_GAME_MENU,
			hideList = {
				{"GameMenuFrame", "BACKGROUND","ARTWORK","BORDER"},
			}
		}, c)
		API:AddElement({name = "VideoOptionsFrame", displayName = MOVANY.EL_VIDEO_OPTIONS, runOnce = function()
				hooksecurefunc(VideoOptionsFrame, "Show", function()
					if MovAny:IsModified("VideoOptionsFrame") then
						HideUIPanel(GameMenuFrame)
					end
				end)
			end, positionReset = function(self, f, opt, readOnly)
		end}, c)
		API:AddElement({name = "AudioOptionsFrame", displayName = MOVANY.EL_SOUND_VOICE_OPTIONS, runOnce = function()
			hooksecurefunc(AudioOptionsFrame, "Show", function()
				if MovAny:IsModified("AudioOptionsFrame") then
					HideUIPanel(GameMenuFrame)
				end
			end)
		end}, c)
		API:AddElement({name = "InterfaceOptionsFrame", displayName = MOVANY.EL_INTERFACE_OPTIONS, runOnce = function()
			hooksecurefunc(InterfaceOptionsFrame, "Show", function()
				if MovAny:IsModified("InterfaceOptionsFrame") then
					HideUIPanel(GameMenuFrame)
				end
			end)
		end}, c)
		API:AddElement({name = "KeyBindingFrame", displayName = MOVANY.EL_KEYBINDING_OPTIONS}, c)
		API:AddElement({name = "MacroFrame", displayName = MOVANY.EL_MACRO_OPTIONS}, c)
		c = API:GetCategory("Garrison")
		API:AddElement({name = "GarrisonLandingPage", displayName = MOVANY.EL_GARRISON_REPORT}, c)
		API:AddElement({name = "GarrisonLandingPageMinimapButton", displayName = MOVANY.EL_GARRISON_MINIMAP_BUTTON}, c)
		API:AddElement({name = "GarrisonBuildingFrame", displayName = MOVANY.EL_GARRISON_ARCHITECT}, c)
		API:AddElement({name = "GarrisonMissionFrame", displayName = MOVANY.EL_GARRISON_MISSIONS}, c)
		API:AddElement({name = "GarrisonMissionAlertFrame", displayName = MOVANY.EL_GARRISON_MISSION_ALERT}, c)
		API:AddElement({name = "GarrisonBuildingAlertFrame", displayName = MOVANY.EL_GARRISON_BUILDING_ALERT}, c)
		API:AddElement({name = "GarrisonFollowerAlertFrame", displayName = MOVANY.EL_GARRISON_FOLLOWER_ALERT}, c)
		API:AddElement({name = "GarrisonCapacitiveDisplayFrame", displayName = MOVANY.EL_GARRISON_WORK_ORDER}, c)
		API:AddElement({name = "GarrisonMonumentFrame", displayName = MOVANY.EL_GARRISON_MONUMENTS}, c)
		c = API:GetCategory("Shipyard")
		API:AddElement({name = "GarrisonShipyardFrame", displayName = MOVANY.EL_NAVAL_OPERATIONS}, c)
		API:AddElement({name = "GarrisonShipMissionAlertFrame", displayName = MOVANY.EL_SHIPYARD_MISSION_ALERT}, c)
		API:AddElement({name = "GarrisonShipFollowerAlertFrame", displayName = MOVANY.EL_SHIPYARD_FOLLOWER_ALERT}, c)
		c = API:GetCategory("Order Hall")
		API:AddElement({name = "OrderHallCommandBar", displayName = MOVANY.EL_ORDER_HALL_COMMAND_BAR}, c)
		API:AddElement({name = "OrderHallMissionFrame", displayName = MOVANY.EL_ORDER_HALL_MISSIONS}, c)
		API:AddElement({name = "OrderHallTalentFrame", displayName = MOVANY.EL_ORDER_HALL_TALENTS}, c)
		API:AddElement({name = "GarrisonTalentAlertFrame", displayName = MOVANY.EL_ORDER_HALL_TALENT_ALERT}, c)
		c = API:GetCategory("Guild")
		API:AddElement({name = "GuildFrame", displayName = MOVANY.EL_GUILD}, c)
		API:AddElement({name = "CommunitiesFrame", displayName = MOVANY.EL_COMMUNITIES}, c)
		gbf:AddCategory(c)
		gbt1:AddCategory(c)
		gbt2:AddCategory(c)
		gbt3:AddCategory(c)
		gbt4:AddCategory(c)
		gbt5:AddCategory(c)
		gbt6:AddCategory(c)
		gbt7:AddCategory(c)
		gbt8:AddCategory(c)
		gisb:AddCategory(c)
		gbis:AddCategory(c)
		gbfw:AddCategory(c)
		gbfd:AddCategory(c)
		gbwm:AddCategory(c)
		gbwmg:AddCategory(c)
		gbwms:AddCategory(c)
		gbwmc:AddCategory(c)
		gbmf:AddCategory(c)
		gbmfg:AddCategory(c)
		gbmfs:AddCategory(c)
		gbmfc:AddCategory(c)
		if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
			gcaf:AddCategory(c)
		end
		API:AddElement({name = "GuildControlUI", displayName = MOVANY.EL_GUILD_CONTROL}, c)
		local lfgf = API:AddElement({name = "LookingForGuildFrame", displayName = MOVANY.EL_GUILD_FINDER}, c)
		--API:AddElement({name = "GuildInfoFrame", displayName = MOVANY.EL_GUILD_INFO}, c)
		API:AddElement({name = "GuildInviteFrame", displayName = MOVANY.EL_GUILD_INVITE}, c)
		--API:AddElement({name = "GuildLogContainer", displayName = MOVANY.EL_GUILD_LOG}, c)
		API:AddElement({name = "GuildMemberDetailFrame", displayName = MOVANY.EL_GUILD_MEMBER_DETAILS}, c)
		API:AddElement({name = "GuildRegistrarFrame", displayName = MOVANY.EL_GUILD_REGISTRAR}, c)
		c = API:GetCategory("Info Panels")
		API:AddElement({name = "UIPanelMover1", displayName = MOVANY.EL_GENERIC_INFO_PANEL_1_LEFT, noHide = 1}, c)
		API:AddElement({name = "UIPanelMover2", displayName = MOVANY.EL_GENERIC_INFO_PANEL_2_CENTER, noHide = 1}, c)
		API:AddElement({name = "UIPanelMover3", displayName = MOVANY.EL_GENERIC_INFO_PANEL_3_RIGHT, noHide = 1}, c)
		bf:AddCategory(c)
		API:AddElement({name = "CharacterFrame", displayName = MOVANY.EL_CHARACTER_REPUTATION_CURRENCY}, c)
		API:AddElement({name = "DressUpFrame", displayName = MOVANY.EL_DRESSING_ROOM}, c)
		--API:AddElement({name = "LFDParentFrame", displayName = MOVANY.EL_DUNGEON_FINDER}, c)
		API:AddElement({name = "ArtifactFrame", displayName = MOVANY.EL_ARTIFACT_FRAME}, c)
		API:AddElement({name = "TaxiFrame", displayName = MOVANY.EL_FLIGHT_PATHS}, c)
		API:AddElement({name = "FlightMapFrame", displayName = MOVANY.EL_FLIGHT_MAP}, c)
		lfgf:AddCategory(c)
		API:AddElement({name = "GossipFrame", displayName = MOVANY.EL_GOSSIP}, c)
		API:AddElement({name = "InspectFrame", displayName = MOVANY.EL_INSPECT}, c)
		--API:AddElement({name = "LFRParentFrame", displayName = MOVANY.EL_LOOKING_FOR_RAID}, c)
		--API:AddElement({name = "MacroFrame", displayName = MOVANY.EL_MACROS}, c)
		API:AddElement({name = "MailFrame", displayName = MOVANY.EL_MAILBOX}, c)
		API:AddElement({name = "MerchantFrame", displayName = MOVANY.EL_MERCHANT}, c)
		API:AddElement({name = "OpenMailFrame", displayName = MOVANY.EL_OPEN_MAIL}, c)
		API:AddElement({name = "PetStableFrame", displayName = MOVANY.EL_PET_STABLE}, c)
		API:AddElement({name = "FriendsFrame", displayName = MOVANY.EL_SOCIAL_FRIENDS_WHO_GUILD_CHAT_RAID}, c)
		API:AddElement({name = "WardrobeFrame", displayName = MOVANY.EL_TRANSMOGRIFICATION}, c)
		pvpf:AddCategory(c)
		--qldf:AddCategory(c)
		--qlf:AddCategory(c)
		qf:AddCategory(c)
		API:AddElement({name = "SpellBookFrame", displayName = MOVANY.EL_SPELLBOOK_PROFESSIONS}, c)
		API:AddElement({name = "ItemUpgradeFrame", displayName = MOVANY.EL_ITEM_UPGRADE}, c)
		API:AddElement({name = "CollectionsJournal", displayName = MOVANY.EL_COLLECTIONS}, c)
		API:AddElement({name = "TabardFrame", displayName = MOVANY.EL_TABARD_DESIGN}, c)
		API:AddElement({name = "PlayerTalentFrame", displayName = MOVANY.EL_SPECIALIZATION_TALENTS_GLYPHS, refuseSync = MOVANY.FRAME_ONLY_ONCE_OPENED}, c)
		API:AddElement({name = "TradeFrame", displayName = MOVANY.EL_TRADE}, c)
		API:AddElement({name = "ArchaeologyFrame", displayName = MOVANY.EL_ARCHAEOLOGY}, c)
		API:AddElement({name = "ReforgingFrame", displayName = MOVANY.EL_REFORGE}, c)
		API:AddElement({name = "TradeSkillFrame", displayName = MOVANY.EL_TRADE_SKILLS}, c)
		API:AddElement({name = "ClassTrainerFrame", displayName = MOVANY.EL_CLASS_TRAINER}, c)
		API:AddElement({name = "GarrisonCapacitiveDisplayFrame", displayName = MOVANY.EL_WORK_ORDER}, c)
		API:AddElement({name = "ReportPlayerNameDialog", displayName = MOVANY.EL_REPORT_PLAYER_NAME}, c)
		API:AddElement({name = "ReportCheatingDialog", displayName = MOVANY.EL_REPORT_PLAYER_CHEATING}, c)
		c = API:GetCategory("Loot")
		API:AddElement({name = "LootFrame", displayName = MOVANY.EL_LOOT}, c)
		API:AddElement({name = "AlertFrame", displayName = MOVANY.EL_ALERTS_FRAMES}, c)
		--API:AddElement({name = "LootWonAlertFrame1", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME_1}, c)
		--API:AddElement({name = "GroupLootContainer", displayName = MOVANY.EL_ALL_LOOT_ROLL_FRAME, create = "GroupLootFrameTemplate", noScale = 1}, c)
		--API:AddElement({name = "LootWonAlertMover1", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME1}, c)
		--API:AddElement({name = "LootWonAlertMover2", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME2}, c)
		--API:AddElement({name = "LootWonAlertMover3", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME3}, c)
		--API:AddElement({name = "LootWonAlertMover4", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME4}, c)
		--API:AddElement({name = "LootWonAlertMover5", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME5}, c)
		--API:AddElement({name = "LootWonAlertMover6", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME6}, c)
		--API:AddElement({name = "LootWonAlertMover7", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME7}, c)
		--API:AddElement({name = "LootWonAlertMover8", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME8}, c)
		--API:AddElement({name = "LootWonAlertMover9", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME9}, c)
		--API:AddElement({name = "LootWonAlertMover10", displayName = MOVANY.EL_LOOT_WON_ALERT_FRAME10}, c)
		API:AddElement({name = "BonusRollFrame", displayName = MOVANY.EL_BONUS_ROLL_FRAME, create = "BonusRollFrameTemplate"}, c)
		API:AddElement({name = "BonusRollLootWonFrame", displayName = MOVANY.EL_BONUS_ROLL_ITEM_WON, create = "LootWonAlertFrameTemplate"}, c)
		API:AddElement({name = "BonusRollMoneyWonFrame", displayName = MOVANY.EL_BONUS_ROLL_MONEY_WON, create = "MoneyWonAlertFrameTemplate"}, c)
		--API:AddElement({name = "MoneyWonAlertMover1", displayName = MOVANY.EL_MONEY_WON_FRAME1}, c)
		--API:AddElement({name = "MoneyWonAlertMover2", displayName = MOVANY.EL_MONEY_WON_FRAME2}, c)
		--API:AddElement({name = "MoneyWonAlertMover3", displayName = MOVANY.EL_MONEY_WON_FRAME3}, c)
		--API:AddElement({name = "MoneyWonAlertMover4", displayName = MOVANY.EL_MONEY_WON_FRAME4}, c)
		--API:AddElement({name = "MoneyWonAlertMover5", displayName = MOVANY.EL_MONEY_WON_FRAME5}, c)
		--API:AddElement({name = "MissingLootFrame", displayName = MOVANY.EL_MISSING_LOOT_FRAME}, c)
		API:AddElement({name = "GroupLootFrame1", displayName = MOVANY.EL_LOOT_ROLL_1, create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame2", displayName = MOVANY.EL_LOOT_ROLL_2, create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame3", displayName = MOVANY.EL_LOOT_ROLL_3, create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame4", displayName = MOVANY.EL_LOOT_ROLL_4, create = "GroupLootFrameTemplate"}, c)
		c = API:GetCategory("Map")
		API:AddElement({name = "WorldMapFrame", displayName = MOVANY.EL_WORLD_MAP}, c)
		--API:AddElement({name = "WorldMapLevelDropDown", displayName = MOVANY.EL_MAP_LEVEL}, c)
		--API:AddElement({name = "WorldMapShowDropDown", displayName = MOVANY.EL_MAP_OPTIONS}, c)
		--API:AddElement({name = "WorldMapTrackQuest", displayName = MOVANY.EL_MAP_TRACK_QUEST}, c)
		--API:AddElement({name = "WorldMapPositioningGuide", displayName = MOVANY.EL_MAP_COORDINATES}, c)
		c = API:GetCategory("Minimap")
		API:AddElement({name = "MinimapCluster", displayName = MOVANY.EL_MINIMAP}, c)
		API:AddElement({name = "MinimapBorder", displayName = MOVANY.EL_MINIMAP_BORDER_TEXTURE}, c)
		API:AddElement({name = "MinimapZoneTextButton", displayName = MOVANY.EL_MINIMAP_ZONE_TEXT}, c)
		API:AddElement({name = "MinimapBorderTop", displayName = MOVANY.EL_MINIMAP_TOP_BORDER, noScale = 1}, c)
		API:AddElement({name = "MinimapBackdrop", displayName = MOVANY.EL_MINIMAP_ROUND_BORDER, noAlpha = 1, noScale = 1, hideList = {{"MinimapBackdrop", "ARTWORK"}}}, c)
		API:AddElement({name = "MinimapNorthTag", displayName = MOVANY.EL_MINIMAP_NORTH_INDICATOR, noScale = 1}, c)
		API:AddElement({name = "GameTimeFrame", displayName = MOVANY.EL_MINIMAP_CALENDAR_BUTTON}, c)
		API:AddElement({name = "TimeManagerClockButton", displayName = MOVANY.EL_MINIMAP_CLOCK_BUTTON}, c)
		API:AddElement({name = "MiniMapInstanceDifficulty", displayName = MOVANY.EL_MINIMAP_DUNGEON_DIFFICULTY}, c)
		API:AddElement({name = "GuildInstanceDifficulty", displayName = MOVANY.EL_MINIMAP_GUILD_GROUP_FLAG}, c)
		API:AddElement({name = "QueueStatusMinimapButton", displayName = MOVANY.EL_MINIMAP_QUEUE_STATUS_BUTTON}, c)
		API:AddElement({name = "MiniMapMailFrame", displayName = MOVANY.EL_MINIMAP_MAIL_NOTIFICATION}, c)
		API:AddElement({name = "MiniMapTracking", displayName = MOVANY.EL_MINIMAP_TRACKING_BUTTON}, c)
		API:AddElement({name = "MinimapZoomIn", displayName = MOVANY.EL_MINIMAP_ZOOM_IN_BUTTON}, c)
		API:AddElement({name = "MinimapZoomOut", displayName = MOVANY.EL_MINIMAP_ZOOM_OUT_BUTTON}, c)
		API:AddElement({name = "MiniMapWorldMapButton", displayName = MOVANY.EL_MINIMAP_WORLD_MAP_BUTTON}, c)
		API:AddElement({name = "BattlefieldMinimap", displayName = MOVANY.EL_ZONE_MINIMAP}, c)
		c = API:GetCategory("Miscellaneous")
		API:AddElement({name = "ActionStaus", displayName = MOVANY.EL_ACTION_STAUS}, c)
		API:AddElement({name = "TimeManagerFrame", displayName = MOVANY.EL_ALARM_CLOCK}, c)
		API:AddElement({name = "BlackMarketFrame", displayName = MOVANY.EL_BLACK_MARKET_AUCTION, runOnce = BlackMarketFrame_Show}, c)
		API:AddElement({name = "AuctionFrame", displayName = MOVANY.EL_AUCTION_HOUSE, runOnce = function()
			local af = _G.AuctionFrame
			if not af then
				return true
			end
			local f = _G.SideDressUpFrame
			if f and not MovAny:IsModified(f) then
				f:ClearAllPoints()
				f:SetPoint("TOPLEFT", af, "TOPRIGHT", - 2, - 28)
			end
		end}, c)
		API:AddElement({name = "SideDressUpFrame", displayName = MOVANY.EL_AUCTION_HOUSE_DRESSING_ROOM}, c)
		API:AddElement({name = "AuctionProgressFrame", displayName = MOVANY.EL_AUCTION_CREATION_PROGRESS}, c)
		API:AddElement({name = "BarberShopFrame", displayName = MOVANY.EL_BARBER_SHOP}, c)
		API:AddElement({name = "BNToastFrame", displayName = MOVANY.EL_BATTLE_NET_POPUP_MESSAGE}, c)
		API:AddElement({name = "TimeAlertFrame", displayName = MOVANY.EL_TIME_ALERT_POPUP_MESSAGE}, c)
		API:AddElement({name = "QuickJoinToastMover", displayName = MOVANY.EL_QUICK_JOIN_TOAST}, c)
		API:AddElement({name = "QuickJoinToast2Mover", displayName = MOVANY.EL_QUICK_JOIN_TOAST_2}, c)
		API:AddElement({name = "QuickJoinToastButton", displayName = MOVANY.EL_QUICK_JOIN_TOAST_BUTTON}, c)
		API:AddElement({name = "MirrorTimer1", displayName = MOVANY.EL_BREATH_FATIGUE_BAR}, c)
		API:AddElement({name = "CalendarFrame", displayName = MOVANY.EL_CALENDAR}, c)
		API:AddElement({name = "CalendarViewEventFrame", displayName = MOVANY.EL_CALENDAR_EVENT}, c)
		API:AddElement({name = "ChannelPullout", displayName = MOVANY.EL_CHANNEL_PULLOUT}, c)
		API:AddElement({name = "ChatConfigFrame", displayName = MOVANY.EL_CHAT_CHANNEL_CONFIGURATION}, c)
		API:AddElement({name = "ChatEditBoxesMover", displayName = MOVANY.EL_CHAT_EDIT_BOX}, c)
		API:AddElement({name = "ChatEditBoxesLengthMover", displayName = MOVANY.EL_CHAT_EDIT_BOX_LENGTH, scaleWH = 1}, c)
		API:AddElement({name = "ColorPickerFrame", displayName = MOVANY.EL_COLOR_PICKER}, c)
		API:AddElement({name = "TokenFramePopup", displayName = MOVANY.EL_CURRENCY_OPTIONS}, c)
		API:AddElement({name = "ItemRefTooltip", displayName = MOVANY.EL_CHAT_POPUP_TOOLTIP}, c)
		API:AddElement({name = "DurabilityFrame", displayName = MOVANY.EL_DURABILITY_FIGURE}, c)
		API:AddElement({name = "UIErrorsFrame", displayName = MOVANY.EL_ERRORS_WARNING_DISPLAY}, c)
		API:AddElement({name = "FramerateLabelMover", displayName = MOVANY.EL_FRAMERATE, noScale = 1, noUnanchorRelatives = 1}, c)
		API:AddElement({name = "ItemSocketingFrame", displayName = MOVANY.EL_GEM_SOCKETING}, c)
		API:AddElement({name = "HelpFrame", displayName = MOVANY.EL_GM_HELP}, c)
		API:AddElement({name = "LevelUpDisplay", displayName = MOVANY.EL_LEVEL_UP_DISPLAY}, c)
		API:AddElement({name = "MacroPopupFrame", displayName = MOVANY.EL_MACRO_NAME_ICON}, c)
		API:AddElement({name = "StaticPopup1", displayName = MOVANY.EL_STATIC_POPUP_1}, c)
		API:AddElement({name = "StaticPopup2", displayName = MOVANY.EL_STATIC_POPUP_2}, c)
		API:AddElement({name = "StaticPopup3", displayName = MOVANY.EL_STATIC_POPUP_3}, c)
		API:AddElement({name = "StaticPopup4", displayName = MOVANY.EL_STATIC_POPUP_4}, c)
		API:AddElement({name = "StreamingIcon", displayName = MOVANY.EL_STREAMING_DOWNLOAD_ICON}, c)
		API:AddElement({name = "ItemTextFrame", displayName = MOVANY.EL_READING_MATERIALS}, c)
		API:AddElement({name = "ReputationDetailFrame", displayName = MOVANY.EL_REPUTATION_DETAILS}, c)
		API:AddElement({name = "GhostFrame", displayName = MOVANY.EL_RETURN_TO_GRAVEYARD_BUTTON}, c)
		API:AddElement({name = "HelpOpenWebTicketButton", displayName = MOVANY.EL_TICKET_STATUS}, c)
		API:AddElement({name = "HelpOpenTicketButtonTutorial", displayName = MOVANY.EL_TICKET_STATUS_TUTORIAL}, c)
		API:AddElement({name = "TooltipMover", displayName = MOVANY.EL_TOOLTIP}, c)
		API:AddElement({name = "BagItemTooltipMover", displayName = MOVANY.EL_TOOLTIP_BAG_ITEM}, c)
		API:AddElement({name = "GuildBankItemTooltipMover", displayName = MOVANY.EL_TOOLTIP_GUILD_BANK_ITEM}, c)
		wsauf:AddCategory(c)
		API:AddElement({name = "TalentMicroButtonAlert", displayName = MOVANY.EL_UNSAVED_TALENT_CHANGES_ALERT}, c)
		API:AddElement({name = "TutorialFrameAlertButton", displayName = MOVANY.EL_TUTORIALS_ALERT_BUTTON}, c)
		API:AddElement({name = "VoiceChatTalkers", displayName = MOVANY.EL_VOICE_CHAT_TALKERS}, c)
		API:AddElement({name = "ZoneTextFrame", displayName = MOVANY.EL_ZONING_ZONE_TEXT}, c)
		API:AddElement({name = "SubZoneTextFrame", displayName = MOVANY.EL_ZONING_SUBZONE_TEXT}, c)
		c = API:GetCategory("MoveAnything")
		API:AddElement({name = "MAOptions", displayName = MOVANY.EL_MOVE_ANYTHING_WINDOW,
			hideList = {
				{"MAOptions", "ARTWORK","BORDER"},
			}
		}, c)
		--API:AddElement({name = "MA_FEMover", displayName = MOVANY.EL_MOVE_ANYTHING_FRAME_EDITOR_CONFIG, noHide = 1}, c)
		API:AddElement({name = "MANudger", displayName = MOVANY.EL_MOVE_ANYTHING_NUDGER}, c)
		API:AddElement({name = "GameMenuButtonMoveAnything", displayName = MOVANY.EL_MOVE_ANYTHING_GAME_MENU_BUTTON}, c)
		c = API:GetCategory("Unit: Focus")
		API:AddElement({name = "FocusFrame", displayName = MOVANY.EL_FOCUS}, c)
		API:AddElement({name = "FocusFrameTextureFramePVPIcon", displayName = MOVANY.EL_FOCUS_PVP_ICON}, c)
		API:AddElement({name = "FocusBuffsMover", displayName = MOVANY.EL_FOCUS_BUFFS}, c)
		API:AddElement({name = "FocusDebuffsMover", displayName = MOVANY.EL_FOCUS_DEBUFFS}, c)
		API:AddElement({name = "FocusFrameSpellBar", displayName = MOVANY.EL_FOCUS_CASTING_BAR, noAlpha = 1}, c)
		API:AddElement({name = "FocusFrameToT", displayName = MOVANY.EL_TARGET_OF_FOCUS}, c)
		API:AddElement({name = "FocusFrameToTDebuffsMover", displayName = MOVANY.EL_TARGET_OF_FOCUS_DEBUFFS}, c)
		c = API:GetCategory("Unit: Party")
		API:AddElement({name = "PartyMemberFrame1", displayName = MOVANY.EL_PARTY_MEMBER_1}, c)
		API:AddElement({name = "PartyMember1DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER_1_DEBUFFS}, c)
		API:AddElement({name = "PartyMemberFrame2", displayName = MOVANY.EL_PARTY_MEMBER_2}, c)
		API:AddElement({name = "PartyMember2DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER_2_DEBUFFS}, c)
		API:AddElement({name = "PartyMemberFrame3", displayName = MOVANY.EL_PARTY_MEMBER_3}, c)
		API:AddElement({name = "PartyMember3DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER_3_DEBUFFS}, c)
		API:AddElement({name = "PartyMemberFrame4", displayName = MOVANY.EL_PARTY_MEMBER_4}, c)
		API:AddElement({name = "PartyMember4DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER_4_DEBUFFS}, c)
		c = API:GetCategory("Unit: Pet")
		API:AddElement({name = "PetFrame", displayName = MOVANY.EL_PET}, c)
		API:AddElement({name = "PetCastingBarFrame", displayName = MOVANY.EL_PET_CASTING_BAR}, c)
		API:AddElement({name = "PetDebuffsMover", displayName = MOVANY.EL_PET_DEBUFFS}, c)
		API:AddElement({name = "PartyMemberFrame1PetFrame", displayName = MOVANY.EL_PARTY_PET_1}, c)
		API:AddElement({name = "PartyMemberFrame2PetFrame", displayName = MOVANY.EL_PARTY_PET_2}, c)
		API:AddElement({name = "PartyMemberFrame3PetFrame", displayName = MOVANY.EL_PARTY_PET_3}, c)
		API:AddElement({name = "PartyMemberFrame4PetFrame", displayName = MOVANY.EL_PARTY_PET_4}, c)
		c = API:GetCategory("Unit: Player")
		API:AddElement({name = "PlayerFrame", displayName = MOVANY.EL_PLAYER}, c)
		API:AddElement({name = "PlayerPVPIcon", displayName = MOVANY.EL_PLAYER_PVP_ICON}, c)
		API:AddElement({name = "PlayerRestIcon", displayName = MOVANY.EL_PLAYER_REST_ICON}, c)
		API:AddElement({name = "PlayerRestGlow", displayName = MOVANY.EL_PLAYER_REST_ICON_S_GLOW}, c)
		API:AddElement({name = "PlayerAttackIcon", displayName = MOVANY.EL_PLAYER_ATTACK_ICON}, c)
		API:AddElement({name = "PlayerAttackGlow", displayName = MOVANY.EL_PLAYER_ATTACK_ICON_S_GLOW}, c)
		API:AddElement({name = "PlayerAttackBackground", displayName = MOVANY.EL_PLAYER_ATTACK_ICON_S_BACKGROUND}, c)
		API:AddElement({name = "PlayerStatusTexture", displayName = MOVANY.EL_PLAYER_STATUS_TEXTURE}, c)
		API:AddElement({name = "PlayerStatusGlow", displayName = MOVANY.EL_PLAYER_STATUS_GLOW}, c)
		API:AddElement({name = "PlayerLeaderIcon", displayName = MOVANY.EL_PLAYER_LEADER_ICON}, c)
		API:AddElement({name = "PlayerMasterIcon", displayName = MOVANY.EL_PLAYER_MASTER_ICON}, c)
		API:AddElement({name = "PlayerBuffsMover", displayName = MOVANY.EL_PLAYER_BUFFS_DEFAULT}, c)
		API:AddElement({name = "PlayerBuffsMover2", displayName = MOVANY.EL_PLAYER_BUFFS_FROM_RIGHT_TO_LEFT}, c)
		--API:AddElement({name = "ConsolidatedBuffs", displayName = MOVANY.EL_CONSOLIDATED_BUFFS}, c)
		--API:AddElement({name = "ConsolidatedBuffsTooltip", displayName = MOVANY.EL_PLAYER_BUFFS_CONSOLIDATED_BUFFS_TOOLTIP}, c)
		API:AddElement({name = "PlayerDebuffsMover", displayName = MOVANY.EL_PLAYER_DEBUFFS_DEFAULT}, c)
		API:AddElement({name = "PlayerDebuffsMover2", displayName = MOVANY.EL_PLAYER_DEBUFFS_FROM_RIGHT_TO_LEFT}, c)
		API:AddElement({name = "DigsiteCompleteToastFrame", displayName = MOVANY.EL_DIGSITE_COMPLETE_TOAST_FRAME}, c)
		API:AddElement({name = "ArcheologyDigsiteProgressBar", displayName = MOVANY.EL_ARCHEOLOGY_DIGSITE_PROGRESS_BAR}, c)
		API:AddElement({name = "PlayerHitIndicator", displayName = MOVANY.EL_HEAL_DAMAGE_NUMBERS}, c)
		API:AddElement({name = "CastingBarFrame", displayName = MOVANY.EL_CASTING_BAR, noAlpha = 1}, c)
		API:AddElement({name = "PlayerFrameGroupIndicator", displayName = MOVANY.EL_PLAYER_GROUP_INDICATOR}, c)
		API:AddElement({name = "LossOfControlFrame", displayName = MOVANY.EL_LOSS_OF_CONTROL}, c)
		pbab:AddCategory(c)
		API:AddElement({name = "SpellActivationOverlayFrame", displayName = MOVANY.EL_CLASS_ABILITY_PROC}, c)
		API:AddElement({name = "PlayerTalentFrame", displayName = MOVANY.EL_TALENTS_GLYPHS}, c)
		c = API:GetCategory("Unit: Target")
		API:AddElement({name = "TargetFrame", displayName = MOVANY.EL_TARGET}, c)
		API:AddElement({name = "TargetFrameTextureFramePVPIcon", displayName = MOVANY.EL_TARGET_PVP_ICON}, c)
		API:AddElement({name = "TargetBuffsMover", displayName = MOVANY.EL_TARGET_BUFFS}, c)
		API:AddElement({name = "TargetDebuffsMover", displayName = MOVANY.EL_TARGET_DEBUFFS}, c)
		--API:AddElement({name = "ComboFrame", displayName = MOVANY.EL_TARGET_COMBO_POINTS_DISPLAY}, c)
		API:AddElement({name = "TargetFrameSpellBar", displayName = MOVANY.EL_TARGET_CASTING_BAR, noAlpha = 1}, c)
		API:AddElement({name = "TargetFrameToT", displayName = MOVANY.EL_TARGET_OF_TARGET}, c)
		API:AddElement({name = "TargetFrameToTDebuffsMover", displayName = MOVANY.EL_TARGET_OF_TARGET_DEBUFFS}, c)
		API:AddElement({name = "TargetFrameNumericalThreat", displayName = MOVANY.EL_TARGET_THREAT_INDICATOR}, c)
		tbab:AddCategory(c)
		c = API:GetCategory("Vehicle")
		API:AddElement({name = "OverrideActionBar", displayName = MOVANY.EL_VEHICLE_BAR,
			hideList = {
				{"OverrideActionBar", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				{"OverrideActionBarLeaveFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				--{"OverrideActionBarArtFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				--{"OverrideActionBarButtonFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"}
			}
		}, c)
		API:AddElement({name = "OverrideActionBarExpBar", displayName = MOVANY.EL_VEHICLE_EXPERIENCE_BAR, onlyOnceCreated = 1}, c)
		API:AddElement({name = "OverrideActionButtonsMover", displayName = MOVANY.EL_VEHICLE_ACTION_BAR, runOnce = function()
			OverrideActionBarButtonFrame:SetSize((OverrideActionBarButton1:GetWidth() + 2) * VEHICLE_MAX_ACTIONBUTTONS, OverrideActionBarButton1:GetHeight() + 2)
		 end}, c)
		API:AddElement({name = "OverrideActionBarHealthBar", displayName = MOVANY.EL_VEHICLE_HEALTH_BAR, onlyOnceCreated = 1}, c)
		API:AddElement({name = "OverrideActionBarPowerBar", displayName = MOVANY.EL_VEHICLE_POWER_BAR, onlyOnceCreated = 1}, c)
		API:AddElement({name = "OverrideActionBarLeaveFrame", displayName = MOVANY.EL_VEHICLE_LEAVE_FRAME}, c)
		--API:AddElement({name = "MicroButtonsVehicleMover", displayName = MOVANY.EL_VEHICLE_MICRO_BAR}, c)
		API:AddElement({name = "VehicleSeatIndicator", displayName = MOVANY.EL_VEHICLE_SEAT_INDICATOR}, c)
		c = API:GetCategory("PetBattle")
		API:AddElement({name = "PetBattleMover7", displayName = MOVANY.EL_TOP_RIGHT_ART, noScale = 1}, c)
		API:AddElement({name = "PetBattleMover8", displayName = MOVANY.EL_TOP_LEFT_ART, noScale = 1}, c)
		API:AddElement({name = "PetBattleMover9", displayName = MOVANY.EL_TOP_LEFT_CENTER, noScale = 1}, c)
		API:AddElement({name = "PetBattleMover3", displayName = MOVANY.EL_WEATHER},c)
		API:AddElement({name = "PetBattleMover1", displayName = MOVANY.EL_PLAYER_PET_FRAME}, c)
		API:AddElement({name = "PetBattleMover2", displayName = MOVANY.EL_ENEMY_PET_FRAME}, c)
		API:AddElement({name = "PetBattleMover6", displayName = MOVANY.EL_BOTTOM_FRAME}, c)
		API:AddElement({name = "PetBattleMover5", displayName = MOVANY.EL_PET_SELECTION_FRAME}, c)
		API:AddElement({name = "PetBattleMover4", displayName = MOVANY.EL_PASS_BUTTON}, c)
		API:AddElement({name = "PetBattleMover11", displayName = MOVANY.EL_ALLY_PET_2}, c)
		API:AddElement({name = "PetBattleMover12", displayName = MOVANY.EL_ALLY_PET_3}, c)
		API:AddElement({name = "PetBattleMover22", displayName = MOVANY.EL_ENEMY_PET_2}, c)
		API:AddElement({name = "PetBattleMover23", displayName = MOVANY.EL_ENEMY_PET_3}, c)
		API:AddElement({name = "PetBattleMover24", displayName = MOVANY.EL_ALLY_PET_BUFFS}, c)
		API:AddElement({name = "PetBattleMover25", displayName = MOVANY.EL_ALLY_PET_DEBUFFS}, c)
		API:AddElement({name = "PetBattleMover26", displayName = MOVANY.EL_ALLY_PET_PAD_BUFFS}, c)
		API:AddElement({name = "PetBattleMover27", displayName = MOVANY.EL_ALLY_PET_PAD_DEBUFFS}, c)
		API:AddElement({name = "PetBattleMover28", displayName = MOVANY.EL_ENEMY_PET_BUFFS}, c)
		API:AddElement({name = "PetBattleMover29", displayName = MOVANY.EL_ENEMY_PET_DEBUFFS}, c)
		API:AddElement({name = "PetBattleMover30", displayName = MOVANY.EL_ENEMY_PET_PAD_BUFFS}, c)
		API:AddElement({name = "PetBattleMover31", displayName = MOVANY.EL_ENEMY_PET_PAD_DEBUFFS}, c)
		API:AddElement({name = "PetBattlePrimaryAbilityTooltip", displayName = MOVANY.EL_PET_BATTLE_PRIMARY_ABILITY_TOOLTIP}, c)
		API:AddElement({name = "PetBattlePrimaryUnitTooltip", displayName = MOVANY.EL_PET_BATTLE_PRIMARY_UNIT_TOOLTIP}, c)
		API:AddElement({name = "BattlePetTooltip", displayName = MOVANY.EL_BATTLE_PET_TOOLTIP}, c)
		API:AddElement({name = "FloatingBattlePetTooltip", displayName = MOVANY.EL_FLOATING_BATTLE_PET_TOOLTIP}, c)
		API:AddElement({name = "FloatingPetBattleAbilityTooltip", displayName = MOVANY.EL_FLOATING_PET_BATTLE_ABILITY_TOOLTIP}, c)
		API:AddElement({name = "StartSplash", displayName = MOVANY.EL_START_SPLASH}, c)
		c = API:GetCategory("Store")
		API:AddElement({name = "StorePurchaseAlertFrame", displayName = MOVANY.EL_STORE_PURCHASE_ALERT}, c)
		API:AddElement({name = "ModelPreviewFrame", displayName = MOVANY.EL_STORE_MODEL_PREVIEW}, c)
		c = API:AddCategory({name = "MA Internal Elements", displayName = MOVANY.CAT_MA_INTERNAL_ELEMENTS})
		--API:AddElement({name = "AlwaysUpFrame1", hidden = 1, onlyOnceCreated = 1}, c)
		--API:AddElement({name = "AlwaysUpFrame2", hidden = 1, onlyOnceCreated = 1}, c)
		--API:AddElement({name = "AlwaysUpFrame3", hidden = 1, onlyOnceCreated = 1}, c)
		--API:AddElement({name = "MainMenuBarArtFrame", hidden = 1, noScale = 1}, c)
		--API:AddElement({name = "WorldMapFrame", hidden = 1, refuseSync = "Unsuppported", unsupported = 1}, c)
		API:AddElement({name = "PaperDollFrame", hidden = 1, unsupported = 1}, c)
		API.default = nil
		API.customCat = API:AddCategory({name = "Custom Frames", displayName = MOVANY.CAT_CUSTOM_FRAMES})
	end
}

MovAny:AddCore("FrameList", m)
