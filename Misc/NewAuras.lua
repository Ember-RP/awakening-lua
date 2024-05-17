local function NewAuras1(event, player)
	player:AddAura(974994, player)
	player:AddAura(974995, player)
	player:AddAura(974996, player)
	player:AddAura(974997, player)
	player:AddAura(974998, player)
	player:AddAura(974999, player)
end

RegisterPlayerEvent( 3, NewAuras1 )