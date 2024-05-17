local aura = 818052 -- put Test Aura ID here
local function TestReturn(event, player, newZone, NewArea)
	if (newZone ~= 3817 and NewArea ~= 3817) then -- Test ZoneID and AreaID
		if player:HasAura(aura) then
			player:Teleport(13, -5.723160, -6.920650, -144.709000, 3.462120) -- Test Zone Coords
		end
	end
end
RegisterPlayerEvent(27, TestReturn)

local testnpc = 212341

function On_Gossip(event, player, unit)
	player:GossipMenuAddItem(0, "Add Test Aura", 0, 1)
	player:GossipMenuAddItem(0, "Remove Test Aura", 0, 2)
	player:GossipSendMenu(1, unit)
end

function On_Select(event, player, unit, sender, intid, code)
	if (intid == 1) then
		player:AddAura(818052, player)
		player:GossipComplete()
		unit:SendUnitSay(""..player:GetName().." now has the Test aura and is now locked to this map.", 7)
		--player:SendBroadcastMessage("You now have a Test Aura, you will not be allowed anywhere else until removed.")
	else
		player:RemoveAura(818052, player)
		player:GossipComplete()
		unit:SendUnitSay(""..player:GetName().." has removed the Test aura and is free to return to Azeroth.", 7)
		--player:SendBroadcastMessage("Your Test aura has been removed, you're welcome to go back to Azeroth")
end
        player:GossipComplete()
end

RegisterCreatureGossipEvent(testnpc, 1, On_Gossip)
RegisterCreatureGossipEvent(testnpc, 2, On_Select)