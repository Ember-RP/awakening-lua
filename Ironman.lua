local function stayDead(event, player)
	if(player:GetQuestStatus(68934) == 6 or player:GetQuestStatus(689340) == 6) then
		player:AddAura(8326, player)
		player:SetHealth(0)
		player:KillPlayer()
	end
end

local function stayDeadLogin(event, player, msg, Type, lang)
	if((player:GetQuestStatus(68934) == 6 or player:GetQuestStatus(689340) == 6) and player:HasAura(8326) == true) then
		player:SetHealth(0)
		player:KillPlayer()
		player:CastSpell(player, 50768)
	end
end

local function removeMeFromGroup(event, delay, pCall, player)
	player:RemoveFromGroup()
end

local function CheckSurvivalistGroup(player)
	local survivalistGroup = false
	if (player:IsInGroup()) then
		local group = player:GetGroup()
		local t_GroupMembers = group:GetMembers()
		for i, groupMember in ipairs(t_GroupMembers) do
			if (groupMember:GetQuestStatus(689340) == 6) then
				survivalistGroup = true
				break
			end
		end
		return survivalistGroup
	else
		return false
	end
end

local function GroupingLogic(event, group, guid)
	local newPlayer = GetPlayerByGUID(guid)
	local t_GroupMembers = group:GetMembers()
	if (newPlayer:GetQuestStatus(68934) == 6) then
		newPlayer:RegisterEvent(removeMeFromGroup, 75, 1, newPlayer)
		for i, groupMember in ipairs(t_GroupMembers) do
			if (groupMember:GetQuestStatus(68934) == 6) then
				groupMember:RegisterEvent(removeMeFromGroup, 50, 1, groupMember)
			end
			groupMember:SendBroadcastMessage("|cffff0000Ironmen can't join groups!|r")
		end

	else
		local survivalistGroup = CheckSurvivalistGroup(newPlayer)
		
		if (survivalistGroup) then
			for i, groupMember in ipairs(t_GroupMembers) do
				if (groupMember:GetQuestStatus(689340) ~= 6) then
					groupMember:RegisterEvent(removeMeFromGroup, 50, 1, groupMember)
				end
				groupMember:SendBroadcastMessage("|cffff0000Survivalists can only join other Survivalists!|r")
			end
		end
	end
end

local function FailIronmanQuest(event, delay, pCall, player)
	player:SendBroadcastMessage("|cffff0000You have lost the ability to become an Ironman!|r")
	player:SetQuestStatus(68934, 5)
	player:FailQuest(68934)
end

local function FailSurvivalistQuest(event, delay, pCall, player)
	player:SendBroadcastMessage("|cffff0000You have lost the ability to become a Survivalist!|r")
	player:SetQuestStatus(689340, 5)
	player:FailQuest(689340)
end

local function IronmanCannotCarryQuestForward(event, player, oldLevel)
	if (player:HasQuest(68934) and (player:GetQuestStatus(68934) == 1 or player:GetQuestStatus(68934) == 3)) then
		player:RegisterEvent(FailIronmanQuest, 1000, 1, player)		
	end
	
	if (player:HasQuest(689340) and (player:GetQuestStatus(689340) == 1 or player:GetQuestStatus(689340) == 3)) then
		PrintError("Fail quest")
		player:RegisterEvent(FailSurvivalistQuest, 1000, 1, player)		
	end
	
	if (((player:HasQuest(68934) and player:GetQuestStatus(68934) == 6) or (player:HasAura(8326) == true)) and player:IsInGroup()) then
		player:RegisterEvent(removeMeFromGroup, 50, 1, player)
	end

	if (((player:HasQuest(689340) and player:GetQuestStatus(689340) == 6)) and player:IsInGroup()) then
		local survivalistGroup = CheckSurvivalistGroup(player)
		PrintError("Survivalist = "..survivalistGroup)
		if (survivalistGroup) then
			player:RegisterEvent(removeMeFromGroup, 50, 1, player)
		end
	end
end

RegisterPlayerEvent(36, stayDead)
RegisterPlayerEvent(3, stayDeadLogin)
RegisterGroupEvent(1, GroupingLogic)
RegisterPlayerEvent(13, IronmanCannotCarryQuestForward)