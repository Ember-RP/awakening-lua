			--[[INTERACTIVE GUARDS SYSTEM]]--

--Loading guard ids--
local Guards_Entry = {}

local Guard_Factions = {
	88, -- dwarwes of dungarok
	11, -- stormwind guards
	57, -- ironforge
	56, -- night watch
	71, -- undercity
	85, -- orgrimmar
	64, -- gnomerigan
	473, -- chernii woron
	1625, -- serebryanni rassvet
	814, -- serebryanni rassvet
	123, -- arathor
	1054, -- wildhammer dwarf
	--1603, -- lunosvet
	76, -- dalaran mages (EASTERN KINGDOM)
	79, -- darnas
	1575, -- straji pustoti
	412, -- oskvernitely
	1577, -- liga arathora
	105, -- thousand needles guards (horde)
	83, -- thunder bluff
	150, -- theramore
	877, -- sen'jin watchers
	1515, -- warsong guard (barrens)
	854, --Everlook
	121, --Gadgetzan
	1857, --Light's Hope Argent Dawn
	475, --Steamwheel
	1254, -- Cenarion Circle
	1475, -- Thormium Point
	
}
for k, v in pairs(Guard_Factions) do 
	local entry = WorldDBQuery("SELECT entry FROM creature_template WHERE faction = "..v..";")
	if (entry) then
		for i = 1, entry:GetRowCount() do
			table.insert(Guards_Entry, entry:GetInt32(0))
			entry:NextRow()
		end
	end
	end

local function Guard_Back(eventId, delay, repeats, creature)
	if (creature:GetFaction() == 7) and (not(creature:GetVictim()) or (creature:GetVictim():IsDead())) then
	local faction = WorldDBQuery("SELECT faction FROM creature_template where entry = '"..creature:GetEntry().."';")
		creature:SetFaction(faction:GetInt32(0))
		if (creature:GetWaypointPath()) then
			creature:MoveHome()
			creature:MoveWaypoint()
		else
		creature:MoveHome()
	end
	end
end
	--attack player when player attacks player of the same faction
local function Guard_MainAction(event, killer, killed)
	if not(killer:IsFFAPvP()) then
		return false
	end
	if (killer:ToPlayer() and killed:ToPlayer()) and ( (killer:IsAlliance() and killed:IsAlliance()) or (killer:IsHorde() and killed:IsHorde()) ) then

		local FriendlyCreatures = killer:GetFriendlyUnitsInRange(60)

		for n, creature in pairs(FriendlyCreatures) do
			for m,faction_g in pairs(Guard_Factions) do
				if (faction_g == creature:GetFaction()) then
					creature:SetFaction(7)
					creature:AttackStart(killer)
					creature:RegisterEvent(Guard_Back, 2000, 0)
					if ((killer:GetLevel()-creature:GetLevel()) > 5) then
						creature:AddAura(266602, creature)
					end
				end
			end
		end
	end
end

RegisterPlayerEvent(33, Guard_MainAction)


--[[for k,v in pairs(Guards_Entry) do
	RegisterCreatureEvent(v, 2, Guard_Back) -- on leave combat
	RegisterCreatureEvent(v, 3, Guard_Back) -- on target died
	RegisterCreatureEvent(v, 5, Guard_Back) -- on spawn
	--RegisterCreatureEvent(v, 10, Guard_Back) -- on precombat
	RegisterCreatureEvent(v, 7, Guard_Back) -- on aiupdate
	--RegisterCreatureEvent(v, 23, Guard_Back)
end]]--