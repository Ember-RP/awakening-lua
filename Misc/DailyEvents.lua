local function DailyGloryFlush(event, player)
	local Stime2 = tostring(GetGameTime())
	-- readies for next timer
	WorldDBQuery("DELETE FROM timestamps WHERE state = 1")
	WorldDBQuery("INSERT INTO timestamps VALUES ( 1, " ..Stime2.. ");")
	player:UnbindInstance(409)
end

local function ResetCheck(event, player)
	-- the time, in seconds
	-- use integers that divide evenly into the "save players interval" value in world.conf for best results
	local Stime = GetGameTime()
	local timerdaily = 86400	
	local GUpdate1 = WorldDBQuery("SELECT * FROM timestamps WHERE state = 1")
	if (player == nil) then
		print("[Eluna]: Error pushing timestamps on reset. No players are online. See: DailyEvents.lua.")
		return false
	elseif (GUpdate1 == nil) then
		if (player:IsGM() == true) then
		-- sends an error message to GMs and server if there is no flush time in the DB
		player:SendBroadcastMessage("The daily timer system has broken! Contact an administrator ASAP!")
		print("[Eluna]: Error loading LUA script: DailyEvents.lua - There is a nil value in the database `timestamps`. Check entries!")
		return false
		end
		return false
	elseif (Stime >= GUpdate1:GetInt32(1) + timerdaily) then
				DailyGloryFlush(event, player)
	else
		return false
	end
end

RegisterPlayerEvent(25, ResetCheck)