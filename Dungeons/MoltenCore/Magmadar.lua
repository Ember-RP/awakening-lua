--[[local BossEntry_Magmadar = 11982
local GameObject_LavaBomb1 = 177704
local Spell_LavaBomb1 = 19411
local Spell_LavaBomb2 = 20474

local function LavaBombSpawn(event, creature, target, spellid)
	if (spellid == Spell_LavaBomb1) or (spellid == Spell_LavaBomb2) then
		PerformIngameSpawn( 2, GameObject_LavaBomb1, target:GetMapId(), target:GetInstanceId(), target:GetX(), target:GetY(), target:GetZ(), target:GetO(), 0, 1800, target:GetPhaseMask())
	end
end

RegisterCreatureEvent(BossEntry_Magmadar, 15, LavaBombSpawn)]]--
