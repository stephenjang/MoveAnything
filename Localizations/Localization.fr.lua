if GetLocale() ~= "frFR" then
	return
end

local MOVANY = {
	ADD = "Ajout",
	ADDNEW = "Nouvel ajout",
	BINDING_NAME_EDIT_FRAME_EXACT = "Edit frame - Exact", -- Missing translation
	BINDING_NAME_EDIT_FRAME_SAFE = "Edit frame - Safe", -- Missing translation
	BINDING_NAME_HIDE_FRAME_EXACT = "Hide frame - Exact", -- Missing translation
	BINDING_NAME_HIDE_FRAME_SAFE = "Hide frame - Safe", -- Missing translation
	BINDING_NAME_MOVE_FRAME_EXACT = "Move frame - Exact", -- Missing translation
	BINDING_NAME_MOVE_FRAME_SAFE = "Move frame - Safe", -- Missing translation
	BINDING_NAME_RESET_FRAME_EXACT = "Reset frame - Exact", -- Missing translation
	BINDING_NAME_RESET_FRAME_SAFE = "Reset frame - Safe", -- Missing translation
	BINDING_NAME_SHOW_FRAME_INFO = "Show frame info", -- Missing translation
	BINDING_NAME_SYNCHRONIZE_ALL_ELEMENTS = "Synchronize all elements", -- Missing translation
	BINDING_NAME_TOGGLE_MA_WINDOW = "Toggle MA window", -- Missing translation
	CLOSEGUIONESC = "Touche Echap. ferme la fenêtre principale",
	CMD_SYNTAX_DELETE = "Syntaxe: /movedelete NomDuProfil",
	CMD_SYNTAX_EXPORT = "Syntaxe: /moveexport NomDuProfil",
	CMD_SYNTAX_HIDE = "Syntaxe: /hide NomDuProfil",
	CMD_SYNTAX_IMPORT = "Syntaxe: /moveimport NomDuProfil",
	CMD_SYNTAX_MAFE = "Syntaxe: /mafe NomDuCadre",
	CMD_SYNTAX_UNMOVE = "Syntaxe: /unmove NomDuCadre",
	DELETE = "Suppression",
	DISABLED_DURING_COMBAT = "Désactivé durant un combat",
	DISERRORMES = "Bascule l'impression des messages d'erreur on/off.",
	DISERRORMESNO = "Désactiver les messages d'erreur",
	DONSEARCHFRAMENAME = "Désactive la recherche de noms de cadre actuel.",
	DONTSEARCH = "Ne pas rechercher les noms de cadres",
	DONTSYNCINCOMBAT = "Bascule si MoveAnything peut synchroniser les cadres en attente au moment de quitter le combat.\n\nCette désactivation pour les cadres protégés nécessitera une synchronisation manuelle au moment de quitter le combat.",
	DONTSYNCINCOMBATNO = "Désactiver la synchronisation au moment de quitter le combat.",
	ELEMENT_NOT_FOUND = "Elément de l'interface introuvable",
	ELEMENT_NOT_FOUND_NAMED = "Elément UI introuvable : %s",
	ERROR_FRAME_FAILED = "Une erreur s'est produite lors de la synchronisation de %s. Réinitialisation du cadre et \"/reload'ing\" avant de le modifier à nouveau pourrait résoudre le problème. Vous pouvez désactiver ce message dans les options. Si le problème persiste, signalez ce qui suit à l'auteur : %s %s %s",
	ERROR_MODULE_FAILED = "Une erreur s'est produite durant l'ajustement %s pour %s. Vous pouvez désactiver ce message dans les options. Si le problème persiste, signalez ce qui suit à l'auteur : %s %s %s %s",
	ERROR_NOT_A_TABLE = "\"%s\" n'est pas un type pris en charge",
	FE_FORCED_LOCK_POSITION_CONFIRM = "Verrouillage forcé de la position ? Cliquez à nouveau dans les 5 secondes pour confirmer",
	FE_FORCED_LOCK_POSITION_TOOLTIP = "Remplace la méthode de l'élément SetPoint,\nremplacez-le par un morceau vide\n\nPeut causer une corruption si l'élément est protégé\net le morceau est appelé pendant le combat\n\nNécessite un rechargement ou une reconnexion après la\ndésactivation de restauration de la méthode originale SetPoint",
	FE_GROUP_RESET_CONFIRM = "Réinitialiser le groupe %i ? Cliquez à nouveau dans les 5 secondes pour confirmer",
	FE_GROUPS_TOOLTIP = "Groupe %i",
	FE_UNREGISTER_ALL_EVENTS_CONFIRM = "Annuler l'inscription de tous les événements ? Cliquez à nouveau dans les 5 secondes pour confirmer",
	FE_UNREGISTER_ALL_EVENTS_TOOLTIP = "Annule l'inscription de tous les événements, dont\nle cadre est à l'écoute, rendra le cadre inactif\n\nAprès une réactivation des événements non enregistrés et après\navoir décoché cette case, il faudra un rechargement ou une reconnexion",
	FRAME_NO_FRAME_EDITOR = "L'éditeur de cadre est désactivé pour %s",
	FRAME_ONLY_ONCE_OPENED = "Peut seulement interagir avec %s quand il aura été affiché",
	FRAME_ONLY_WHEN_BANK_IS_OPEN = "Peut uniquement intéragir avec %s tant que la banque est affichée",
	FRAME_ONLY_WHEN_VOIDSTORAGE_IS_OPEN = "Peut interagir avec %s si affiché",
	FRAME_PROTECTED_DURING_COMBAT = "Ne peut interagir avec %s durant un combat",
	FRAME_UNPOSITIONED = "%s n'est actuellement pas positionné et ne peut être déplacé jusqu'à ce qu'il soit positionné",
	FRAME_VISIBILITY_ONLY = "%s peut uniquement être masqué",
	HOOKALLOWED = "Bascule MoveAnything si vous accrochez CreateFrame.\n\nRequiert un rechargement pour prendre effet.",
	HOOKALLOWEDNO = "Désactiver le crochet de création du cadre",
	LIST_HEADING_CATEGORY_AND_FRAMES = "Catégories et Trames",
	LIST_HEADING_HIDE = "Masquage",
	LIST_HEADING_MOVER = "Déplacement",
	LIST_HEADING_SEARCH_RESULTS = "Résultats de la recherche : %i",
	MA_OPT_ALWAYS_SHOW_NUDGER = "Show Nudger with main window", -- Missing translation
	MA_OPT_ALWAYS_SHOW_NUDGER_TOOLTIP = "Enable to show the nudger with the main window\n\nBy default the Nudger is only shown when interacting with frames.", -- Missing translation
	MA_OPT_CLOSE_GUI_ON_ESCAPE = "Escape key closes main window", -- Missing translation
	MA_OPT_DISABLE_ERROR_MESSAGES = "Disable error messages", -- Missing translation
	MA_OPT_DISABLE_ERROR_MESSAGES_TOOLTIP = "Toggles printing of error messages on/off.", -- Missing translation
	MA_OPT_DONT_HOOK_CREATE_FRAME = "Disable frame creation hook", -- Missing translation
	MA_OPT_DONT_HOOK_CREATE_FRAME_TOOLTIP = "Toggles if MoveAnything will hook CreateFrame.\n\nRequires reload to take effect.", -- Missing translation
	MA_OPT_DONT_SEARCH_FRAME_NAMES = "Don't search frame names", -- Missing translation
	MA_OPT_DONT_SEARCH_FRAME_NAMES_TOOLTIP = "Disables searching of actual frame names.", -- Missing translation
	MA_OPT_DONT_SYNC_WHEN_LEAVING_COMBAT = "Disable sync when leaving combat", -- Missing translation
	MA_OPT_DONT_SYNC_WHEN_LEAVING_COMBAT_TOOLTIP = "Toggles if MoveAnything will synchronize pending frames when leaving combat.\n\nDisabling this may result in protected frames requiring a manual sync when leaving combat.", -- Missing translation
	MA_OPT_EXPORT_PROFILE = "Export Profile", -- Missing translation
	MA_OPT_FRAME_LIST_ROWS = "List rows", -- Missing translation
	MA_OPT_IMPORT_PROFILE = "Import Profile", -- Missing translation
	MA_OPT_NO_BAGS = "Disable bag container hook", -- Missing translation
	MA_OPT_NO_BAGS_TOOLTIP = "Toggles if MoveAnything will hook containers.\n\nThis should be checked if you use another addon to move your bags.", -- Missing translation
	MA_OPT_NO_MMMW = "Disable Minimap mousewheel zoom", -- Missing translation
	MA_OPT_NO_MMMW_TOOLTIP = "Toggles Minimap mousewheel zoom on/off.\n\nRequires reload to take effect.", -- Missing translation
	MA_OPT_PLAY_SOUND = "Play sound", -- Missing translation
	MA_OPT_PLAY_SOUND_TOOLTIP = "Toggles if MoveAnything should play a sound when opening and closing the main window.", -- Missing translation
	MA_OPT_PROFILE = "Profile", -- Missing translation
	MA_OPT_PROFILE_ADD_TOOLTIP = "Add new", -- Missing translation
	MA_OPT_PROFILE_DELETE_TOOLTIP = "Delete", -- Missing translation
	MA_OPT_PROFILE_EXPORT = "Export", -- Missing translation
	MA_OPT_PROFILE_EXPORT_IMPORT_LABEL = "%s Profile", -- Missing translation
	MA_OPT_PROFILE_FROM = "From", -- Missing translation
	MA_OPT_PROFILE_IMPORT = "Import", -- Missing translation
	MA_OPT_PROFILE_NO_PROFILES = "No profiles available", -- Missing translation
	MA_OPT_PROFILE_PROFILE_NOT_MODIFIED = "No profile has modified this frame", -- Missing translation
	MA_OPT_PROFILE_PROFILE_NOT_MODIFIED_PLURAL = "No profiles has modified this frame", -- Missing translation
	MA_OPT_PROFILE_RENAME_TOOLTIP = "Rename", -- Missing translation
	MA_OPT_PROFILE_SAVE_AS_TOOLTIP = "Save as", -- Missing translation
	MA_OPT_PROFILE_TO = "To", -- Missing translation
	MA_OPT_RESET_ALL = "Reset All", -- Missing translation
	MA_OPT_RESET_ALL_TOOLTIP = "Reset all\n\nReset MoveAnything to default settings. Deletes all frame settings, as well as the custom frame list", -- Missing translation
	MA_OPT_RESET_PROFILE_TOOLTIP = "Reset profile\n\nResets the profile, deleting all stored frame settings for this profile.", -- Missing translation
	MA_OPT_ROWS_SLIDER = "# of rows", -- Missing translation
	MA_OPT_SHOW_TOOLTIPS = "Show tooltips", -- Missing translation
	MA_OPT_SHOW_TOOLTIPS_TOOLTIP = "Toggles display of tooltips on/off\n\nPressing Shift when mousing over elements will reverse tooltip display behavior.", -- Missing translation
	MA_OPT_SQUARE_MM = "Enable square Minimap", -- Missing translation
	MA_OPT_SQUARE_MM_TOOLTIP = "Toggles square MiniMap on/off.\n\nHide \"Round Border\" in the \"Minimap\" category to get rid of the overlaying border.", -- Missing translation
	MA_OPT_TEXT_STRING = "Text String", -- Missing translation
	MA_OPT_VERSION = "Version", -- Missing translation
	NO_NAMED_FRAMES_FOUND = "Aucun élément nommé trouvé",
	NOMMWP = "Bascule la molette de zoom de la minicarte en on/off.\n\nRequiert un rechargement pour prendre effet.",
	NOMMWPNO = "Désactiver la molette de zoom de la minicarte",
	NUDGER1 = "Afficher le Pousseur avec la fenêtre principale",
	ONLY_ONCE_CREATED = "%s peut être modifié uniquement après avoir été créé",
	OPTBAGS1 = "Bascule si MoveAnything peut accrocher des conteneurs.\n\nDoit être coché si vous utilisez un autre addon pour déplacer vos sacs.",
	OPTBAGSTOOLTIP = "Désactiver le crochet du contenant du sac.",
	OPTIONTOOLTIP1 = "Activer pour afficher le Pousseur avec la fenêtre principale\n\nPar défaut, le Pousseur est affiché uniquement lors de l'interaction avec les cadres.",
	OPTIONTOOLTIP2 = "Bascule l'affichage des info-bulles on/off\n\nAppuyant sur Maj. au survol des éléments inversera le comportement d'affichage de l'info-bulle.",
	PLAYSOUND = "Provoque un son",
	PLAYSOUNDS = "Bascule si MoveAnything devraient jouer un son lors de l'ouverture et de la fermeture de la fenêtre principale.",
	PROFILE_ADD_TEXT = "Entrer un nouveau nom de profil",
	PROFILE_ALREADY_EXISTS = "Le profil \"%s\" existe déjà",
	PROFILE_CANT_DELETE_CURRENT_IN_COMBAT = "Impossible de supprimer le profil actuel durant un combat",
	PROFILE_CANT_DELETE_DEFAULT = "Le profil par défaut ne peut être supprimé",
	PROFILE_CURRENT = "Actuel",
	PROFILE_DELETE_TEXT = "Supprimer le profil \"%s\"?",
	PROFILE_DELETED = "Profil supprimé: %s",
	PROFILE_EXPORTED = "\"%s\" exporté en \"%s\"",
	PROFILE_IMPORTED = "\"%s\" a été importé en \"%s\"",
	PROFILE_RENAME_TEXT = "Entrer un nouveau nom pour \"%s\"",
	PROFILE_RESET_CONFIRM = "MoveAnything: Réinitialiser tous les cadres dans le profil actuel ?",
	PROFILE_SAVE_AS_TEXT = "Entrer un nouveau nom de profil",
	PROFILE_UNKNOWN = "Profil inconnu: %s",
	PROFILES = "Profils",
	PROFILES_CANT_SWITCH_DURING_COMBAT = "Les profils ne peuvent pas être interchangés durant un combat",
	RENAME = "Renommer",
	RESET_ALL_CONFIRM = "MoveAnything: Revenir à l'état initial d'installation de MoveAnything?\n\nAttention: cela supprimera tous les réglages de cadres et effacera la liste des cadres personnalisés.",
	RESET_FRAME_CONFIRM = "Réinitialiser %s ? Appuyer à nouveau dans les 5 secondes pour confirmer",
	RESETALL1 = "Tous réinitialiser\n\nRéinitialiser les paramètres par défaut MoveAnything. Supprime tous les réglages de cadres, ainsi que la liste des cadres personnalisés.",
	RESETPROFILE1 = "Réinitialiser le profil\n\nRéinitialise le profil, en supprimant tous les réglages de cadres stockés pour ce profil.",
	RESETTING_FRAME = "Remise à zéro %s",
	SAVE = "Enregistrer",
	SAVEAS = "Enregistrer sous",
	SEARCH_TEXT = "Rechercher",
	SHOWTOOLTIPS = "Afficher info-bulle",
	SQUARMAP = "Bascule le carré de la minicarte on/off.\n\nMasque le \"Bord arrondi\" dans la catégorie \"minicarte\" pour se défaire du bord qui recouvre.",
	SQUARMAPNO = "Activer la minicarte carrée",
	UNSERIALIZE_FRAME_INVALID_FORMAT = "Format non valide",
	UNSERIALIZE_FRAME_NAME_DIFFERS = "Nom du cadre importés diffère de la cible d'importation",
	UNSERIALIZE_PROFILE_COMPLETED = "Importé %i élément(s) dans le profil \"%s\"",
	UNSERIALIZE_PROFILE_NO_NAME = "Impossible de localiser le nom du profil",
	UNSUPPORTED_FRAME = "Cadre non supporté: %s",
	UNSUPPORTED_TYPE = "Type non supporté: %s"
}

_G.MOVANY = MOVANY
