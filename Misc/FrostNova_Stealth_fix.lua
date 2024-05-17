-- Radius 10x10

local stealth = {1784, 58984, 66}
local frost = 122

local function OnNova(event, player, spell, skipCheck)
	if (spell:GetEntry() == frost) then
	local target = player:GetPlayersInRange(10, 1)
	--print("test 1")
		for _, t in pairs(target) do
			for k, v in pairs(stealth) do
			if(t:HasAura(v)) then
			--print("test 2")
				t:RemoveAura(v)
				--t:AddAura(122)
			--print("test 3")
			end
		end
	end
end
end

RegisterPlayerEvent(5, OnNova)