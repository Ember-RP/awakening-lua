local sprint = 818012

local function OnMapChange(event, player)
	if player:HasAura(sprint) then
		player:RemoveAura(sprint)
	end
end
RegisterPlayerEvent(28, OnMapChange)