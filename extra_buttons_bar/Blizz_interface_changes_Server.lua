--fix for talent points players have and which can be used in standart interface and then exploited
local function RemoveTalentPoints(event,player)
    if (player:GetFreeTalentPoints()) then
        player:SetFreeTalentPoints(0)
    end
end

RegisterPlayerEvent(3, RemoveTalentPoints)

--ressurect and tele to city
local AIO = AIO or require("AIO")


local MyHandlers = AIO.AddHandlers("DeathRessurect", {})

 function MyHandlers.Ressurect(player)
 	if player:HasAura(8326) and (player:GetLevel() >= 10) then
 		if (player:InBattleground()) then
 			return false
 		end
 		player:ResurrectPlayer(20, true)
 		player:DurabilityLossAll(100, true)
 		if player:IsAlliance() then
 			player:Teleport(0, -8525.72, 851.9157, 106.51, 3.8)
 		else
 			player:Teleport(1, 1451, -4181, 61.6, 1.05)
 		end
 	end
end

 function GetGoldForMoney(cost)
    local c_gold,c_silver,c_copper = 0
            c_gold = math.floor(math.abs(cost / 10000))
            c_silver = math.floor(math.abs(math.fmod(cost / 100, 100)))
            c_copper = math.floor(math.abs(math.fmod(cost, 100)))
            return c_gold,c_silver,c_copper
end