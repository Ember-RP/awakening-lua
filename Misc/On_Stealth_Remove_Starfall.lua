local stealth = {1784, 58984, 66}
local starfall = {48505, 53199, 53200, 53201, 75}

local function OnStealth(event, player, spell, skipCheck)
	for _, t in pairs(stealth) do
		for k, v in pairs(starfall) do
			if (player:HasAura(t) and player:HasAura(v)) then
				--print("Test 1")
				player:RemoveAura(v)
				--print("test 2")
			end
		end
	end
end
RegisterPlayerEvent(5, OnStealth)