local function MaraStaff(event, player, item, target)
	local goober = player:GetNearestGameObject( 0.1, 178386)
	if (goober ~= nil) then
	player:CastSpell(player, 21127, true)
	end
end

RegisterItemEvent(17191, 2, MaraStaff)