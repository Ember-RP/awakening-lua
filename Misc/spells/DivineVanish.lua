local function DivineDebuff(event, player, spell, skipCheck)
	if (spell:GetEntry() >= 1856) and (spell:GetEntry() <= 1857) then
		player:RemoveAura(642)
	end
end

RegisterPlayerEvent(5, DivineDebuff)