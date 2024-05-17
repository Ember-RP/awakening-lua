local function NoSummon(event, player, spell, skipCheck)
	if (player:GetInstanceId() == 0) then
		return false
	elseif (spell:GetEntry() ~= 698) then
		return false
	else
		spell:Cancel()
	end
end


RegisterPlayerEvent(5, NoSummon)