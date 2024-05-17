local AIO = AIO or require("AIO")


local MyHandlers = AIO.AddHandlers("EnchantReRoll", {})

local ReforgeAltar = 8000051
local ReforgeAltar_menu = 45004

--gossip part
	 function enchantReRoll_CloseMenu(msg,player)

	return msg:Add("EnchantReRoll", "EnchantReRoll_Close")
end

	 function enchantReRoll_OpenMenu(msg,player)
	return msg:Add("EnchantReRoll", "EnchantReRoll_Init")
end

local function OnGossipHello_ReforgeAltar(event, player, Altar)
player:GossipClearMenu()
enchantReRoll_OpenMenu(AIO.Msg(), player):Send(player)
player:GossipSendMenu(1, Altar, ReforgeAltar_menu) 
player:GossipComplete()
end
RegisterGameObjectGossipEvent(ReforgeAltar, 1, OnGossipHello_ReforgeAltar)

 function GameobjectCheck(player)
 	local altar = nil
 	altar = player:GetNearestGameObject(10, ReforgeAltar)
 	if (altar) then
		return true
	end
	enchantReRoll_CloseMenu(AIO.Msg(), player):Send(player)
	return false
	end

local function PlayerIsFar(event, go, diff)
	for k,player in pairs(go:GetPlayersInRange(60)) do
		GameobjectCheck(player)
	end
end
 RegisterGameObjectEvent(ReforgeAltar, 1, PlayerIsFar)
--gossip part

function EnchantItemCheck(player,item)
	   if not(GameobjectCheck(player)) then
   	return false
   end
   if (item:GetClass() == 2 or item:GetClass() == 4) then
       if (item:GetQuality() >= 3) then
       	return true
       end
   end

   player:SendBroadcastMessage("This item can't be reforged")
   return false
end

function EnchantItemCost(item)
	local cost = nil
	cost = item:GetItemLevel() * 2285 -- Temporary was 2285
	return cost
end

--[[function EnchantItemTier(item, player)
	local Tier = 1
	local rlevel = item:GetItemLevel()
	local ilevel = item:GetRequiredLevel()

	if (1 <= rlevel) and (rlevel <=10) then
		Tier = 1
		elseif (11 <= rlevel) and (rlevel <=20) then
			Tier = 2
			elseif (21 <= rlevel) and (rlevel <=30) then
				Tier = 3
				elseif (31 <= rlevel) and (rlevel <=40) then
					Tier = 4
					elseif (41 <= rlevel) and (rlevel <=50) then
						Tier = 5
						elseif (51 <= rlevel) and (rlevel <=59) then
							Tier = 6
							elseif (rlevel == 60) and ( (ilevel >= 50) and (ilevel <= 55) ) then
								Tier = 7
								elseif (rlevel == 60) and ( (ilevel >= 56) and (ilevel <= 63) ) then
								Tier = 8
								elseif (rlevel == 60) and ( (ilevel >= 64) and (ilevel <= 71) ) then
								Tier = 9
								elseif (rlevel == 60) and ( (ilevel >= 72) and (ilevel <= 78) ) then
								Tier = 10
								elseif (rlevel == 60) and ( (ilevel >= 79) and (ilevel <= 83) ) then
								Tier = 11
								elseif (rlevel == 60) and  (ilevel >= 84)  then
								Tier = 12
		end
	return Tier
end]]--
--MAIN SET ITEM FUNCTION
 function MyHandlers.SetItem(player,bag,slot)
 	--AIO ADDITIONAL CHECK--
	local expectedData = {"number","number"}
	local values = {bag,slot}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
 local item = player:GetItemByPos(bag,slot)
 	if not(item) then
 		return false
 	end
	if (EnchantItemCheck(player,item)) then
	local itemlink = GetItemLink(item:GetEntry())
	local effect = nil
	local cost = EnchantItemCost(item)

	if (item:GetEnchantmentSpellId(5)) then
		effect = item:GetEnchantmentSpellId(5)
	else
		effect = 964998
	end

	enchantReRoll_PlaceItem(AIO.Msg(), player,itemlink, effect, cost,bag,slot):Send(player)
	end
end

 function enchantReRoll_PlaceItem(msg,player,item,effect,cost,bag,slot)
	return msg:Add("EnchantReRoll", "EnchantReRoll_PlaceItem", item,effect,cost,bag,slot)
end
--end

--MAIN REFORGE ITEM FUNCTION
function MyHandlers.ReforgeItem_Prep(player,bag,slot)
		--AIO ADDITIONAL CHECK--
	local expectedData = {"number","number"}
	local values = {bag,slot}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
local item = player:GetItemByPos(bag,slot)
 	if not(item) then
 		return false
 	end
	if (EnchantItemCheck(player,item)) then
		local cost = EnchantItemCost(item)

			if (cost > player:GetCoinage()) then
			player:SendBroadcastMessage("You don't have enough money to do that")
			return false
		end

			player:CastSpell(player, 964998)
	end
end

function MyHandlers.ReforgeItem(player,bag,slot)
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number","number"}
	local values = {bag,slot}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	local item = player:GetItemByPos(bag,slot)
	 	if not(item) then
 		return false
 	end
	if (EnchantItemCheck(player,item)) then

		local cost = EnchantItemCost(item)
		local enchant = nil
		--local class = item:GetClass()
		--local enchantTier = EnchantItemTier(item, player)
		--local neweffect = math.random(1,10)
		--local neweffectSQL = nil

		--[[if (class == 4) then
			class = "ANY"
			elseif (class == 2) then
				class = "WEAPON"
			end]]--

		if (cost > player:GetCoinage()) then
			player:SendBroadcastMessage("You don't have enough money to do that")
			return false
		else
			player:SetCoinage(player:GetCoinage() - cost)
		end

		--[[local enchantTierSQL = WorldDBQuery("SELECT tier FROM item_enchantment_random_tiers WHERE enchantID = "..effect..";")
		if not(enchantTierSQL) then
		player:SendBroadcastMessage("Reforge Failed")
		return false
		else
		enchantTier = enchantTierSQL:GetInt32(0)
		end]]--

		--[[if (class == "ANY") then
			neweffectSQL = WorldDBQuery("SELECT enchantID FROM item_enchantment_random_tiers WHERE tier = "..enchantTier.." AND class = '"..class.."';")
		else
			neweffectSQL = WorldDBQuery("SELECT enchantID FROM item_enchantment_random_tiers WHERE tier = "..enchantTier..";")
		end]]--
		--choosing random row from our query

		enchant = RollEnchant(item, player)
		if (enchant) then
			--[[if (neweffectSQL:GetRowCount()>1) then
		for i = 1, math.random(1, (neweffectSQL:GetRowCount()-1)) do
			neweffectSQL:NextRow()
		end
	end]]--
		--neweffect = neweffectSQL:GetInt32(0)
		item:SetEnchantment(enchant, 5) -- ATTEMPT TO FIND A REASON OF CRASHES
		enchantReRoll_Reforge(AIO.Msg(),player,item):Send(player)
	else
		player:SendBroadcastMessage("Reforge Failed")
	end
	end
end

function enchantReRoll_Reforge(msg,player,item)
	local neweffect = nil
	if (item:GetEnchantmentSpellId(5)) then
		neweffect = item:GetEnchantmentSpellId(5)
	else
		neweffect = 964998
	end
	return msg:Add("EnchantReRoll", "EnchantReRollMain_Reforge", neweffect)
end