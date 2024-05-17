-- How it works:
-- Each week it should run a check that will remove 5% of player's glory
-- For each kill player gets 50 glory
-- Each 30 secs time event for player checks if player has enough glory for title
-- if yes, it learns title to a player, otherwise it ulearns a title 
-- Titles goes according to array Asc_Glory_Titles = {titleid, cost, hordetitleid}
-- Glory goes according to colum in character DB
-- Check goes according to table in character DB

--[[local Asc_Glory_Titles = {
	[1] = {1, 1500, 15},
	[2] = {2, 2500, 16},
	[3] = {3, 5000, 17},
	[4] = {4, 7500, 18},
	[5] = {5, 10000, 19},
	[6] = {6, 15000, 20},
	[7] = {7, 20000, 21},
	[8] = {8, 22500, 22},
	[9] = {9, 25000, 23},
	[10] = {10, 30000, 24},
	[11] = {11, 32500, 25},
	[12] = {12, 35000, 26},
	[13] = {13, 40000, 27},
	[14] = {14, 50000, 28},
	[15] = {230, 51000, 229},
}

local Asc_Reduce_Amount = 5

local Asc_Kill_Reward = 50

local Asc_Time_ToCheck = 0

local function Asc_Glory_SQL(glory, guid)
local glorySQL = CharDBQuery("SELECT gloryPoints FROM characters WHERE guid = "..guid..";")
if not(glorySQL) then
		CharDBQuery("UPDATE characters SET gloryPoints = "..glory.." WHERE guid = "..guid..";")
	else
		local glory = glorySQL:GetInt32(0)+glory
		CharDBQuery("UPDATE characters SET gloryPoints = "..glory.." WHERE guid = "..guid..";")
	end
	end

function Asc_Glory_Check(eventId, delay, repeats, player) -- function registered in Sanctuaryfix.lua
	local enoughGlory = false
	local pGUID = player:GetGUIDLow()
	local glorySQL = CharDBQuery("SELECT gloryPoints FROM characters WHERE guid = "..pGUID..";")

	if not(glorySQL) then
		return false
	end

	local glory = glorySQL:GetInt32(0)

	for k,titles in pairs(Asc_Glory_Titles) do
		local Title = nil 

		if (glory >= titles[2]) then -- check for enough glory
			enoughGlory = true
		else
			enoughGlory = false
		end 


		if player:IsAlliance() then --set correct title entry
			Title = titles[1]
		else
			Title = titles[3]
		end
		

		if (player:HasTitle(Title)) then -- main check to learn/unlearn title
			if not(enoughGlory) then
				player:UnsetKnownTitle(Title)
			end
		else
			if (enoughGlory) then
				player:SetKnownTitle(Title)
			end
			end
	end

	--player:SendBroadcastMessage("DEBUG Glory = "..glory)
end

local function Asc_Glory_HonorKill(event, killer, killed)
	local kLevel = killer:GetLevel()
	local vLevel = killed:GetLevel()
	local kGUID = killer:GetGUIDLow()
	local isHonoredKill_glorycount = -Asc_Kill_Reward

	if kLevel <= (vLevel+5) then
		isHonoredKill_glorycount = Asc_Kill_Reward
	end

	Asc_Glory_SQL(isHonoredKill_glorycount, kGUID)

	end

RegisterPlayerEvent(6, Asc_Glory_HonorKill)

local function Asc_Glory_BG(event, bg, bgId, instanceId, winner)
	print(winner)
	end

RegisterBGEvent(2, Asc_Glory_BG)]]--