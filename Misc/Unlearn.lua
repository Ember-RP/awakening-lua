local function UnlearnHello(event, player, creature)
	player:GossipMenuAddItem(0, "Alchemy", 900017, 1, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Blacksmithing", 900017, 2, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Enchanting", 900017, 3, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Engineering", 900017, 4, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Herbalism", 900017, 5, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Leatherworking", 900017, 6, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Mining", 900017, 7, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Skinning", 900017, 8, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Tailoring", 900017, 9, false, "Are you sure you want to unlearn this profession?")
	player:GossipMenuAddItem(0, "Nevermind", 900017, 0)
	player:GossipSendMenu(900017, creature, MenuId)
end

local function UnlearnSelect(event, player, creature, sender, intid, code)
	if (intid > 0) then
	local UnQuery1 = WorldDBQuery("SELECT intid, spell FROM gossip_options_lua WHERE intid = " ..intid.. ";")
	local spellid = UnQuery1:GetInt32(1)
	player:GossipComplete()
		if (UnQuery1 ~= nil) then
			if (player:HasSpell(spellid) == true) then
				player:RemoveSpell(spellid)
			else
				player:SendBroadcastMessage("You do not know that profession!")
			end
		else
		player:SendBroadcastMessage("Sorry, but the action you are trying to perform cannot be finished. Please report this to an administrator.")
		end
	else
	player:GossipComplete()
	end
end

RegisterCreatureGossipEvent(9999999, 1, UnlearnHello)
RegisterCreatureGossipEvent(9999999, 2, UnlearnSelect)
RegisterCreatureGossipEvent(9999998, 1, UnlearnHello)
RegisterCreatureGossipEvent(9999998, 2, UnlearnSelect)