RegisterGameObjectEvent( 170592, 1, function(event, go, diff) 
	if (diff>100) then
		diff = 0
	local player = go:GetNearestPlayer(10)
	if not(player) then
		return false
	end -- check if there is a player

	local throne = player:GetNearestGameObject(5)
	if not(throne) then
		return false
		end 
	if (throne:GetEntry() ~= go:GetEntry()) then
		return false
		end-- check if nearest gameobject is throne we need
	if not(player:GetStandState() == 5) then
		return false
	end -- check if player is sitting
	local creature = player:GetNearestCreature(533, 9019)
	if not(creature) then
		return false
	end -- check if there is a crature we need
	if not(creature:IsAlive()) then
		return false
	end -- check if it is alive and we can cast spells
	player:CastSpell( creature, 56685, true)

end
	end)