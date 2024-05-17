local function ZFGong(event, player, item, target)
	local goober = player:GetNearestGameObject( 5, 141832)
	if (goober == nil) then
		return false;
	else
		player:SpawnCreature(7273, 1665.56, 1187.32, 11.64, 3.9, 7)
	end
end


RegisterItemEvent(9240, 2, ZFGong)