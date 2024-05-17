--[[
			ToDO:
1. Set up chair fix - In Progress
	a) Try emote states - FAILED
	b) Try Gameobject hook - N/A
	c) Create a beacon - N/A
2. Find a way to prevent players from attacking at all once in sanctuary - Not Started
	a) Find a way to change their target 
		i) Clear target - N/A
		ii) Select Self - N/A

]]

local function sanctuary_fix_2(eventId, delay, repeats, player) -- using to prevent saving flags after leaving the inn
if not(player:HasFlag(150,0x00000020)) and not(player:IsFFAPvP()) then
	if (player:GetLevel()<20) then
		if player:IsPvPFlagged() then
			player:SetFFA(true)
		end
	else
		player:SetFFA(true)
	end
end

if (player:HasFlag(150,0x00000020)) and (player:IsFFAPvP()) then
	player:SetFFA(false)
end

if (player:GetLevel()<20) then
	if not(player:IsPvPFlagged()) then
			player:SetFFA(false)
		end
	end

if (player:IsInCombat() and player:GetVictim()) then
	if not(player:GetVictim():ToPlayer()) then

		return false
	end
	local victim = player:GetVictim():ToPlayer()
	if (player:IsAlliance() and victim:IsAlliance()) or (player:IsHorde() and victim:IsHorde()) then
		if not(victim:IsFFAPvP()) then
			player:ClearInCombat()
		end
	end
	end

	--special check for mrgmreview
	if (player:GetGUIDLow() == 1458) then
		player:SetFFA(false)
	end
	--end
end

local function TimingChecks(event,player)
	player:RegisterEvent(sanctuary_fix_2, 2000, 0)
	--player:RegisterEvent(Asc_Glory_Check, 30000, 0)
end
RegisterPlayerEvent(28, TimingChecks)
--RegisterPlayerEvent(3, TimingChecks)