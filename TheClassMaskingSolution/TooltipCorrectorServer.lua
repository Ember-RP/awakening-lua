-- the lua script for grabbing if the player has a certain spellid learned.

local AIO = AIO or require ("AIO")

local tTHandler = AIO.AddHandlers ("TooltipAIO", {})

function tTHandler.HasSpellID(player, spellid)
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number"}
	local values = {spellid}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	local y = player:HasSpell(spellid)
	AIO.Handle(player, "TooltipAIO", "ReceiveIDCheck", y)
	
end

function tTHandler.CostGrabber(player, spellid)
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number"}
	local values = {spellid}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	local y = player:GetSpellCost(spellid)
	local x = player:GetSpellCooldown(spellid)
	local z = player:GetSpellRange(spellid)
	local w = player:GetSpellPowerType(spellid)
	local v = player:GetSpellCastTime(spellid)

	AIO.Handle(player, "TooltipAIO", "ReceiveCostGrab", y, w)
	AIO.Handle(player, "TooltipAIO", "ReceiveCDGrab", x)
	AIO.Handle(player, "TooltipAIO", "ReceiveRangeGrab", z)
	AIO.Handle(player, "TooltipAIO", "ReceiveCastTime", v)
	AIO.Handle(player, "TooltipAIO", "UpdateTooltips")
end

function tTHandler.SendRefresh(event, player, spellid)
	AIO.Handle(player, "TooltipAIO", "RefreshTable")
end

function tTHandler.SpellCostGrabber(player,spellid)
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number"}
	local values = {spellid}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--

	local Cost = player:GetSpellCost(spellid)
	local Type = player:GetSpellPowerType(spellid)
	local Range = player:GetSpellRange(spellid)
	
AIO.Handle(player, "TooltipAIO", "GetSpellCost", Cost,Type,Range,spellid)
end

RegisterPlayerEvent(45, tTHandler.SendRefresh)

