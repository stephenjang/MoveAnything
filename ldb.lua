local addonName, addon = ...

local ldb = LibStub:GetLibrary("LibDataBroker-1.1", true)
if not ldb then return end

local plugin = ldb:NewDataObject(addonName, {
	type = "data source",
	text = "MoveAnything",
	icon = "Interface\\Icons\\inv_misc_magnet",
})

function plugin.OnClick(self, button)
	if button == "RightButton" then
		InterfaceOptionsFrame_OpenToCategory(addonName)
		InterfaceOptionsFrame_OpenToCategory(addonName)
	else
		if IsShiftKeyDown() then
			ReloadUI()
		elseif MAOptions and MAOptions:IsShown() then
			MADB.autoShowNext = nil
			MAOptions:Hide()
		else
			ShowUIPanel(MAOptions)
		end
	end
end

function plugin.OnTooltipShow(tooltip)
	if not tooltip or not tooltip.AddLine then
		return
	end
	tooltip:AddLine(addonName)
	if MAOptions:IsShown() then
		GameTooltip_AddInstructionLine(tooltip, MOVANY.LDB_TOOLTIP_LEFT_CLICK_CLOSE)
	else
		GameTooltip_AddInstructionLine(tooltip, MOVANY.LDB_TOOLTIP_LEFT_CLICK_OPEN)
	end
	GameTooltip_AddInstructionLine(tooltip, MOVANY.LDB_TOOLTIP_SHIFT_CLICK)
	GameTooltip_AddInstructionLine(tooltip, MOVANY.LDB_TOOLTIP_RIGHT_CLICK)
end

