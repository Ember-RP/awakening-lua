--[[local function Redo(eventId, delay, repeats, player)
	Buff(event, player)
	--DEBUG--player:SendBroadcastMessage("test")
end

local timing = false

function Buff(event, player)
	-- query to select spell and map
	local Buff1 = WorldDBQuery("SELECT map, spell FROM instance_buff WHERE map = " ..player:GetMapId().. ";")
	if (Buff1 ~= nil) then
		--so we dont dupe the same timer 100000 times
		if (timing == false) then
			player:RegisterEvent(Redo, 60000, 0)
			--DEBUG--player:SendBroadcastMessage("timing now")
			timing = true
		end
	local mobs = player:GetCreaturesInRange(533)
	local buffspell = {}
		for z=1,Buff1:GetRowCount(),1 do
			buffspell[z] = Buff1:GetInt32(1)
			Buff1:NextRow()
		end
		-- add aura based on DB query above and loop for mobs in range
		for x=1,#mobs,1 do
			for y=1,#buffspell,1 do
				-- checks for aura first, then possible pet, then for player
				if (mobs[x]:HasAura(buffspell[y]) == false) and (mobs[x]:GetPetGUID() == nil) and (mobs[x]:HasSpell(818011) == false) then
					mobs[x]:AddAura(buffspell[y], mobs[x])
				end
			end
		end
	else
		-- do this because they arent in a buffed instance
		timing = false
		--DEBUG--player:SendBroadcastMessage("stopped timing")
	end
end

RegisterPlayerEvent(28, Buff)]]--

-- my edit of this script -- Need to be tested -- 
local instance_buff = {
	
[43]={966010}, -- WC
[389]={966010}, -- RFC
[36]={966010}, -- Deadmines
[33]={966011}, -- SFK
[48]={966011}, -- BFD
[34]={966011}, -- Stockades
[90]={966012}, -- Gnomer
[47]={966012}, -- RFK
[189]={966012}, -- SM
[129]={966013}, -- RFD
[70]={966013}, -- Uld
[209]={966013}, -- ZF
[349]={966013}, -- Mara
[109]={966014}, -- ST
[230]={966014}, -- BRD
[229]={966016}, -- Scholo
[429]={966016}, -- DM
[329]={966016}, -- Strat
[289]={966015}, -- BRS
[409]={966019}, -- MC
[249]={966020}, -- Onyxias Lair
[309]={966022}, -- Zul'Gurub
[469]={966021}, -- Blackwing Lair
[509]={966021}, -- AQ20
[531]={966024}, -- AQ40
[533]={966025}, -- Naxx



}
local instance_flag_buff = 966026

local function Instance_Buff(event,player,enemy)
	if not(enemy:ToCreature()) then
		return false
	end

	if (enemy:HasAura(instance_flag_buff)) then -- flag check
		return false
	end

	local Instance_Map = player:GetMap()
	local Instance_Creatures_ToBuff = {}
	local Instance_Buffs = {}

	if not(Instance_Map:IsDungeon()) and not(Instance_Map:IsRaid()) then
		return false
	end	

	Instance_Buffs = instance_buff[Instance_Map:GetMapId()]

	if not(Instance_Buffs[1]) then 
		return false
	end

	local Instance_Creatures = player:GetCreaturesInRange(300)
	for id,creature in pairs(Instance_Creatures) do
		if not(creature:HasAura(instance_flag_buff)) and not(creature:HasSpell(818011)) then -- flag check (replaced with special aura which works the same way as auras we have)
			-- pet check -- 
			if (creature:GetOwner()) then
				if not(creature:GetOwner():ToPlayer()) then
					table.insert(Instance_Creatures_ToBuff, creature)
				end
			else
			--           --
			table.insert(Instance_Creatures_ToBuff, creature)
		end
		end
	end

	if not(Instance_Creatures_ToBuff[1]) then
		return false
	end

	for k,cre_to_buff in pairs(Instance_Creatures_ToBuff) do
		for i,cre_aura in pairs(Instance_Buffs) do
			if not(cre_to_buff:HasAura(cre_aura)) then
			cre_to_buff:AddAura(cre_aura, cre_to_buff)
			cre_to_buff:AddAura(instance_flag_buff, cre_to_buff)
			--cre_to_buff:SendUnitSay("Aura Applied", 0) -- DEBUG
		end
		end
	end

end
--RegisterPlayerEvent(28, Instance_Buff) -- run the script on mapchange event

RegisterPlayerEvent(33, Instance_Buff) -- on enter combat
