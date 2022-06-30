if GetLocale() ~= "zhTW" then
	return
end

local MOVANY = {
	ADD = "增加",
	ADDNEW = "Add new", -- Missing translation
	CLOSEGUIONESC = "Escape key closes main window", -- Missing translation
	CMD_SYNTAX_DELETE = "Syntax: /movedelete ProfileName", -- Missing translation
	CMD_SYNTAX_EXPORT = "Syntax: /moveexport ProfileName", -- Missing translation
	CMD_SYNTAX_HIDE = "Syntax: /hide ProfileName", -- Missing translation
	CMD_SYNTAX_IMPORT = "Syntax: /moveimport ProfileName", -- Missing translation
	CMD_SYNTAX_MAFE = "Syntax: /mafe frameName", -- Missing translation
	CMD_SYNTAX_UNMOVE = "Syntax: /unmove frameName", -- Missing translation
	DELETE = "刪除",
	DISABLED_DURING_COMBAT = "戰鬥中不啟用",
	DISERRORMES = "Toggles printing of error messages on/off.", -- Missing translation
	DISERRORMESNO = "Disable error messages", -- Missing translation
	DONSEARCHFRAMENAME = "Disables searching of actual frame names.", -- Missing translation
	DONTSEARCH = "Dont search frame names", -- Missing translation
	DONTSYNCINCOMBAT = "Toggles if MoveAnything will synchronize pending frames when leaving combat.\n\nDisabling this may result in protected frames requiring a manual sync when leaving combat.", -- Missing translation
	DONTSYNCINCOMBATNO = "Disable sync when leaving combat", -- Missing translation
	ELEMENT_NOT_FOUND = "UI的元件不存在",
	ELEMENT_NOT_FOUND_NAMED = "UI element not found: %s", -- Missing translation
	ERROR_FRAME_FAILED = "An error occured while syncing %s. Resetting the frame and /reload'ing before modifying it again might solve the issue. You can disable this message in the options. If the problem persists please report the following to the author: %s %s %s", -- Missing translation
	ERROR_MODULE_FAILED = "An error occured while adjusting %s for %s. You can disable this message in the options. If the problem persists please report the following to the author: %s %s %s %s", -- Missing translation
	ERROR_NOT_A_TABLE = "\"%s\" is an unsupported type", -- Missing translation
	FE_FORCED_LOCK_POSITION_CONFIRM = "強制鎖定位置？ 於5秒內點擊以確認這個動作。",
	FE_FORCED_LOCK_POSITION_TOOLTIP = "Overwrites the element's SetPoint method,\nreplacing it with an empty stub\n\nMay cause taint if the element is protected\nand the stub gets called during combat\n\nRequires a reload or relog after unchecking to\nrestore the original SetPoint method", -- Missing translation
	FE_GROUP_RESET_CONFIRM = "重設%i群組? 於5秒內點擊以確認這個動作。",
	FE_GROUPS_TOOLTIP = "%i 群組",
	FE_UNREGISTER_ALL_EVENTS_CONFIRM = "取消註冊所有事件？ 於5秒內點擊以確認這個動作。",
	FE_UNREGISTER_ALL_EVENTS_TOOLTIP = "Unregisters any events that the frame is listening to,\nrendering the frame inert\n\nRe-enabling unregistered events will require a reload\nor relog after unchecking this checkbox", -- Missing translation
	FRAME_NO_FRAME_EDITOR = "已停用 %s 之框架編輯器",
	FRAME_ONLY_ONCE_OPENED = "Can only interact with %s once it has been shown", -- Missing translation
	FRAME_ONLY_WHEN_BANK_IS_OPEN = "Can only interact with %s while the bank is open", -- Missing translation
	FRAME_ONLY_WHEN_VOIDSTORAGE_IS_OPEN = "Can only interact %s is open", -- Missing translation
	FRAME_PROTECTED_DURING_COMBAT = "無法於戰鬥中與 %s 互動",
	FRAME_UNPOSITIONED = "%s is currently unpositioned and can't be moved till it is", -- Missing translation
	FRAME_VISIBILITY_ONLY = "%s 只能被隱藏。",
	HOOKALLOWED = "Toggles if MoveAnything will hook CreateFrame.\n\nRequires reload to take effect.", -- Missing translation
	HOOKALLOWEDNO = "Disable frame creation hook", -- Missing translation
	LIST_HEADING_CATEGORY_AND_FRAMES = "類別與框架",
	LIST_HEADING_HIDE = "隱藏",
	LIST_HEADING_MOVER = "Mover", -- Missing translation
	LIST_HEADING_SEARCH_RESULTS = "搜尋結果： %i",
	NO_NAMED_FRAMES_FOUND = "No named elements found", -- Missing translation
	NOMMWP = "Toggles Minimap mousewheel zoom on/off.\n\nRequires reload to take effect.", -- Missing translation
	NOMMWPNO = "Disable Minimap mousewheel zoom", -- Missing translation
	NUDGER1 = "Show Nudger with main window", -- Missing translation
	ONLY_ONCE_CREATED = "%s can only be modified after it has been created", -- Missing translation
	OPTBAGS1 = "Toggles if MoveAnything will hook containers.\n\nThis should be checked if you use another addon to move your bags.", -- Missing translation
	OPTBAGSTOOLTIP = "Disable bag container hook", -- Missing translation
	OPTIONTOOLTIP1 = "Enable to show the nudger with the main window\n\nBy default the Nudger is only shown when interacting with frames.", -- Missing translation
	OPTIONTOOLTIP2 = "Toggles display of tooltips on/off\n\nPressing Shift when mousing over elements will reverse tooltip display behavior.", -- Missing translation
	PLAYSOUND = "Play sound", -- Missing translation
	PLAYSOUNDS = "Toggles if MoveAnything should play a sound when opening and closing the main window.", -- Missing translation
	PROFILE_ADD_TEXT = "輸入新的設定檔名稱",
	PROFILE_ALREADY_EXISTS = "設定檔 \"%s\" 已經存在。",
	PROFILE_CANT_DELETE_CURRENT_IN_COMBAT = "無法於戰鬥中刪除目前的設定檔",
	PROFILE_CANT_DELETE_DEFAULT = "The default profile can't be deleted", -- Missing translation
	PROFILE_CURRENT = "目前",
	PROFILE_DELETE_TEXT = "刪除設定檔：%s ?",
	PROFILE_DELETED = "已刪除 %s 設定檔",
	PROFILE_EXPORTED = "\"%s\" exported to \"%s\"", -- Missing translation
	PROFILE_IMPORTED = "\"%s\" has been imported into \"%s\"", -- Missing translation
	PROFILE_RENAME_TEXT = "Enter new name for \"%s\"", -- Missing translation
	PROFILE_RESET_CONFIRM = "Reset all frames in the current profile?", -- Missing translation
	PROFILE_SAVE_AS_TEXT = "Enter new profile name", -- Missing translation
	PROFILE_UNKNOWN = "Unknown profile: %s", -- Missing translation
	PROFILES = "Profiles", -- Missing translation
	PROFILES_CANT_SWITCH_DURING_COMBAT = "Profiles can't be switched during combat", -- Missing translation
	RENAME = "Rename", -- Missing translation
	RESET_ALL_CONFIRM = "MoveAnything: Reset MoveAnything to installation state?\n\nWarning: this will delete all frame settings and clear out the custom frame list.", -- Missing translation
	RESET_FRAME_CONFIRM = "Reset %s? Press again within 5 seconds to confirm", -- Missing translation
	RESETALL1 = "Reset all\n\nReset MoveAnything to default settings. Deletes all frame settings, as well as the custom frame list", -- Missing translation
	RESETPROFILE1 = "Reset profile\n\nResets the profile, deleting all stored frame settings for this profile.", -- Missing translation
	RESETTING_FRAME = "Resetting %s", -- Missing translation
	SAVE = "Save", -- Missing translation
	SAVEAS = "Save as", -- Missing translation
	SEARCH_TEXT = "Search", -- Missing translation
	SHOWTOOLTIPS = "Show tooltips", -- Missing translation
	SQUARMAP = "Toggles square MiniMap on/off.\n\nHide \"Round Border\" in the \"Minimap\" category to get rid of the overlaying border.", -- Missing translation
	SQUARMAPNO = "Enable square Minimap", -- Missing translation
	UNSERIALIZE_FRAME_INVALID_FORMAT = "Invalid format", -- Missing translation
	UNSERIALIZE_FRAME_NAME_DIFFERS = "Imported frame name differs from import target", -- Missing translation
	UNSERIALIZE_PROFILE_COMPLETED = "Imported %i element(s) into profile \"%s\"", -- Missing translation
	UNSERIALIZE_PROFILE_NO_NAME = "Unable to locate profile name", -- Missing translation
	UNSUPPORTED_FRAME = "Unsupported frame: %s", -- Missing translation
	UNSUPPORTED_TYPE = "Unsupported type: %s" -- Missing translation
}

_G.MOVANY = MOVANY
