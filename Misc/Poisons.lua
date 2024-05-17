local function PoisonMaxSkill(event, player)
	local x = player:GetSkillValue(40)
	local level = player:GetLevel()
	local mult = (level * 5)
	if player:HasSpell(2842) then
		player:SetSkill(40, 0, x, mult)
	end
end

RegisterPlayerEvent( 3, PoisonMaxSkill)
RegisterPlayerEvent( 13, PoisonMaxSkill)