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
		API:AddElement({name = "AchievementFrame", displayName = MOVANY.EL_ACHIEVEMENT_FRAME}, c)
		local gcaf
		if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
			API:AddElement({name = "AchievementAlertFrame1", displayName = MOVANY.EL_ACHIEVEMENT_ALERT_FRAME1, runOnce = AchievementFrame_LoadUI, create = "AchievementAlertFrameTemplate"}, c)
			API:AddElement({name = "AchievementAlertFrame2", displayName = MOVANY.EL_ACHIEVEMENT_ALERT_FRAME2, runOnce = AchievementFrame_LoadUI, create = "AchievementAlertFrameTemplate"}, c)
			API:AddElement({name = "CriteriaAlertFrame1", displayName = MOVANY.EL_CRITERIA_ALERT_FRAME1, create = "CriteriaAlertFrameTemplate"}, c)
			API:AddElement({name = "CriteriaAlertFrame2", displayName = MOVANY.EL_CRITERIA_ALERT_FRAME2, create = "CriteriaAlertFrameTemplate"}, c)
			gcaf = API:AddElement({name = "GuildChallengeAlertFrame", displayName = MOVANY.EL_GUILD_CHALLENGE_ALERT_FRAME}, c)
		end
		API:AddElement({name = "ObjectiveTrackerFrameMover", displayName = MOVANY.EL_OBJECTIVE_TRACKER_FRAME_MOVER, scaleWH = 1}, c)
		API:AddElement({name = "ObjectiveTrackerFrameScaleMover", displayName = MOVANY.EL_OBJECTIVE_TRACKER_FRAME_SCALE_MOVER}, c)
		API:AddElement({name = "ObjectiveTrackerBonusBannerFrame", displayName = MOVANY.EL_OBJECTIVE_TRACKER_BONUS_BANNER_FRAME}, c)
		--[[local qldf = API:AddElement({name = "QuestLogDetailFrame", displayName = "Quest Details", runOnce = function()
			if not QuestLogDetailFrame:IsShown() then
				ShowUIPanel(QuestLogDetailFrame)
				HideUIPanel(QuestLogDetailFrame)
			end
		end}, c)]]
		if WOW_PROJECT_ID ~= WOW_PROJECT_CLASSIC then
			API:AddElement({name = "QuestLogPopupDetailFrame", displayName = MOVANY.EL_QUEST_LOG_POPUP_DETAIL_FRAME}, c)
		end
		API:AddElement({name = "QuestNPCModel", displayName = MOVANY.EL_QUEST_NPC_MODEL}, c)
		local qf = API:AddElement({name = "QuestFrame", displayName = MOVANY.EL_QUEST_FRAME, runOnce = function()
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
		API:AddElement({name = "WorldQuestCompleteAlertFrame", displayName = MOVANY.EL_WORLD_QUEST_COMPLETE_ALERT_FRAME}, c)
		API:AddElement({name = "TalkingHeadFrame", displayName = MOVANY.EL_TALKING_HEAD_FRAME, runOnce = TalkingHead_LoadUI}, c)
		--API:AddElement({name = "QuestTimerFrame", displayName = "Quest Timer"}, c)
		c = API:GetCategory("Arena")
		--API:AddElement({name = "ArenaEnemyFrames", displayName = "ArenaEnemyFrames", noScale = 1}, c)
		--API:AddElement({name = "ArenaPrepFrames", displayName = "ArenaPrepFrames", noScale = 1}, c)
		API:AddElement({name = "ArenaEnemyFrame1", displayName = MOVANY.EL_ARENA_ENEMY_FRAME1, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame2", displayName = MOVANY.EL_ARENA_ENEMY_FRAME2, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame3", displayName = MOVANY.EL_ARENA_ENEMY_FRAME3, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame4", displayName = MOVANY.EL_ARENA_ENEMY_FRAME4, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame5", displayName = MOVANY.EL_ARENA_ENEMY_FRAME5, create = "ArenaEnemyFrameTemplate", runOnce = Arena_LoadUI}, c)
		local ttt1 = API:AddElement({name = "TimerTrackerTimer1", displayName = MOVANY.EL_TIMER_TRACKER_TIMER1}, c)
		API:AddElement({name = "ArenaEnemyFrame1PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_FRAME1_PET_FRAME, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame2PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_FRAME2_PET_FRAME, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame3PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_FRAME3_PET_FRAME, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame4PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_FRAME4_PET_FRAME, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame5PetFrame", displayName = MOVANY.EL_ARENA_ENEMY_FRAME5_PET_FRAME, create = "ArenaEnemyPetFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame1CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_FRAME1_CASTING_BAR, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame2CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_FRAME2_CASTING_BAR, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame3CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_FRAME3_CASTING_BAR, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame4CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_FRAME4_CASTING_BAR, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaEnemyFrame5CastingBar", displayName = MOVANY.EL_ARENA_ENEMY_FRAME5_CASTING_BAR, create = "ArenaCastingBarFrameTemplate", runOnce = Arena_LoadUI}, c)
		--API:AddElement({name = "PVPTeamDetails", displayName = "Arena Team Details"}, c)
		--API:AddElement({name = "ArenaFrame", displayName = "Arena Queue List"}, c)
		--API:AddElement({name = "ArenaRegistrarFrame", displayName = "Arena Registrar"}, c)
		--API:AddElement({name = "PVPBannerFrame", displayName = "Arena Banner"}, c)
		API:AddElement({name = "ArenaPrepFrame1", displayName = MOVANY.EL_ARENA_PREP_FRAME1, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame2", displayName = MOVANY.EL_ARENA_PREP_FRAME2, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame3", displayName = MOVANY.EL_ARENA_PREP_FRAME3, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame4", displayName = MOVANY.EL_ARENA_PREP_FRAME4, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		API:AddElement({name = "ArenaPrepFrame5", displayName = MOVANY.EL_ARENA_PREP_FRAME5, create = "ArenaPrepFrameTemplate", runOnce = Arena_LoadUI}, c)
		c = API:GetCategory("Battlegrounds & PvP")
		local pvpf = API:AddElement({name = "PVPUIFrame", displayName = MOVANY.EL_PVPUI_FRAME}, c)
		API:AddElement({name = "PVPReadyDialog", displayName = MOVANY.EL_PVP_READY_DIALOG}, c)
		API:AddElement({name = "PVPReadyPopup", displayName = MOVANY.EL_PVP_READY_POPUP}, c)
		ttt1:AddCategory(c)
		--API:AddElement({name = "BattlefieldMinimap", displayName = "Battlefield Mini Map"}, c)
		--API:AddElement({name = "MiniMapBattlefieldFrame", displayName = "Battleground Minimap Button"}, c)
		API:AddElement({name = "QueueStatusMinimapButton", displayName = MOVANY.EL_QUEUE_STATUS_MINIMAP_BUTTON_BATTLEGROUND}, c)
		API:AddElement({name = "QueueStatusFrame", displayName = MOVANY.EL_QUEUE_STATUS_FRAME_BATTLEGROUND}, c)
		--API:AddElement({name = "BattlefieldFrame", displayName = "Battleground Queue"}, c)
		API:AddElement({name = "UIWidgetTopCenterContainerFrame", displayName = MOVANY.EL_UI_WIDGET_TOP_CENTER_CONTAINER_FRAME}, c)
		API:AddElement({name = "UIWidgetBelowMinimapContainerFrame", displayName = MOVANY.EL_UI_WIDGET_BELOW_MINIMAP_CONTAINER_FRAME, onlyOnceCreated = 1}, c)
		local wsauf = API:AddElement({name = "WorldStateAlwaysUpFrame", displayName = MOVANY.EL_WORLD_STATE_ALWAYS_UP_FRAME, noUnanchorRelatives = 1}, c)
		API:AddElement({name = "AlwaysUpFrame1", displayName = MOVANY.EL_ALWAYS_UP_FRAME1, create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)
		API:AddElement({name = "AlwaysUpFrame2", displayName = MOVANY.EL_ALWAYS_UP_FRAME2, create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)
		API:AddElement({name = "AlwaysUpFrame3", displayName = MOVANY.EL_ALWAYS_UP_FRAME3, create = "WorldStateAlwaysUpTemplate", onlyOnceCreated = 1}, c)
		API:AddElement({name = "PrestigeLevelUpBanner", displayName = MOVANY.EL_PRESTIGE_LEVEL_UP_BANNER}, c)
		c = API:GetCategory("Blizzard Bags")
		API:AddElement({name = "BagsMover", displayName = MOVANY.EL_BAGS_MOVER, noHide = 1}, c)
		API:AddElement({name = "BagButtonsVerticalMover", displayName = MOVANY.EL_BAG_BUTTONS_VERTICAL_MOVER}, c)
		API:AddElement({name = "BagItemSearchBox", displayName = MOVANY.EL_BAG_ITEM_SEARCH_BOX}, c)
		API:AddElement({name = "BagItemAutoSortButton", displayName = MOVANY.EL_BAG_ITEM_AUTO_SORT_BUTTON}, c)
		API:AddElement({name = "BagFrame1", displayName = MOVANY.EL_BAG_FRAME1}, c)
		API:AddElement({name = "BagFrame2", displayName = MOVANY.EL_BAG_FRAME2}, c) --refuseSync = 1
		API:AddElement({name = "BagFrame3", displayName = MOVANY.EL_BAG_FRAME3}, c)
		API:AddElement({name = "BagFrame4", displayName = MOVANY.EL_BAG_FRAME4}, c)
		API:AddElement({name = "BagFrame5", displayName = MOVANY.EL_BAG_FRAME5}, c)
		--API:AddElement({name = "KeyRingFrame", displayName = "Keyring"}, c)
		API:AddElement({name = "MainMenuBarBackpackButton", displayName = MOVANY.EL_MAIN_MENU_BAR_BACKPACK_BUTTON}, c)
		API:AddElement({name = "CharacterBag0Slot", displayName = MOVANY.EL_CHARACTER_BAG0_SLOT}, c)
		API:AddElement({name = "CharacterBag1Slot", displayName = MOVANY.EL_CHARACTER_BAG1_SLOT}, c)
		API:AddElement({name = "CharacterBag2Slot", displayName = MOVANY.EL_CHARACTER_BAG2_SLOT}, c)
		API:AddElement({name = "CharacterBag3Slot", displayName = MOVANY.EL_CHARACTER_BAG3_SLOT}, c)
		--API:AddElement({name = "KeyRingButton", displayName = "Keyring Button"}, c)
		c = API:GetCategory("Blizzard Action Bars")
		API:AddElement({name = "BasicActionButtonsMover", displayName = MOVANY.EL_BASIC_ACTION_BUTTONS_MOVER, --[[linkedScaling = {"ActionBarDownButton", "ActionBarUpButton"}--]]}, c)
		API:AddElement({name = "BasicActionButtonsVerticalMover", displayName = MOVANY.EL_BASIC_ACTION_BUTTONS_VERTICAL_MOVER}, c)
		API:AddElement({name = "MultiBarBottomLeft", displayName = MOVANY.EL_MULTI_BAR_BOTTOM_LEFT}, c)
		API:AddElement({name = "MultiBarBottomRight", displayName = MOVANY.EL_MULTI_BAR_BOTTOM_RIGHT}, c)
		--[[API:AddElement({name = "MultiBarRightMovert", displayName = "Right Action Bar", run = function()
			if MovAny:IsModified("MultiBarRightHorizontalMover") then
				MovAny:ResetFrame("MultiBarRightHorizontalMover")
			end
		end}, c)]]
		API:AddElement({name = "MultiBarRightMover", displayName = MOVANY.EL_MULTI_BAR_RIGHT_MOVER}, c)
		API:AddElement({name = "MultiBarRightHorizontalMover", displayName = MOVANY.EL_MULTI_BAR_RIGHT_HORIZONTAL_MOVER}, c)
		--[[API:AddElement({name = "MultiBarLeft", displayName = "Right Action Bar 2", run = function()
			if MovAny:IsModified("MultiBarLeftHorizontalMover") then
				MovAny:ResetFrame("MultiBarLeftHorizontalMover")
			end
		end}, c)]] --MultiBarLeftMover
		API:AddElement({name = "MultiBarLeftMover", displayName = MOVANY.EL_MULTI_BAR_LEFT_MOVER}, c)
		API:AddElement({name = "MultiBarLeftHorizontalMover", displayName = MOVANY.EL_MULTI_BAR_LEFT_HORIZONTAL_MOVER}, c)
		--API:AddElement({name = "MainMenuBarPageNumber", displayName = "Action Bar Page Number"}, c)
		API:AddElement({name = "MainMenuBarPageNumberMover", displayName = MOVANY.EL_MAIN_MENU_BAR_PAGE_NUMBER_MOVER}, c)
		API:AddElement({name = "ActionBarUpButton", displayName = MOVANY.EL_ACTION_BAR_UP_BUTTON}, c)
		API:AddElement({name = "ActionBarDownButton", displayName = MOVANY.EL_ACTION_BAR_DOWN_BUTTON}, c)
		API:AddElement({name = "ExtraAbilityContainer", displayName = MOVANY.EL_EXTRA_ABILITY_CONTAINER}, c)
		API:AddElement({name = "UIWidgetPowerBarContainerFrame", displayName = MOVANY.EL_UI_WIDGET_POWER_BAR_CONTAINER_FRAME}, c)
		API:AddElement({name = "PetActionButtonsMover", displayName = MOVANY.EL_PET_ACTION_BUTTONS_MOVER}, c)
		API:AddElement({name = "PetActionButtonsVerticalMover", displayName = MOVANY.EL_PET_ACTION_BUTTONS_VERTICAL_MOVER}, c)
		API:AddElement({name = "StanceButtonsMover", displayName = MOVANY.EL_STANCE_BUTTONS_MOVER}, c)
		API:AddElement({name = "StanceButtonsVerticalMover", displayName = MOVANY.EL_STANCE_BUTTONS_VERTICAL_MOVER}, c)
		c = API:GetCategory("Blizzard Bank and VoidStorage")
		local bf = API:AddElement({name = "BankFrame", displayName = MOVANY.EL_BANK_FRAME}, c)
		API:AddElement({name = "BankItemSearchBox", displayName = MOVANY.EL_BANK_ITEM_SEARCH_BOX}, c)
		API:AddElement({name = "BankItemAutoSortButton", displayName = MOVANY.EL_BANK_ITEM_AUTO_SORT_BUTTON}, c)
		API:AddElement({name = "BankBagItemsMover", displayName = MOVANY.EL_BANK_BAG_ITEMS_MOVER}, c)
		API:AddElement({name = "BankBagSlotsMover", displayName = MOVANY.EL_BANK_BAG_SLOTS_MOVER}, c)
		--[[API:AddElement({name = "BankFrameBag1", displayName = "Bank Bag Slot 1"}, c)
		API:AddElement({name = "BankFrameBag2", displayName = "Bank Bag Slot 2"}, c)
		API:AddElement({name = "BankFrameBag3", displayName = "Bank Bag Slot 3"}, c)
		API:AddElement({name = "BankFrameBag4", displayName = "Bank Bag Slot 4"}, c)
		API:AddElement({name = "BankFrameBag5", displayName = "Bank Bag Slot 5"}, c)
		API:AddElement({name = "BankFrameBag6", displayName = "Bank Bag Slot 6"}, c)
		API:AddElement({name = "BankFrameBag7", displayName = "Bank Bag Slot 7"}, c)]]
		API:AddElement({name = "BankFrameMoneyFrame", displayName = MOVANY.EL_BANK_FRAME_MONEY_FRAME}, c)
		API:AddElement({name = "BankFrameMoneyFrameGoldButton", displayName = MOVANY.EL_BANK_FRAME_MONEY_FRAME_GOLD_BUTTON}, c)
		API:AddElement({name = "BankFrameMoneyFrameSilverButton", displayName = MOVANY.EL_BANK_FRAME_MONEY_FRAME_SILVER_BUTTON}, c)
		API:AddElement({name = "BankFrameMoneyFrameCopperButton", displayName = MOVANY.EL_BANK_FRAME_MONEY_FRAME_COPPER_BUTTON}, c)
		--API:AddElement({name = "BankFrameMoneyFrameBorder", displayName = "Bank Money Border"}, c)
		--API:AddElement({name = "BankFrameMoneyFrameInset", displayName = "Bank Money Inset"}, c)
		API:AddElement({name = "BankBagFrame1", displayName = MOVANY.EL_BANK_BAG_FRAME1}, c)
		API:AddElement({name = "BankBagFrame2", displayName = MOVANY.EL_BANK_BAG_FRAME2}, c)
		API:AddElement({name = "BankBagFrame3", displayName = MOVANY.EL_BANK_BAG_FRAME3}, c)
		API:AddElement({name = "BankBagFrame4", displayName = MOVANY.EL_BANK_BAG_FRAME4}, c)
		API:AddElement({name = "BankBagFrame5", displayName = MOVANY.EL_BANK_BAG_FRAME5}, c)
		API:AddElement({name = "BankBagFrame6", displayName = MOVANY.EL_BANK_BAG_FRAME6}, c)
		API:AddElement({name = "BankBagFrame7", displayName = MOVANY.EL_BANK_BAG_FRAME7}, c)
		local gbf = API:AddElement({name = "GuildBankFrame", displayName = MOVANY.EL_GUILD_BANK_FRAME}, c)
		local gbt1 = API:AddElement({name = "GuildBankTab1", displayName = MOVANY.EL_GUILD_BANK_TAB1}, c)
		local gbt2 = API:AddElement({name = "GuildBankTab2", displayName = MOVANY.EL_GUILD_BANK_TAB2}, c)
		local gbt3 = API:AddElement({name = "GuildBankTab3", displayName = MOVANY.EL_GUILD_BANK_TAB3}, c)
		local gbt4 = API:AddElement({name = "GuildBankTab4", displayName = MOVANY.EL_GUILD_BANK_TAB4}, c)
		local gbt5 = API:AddElement({name = "GuildBankTab5", displayName = MOVANY.EL_GUILD_BANK_TAB5}, c)
		local gbt6 = API:AddElement({name = "GuildBankTab6", displayName = MOVANY.EL_GUILD_BANK_TAB6}, c)
		local gbt7 = API:AddElement({name = "GuildBankTab7", displayName = MOVANY.EL_GUILD_BANK_TAB7}, c)
		local gbt8 = API:AddElement({name = "GuildBankTab8", displayName = MOVANY.EL_GUILD_BANK_TAB8}, c)
		local gisb = API:AddElement({name = "GuildItemSearchBox", displayName = MOVANY.EL_GUILD_ITEM_SEARCH_BOX}, c)
		local gbis = API:AddElement({name = "GuildBankInfoSaveButton", displayName = MOVANY.EL_GUILD_BANK_INFO_SAVE_BUTTON}, c)
		local gbfw = API:AddElement({name = "GuildBankFrameWithdrawButton", displayName = MOVANY.EL_GUILD_BANK_FRAME_WITHDRAW_BUTTON}, c)
		local gbfd = API:AddElement({name = "GuildBankFrameDepositButton", displayName = MOVANY.EL_GUILD_BANK_FRAME_DEPOSIT_BUTTON}, c)
		local gbwm = API:AddElement({name = "GuildBankWithdrawMoneyFrame", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY_FRAME}, c)
		local gbwmg = API:AddElement({name = "GuildBankWithdrawMoneyFrameGoldButton", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY_FRAME_GOLD_BUTTON}, c)
		local gbwms = API:AddElement({name = "GuildBankWithdrawMoneyFrameSilverButton", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY_FRAME_SILVER_BUTTON}, c)
		local gbwmc = API:AddElement({name = "GuildBankWithdrawMoneyFrameCopperButton", displayName = MOVANY.EL_GUILD_BANK_WITHDRAW_MONEY_FRAME_COPPER_BUTTON}, c)
		local gbmf = API:AddElement({name = "GuildBankMoneyFrame", displayName = MOVANY.EL_GUILD_BANK_MONEY_FRAME}, c)
		local gbmfg = API:AddElement({name = "GuildBankMoneyFrameGoldButton", displayName = MOVANY.EL_GUILD_BANK_MONEY_FRAME_GOLD_BUTTON}, c)
		local gbmfs = API:AddElement({name = "GuildBankMoneyFrameSilverButton", displayName = MOVANY.EL_GUILD_BANK_MONEY_FRAME_SILVER_BUTTON}, c)
		local gbmfc = API:AddElement({name = "GuildBankMoneyFrameCopperButton", displayName = MOVANY.EL_GUILD_BANK_MONEY_FRAME_COPPER_BUTTON}, c)
		API:AddElement({name = "VoidStorageFrame", displayName = MOVANY.EL_VOID_STORAGE_FRAME}, c) --refuseSync = MOVANY.FRAME_ONLY_WHEN_VOIDSTORAGE_IS_OPEN
		c = API:GetCategory("Blizzard Bottom Bar")
		--[[API:AddElement({name = "MainMenuBar", displayName = "Main Bar", run = function ()
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
		API:AddElement({name = "MainMenuBarArtFrameLeftEndCapMover", displayName = "Left Gryphon", noScale = 1}, c)
		API:AddElement({name = "MainMenuBarArtFrameRightEndCapMover", displayName = "Right Gryphon", noScale = 1}, c)
		API:AddElement({name = "MainMenuExpBar", displayName = "Experience Bar", scaleWH = 1, hideOnScale = {
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
		--API:AddElement({name = "HonorWatchBar", displayName = "Honor Bar"}, c)
		--API:AddElement({name = "ArtifactWatchBar", displayName = "Artifact Bar"}, c)
		--API:AddElement({name = "MainMenuBarMaxLevelBar", displayName = "Max Level Bar Filler", noFE = 1, noScale = 1}, c)
		--[[API:AddElement({name = "ReputationWatchBar", displayName = "Reputation Tracker Bar", runOnce = function()
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
		API:AddElement({name = "MicroButtonAndBagsBar", displayName = MOVANY.EL_MICRO_BUTTON_AND_BAGS_BAR}, c)
		API:AddElement({name = "BagButtonsMover", displayName = MOVANY.EL_BAG_BUTTONS_MOVER}, c)
		API:AddElement({name = "MicroButtonsMover", displayName = MOVANY.EL_MICRO_BUTTONS_MOVER}, c)
		--API:AddElement({name = "MicroButtonsSplitMover", displayName = "Micro Menu - Split"}, c)
		--API:AddElement({name = "MicroButtonsVerticalMover", displayName = "Micro Menu - Vertical"}, c)
		API:AddElement({name = "MainMenuBarVehicleLeaveButton", displayName = MOVANY.EL_MAIN_MENU_BAR_VEHICLE_LEAVE_BUTTON}, c)
		c = API:GetCategory("Class Specific")
		API:AddElement({name = "PlayerFrameAlternateManaBar", displayName = MOVANY.EL_PLAYER_FRAME_ALTERNATE_MANA_BAR}, c)
		API:AddElement({name = "ComboPointPlayerFrame", displayName = MOVANY.EL_COMBO_POINT_PLAYER_FRAME}, c)
		API:AddElement({name = "RuneFrame", displayName = MOVANY.EL_RUNE_FRAME}, c)
		API:AddElement({name = "PaladinPowerBarFrame", displayName = MOVANY.EL_PALADIN_POWER_BAR_FRAME}, c)
		API:AddElement({name = "MageArcaneChargesFrame", displayName = MOVANY.EL_MAGE_ARCANE_CHARGES_FRAME}, c)
		API:AddElement({name = "WarlockPowerFrame", displayName = MOVANY.EL_WARLOCK_POWER_FRAME}, c)
		API:AddElement({name = "MonkHarmonyBarFrameMover", displayName = MOVANY.EL_MONK_HARMONY_BAR_FRAME_MOVER}, c)
		API:AddElement({name = "MonkStaggerBar", displayName = MOVANY.EL_MONK_STAGGER_BAR}, c)
		API:AddElement({name = "MultiCastActionBarFrame", displayName = MOVANY.EL_MULTI_CAST_ACTION_BAR_FRAME}, c)
		API:AddElement({name = "TotemFrame", displayName = MOVANY.EL_TOTEM_FRAME}, c)
		c = API:GetCategory("Dungeons & Raids")
		API:AddElement({name = "PVEFrame", displayName = MOVANY.EL_PVE_FRAME}, c)
		API:AddElement({name = "EncounterJournal", displayName = MOVANY.EL_ENCOUNTER_JOURNAL}, c)
		--API:AddElement({name = "LFGSearchStatus", displayName = "Dungeon/Raid Finder Queue Status"}, c)
		API:AddElement({name = "ChallengesKeystoneFrame", displayName = MOVANY.EL_CHALLENGES_KEYSTONE_FRAME}, c)
		API:AddElement({name = "DungeonCompletionAlertFrame1", displayName = MOVANY.EL_DUNGEON_COMPLETION_ALERT_FRAME1}, c)
		API:AddElement({name = "ScenarioAlertFrame1", displayName = MOVANY.EL_SCENARIO_ALERT_FRAME1}, c)
		API:AddElement({name = "ScenarioAlertFrame2", displayName = MOVANY.EL_SCENARIO_ALERT_FRAME2}, c)
		API:AddElement({name = "LevelUpDisplay", displayName = MOVANY.EL_LEVEL_UP_DISPLAY}, c)
		API:AddElement({name = "QueueStatusMinimapButton", displayName = MOVANY.EL_QUEUE_STATUS_MINIMAP_BUTTON_DUNGEON}, c)
		API:AddElement({name = "QueueStatusFrame", displayName = MOVANY.EL_QUEUE_STATUS_FRAME_DUNGEON}, c)
		API:AddElement({name = "LFGDungeonReadyDialog", displayName = MOVANY.EL_LFG_DUNGEON_READY_DIALOG}, c)
		API:AddElement({name = "LFGDungeonReadyPopup", displayName = MOVANY.EL_LFG_DUNGEON_READY_POPUP}, c)
		API:AddElement({name = "LFGDungeonReadyStatus", displayName = MOVANY.EL_LFG_DUNGEON_READY_STATUS}, c)
		API:AddElement({name = "LFDRoleCheckPopup", displayName = MOVANY.EL_LFD_ROLE_CHECK_POPUP}, c)
		API:AddElement({name = "RaidBossEmoteFrame", displayName = MOVANY.EL_RAID_BOSS_EMOTE_FRAME}, c)
		API:AddElement({name = "Boss1TargetFrame", displayName = MOVANY.EL_BOSS1_TARGET_FRAME, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss1TargetFramePowerBarAlt", displayName = MOVANY.EL_BOSS1_TARGET_FRAME_POWER_BAR_ALT}, c)
		API:AddElement({name = "Boss2TargetFrame", displayName = MOVANY.EL_BOSS2_TARGET_FRAME, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss2TargetFramePowerBarAlt", displayName = MOVANY.EL_BOSS2_TARGET_FRAME_POWER_BAR_ALT}, c)
		API:AddElement({name = "Boss3TargetFrame", displayName = MOVANY.EL_BOSS3_TARGET_FRAME, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss3TargetFramePowerBarAlt", displayName = MOVANY.EL_BOSS3_TARGET_FRAME_POWER_BAR_ALT}, c)
		API:AddElement({name = "Boss4TargetFrame", displayName = MOVANY.EL_BOSS4_TARGET_FRAME, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss4TargetFramePowerBarAlt", displayName = MOVANY.EL_BOSS4_TARGET_FRAME_POWER_BAR_ALT}, c)
		API:AddElement({name = "Boss5TargetFrame", displayName = MOVANY.EL_BOSS5_TARGET_FRAME, create = "BossTargetFrameTemplate"}, c)
		API:AddElement({name = "Boss5TargetFramePowerBarAlt", displayName = MOVANY.EL_BOSS5_TARGET_FRAME_POWER_BAR_ALT}, c)
		API:AddElement({name = "RaidBrowserFrame", displayName = MOVANY.EL_RAID_BROWSER_FRAME}, c)
		--API:AddElement({name = "RaidParentFrame", displayName = "Raid Finder"}, c)
		API:AddElement({name = "CompactRaidGroup1", displayName = MOVANY.EL_COMPACT_RAID_GROUP1}, c)
		API:AddElement({name = "CompactRaidGroup2", displayName = MOVANY.EL_COMPACT_RAID_GROUP2}, c)
		API:AddElement({name = "CompactRaidGroup3", displayName = MOVANY.EL_COMPACT_RAID_GROUP3}, c)
		API:AddElement({name = "CompactRaidGroup4", displayName = MOVANY.EL_COMPACT_RAID_GROUP4}, c)
		API:AddElement({name = "CompactRaidGroup5", displayName = MOVANY.EL_COMPACT_RAID_GROUP5}, c)
		API:AddElement({name = "CompactRaidGroup6", displayName = MOVANY.EL_COMPACT_RAID_GROUP6}, c)
		API:AddElement({name = "CompactRaidGroup7", displayName = MOVANY.EL_COMPACT_RAID_GROUP7}, c)
		API:AddElement({name = "CompactRaidGroup8", displayName = MOVANY.EL_COMPACT_RAID_GROUP8}, c)
		API:AddElement({name = "CompactRaidFrameManager", displayName = MOVANY.EL_COMPACT_RAID_FRAME_MANAGER}, c)
		API:AddElement({name = "CompactRaidFrameManagerToggleButton", displayName = MOVANY.EL_COMPACT_RAID_FRAME_MANAGER_TOGGLE_BUTTON, onlyOnceCreated = 1}, c)
		API:AddElement({name = "CompactRaidFrameBuffTooltipsMover", displayName = MOVANY.EL_COMPACT_RAID_FRAME_BUFF_TOOLTIPS_MOVER}, c)
		API:AddElement({name = "CompactRaidFrameDebuffTooltipsMover", displayName = MOVANY.EL_COMPACT_RAID_FRAME_DEBUFF_TOOLTIPS_MOVER}, c)
		API:AddElement({name = "RolePollPopup", displayName = MOVANY.EL_ROLE_POLL_POPUP}, c)
		API:AddElement({name = "RaidUnitFramesMover", displayName = MOVANY.EL_RAID_UNIT_FRAMES_MOVER}, c)
		API:AddElement({name = "RaidWarningFrame", displayName = MOVANY.EL_RAID_WARNING_FRAME}, c)
		API:AddElement({name = "ReadyCheckFrame", displayName = MOVANY.EL_READY_CHECK_FRAME}, c)
		c = API:GetCategory("Boss Specific Frames")
		API:AddElement({name = "BossBanner", displayName = MOVANY.EL_BOSS_BANNER}, c)
		local pbab = API:AddElement({name = "PlayerPowerBarAltMover", displayName = MOVANY.EL_PLAYER_POWER_BAR_ALT_MOVER}, c)
		local tbab = API:AddElement({name = "TargetFramePowerBarAltMover", displayName = MOVANY.EL_TARGET_FRAME_POWER_BAR_ALT_MOVER}, c)
		c = API:GetCategory("Game Menu")
		API:AddElement({name = "GameMenuFrame", displayName = MOVANY.EL_GAME_MENU_FRAME,
			hideList = {
				{"GameMenuFrame", "BACKGROUND","ARTWORK","BORDER"},
			}
		}, c)
		API:AddElement({name = "VideoOptionsFrame", displayName = MOVANY.EL_VIDEO_OPTIONS_FRAME, runOnce = function()
				hooksecurefunc(VideoOptionsFrame, "Show", function()
					if MovAny:IsModified("VideoOptionsFrame") then
						HideUIPanel(GameMenuFrame)
					end
				end)
			end, positionReset = function(self, f, opt, readOnly)
		end}, c)
		API:AddElement({name = "AudioOptionsFrame", displayName = MOVANY.EL_AUDIO_OPTIONS_FRAME, runOnce = function()
			hooksecurefunc(AudioOptionsFrame, "Show", function()
				if MovAny:IsModified("AudioOptionsFrame") then
					HideUIPanel(GameMenuFrame)
				end
			end)
		end}, c)
		API:AddElement({name = "InterfaceOptionsFrame", displayName = MOVANY.EL_INTERFACE_OPTIONS_FRAME, runOnce = function()
			hooksecurefunc(InterfaceOptionsFrame, "Show", function()
				if MovAny:IsModified("InterfaceOptionsFrame") then
					HideUIPanel(GameMenuFrame)
				end
			end)
		end}, c)
		API:AddElement({name = "KeyBindingFrame", displayName = MOVANY.EL_KEY_BINDING_FRAME}, c)
		API:AddElement({name = "MacroFrame", displayName = MOVANY.EL_MACRO_OPTIONS}, c)
		c = API:GetCategory("Garrison")
		API:AddElement({name = "GarrisonLandingPage", displayName = MOVANY.EL_GARRISON_LANDING_PAGE}, c)
		API:AddElement({name = "GarrisonLandingPageMinimapButton", displayName = MOVANY.EL_GARRISON_LANDING_PAGE_MINIMAP_BUTTON}, c)
		API:AddElement({name = "GarrisonBuildingFrame", displayName = MOVANY.EL_GARRISON_BUILDING_FRAME}, c)
		API:AddElement({name = "GarrisonMissionFrame", displayName = MOVANY.EL_GARRISON_MISSION_FRAME}, c)
		API:AddElement({name = "GarrisonMissionAlertFrame", displayName = MOVANY.EL_GARRISON_MISSION_ALERT_FRAME}, c)
		API:AddElement({name = "GarrisonBuildingAlertFrame", displayName = MOVANY.EL_GARRISON_BUILDING_ALERT_FRAME}, c)
		API:AddElement({name = "GarrisonFollowerAlertFrame", displayName = MOVANY.EL_GARRISON_FOLLOWER_ALERT_FRAME}, c)
		API:AddElement({name = "GarrisonCapacitiveDisplayFrame", displayName = MOVANY.EL_GARRISON_CAPACITIVE_DISPLAY_FRAME}, c)
		API:AddElement({name = "GarrisonMonumentFrame", displayName = MOVANY.EL_GARRISON_MONUMENT_FRAME}, c)
		c = API:GetCategory("Shipyard")
		API:AddElement({name = "GarrisonShipyardFrame", displayName = MOVANY.EL_GARRISON_SHIPYARD_FRAME}, c)
		API:AddElement({name = "GarrisonShipMissionAlertFrame", displayName = MOVANY.EL_GARRISON_SHIP_MISSION_ALERT_FRAME}, c)
		API:AddElement({name = "GarrisonShipFollowerAlertFrame", displayName = MOVANY.EL_GARRISON_SHIP_FOLLOWER_ALERT_FRAME}, c)
		c = API:GetCategory("Order Hall")
		API:AddElement({name = "OrderHallCommandBar", displayName = MOVANY.EL_ORDER_HALL_COMMAND_BAR}, c)
		API:AddElement({name = "OrderHallMissionFrame", displayName = MOVANY.EL_ORDER_HALL_MISSION_FRAME}, c)
		API:AddElement({name = "OrderHallTalentFrame", displayName = MOVANY.EL_ORDER_HALL_TALENT_FRAME}, c)
		API:AddElement({name = "GarrisonTalentAlertFrame", displayName = MOVANY.EL_GARRISON_TALENT_ALERT_FRAME}, c)
		c = API:GetCategory("Guild")
		API:AddElement({name = "GuildFrame", displayName = MOVANY.EL_GUILD_FRAME}, c)
		API:AddElement({name = "CommunitiesFrame", displayName = MOVANY.EL_COMMUNITIES_FRAME}, c)
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
		API:AddElement({name = "GuildControlUI", displayName = MOVANY.EL_GUILD_CONTROL_UI}, c)
		local lfgf = API:AddElement({name = "LookingForGuildFrame", displayName = MOVANY.EL_LOOKING_FOR_GUILD_FRAME}, c)
		--API:AddElement({name = "GuildInfoFrame", displayName = "Guild Info"}, c)
		API:AddElement({name = "GuildInviteFrame", displayName = MOVANY.EL_GUILD_INVITE_FRAME}, c)
		--API:AddElement({name = "GuildLogContainer", displayName = "Guild Log"}, c)
		API:AddElement({name = "GuildMemberDetailFrame", displayName = MOVANY.EL_GUILD_MEMBER_DETAIL_FRAME}, c)
		API:AddElement({name = "GuildRegistrarFrame", displayName = MOVANY.EL_GUILD_REGISTRAR_FRAME}, c)
		c = API:GetCategory("Info Panels")
		API:AddElement({name = "UIPanelMover1", displayName = MOVANY.EL_UI_PANEL_MOVER1, noHide = 1}, c)
		API:AddElement({name = "UIPanelMover2", displayName = MOVANY.EL_UI_PANEL_MOVER2, noHide = 1}, c)
		API:AddElement({name = "UIPanelMover3", displayName = MOVANY.EL_UI_PANEL_MOVER3, noHide = 1}, c)
		bf:AddCategory(c)
		API:AddElement({name = "CharacterFrame", displayName = MOVANY.EL_CHARACTER_FRAME}, c)
		API:AddElement({name = "DressUpFrame", displayName = MOVANY.EL_DRESS_UP_FRAME}, c)
		--API:AddElement({name = "LFDParentFrame", displayName = "Dungeon Finder"}, c)
		API:AddElement({name = "ArtifactFrame", displayName = MOVANY.EL_ARTIFACT_FRAME}, c)
		API:AddElement({name = "TaxiFrame", displayName = MOVANY.EL_TAXI_FRAME}, c)
		API:AddElement({name = "FlightMapFrame", displayName = MOVANY.EL_FLIGHT_MAP_FRAME}, c)
		lfgf:AddCategory(c)
		API:AddElement({name = "GossipFrame", displayName = MOVANY.EL_GOSSIP_FRAME}, c)
		API:AddElement({name = "InspectFrame", displayName = MOVANY.EL_INSPECT_FRAME}, c)
		--API:AddElement({name = "LFRParentFrame", displayName = "Looking For Raid"}, c)
		--API:AddElement({name = "MacroFrame", displayName = "Macros"}, c)
		API:AddElement({name = "MailFrame", displayName = MOVANY.EL_MAIL_FRAME}, c)
		API:AddElement({name = "MerchantFrame", displayName = MOVANY.EL_MERCHANT_FRAME}, c)
		API:AddElement({name = "OpenMailFrame", displayName = MOVANY.EL_OPEN_MAIL_FRAME}, c)
		API:AddElement({name = "PetStableFrame", displayName = MOVANY.EL_PET_STABLE_FRAME}, c)
		API:AddElement({name = "FriendsFrame", displayName = MOVANY.EL_FRIENDS_FRAME}, c)
		API:AddElement({name = "WardrobeFrame", displayName = MOVANY.EL_WARDROBE_FRAME}, c)
		pvpf:AddCategory(c)
		--qldf:AddCategory(c)
		--qlf:AddCategory(c)
		qf:AddCategory(c)
		API:AddElement({name = "SpellBookFrame", displayName = MOVANY.EL_SPELL_BOOK_FRAME}, c)
		API:AddElement({name = "ItemUpgradeFrame", displayName = MOVANY.EL_ITEM_UPGRADE_FRAME}, c)
		API:AddElement({name = "CollectionsJournal", displayName = MOVANY.EL_COLLECTIONS_JOURNAL}, c)
		API:AddElement({name = "TabardFrame", displayName = MOVANY.EL_TABARD_FRAME}, c)
		API:AddElement({name = "PlayerTalentFrame", displayName = MOVANY.EL_PLAYER_TALENT_FRAME, refuseSync = MOVANY.FRAME_ONLY_ONCE_OPENED}, c)
		API:AddElement({name = "TradeFrame", displayName = MOVANY.EL_TRADE_FRAME}, c)
		API:AddElement({name = "ArchaeologyFrame", displayName = MOVANY.EL_ARCHAEOLOGY_FRAME}, c)
		API:AddElement({name = "ReforgingFrame", displayName = MOVANY.EL_REFORGING_FRAME}, c)
		API:AddElement({name = "TradeSkillFrame", displayName = MOVANY.EL_TRADE_SKILL_FRAME}, c)
		API:AddElement({name = "ClassTrainerFrame", displayName = MOVANY.EL_CLASS_TRAINER_FRAME}, c)
		API:AddElement({name = "GarrisonCapacitiveDisplayFrame", displayName = MOVANY.EL_GARRISON_CAPACITIVE_DISPLAY_FRAME2}, c)
		API:AddElement({name = "ReportPlayerNameDialog", displayName = MOVANY.EL_REPORT_PLAYER_NAME_DIALOG}, c)
		API:AddElement({name = "ReportCheatingDialog", displayName = MOVANY.EL_REPORT_CHEATING_DIALOG}, c)
		c = API:GetCategory("Loot")
		API:AddElement({name = "LootFrame", displayName = MOVANY.EL_LOOT_FRAME}, c)
		API:AddElement({name = "AlertFrame", displayName = MOVANY.EL_ALERT_FRAME}, c)
		--API:AddElement({name = "LootWonAlertFrame1", displayName = "Loot Won Alert Frame 1"}, c)
		--API:AddElement({name = "GroupLootContainer", displayName = "All Loot Roll Frame", create = "GroupLootFrameTemplate", noScale = 1}, c)
		--API:AddElement({name = "LootWonAlertMover1", displayName = "Loot Won Alert Frame1"}, c)
		--API:AddElement({name = "LootWonAlertMover2", displayName = "Loot Won Alert Frame2"}, c)
		--API:AddElement({name = "LootWonAlertMover3", displayName = "Loot Won Alert Frame3"}, c)
		--API:AddElement({name = "LootWonAlertMover4", displayName = "Loot Won Alert Frame4"}, c)
		--API:AddElement({name = "LootWonAlertMover5", displayName = "Loot Won Alert Frame5"}, c)
		--API:AddElement({name = "LootWonAlertMover6", displayName = "Loot Won Alert Frame6"}, c)
		--API:AddElement({name = "LootWonAlertMover7", displayName = "Loot Won Alert Frame7"}, c)
		--API:AddElement({name = "LootWonAlertMover8", displayName = "Loot Won Alert Frame8"}, c)
		--API:AddElement({name = "LootWonAlertMover9", displayName = "Loot Won Alert Frame9"}, c)
		--API:AddElement({name = "LootWonAlertMover10", displayName = "Loot Won Alert Frame10"}, c)
		API:AddElement({name = "BonusRollFrame", displayName = MOVANY.EL_BONUS_ROLL_FRAME, create = "BonusRollFrameTemplate"}, c)
		API:AddElement({name = "BonusRollLootWonFrame", displayName = MOVANY.EL_BONUS_ROLL_LOOT_WON_FRAME, create = "LootWonAlertFrameTemplate"}, c)
		API:AddElement({name = "BonusRollMoneyWonFrame", displayName = MOVANY.EL_BONUS_ROLL_MONEY_WON_FRAME, create = "MoneyWonAlertFrameTemplate"}, c)
		--API:AddElement({name = "MoneyWonAlertMover1", displayName = "Money Won Frame1"}, c)
		--API:AddElement({name = "MoneyWonAlertMover2", displayName = "Money Won Frame2"}, c)
		--API:AddElement({name = "MoneyWonAlertMover3", displayName = "Money Won Frame3"}, c)
		--API:AddElement({name = "MoneyWonAlertMover4", displayName = "Money Won Frame4"}, c)
		--API:AddElement({name = "MoneyWonAlertMover5", displayName = "Money Won Frame5"}, c)
		--API:AddElement({name = "MissingLootFrame", displayName = "Missing Loot Frame"}, c)
		API:AddElement({name = "GroupLootFrame1", displayName = MOVANY.EL_GROUP_LOOT_FRAME1, create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame2", displayName = MOVANY.EL_GROUP_LOOT_FRAME2, create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame3", displayName = MOVANY.EL_GROUP_LOOT_FRAME3, create = "GroupLootFrameTemplate"}, c)
		API:AddElement({name = "GroupLootFrame4", displayName = MOVANY.EL_GROUP_LOOT_FRAME4, create = "GroupLootFrameTemplate"}, c)
		c = API:GetCategory("Map")
		API:AddElement({name = "WorldMapFrame", displayName = MOVANY.EL_WORLD_MAP_FRAME}, c)
		--API:AddElement({name = "WorldMapLevelDropDown", displayName = "Map Level"}, c)
		--API:AddElement({name = "WorldMapShowDropDown", displayName = "Map Options"}, c)
		--API:AddElement({name = "WorldMapTrackQuest", displayName = "Map Track Quest"}, c)
		--API:AddElement({name = "WorldMapPositioningGuide", displayName = "Map Coordinates"}, c)
		c = API:GetCategory("Minimap")
		API:AddElement({name = "MinimapCluster", displayName = MOVANY.EL_MINIMAP_CLUSTER}, c)
		API:AddElement({name = "MinimapBorder", displayName = MOVANY.EL_MINIMAP_BORDER}, c)
		API:AddElement({name = "MinimapZoneTextButton", displayName = MOVANY.EL_MINIMAP_ZONE_TEXT_BUTTON}, c)
		API:AddElement({name = "MinimapBorderTop", displayName = MOVANY.EL_MINIMAP_BORDER_TOP, noScale = 1}, c)
		API:AddElement({name = "MinimapBackdrop", displayName = MOVANY.EL_MINIMAP_BACKDROP, noAlpha = 1, noScale = 1, hideList = {{"MinimapBackdrop", "ARTWORK"}}}, c)
		API:AddElement({name = "MinimapNorthTag", displayName = MOVANY.EL_MINIMAP_NORTH_TAG, noScale = 1}, c)
		API:AddElement({name = "GameTimeFrame", displayName = MOVANY.EL_GAME_TIME_FRAME}, c)
		API:AddElement({name = "TimeManagerClockButton", displayName = MOVANY.EL_TIME_MANAGER_CLOCK_BUTTON}, c)
		API:AddElement({name = "MiniMapInstanceDifficulty", displayName = MOVANY.EL_MINI_MAP_INSTANCE_DIFFICULTY}, c)
		API:AddElement({name = "GuildInstanceDifficulty", displayName = MOVANY.EL_GUILD_INSTANCE_DIFFICULTY}, c)
		API:AddElement({name = "QueueStatusMinimapButton", displayName = MOVANY.EL_QUEUE_STATUS_MINIMAP_BUTTON}, c)
		API:AddElement({name = "MiniMapMailFrame", displayName = MOVANY.EL_MINI_MAP_MAIL_FRAME}, c)
		API:AddElement({name = "MiniMapTracking", displayName = MOVANY.EL_MINI_MAP_TRACKING}, c)
		API:AddElement({name = "MinimapZoomIn", displayName = MOVANY.EL_MINIMAP_ZOOM_IN}, c)
		API:AddElement({name = "MinimapZoomOut", displayName = MOVANY.EL_MINIMAP_ZOOM_OUT}, c)
		API:AddElement({name = "MiniMapWorldMapButton", displayName = MOVANY.EL_MINI_MAP_WORLD_MAP_BUTTON}, c)
		API:AddElement({name = "BattlefieldMinimap", displayName = MOVANY.EL_BATTLEFIELD_MINIMAP}, c)
		c = API:GetCategory("Miscellaneous")
		API:AddElement({name = "ActionStaus", displayName = MOVANY.EL_ACTION_STAUS}, c)
		API:AddElement({name = "TimeManagerFrame", displayName = MOVANY.EL_TIME_MANAGER_FRAME}, c)
		API:AddElement({name = "BlackMarketFrame", displayName = MOVANY.EL_BLACK_MARKET_FRAME, runOnce = BlackMarketFrame_Show}, c)
		API:AddElement({name = "AuctionFrame", displayName = MOVANY.EL_AUCTION_FRAME, runOnce = function()
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
		API:AddElement({name = "SideDressUpFrame", displayName = MOVANY.EL_SIDE_DRESS_UP_FRAME}, c)
		API:AddElement({name = "AuctionProgressFrame", displayName = MOVANY.EL_AUCTION_PROGRESS_FRAME}, c)
		API:AddElement({name = "BarberShopFrame", displayName = MOVANY.EL_BARBER_SHOP_FRAME}, c)
		API:AddElement({name = "BNToastFrame", displayName = MOVANY.EL_BN_TOAST_FRAME}, c)
		API:AddElement({name = "TimeAlertFrame", displayName = MOVANY.EL_TIME_ALERT_FRAME}, c)
		API:AddElement({name = "QuickJoinToastMover", displayName = MOVANY.EL_QUICK_JOIN_TOAST_MOVER}, c)
		API:AddElement({name = "QuickJoinToast2Mover", displayName = MOVANY.EL_QUICK_JOIN_TOAST2_MOVER}, c)
		API:AddElement({name = "QuickJoinToastButton", displayName = MOVANY.EL_QUICK_JOIN_TOAST_BUTTON}, c)
		API:AddElement({name = "MirrorTimer1", displayName = MOVANY.EL_MIRROR_TIMER1}, c)
		API:AddElement({name = "CalendarFrame", displayName = MOVANY.EL_CALENDAR_FRAME}, c)
		API:AddElement({name = "CalendarViewEventFrame", displayName = MOVANY.EL_CALENDAR_VIEW_EVENT_FRAME}, c)
		API:AddElement({name = "ChannelPullout", displayName = MOVANY.EL_CHANNEL_PULLOUT}, c)
		API:AddElement({name = "ChatConfigFrame", displayName = MOVANY.EL_CHAT_CONFIG_FRAME}, c)
		API:AddElement({name = "ChatEditBoxesMover", displayName = MOVANY.EL_CHAT_EDIT_BOXES_MOVER}, c)
		API:AddElement({name = "ChatEditBoxesLengthMover", displayName = MOVANY.EL_CHAT_EDIT_BOXES_LENGTH_MOVER, scaleWH = 1}, c)
		API:AddElement({name = "ColorPickerFrame", displayName = MOVANY.EL_COLOR_PICKER_FRAME}, c)
		API:AddElement({name = "TokenFramePopup", displayName = MOVANY.EL_TOKEN_FRAME_POPUP}, c)
		API:AddElement({name = "ItemRefTooltip", displayName = MOVANY.EL_ITEM_REF_TOOLTIP}, c)
		API:AddElement({name = "DurabilityFrame", displayName = MOVANY.EL_DURABILITY_FRAME}, c)
		API:AddElement({name = "UIErrorsFrame", displayName = MOVANY.EL_UI_ERRORS_FRAME}, c)
		API:AddElement({name = "FramerateLabelMover", displayName = MOVANY.EL_FRAMERATE_LABEL_MOVER, noScale = 1, noUnanchorRelatives = 1}, c)
		API:AddElement({name = "ItemSocketingFrame", displayName = MOVANY.EL_ITEM_SOCKETING_FRAME}, c)
		API:AddElement({name = "HelpFrame", displayName = MOVANY.EL_HELP_FRAME}, c)
		API:AddElement({name = "LevelUpDisplay", displayName = MOVANY.EL_LEVEL_UP_DISPLAY}, c)
		API:AddElement({name = "MacroPopupFrame", displayName = MOVANY.EL_MACRO_POPUP_FRAME}, c)
		API:AddElement({name = "StaticPopup1", displayName = MOVANY.EL_STATIC_POPUP1}, c)
		API:AddElement({name = "StaticPopup2", displayName = MOVANY.EL_STATIC_POPUP2}, c)
		API:AddElement({name = "StaticPopup3", displayName = MOVANY.EL_STATIC_POPUP3}, c)
		API:AddElement({name = "StaticPopup4", displayName = MOVANY.EL_STATIC_POPUP4}, c)
		API:AddElement({name = "StreamingIcon", displayName = MOVANY.EL_STREAMING_ICON}, c)
		API:AddElement({name = "ItemTextFrame", displayName = MOVANY.EL_ITEM_TEXT_FRAME}, c)
		API:AddElement({name = "ReputationDetailFrame", displayName = MOVANY.EL_REPUTATION_DETAIL_FRAME}, c)
		API:AddElement({name = "GhostFrame", displayName = MOVANY.EL_GHOST_FRAME}, c)
		API:AddElement({name = "HelpOpenWebTicketButton", displayName = MOVANY.EL_HELP_OPEN_WEB_TICKET_BUTTON}, c)
		API:AddElement({name = "HelpOpenTicketButtonTutorial", displayName = MOVANY.EL_HELP_OPEN_TICKET_BUTTON_TUTORIAL}, c)
		API:AddElement({name = "TooltipMover", displayName = MOVANY.EL_TOOLTIP_MOVER}, c)
		API:AddElement({name = "BagItemTooltipMover", displayName = MOVANY.EL_BAG_ITEM_TOOLTIP_MOVER}, c)
		API:AddElement({name = "GuildBankItemTooltipMover", displayName = MOVANY.EL_GUILD_BANK_ITEM_TOOLTIP_MOVER}, c)
		wsauf:AddCategory(c)
		API:AddElement({name = "TalentMicroButtonAlert", displayName = MOVANY.EL_TALENT_MICRO_BUTTON_ALERT}, c)
		API:AddElement({name = "TutorialFrameAlertButton", displayName = MOVANY.EL_TUTORIAL_FRAME_ALERT_BUTTON}, c)
		API:AddElement({name = "VoiceChatTalkers", displayName = MOVANY.EL_VOICE_CHAT_TALKERS}, c)
		API:AddElement({name = "ZoneTextFrame", displayName = MOVANY.EL_ZONE_TEXT_FRAME}, c)
		API:AddElement({name = "SubZoneTextFrame", displayName = MOVANY.EL_SUB_ZONE_TEXT_FRAME}, c)
		c = API:GetCategory("MoveAnything")
		API:AddElement({name = "MAOptions", displayName = MOVANY.EL_MA_OPTIONS,
			hideList = {
				{"MAOptions", "ARTWORK","BORDER"},
			}
		}, c)
		--API:AddElement({name = "MA_FEMover", displayName = "MoveAnything Frame Editor Config", noHide = 1}, c)
		API:AddElement({name = "MANudger", displayName = MOVANY.EL_MA_NUDGER}, c)
		API:AddElement({name = "GameMenuButtonMoveAnything", displayName = MOVANY.EL_GAME_MENU_BUTTON_MOVE_ANYTHING}, c)
		c = API:GetCategory("Unit: Focus")
		API:AddElement({name = "FocusFrame", displayName = MOVANY.EL_FOCUS_FRAME}, c)
		API:AddElement({name = "FocusFrameTextureFramePVPIcon", displayName = MOVANY.EL_FOCUS_FRAME_TEXTURE_FRAME_PVP_ICON}, c)
		API:AddElement({name = "FocusBuffsMover", displayName = MOVANY.EL_FOCUS_BUFFS_MOVER}, c)
		API:AddElement({name = "FocusDebuffsMover", displayName = MOVANY.EL_FOCUS_DEBUFFS_MOVER}, c)
		API:AddElement({name = "FocusFrameSpellBar", displayName = MOVANY.EL_FOCUS_FRAME_SPELL_BAR, noAlpha = 1}, c)
		API:AddElement({name = "FocusFrameToT", displayName = MOVANY.EL_FOCUS_FRAME_TOT}, c)
		API:AddElement({name = "FocusFrameToTDebuffsMover", displayName = MOVANY.EL_FOCUS_FRAME_TOT_DEBUFFS_MOVER}, c)
		c = API:GetCategory("Unit: Party")
		API:AddElement({name = "PartyMemberFrame1", displayName = MOVANY.EL_PARTY_MEMBER_FRAME1}, c)
		API:AddElement({name = "PartyMember1DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER1_DEBUFFS_MOVER}, c)
		API:AddElement({name = "PartyMemberFrame2", displayName = MOVANY.EL_PARTY_MEMBER_FRAME2}, c)
		API:AddElement({name = "PartyMember2DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER2_DEBUFFS_MOVER}, c)
		API:AddElement({name = "PartyMemberFrame3", displayName = MOVANY.EL_PARTY_MEMBER_FRAME3}, c)
		API:AddElement({name = "PartyMember3DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER3_DEBUFFS_MOVER}, c)
		API:AddElement({name = "PartyMemberFrame4", displayName = MOVANY.EL_PARTY_MEMBER_FRAME4}, c)
		API:AddElement({name = "PartyMember4DebuffsMover", displayName = MOVANY.EL_PARTY_MEMBER4_DEBUFFS_MOVER}, c)
		c = API:GetCategory("Unit: Pet")
		API:AddElement({name = "PetFrame", displayName = MOVANY.EL_PET_FRAME}, c)
		API:AddElement({name = "PetCastingBarFrame", displayName = MOVANY.EL_PET_CASTING_BAR_FRAME}, c)
		API:AddElement({name = "PetDebuffsMover", displayName = MOVANY.EL_PET_DEBUFFS_MOVER}, c)
		API:AddElement({name = "PartyMemberFrame1PetFrame", displayName = MOVANY.EL_PARTY_MEMBER_FRAME1_PET_FRAME}, c)
		API:AddElement({name = "PartyMemberFrame2PetFrame", displayName = MOVANY.EL_PARTY_MEMBER_FRAME2_PET_FRAME}, c)
		API:AddElement({name = "PartyMemberFrame3PetFrame", displayName = MOVANY.EL_PARTY_MEMBER_FRAME3_PET_FRAME}, c)
		API:AddElement({name = "PartyMemberFrame4PetFrame", displayName = MOVANY.EL_PARTY_MEMBER_FRAME4_PET_FRAME}, c)
		c = API:GetCategory("Unit: Player")
		API:AddElement({name = "PlayerFrame", displayName = MOVANY.EL_PLAYER_FRAME}, c)
		API:AddElement({name = "PlayerPVPIcon", displayName = MOVANY.EL_PLAYER_PVP_ICON}, c)
		API:AddElement({name = "PlayerRestIcon", displayName = MOVANY.EL_PLAYER_REST_ICON}, c)
		API:AddElement({name = "PlayerRestGlow", displayName = MOVANY.EL_PLAYER_REST_GLOW}, c)
		API:AddElement({name = "PlayerAttackIcon", displayName = MOVANY.EL_PLAYER_ATTACK_ICON}, c)
		API:AddElement({name = "PlayerAttackGlow", displayName = MOVANY.EL_PLAYER_ATTACK_GLOW}, c)
		API:AddElement({name = "PlayerAttackBackground", displayName = MOVANY.EL_PLAYER_ATTACK_BACKGROUND}, c)
		API:AddElement({name = "PlayerStatusTexture", displayName = MOVANY.EL_PLAYER_STATUS_TEXTURE}, c)
		API:AddElement({name = "PlayerStatusGlow", displayName = MOVANY.EL_PLAYER_STATUS_GLOW}, c)
		API:AddElement({name = "PlayerLeaderIcon", displayName = MOVANY.EL_PLAYER_LEADER_ICON}, c)
		API:AddElement({name = "PlayerMasterIcon", displayName = MOVANY.EL_PLAYER_MASTER_ICON}, c)
		API:AddElement({name = "PlayerBuffsMover", displayName = MOVANY.EL_PLAYER_BUFFS_MOVER}, c)
		API:AddElement({name = "PlayerBuffsMover2", displayName = MOVANY.EL_PLAYER_BUFFS_MOVER2}, c)
		--API:AddElement({name = "ConsolidatedBuffs", displayName = "Consolidated Buffs"}, c)
		--API:AddElement({name = "ConsolidatedBuffsTooltip", displayName = "Player Buffs - Consolidated Buffs Tooltip"}, c)
		API:AddElement({name = "PlayerDebuffsMover", displayName = MOVANY.EL_PLAYER_DEBUFFS_MOVER}, c)
		API:AddElement({name = "PlayerDebuffsMover2", displayName = MOVANY.EL_PLAYER_DEBUFFS_MOVER2}, c)
		API:AddElement({name = "DigsiteCompleteToastFrame", displayName = MOVANY.EL_DIGSITE_COMPLETE_TOAST_FRAME}, c)
		API:AddElement({name = "ArcheologyDigsiteProgressBar", displayName = MOVANY.EL_ARCHEOLOGY_DIGSITE_PROGRESS_BAR}, c)
		API:AddElement({name = "PlayerHitIndicator", displayName = MOVANY.EL_PLAYER_HIT_INDICATOR}, c)
		API:AddElement({name = "CastingBarFrame", displayName = MOVANY.EL_CASTING_BAR_FRAME, noAlpha = 1}, c)
		API:AddElement({name = "PlayerFrameGroupIndicator", displayName = MOVANY.EL_PLAYER_FRAME_GROUP_INDICATOR}, c)
		API:AddElement({name = "LossOfControlFrame", displayName = MOVANY.EL_LOSS_OF_CONTROL_FRAME}, c)
		pbab:AddCategory(c)
		API:AddElement({name = "SpellActivationOverlayFrame", displayName = MOVANY.EL_SPELL_ACTIVATION_OVERLAY_FRAME}, c)
		API:AddElement({name = "PlayerTalentFrame", displayName = MOVANY.EL_PLAYER_TALENT_FRAME2}, c)
		c = API:GetCategory("Unit: Target")
		API:AddElement({name = "TargetFrame", displayName = MOVANY.EL_TARGET_FRAME}, c)
		API:AddElement({name = "TargetFrameTextureFramePVPIcon", displayName = MOVANY.EL_TARGET_FRAME_TEXTURE_FRAME_PVP_ICON}, c)
		API:AddElement({name = "TargetBuffsMover", displayName = MOVANY.EL_TARGET_BUFFS_MOVER}, c)
		API:AddElement({name = "TargetDebuffsMover", displayName = MOVANY.EL_TARGET_DEBUFFS_MOVER}, c)
		--API:AddElement({name = "ComboFrame", displayName = "Target Combo Points Display"}, c)
		API:AddElement({name = "TargetFrameSpellBar", displayName = MOVANY.EL_TARGET_FRAME_SPELL_BAR, noAlpha = 1}, c)
		API:AddElement({name = "TargetFrameToT", displayName = MOVANY.EL_TARGET_FRAME_TOT}, c)
		API:AddElement({name = "TargetFrameToTDebuffsMover", displayName = MOVANY.EL_TARGET_FRAME_TOT_DEBUFFS_MOVER}, c)
		API:AddElement({name = "TargetFrameNumericalThreat", displayName = MOVANY.EL_TARGET_FRAME_NUMERICAL_THREAT}, c)
		tbab:AddCategory(c)
		c = API:GetCategory("Vehicle")
		API:AddElement({name = "OverrideActionBar", displayName = MOVANY.EL_OVERRIDE_ACTION_BAR,
			hideList = {
				{"OverrideActionBar", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				{"OverrideActionBarLeaveFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				--{"OverrideActionBarArtFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"},
				--{"OverrideActionBarButtonFrame", "ARTWORK","BACKGROUND","BORDER","OVERLAY"}
			}
		}, c)
		API:AddElement({name = "OverrideActionBarExpBar", displayName = MOVANY.EL_OVERRIDE_ACTION_BAR_EXP_BAR, onlyOnceCreated = 1}, c)
		API:AddElement({name = "OverrideActionButtonsMover", displayName = MOVANY.EL_OVERRIDE_ACTION_BUTTONS_MOVER, runOnce = function()
			OverrideActionBarButtonFrame:SetSize((OverrideActionBarButton1:GetWidth() + 2) * VEHICLE_MAX_ACTIONBUTTONS, OverrideActionBarButton1:GetHeight() + 2)
		 end}, c)
		API:AddElement({name = "OverrideActionBarHealthBar", displayName = MOVANY.EL_OVERRIDE_ACTION_BAR_HEALTH_BAR, onlyOnceCreated = 1}, c)
		API:AddElement({name = "OverrideActionBarPowerBar", displayName = MOVANY.EL_OVERRIDE_ACTION_BAR_POWER_BAR, onlyOnceCreated = 1}, c)
		API:AddElement({name = "OverrideActionBarLeaveFrame", displayName = MOVANY.EL_OVERRIDE_ACTION_BAR_LEAVE_FRAME}, c)
		--API:AddElement({name = "MicroButtonsVehicleMover", displayName = "Vehicle Micro Bar"}, c)
		API:AddElement({name = "VehicleSeatIndicator", displayName = MOVANY.EL_VEHICLE_SEAT_INDICATOR}, c)
		c = API:GetCategory("PetBattle")
		API:AddElement({name = "PetBattleMover7", displayName = MOVANY.EL_PET_BATTLE_MOVER7, noScale = 1}, c)
		API:AddElement({name = "PetBattleMover8", displayName = MOVANY.EL_PET_BATTLE_MOVER8, noScale = 1}, c)
		API:AddElement({name = "PetBattleMover9", displayName = MOVANY.EL_PET_BATTLE_MOVER9, noScale = 1}, c)
		API:AddElement({name = "PetBattleMover3", displayName = MOVANY.EL_PET_BATTLE_MOVER3},c)
		API:AddElement({name = "PetBattleMover1", displayName = MOVANY.EL_PET_BATTLE_MOVER1}, c)
		API:AddElement({name = "PetBattleMover2", displayName = MOVANY.EL_PET_BATTLE_MOVER2}, c)
		API:AddElement({name = "PetBattleMover6", displayName = MOVANY.EL_PET_BATTLE_MOVER6}, c)
		API:AddElement({name = "PetBattleMover5", displayName = MOVANY.EL_PET_BATTLE_MOVER5}, c)
		API:AddElement({name = "PetBattleMover4", displayName = MOVANY.EL_PET_BATTLE_MOVER4}, c)
		API:AddElement({name = "PetBattleMover11", displayName = MOVANY.EL_PET_BATTLE_MOVER11}, c)
		API:AddElement({name = "PetBattleMover12", displayName = MOVANY.EL_PET_BATTLE_MOVER12}, c)
		API:AddElement({name = "PetBattleMover22", displayName = MOVANY.EL_PET_BATTLE_MOVER22}, c)
		API:AddElement({name = "PetBattleMover23", displayName = MOVANY.EL_PET_BATTLE_MOVER23}, c)
		API:AddElement({name = "PetBattleMover24", displayName = MOVANY.EL_PET_BATTLE_MOVER24}, c)
		API:AddElement({name = "PetBattleMover25", displayName = MOVANY.EL_PET_BATTLE_MOVER25}, c)
		API:AddElement({name = "PetBattleMover26", displayName = MOVANY.EL_PET_BATTLE_MOVER26}, c)
		API:AddElement({name = "PetBattleMover27", displayName = MOVANY.EL_PET_BATTLE_MOVER27}, c)
		API:AddElement({name = "PetBattleMover28", displayName = MOVANY.EL_PET_BATTLE_MOVER28}, c)
		API:AddElement({name = "PetBattleMover29", displayName = MOVANY.EL_PET_BATTLE_MOVER29}, c)
		API:AddElement({name = "PetBattleMover30", displayName = MOVANY.EL_PET_BATTLE_MOVER30}, c)
		API:AddElement({name = "PetBattleMover31", displayName = MOVANY.EL_PET_BATTLE_MOVER31}, c)
		API:AddElement({name = "PetBattlePrimaryAbilityTooltip", displayName = MOVANY.EL_PET_BATTLE_PRIMARY_ABILITY_TOOLTIP}, c)
		API:AddElement({name = "PetBattlePrimaryUnitTooltip", displayName = MOVANY.EL_PET_BATTLE_PRIMARY_UNIT_TOOLTIP}, c)
		API:AddElement({name = "BattlePetTooltip", displayName = MOVANY.EL_BATTLE_PET_TOOLTIP}, c)
		API:AddElement({name = "FloatingBattlePetTooltip", displayName = MOVANY.EL_FLOATING_BATTLE_PET_TOOLTIP}, c)
		API:AddElement({name = "FloatingPetBattleAbilityTooltip", displayName = MOVANY.EL_FLOATING_PET_BATTLE_ABILITY_TOOLTIP}, c)
		API:AddElement({name = "StartSplash", displayName = MOVANY.EL_START_SPLASH}, c)
		c = API:GetCategory("Store")
		API:AddElement({name = "StorePurchaseAlertFrame", displayName = MOVANY.EL_STORE_PURCHASE_ALERT_FRAME}, c)
		API:AddElement({name = "ModelPreviewFrame", displayName = MOVANY.EL_MODEL_PREVIEW_FRAME}, c)
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
