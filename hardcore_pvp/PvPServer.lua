
local AIO = AIO or require("AIO")


local MyHandlers = AIO.AddHandlers("PvP", {})

--local guid_linking_table = {}
item_table = {}
local prohibited_items = {
6948,
597600,
597601,
977020,
977021,
5863,
22115,
22048,
21984,
22047,
22046,
800096,
98457,
977025,
23720,
69228,
38576,
54811,
33225,
977019,
777998,
}
local dropmodifier = 5
local item_looted = {}
--local playerdeath = true
--local creaturedeath = true
--local leveldiff = 6

-- this function is never called for some unknown reason, known bug with ElunaCore
--[[function Remove_FullLootContainer(event, delay, call, object)
	print("I got here!")
	print("I got here!")
	local nearbyplayers = object:GetPlayersInRange(100)
	for k, v in pairs(nearbyplayers) do
		v:SendBroadcastMessage("|CFFFF8040The sack of items turns to dust, and blows away with the wind.|r")
	end
	object:Despawn()
	object:RemoveFromWorld(false)
	FullLootFrame:Hide()
    guid_linking_table[object:GetGUIDLow()] = nil
	item_table[object:GetGUIDLow()] = nil
	print("Chest removed from world")
end]]--
local SafeCostModifier = 3540
function SafeSlotGetLostCost(item)
	local cost = nil
	cost = item:GetItemLevel() * SafeCostModifier -- Temporary was 2285
	return cost
end

local function PVP_ItemCheck(item, target)
					for k,v in pairs(prohibited_items) do
						if (item:GetEntry() == v) then
							return false
						end
					end -- check for special item ids
		  			if (target:HasQuestForItem(item:GetEntry()) or (item:IsBag()==true)) then
		   			 return false
					end -- check for bags and quest items

					local mv = WorldDBQuery("SELECT bonding FROM item_template WHERE entry = "..item:GetEntry().."")
					if (mv:GetInt32(0) >= 4) then
						return false
					end

					return true
end

local function EntropyPvP(event, pKiller, pKilled)
	--PLAYER_EVENT_ON_KILLED_BY_CREATURE
	if pKiller:ToCreature() then
		if not(pKiller:GetOwner()) then
			return false
		end

		if not(pKiller:GetOwner():ToPlayer()) then
			return false
		end

		pKiller = pKiller:GetOwner():ToPlayer()
	end
	--PLAYER_EVENT_ON_KILLED_BY_CREATURE
	math.random(1,10)
	local check_safe = false
	local pKiller_loc = pKiller:GetMapId()
	local pKiller_zone = pKiller:GetZoneId()
	local items_droplist = {}
	local spawnType = 2
	local instanceID = pKiller:GetInstanceId()
	local DropGold = 0
	for i,v in ipairs(safety_ids) do
		if v == pKiller_loc then
			check_safe = true
			break
		end
	end
	for k,z in ipairs(nocapzones) do
		if z == pKiller_zone then
			setcap = true
		else
			setcap = false
		end
	end
	if setcap == true then
		leveldiff = 255
	else
		leveldiff = 5
	end --some checks for safe zones and other stuff
	if not (pKilled == pKiller) then -- if player commited suicide, no drop
		-- check for honorless target
		if pKilled:HasAura(2479) == false then
			if (check_safe == false and instanceID == 0) then -- begin main action

				if (((pKiller:GetLevel()-pKilled:GetLevel())<=leveldiff) and ((pKiller:GetLevel()-pKilled:GetLevel())>=(leveldiff * -1))) then -- level difference check	
					local pKilledGUID = pKilled:GetGUIDLow()
					local pKillerGUID = pKiller:GetGUIDLow()
					local x,y,z,o = pKilled:GetX(),pKilled:GetY(),pKilled:GetZ(),pKilled:GetO()
					local ContainerID = 818001
					local FullLootContainer = PerformIngameSpawn(spawnType,ContainerID,pKiller_loc,instanceID, x, y, z, o)	--Spawn a Sack of Belongings
					item_table[FullLootContainer:GetGUIDLow()] = {}
					-- my updated part
					local amountofdroppeditems = math.ceil(pKilled:GetLevel()/dropmodifier)
						if (amountofdroppeditems >= 1) then
							--list of items player have
							for i = 1, 8 do
							math.random(1,10)
							slot = math.random(0,38)
								if (pKilled:GetItemByPos(255, slot)) then
									if not(pKilled:HasQuestForItem(pKilled:GetItemByPos(255, slot):GetEntry())) and not(pKilled:GetItemByPos(255, slot):IsBag()==true) then
									table.insert(items_droplist, {255,slot})
									end
								end
							end
							for slot = 0,35 do
								for bag = 19,22 do
								if (pKilled:GetItemByPos(bag, slot)) then
									if not(pKilled:HasQuestForItem(pKilled:GetItemByPos(bag, slot):GetEntry())) and not(pKilled:GetItemByPos(bag, slot):IsBag()==true) then
									table.insert(items_droplist, {bag,slot})
									end
								end
							end
							end
							-- list is done
							if (items_droplist[1]) then
							for i = 1, amountofdroppeditems do
								math.random(1,10)
							local itemslot_temp = math.random(1,#items_droplist)
							local item = pKilled:GetItemByPos(items_droplist[itemslot_temp][1],items_droplist[itemslot_temp][2])
								if (item) then
								local itemcount = math.random(1,item:GetCount())
									if (PVP_ItemCheck(item,pKilled)) then
									-- Get Money for item part--

											--SQL CHECK IF ITEM IS "SAFE"
											local SafeSQL = nil
											if ((items_droplist[itemslot_temp][2]<19) and (items_droplist[itemslot_temp][1] == 255)) then
												SafeSQL = CharDBQuery("SELECT slot"..items_droplist[itemslot_temp][2].." FROM custom_iteminsurance WHERE playerguid = "..pKilled:GetGUIDLow()..";")
											end
											local DropSafeCost = SafeSlotGetLostCost(item)
											if (SafeSQL and (SafeSQL:GetInt32(0) == 1) and (pKilled:GetCoinage() >= DropSafeCost)) then
												pKilled:ModifyMoney(-DropSafeCost)
												pKiller:ModifyMoney(DropSafeCost)
												DropGold = DropGold + DropSafeCost
											else
											if (item:GetClass() == 2 or item:GetClass() == 4) then
											if (item:GetEnchantmentId(5) == 0 or item:GetEnchantmentId(5) == nil) then
											table.insert (item_table[FullLootContainer:GetGUIDLow()], {item:GetItemLink(), item:GetEntry(), itemcount, pKilled:GetName()})
											else
											table.insert (item_table[FullLootContainer:GetGUIDLow()], {item:GetItemLink(), item:GetEntry(), itemcount, pKilled:GetName(), item:GetEnchantmentId(5)})
											end
											else
											table.insert (item_table[FullLootContainer:GetGUIDLow()], {item:GetItemLink(), item:GetEntry(), itemcount, pKilled:GetName()})
											end
											pKilled:RemoveItem(item:GetEntry(), itemcount)
										end

									else
									amountofdroppeditems = amountofdroppeditems+1
									end
								end
							end
						end
					end
					
					if not(item_table[FullLootContainer:GetGUIDLow()][1]) then
							FullLootContainer:Despawn()
							FullLootContainer:RemoveFromWorld(true)
					end
				end -- end of lvl diff check

			end -- end of main action
		end -- end of aura check
		else
			pKilled:SendBroadcastMessage("You have commited suicide, none of your items were lost")
		end -- end of suicide check

		if (DropGold > 0) then
			local gold,silver,copper = GetGoldForMoney(DropGold)
			pKiller:SendBroadcastMessage("You recieved |cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r from killing this player")
			pKilled:SendBroadcastMessage("You lost |cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r but saved your items by Fel Commutation")
		end
end

--[[local function CreatureDeath (event, pKiller, pKilled)
	local check_safe = false
	local pKilled_loc = pKilled:GetMapId()
	local spawnType = 2
	local instanceID = pKilled:GetInstanceId()
	for i,v in ipairs(safety_ids) do
		if v == pKilled_loc then
			check_safe = true
			break
		end
	end
	if (pKiller:GetOwner() == nil or pKiller:GetOwner() == 0) then
		 petkill = false
		 --print("No Owner")
	else
		local plrs = pKiller:GetPlayersInRange(20)
		for h,p in pairs(plrs) do
			if p == pKiller:GetOwner() then
				petkill = true
				print("Has owner")
			end
		end
	end
	if petkill == false then
		npcleveldiff = 255
	else
		npcleveldiff = 6
	end
	if (creaturedeath==true and check_safe == false and instanceID == 0 and ((pKiller:GetLevel()-pKilled:GetLevel())<=npcleveldiff))then
		local pKilledGUID = pKilled:GetGUIDLow()
		local x,y,z,o = pKilled:GetX(),pKilled:GetY(),pKilled:GetZ(),pKilled:GetO()
		local ContainerID = 818001
		local kill_message = math.random(1,6)
		local FullLootContainer = PerformIngameSpawn(spawnType,ContainerID,pKilled_loc,instanceID, x, y, z, o, false, 10)	--Spawn a Sack of Belongings
		guid_linking_table[FullLootContainer:GetGUIDLow()] = pKilled:GetGUIDLow()
		--Get Items
		local bagslot = 255
		local inven_ticker = 0
		local item_ticker = 0
		local maxitems = 25 --Equal to amount of buttons that I have declared.
		item_table[FullLootContainer:GetGUIDLow()] = {}
		remove_table[FullLootContainer:GetGUIDLow()] = {}
	repeat
		local SlotRange = 35
		inven_ticker = inven_ticker+1
		local bagToTake = math.random(3)
		if bagToTake < 3 then
			SlotRange = 38
			bagToTake = 255
		else
			bagToTake = math.random(4)
			if petkill == true then
				bagToTake = bagToTake + 6
			else
				bagToTake = bagToTake + 6
			end
		end
			local slotToTake = math.random(SlotRange)
					
			local checkitem = pKilled:GetItemByPos(bagToTake, slotToTake)
			if not(checkitem) then
				return false
			end
			safe_to_take = true
			if petkill == false then
				if checkitem:GetClass() == 12 then
				
					safe_to_take = false
					
				elseif checkitem:GetClass() == 0 then
				
					if checkitem:GetDisplayId() == 34802 then
					
						safe_to_take = false
						
					end
					
				end
			end	
			if petkill == false then
				if (checkitem~=nil) and (checkitem:IsBag()==false) and (checkitem:GetEntry()~=6948) and safe_to_take == true then
					item_ticker = item_ticker+1
					if (checkitem:GetClass() == 2 or checkitem:GetClass() == 4) then
						if (checkitem:GetEnchantmentId(5) == 0 or checkitem:GetEnchantmentId(5) == nil) then
							table.insert (item_table[FullLootContainer:GetGUIDLow()], {checkitem:GetItemLink(), checkitem:GetEntry(), pKilled:GetItemCount(checkitem:GetEntry()), pKilled:GetName()})
						else
							table.insert (item_table[FullLootContainer:GetGUIDLow()], {checkitem:GetItemLink(), checkitem:GetEntry(), pKilled:GetItemCount(checkitem:GetEntry()), pKilled:GetName(), checkitem:GetEnchantmentId(5)})
						end
					end
					table.insert (remove_table[FullLootContainer:GetGUIDLow()], {item_ticker, false})
					pKilled:RemoveItem(checkitem:GetEntry(), pKilled:GetItemCount(checkitem:GetEntry()))
				end
			else
				if (checkitem ~= 0) then -- Checks to make sure player has an item
					if (checkitem~=nil) and (checkitem:IsBag()==false) and (checkitem:GetEntry()~=6948) then
						item_ticker = item_ticker+1
						if (checkitem:GetClass() == 2 or checkitem:GetClass() == 4) then
							if (checkitem:GetEnchantmentId(5) == 0 or checkitem:GetEnchantmentId(5) == nil) then
								table.insert (item_table[FullLootContainer:GetGUIDLow()], {checkitem:GetItemLink(), checkitem:GetEntry(), pKilled:GetItemCount(checkitem:GetEntry()), pKilled:GetName()})
							else
								table.insert (item_table[FullLootContainer:GetGUIDLow()], {checkitem:GetItemLink(), checkitem:GetEntry(), pKilled:GetItemCount(checkitem:GetEntry()), pKilled:GetName(), checkitem:GetEnchantmentId(5)})
							end
						end
						table.insert (remove_table[FullLootContainer:GetGUIDLow()], {item_ticker, false})
						pKilled:RemoveItem(checkitem:GetEntry(), pKilled:GetItemCount(checkitem:GetEntry()))
					end
				end
			end
		until (inven_ticker>=38) or (item_ticker>=maxitems)
	end
	if petkill == true then
		local killed_color = ClassColorCodes[pKilled:GetClass()]
		local killer_color = ClassColorCodes[pKiller:GetOwner():GetClass()]
		local killerguild_name = ", a Lone Wolf"
		local killedguild_name = ", a Lone Wolf"
		--Kill Announcer
		local DeathAnnouncements = {
		"[PvP]: |CFF"..killed_color..""..pKilled:GetName().."|r"..killedguild_name..", was slain by |CFF"..killer_color..""..pKiller:GetOwner():GetName().."|r"..killerguild_name.."!",
		"[PvP]: |CFF"..killed_color..""..pKilled:GetName().."|r"..killedguild_name..", met the maker to the hand of |CFF"..killer_color..""..pKiller:GetOwner():GetName().."|r"..killerguild_name.."!",
		"[PvP]: |CFF"..killed_color..""..pKilled:GetName().."|r"..killedguild_name..", was vanquished by |CFF"..killer_color..""..pKiller:GetOwner():GetName().."|r"..killerguild_name.."!",
		"[PvP]: |CFF"..killed_color..""..pKilled:GetName().."|r"..killedguild_name..", has fallen to |CFF"..killer_color..""..pKiller:GetOwner():GetName().."|r"..killerguild_name.."!",
		"[PvP]: |CFF"..killed_color..""..pKilled:GetName().."|r"..killedguild_name..", died a swift death, courtesy of |CFF"..killer_color..""..pKiller:GetOwner():GetName().."|r"..killerguild_name..".",
		"[PvP]: |CFF"..killed_color..""..pKilled:GetName().."|r"..killedguild_name..", wanted a piece of |CFF"..killer_color..""..pKiller:GetOwner():GetName().."|r"..killerguild_name..", but bit off a little more than they could chew!"
		}
		if (pKilled == pKiller) then
			EnableDeathAnnouncer = false			
		else
			if (EnableDeathAnnouncer==true) then
				local DeathAnnounce_Roll = math.random(1,6)
				SendWorldMessage(DeathAnnouncements[DeathAnnounce_Roll])
			end
		end
	end
end]]--


local function Init_FullLootFrame(event, player, object)

	local itemNumber = 0
	local playerKilledName = "h"
	local itemList = {}
	local objectid = object:GetGUIDLow()

	for k, v in ipairs(item_table[objectid]) do
	
		if v[1] ~= nil then
	
			table.insert (itemList, v)
			
			itemNumber = itemNumber + 1
			
		end
	
	end
	
	
	sendItemsToPlayer(AIO.Msg(), player, itemNumber, itemList, objectid):Send(player)

end

function sendItemsToPlayer(msg, player, itemNumber, itemList, playerKilledName, object)

	return msg:Add("PvP", "ReceiveItems", itemNumber, itemList, playerKilledName)

end

function MyHandlers.AddPlayerItem(player, itemEntry, itemCount, object)
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number","number","number"}
	local values = {itemEntry,itemCount,object}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	for i,v in pairs(item_table[object]) do
		if v[2] == itemEntry then
			-- check the possibility to add item
			if (player:AddItem(itemEntry, itemCount)) then
			item_table[object][i][2] = nil
			item_table[object][i][1] = nil
			item_table[object][i][3] = nil
			if (item_table[object][i][5] ~= nil or item_table[object][i][5] ~= 0) then
				player:GetItemByEntry(itemEntry):SetEnchantment(item_table[object][i][5], 5)
				item_table[object][i][5] = nil
			end
		else 
			player:SendBroadcastMessage("You don't have enough space in bags")
		end
		end
	end

end

local function Container_Interact(event, player, object)
	if (item_looted[object:GetGUIDLow()]) then
		return false
	end
	table.insert(item_looted, object:GetGUIDLow())
	Init_FullLootFrame(event, player, object)
	object:Despawn()
	object:RemoveFromWorld(false)
	return false
end


RegisterPlayerEvent(8, EntropyPvP)
RegisterPlayerEvent(6, EntropyPvP)	
RegisterGameObjectGossipEvent(818001, 1, Container_Interact)


--[[Demonic rune fix
local function DemonicRuneFix(event, player, spell, skipCheck)
	if not(spell:GetEntry() == 16666) then
		return false
	end

	if player:IsDead() then
		print("you died by using demonic rune")
	end

end
RegisterPlayerEvent(5, DemonicRuneFix)]]--