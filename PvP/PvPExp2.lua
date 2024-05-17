--[[
			ToDO:
1. Reduce decimal places on timer





]]--

local function KillReset(event, delay, repeats, pKiller)
	CharDBExecute("DELETE FROM character_kill_count WHERE killerguid = "..killerguid.." AND victimguid = "..victimguid)
end

local function PvPExp(event, pKiller, pKilled)
	--EXP Formula
	local exp1 = pKiller:GetLevel()
	local exp2 = pKilled:GetLevel()
	local mod = exp1 - exp2
	local ExpBase = (exp2 * 5 + 45) * (1 + 0.05 * mod) * PvPExpRate
	--Kill Table stuff
	local killerguid = pKiller:GetGUIDLow()
	local victimguid = pKilled:GetGUIDLow()
	local check = CharDBQuery("SELECT victimguid FROM character_kill_count WHERE killerguid = "..killerguid)
	local cap = 5 -- set cap
	if(pKiller ~= pKilled) then
		if(check == nil) then -- if player has not killed anyone yet:
			print("Player has no kill data")
			CharDBExecute("INSERT INTO character_kill_count(killerguid, victimguid, count) VALUES("..killerguid..","..victimguid..",1)")
			if (exp2 >= exp1 - 10 and exp2 <= exp1 + 10) then
				-- check for group and if group above max party count (so raid)
				local group = pKiller:GetGroup()
				if (group ~= nil) then
					local groupmem = group:GetMembersCount()
					if (groupmem <= 5) then
						local partymember = group:GetMembers()
							for x=1,#partymember,1 do
								partymember[x]:GiveXP(ExpBase / groupmem)
							end
					end
				else
					pKiller:GiveXP(ExpBase)
				end
			end
		else
			local kills = CharDBQuery("SELECT count FROM character_kill_count WHERE killerguid = "..killerguid.." AND victimguid = "..victimguid):GetInt32(0)
			local AddKill = kills + 1
			if(pKiller:GetMap():GetMapId() == 0 or pKiller:GetMap():GetMapId() == 1) then
				if (kills < cap) then
					if (exp2 >= exp1 - 10 and exp2 <= exp1 + 10) then
						-- check for group and if group above max party count (so raid)
						local group = pKiller:GetGroup()
						if (group ~= nil) then
							local groupmem = group:GetMembersCount()
							if (groupmem <= 5) then
								local partymember = group:GetMembers()
									for x=1,#partymember,1 do
										partymember[x]:GiveXP(ExpBase / groupmem)
									end
							end
						else
							pKiller:GiveXP(ExpBase)
							CharDBQuery("UPDATE character_kill_count SET count = "..AddKill.." WHERE killerguid = "..killerguid.." AND victimguid = "..victimguid)
						end
					end
				elseif (kills >= cap) then
					CharDBQuery("UPDATE character_kill_count SET count = "..AddKill.." WHERE killerguid = "..killerguid.." AND victimguid = "..victimguid)
					if(pKiller:GetLuaCooldown() == 0) then -- Check if cooldown is present
						pKiller:SetLuaCooldown(86400) -- Set cooldown in seconds for kills. Default: 24hrs = 86400
						local timer = math.floor( pKiller:GetLuaCooldown() / 3600 )
						pKiller:SendBroadcastMessage("You have killed this player to many times and will no longer receive exp from this player for "..timer.." hours.")
						pKiller:RegisterEvent(KillReset, 86400000, 1)
					else 
						local timer = math.floor( pKiller:GetLuaCooldown() / 3600 )
						pKiller:SendBroadcastMessage("You have killed this player to many times and will no longer receive exp from this player for "..timer.." hours.")
					end
				end
			end
		end
	end
end

RegisterPlayerEvent(6, PvPExp)