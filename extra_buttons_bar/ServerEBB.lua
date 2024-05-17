local AIO = AIO or require("AIO")


local MyHandlers = AIO.AddHandlers("sideBar", {})
local ghost = {8326}

local scrollitem = 1101243
local Reset_Level = {
    [0] = {2500, 2700, 105},
    [10] = {5000, 7500, 150},
    [20] = {7500, 10000, 2150},
    [30] = {50000,150000,3250},
    [40] = {150000,300000,9250},
    [50] = {300000,1000000,10550},
    [60] = {350000,1500000,20000},
    [70] = {500000,2500000,20000},
    [80] = {500000,2500000,20000},
}

local function GetMoneyForReset(player,purgemissing)
	local TalentMult = 0
	local SpellMult = 0
	local mult = 0
	local SQLMultQuery = CharDBQuery("SELECT ability_resets, talent_resets FROM custom_resets WHERE char_guid = "..player:GetGUIDLow()..";")
	if not(SQLMultQuery) then
		CharDBExecute("INSERT INTO custom_resets VALUES ("..player:GetGUIDLow()..",0,0);")
	else
		SpellMult = SQLMultQuery:GetInt32(0)
		TalentMult = SQLMultQuery:GetInt32(1)
	end
for k,v in pairs(Reset_Level) do
    if (player:GetLevel() >= k) and (player:GetLevel() < k+10) then

    	if (purgemissing == 1) then
        mult = TalentMult
        elseif (purgemissing == 2) then
        mult = SpellMult
    	end

        local talent_cost = Reset_Level[k][purgemissing] + Reset_Level[k][3]*(player:GetLevel()-k+mult*2)
        if (talent_cost>Reset_Level[k][purgemissing]*1.75) then
        	talent_cost = Reset_Level[k][purgemissing]*1.75
        end
        return talent_cost,TalentMult,SpellMult
    end
end
end

 function MyHandlers.GetMults(player)
 	local cost = 0
 	local t_mult = 0
 	local a_mult = 0
 	cost, t_mult, a_mult = GetMoneyForReset(player, 1)
	resetFrame_Refresh(AIO.Msg(), player,t_mult, a_mult):Send(player)
end

 function resetFrame_Refresh(msg,player,t_mult, a_mult)
	return msg:Add("sideBar", "ResetFrame_Init", t_mult, a_mult)
end

function MyHandlers.ReceivePlayerStats(player)
	local player_guid = player:GetGUIDLow()
	local stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid)
	local stat_point_query = CharDBQuery("SELECT points FROM character_stat_points WHERE guid = "..player_guid)
	local stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4), stat_point_query:GetInt32(0)}
	sendStatsToPlayer(AIO.Msg(), player, stats):Send(player)
end



function MyHandlers.AddStats(player, stat, s_amount)
	if (s_amount) then
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number","number"}
	local values = {stat,s_amount}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	else
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number"}
	local values = {stat}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	end
	-- stat values equal >>>>> 1 = strength | 2 = stamina | 3 = agility | 4 = intellect | 5 = spirit 

	local stat_names = {"str", "sta", "agi", "inte", "spi"}
	local player_guid = player:GetGUIDLow()
	local stat_point_query = CharDBQuery("SELECT points FROM character_stat_points WHERE guid = "..player_guid)
	local point_val = stat_point_query:GetInt32(0)
	local stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid)
	local stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4)}
	local range = {[9]=(player:GetLevel() + 4), [19]=((player:GetLevel() * 2) - 5), [29]=((player:GetLevel() * 3) - 24), [39]=((player:GetLevel() * 4) - 53), [59]=((player:GetLevel() * 5) - 92), [69]=((player:GetLevel() * 10) - 387)}
	local levels = {9, 19, 29, 39, 59, 69}
	local amount = 1
	if (s_amount) then
		if (s_amount <= point_val) then
		amount = s_amount
		elseif (point_val > 0) and (point_val<s_amount) then
			amount = point_val
		end
	end
	
	--for _, v in ipairs(ghost) do
		--if (player:HasAura(v) == false and player:IsDead() == false) then
	if (player:InArena() ==	true or player:InBattleground() == 	true) then
		player:SendBroadcastMessage("You can't do that in Battlegrounds and Arenas.")
	else
		if (player:IsInCombat() == true) then
			player:SendBroadcastMessage("You cannot do that while in combat!")
		else
			if (player:IsAlive() == true) then
				if point_val > 0 then
					if (player:GetLevel() <= 9) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[9] then
							local point_max = range[9]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
						point_val = point_val - amount
						CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 19) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[19] then
							local point_max = range[19]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
						point_val = point_val - amount
						CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 29) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[29] then
							local point_max = range[29]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
						point_val = point_val - amount
						CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 39) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[39] then
							local point_max = range[39]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
							point_val = point_val - amount
							CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 59) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[59] then
							local point_max = range[59]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
							point_val = point_val - amount
							CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					else--if (player:GetLevel() <= 69) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[69] then
							local point_max = range[69]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
							point_val = point_val - amount
							CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					end
	
				local stat_use = stat_names[stat]

	
				stats_query = CharDBQuery("SELECT "..stat_use.." FROM character_stat_allocation WHERE guid = "..player_guid)
				local stat_value = stats_query:GetInt32(0)
		
		
				stat_value = stat_value + amount
		
				CharDBExecute("UPDATE character_stat_allocation set "..stat_use.." = "..stat_value.." WHERE guid = "..player_guid)
		
		
				stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid)
		
				stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4), point_val}
				stats[stat] = stat_value
		

		
				sendStatsToPlayer(AIO.Msg(), player, stats):Send(player)
				player_stat_auras(player, stats)
			
			
			else
	
				player:SendBroadcastMessage("You do not have enough points to do that!")
			end
		else
			player:SendBroadcastMessage("You cannot do that while dead!")
		end
	end
	end
end




function MyHandlers.ReduceStats(player, stat, s_amount)
	if (s_amount) then
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number","number"}
	local values = {stat,s_amount}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	else
	--AIO ADDITIONAL CHECK--
	local expectedData = {"number"}
	local values = {stat}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--
	end
	-- stat values equal >>>>> 1 = strength | 2 = stamina | 3 = agility | 4 = intellect | 5 = spirit 
	local stat_names = {"str", "sta", "agi", "inte", "spi"}
	local player_guid = player:GetGUIDLow()
	local stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid)
	local points_query = CharDBQuery("SELECT points FROM character_stat_points WHERE guid = "..player_guid)
	local point_val = points_query:GetInt32(0)
	local stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4)}
	local range = {[9]=(player:GetLevel() + 4), [19]=((player:GetLevel() * 2) - 5), [29]=((player:GetLevel() * 3) - 24), [39]=((player:GetLevel() * 4) - 53), [59]=((player:GetLevel() * 5) - 92), [69]=((player:GetLevel() * 10) - 387)}
	local levels = {9, 19, 29, 39, 59, 69}
	local amount = 1
	if (s_amount) then
		if (s_amount <= stats[stat]) then
		amount = s_amount
		elseif (stats[stat] > 0) and (stats[stat]<s_amount) then
			amount = stats[stat]
		end
	end
	--for _, v in ipairs(ghost) do
		--if (player:HasAura(v) == false and player:IsDead() == false) then
	if (player:InArena() ==	true or player:InBattleground() == 	true) then
		player:SendBroadcastMessage("You can't do that in Battlegrounds and Arenas.")
	else
		if (player:IsInCombat() == true) then
			player:SendBroadcastMessage("You cannot do that while in combat!")
		else
			if (player:IsAlive() == true) then
				if stats[stat] > 0 then
					if (player:GetLevel() <= 9) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[9] then
							local point_max = range[9]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
						point_val = point_val + amount
						CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 19) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[19] then
							local point_max = range[19]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
						point_val = point_val + amount
						CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 29) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[29] then
							local point_max = range[29]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
						point_val = point_val + amount
						CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 39) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[39] then
							local point_max = range[39]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
							point_val = point_val + 1
							CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					elseif (player:GetLevel() <= 59) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[59] then
							local point_max = range[59]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
							point_val = point_val + amount
							CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					else--if (player:GetLevel() <= 69) then
						if point_val + (stats[1] + stats[2] + stats[3] + stats[4] + stats[5]) ~= range[69] then
							local point_max = range[69]
							point_max = point_max - (stats[1] + stats[2] + stats[3] + stats[4] + stats[5])
							point_val = point_max
						end
							point_val = point_val + amount
							CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
					end
	
	
				local stat_value = stats[stat] - amount
				CharDBExecute("UPDATE character_stat_allocation set "..stat_names[stat].." = "..stat_value.." WHERE guid = "..player_guid)
		
				stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid)
				local stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4), point_val}
		
				stats[stat] = stat_value
		

		
				sendStatsToPlayer(AIO.Msg(), player, stats):Send(player)
				player_stat_auras(player, stats)
		
		
		
			else
				player:SendBroadcastMessage("You do not have any points in that stat")	
			end
		else
			player:SendBroadcastMessage("You cannot do that while dead!")
		end
	end
	end
end

	




function sendStatsToPlayer(msg, player, stats)

	return msg:Add("sideBar", "GetStatValues", stats)

end



local function OnPlayerLogin(event, player) -- Caps out at 302 stats wont show beyond level 69, NEVER WIPE AGAIN unless no one has reached level 70:D
	local player_guid = player:GetGUIDLow()
	local stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid.."")
	local points_query = CharDBQuery("SELECT points FROM character_stat_points WHERE guid = "..player_guid.."")
	if not(stats_query or points_query) then
		return false
	end
	local statsq = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4)}
	--for _,v in pairs(statsq) do
		if ((statsq[1] + statsq[2] + statsq[3] + statsq[4] + statsq[5]) == 0) then
			if (player:GetLevel() <= 9) then
				local init_points = player:GetLevel() + 4
				CharDBExecute("REPLACE INTO character_stat_points(guid, points) VALUES("..player_guid..","..init_points..")")
			elseif (player:GetLevel() <= 19) then
				local init_points = ((player:GetLevel() * 2) - 5)
				CharDBExecute("REPLACE INTO character_stat_points(guid, points) VALUES("..player_guid..","..init_points..")")
			elseif (player:GetLevel() <= 29) then
				local init_points = ((player:GetLevel() * 3) - 24)
				CharDBExecute("REPLACE INTO character_stat_points(guid, points) VALUES("..player_guid..","..init_points..")")
			elseif (player:GetLevel() <= 39) then
				local init_points = ((player:GetLevel() * 4) - 53)
				CharDBExecute("REPLACE INTO character_stat_points(guid, points) VALUES("..player_guid..","..init_points..")")
			elseif (player:GetLevel() <= 59) then
				local init_points = ((player:GetLevel() * 5) - 92)
				CharDBExecute("REPLACE INTO character_stat_points(guid, points) VALUES("..player_guid..","..init_points..")")
			else--if (player:GetLevel() <= 69) then
				local init_points = ((player:GetLevel() * 10) - 387)
				CharDBExecute("REPLACE INTO character_stat_points(guid, points) VALUES("..player_guid..","..init_points..")")
			end
		else
			local stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4)}
			player_stat_auras(player, stats)
			player:DealHeal(player, 818037, 500000)
		end
		end


function player_stat_auras(player, stats)
	local stat_auras = {7464, 7477, 7471, 7468, 7474}
	for i,v in ipairs(stats) do
		if v == 0 and player:HasAura(stat_auras[i]) == true then
			player:RemoveAura(stat_auras[i], player)
		
		elseif v ~= 0 then
		
			if player:HasAura(stat_auras[i]) == false then
				player:AddAura(stat_auras[i], player)
				--print("adding aura")
			end
		
			local stack_amount = stats[i]
			local aura = player:GetAura(stat_auras[i])
			aura:SetStackAmount(stack_amount)
			
		
		end
	end
end

local function OnRevive(event, player)
	local player_guid = player:GetGUIDLow()
	local stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid.."")
	if not(stats_query) then
		return false
	end
	local stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4)}
	player_stat_auras(player, stats)
end

local function OnLevelChange(event, player, oldLevel)

	local player_guid = player:GetGUIDLow()
		--resets part--
		if (oldLevel == 9) or (oldLevel == 19) or (oldLevel == 29) or (oldLevel == 39) or (oldLevel == 49) or (oldLevel == 59) then
		CharDBExecute("DELETE FROM custom_resets WHERE char_guid = "..player_guid..";")
		resetFrame_Refresh(AIO.Msg(), player,0, 0):Send(player)
		end

	local points_query = CharDBQuery("SELECT points FROM character_stat_points WHERE guid = "..player_guid)
	local point_val = points_query:GetInt32(0)
	if (player:GetLevel() <= 9) then
		point_val = point_val + 1
		CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
	elseif (player:GetLevel() <= 19) then
		point_val = point_val + 2
		CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
	elseif (player:GetLevel() <= 29) then
		point_val = point_val + 3
		CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
	elseif (player:GetLevel() <= 39) then
		point_val = point_val + 4
		CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
	elseif (player:GetLevel() <= 59) then
		point_val = point_val + 5
		CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
	elseif (player:GetLevel() <= 69) then
		point_val = point_val + 10
		CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
	else--if (player:GetLevel() <= 80) then
		point_val = point_val + 20
		CharDBExecute("UPDATE character_stat_points SET points = "..point_val.." WHERE guid = "..player_guid)
	end
	
	local stats_query = CharDBQuery("SELECT str, sta, agi, inte, spi FROM character_stat_allocation WHERE guid = "..player_guid)
	local stats = {stats_query:GetInt32(0), stats_query:GetInt32(1), stats_query:GetInt32(2), stats_query:GetInt32(3), stats_query:GetInt32(4), point_val}
	
	sendStatsToPlayer(AIO.Msg(), player, stats):Send(player)

end

RegisterPlayerEvent(36, OnRevive)
RegisterPlayerEvent(13, OnLevelChange)
RegisterPlayerEvent(3, OnPlayerLogin)


noTEspells = {54785, 50589, 818050, 50581, 59671, 21849, 21850, 26991, 48470, 21562, 21564, 25782, 25916, 27141, 27681, 10143, 8121, 7763, 10937, 10938, 9884, 1373}
			
function MyHandlers.ResetSpells(player)
	local free_spell_reset = false
	if (player:GetLevel() < 10) then
		free_spell_reset = true
	end
	local cost = GetMoneyForReset(player,2)
	local all_spell_lists = {druid_balance_spells, druid_feral_spells, druid_restoration_spells,
							   hunter_beastmastery_spells, hunter_marksmanship_spells, hunter_survival_spells,
							   mage_arcane_spells, mage_fire_spells, mage_frost_spells,
							   paladin_holy_spells, paladin_protection_spells, paladin_retribution_spells,
							   priest_discipline_spells, priest_holy_spells, priest_shadow_spells,
							   rogue_assassination_spells, rogue_combat_spells, rogue_subtlety_spells,
							   shaman_elemental_spells, shaman_enhancement_spells, shaman_restoration_spells,
							   warlock_affliction_spells, warlock_demonology_spells, warlock_destruction_spells,
							   warrior_arms_spells, warrior_fury_spells, warrior_protection_spells, general_spells}
	if (player:InArena() ==	true or player:InBattleground() == 	true) then
		player:SendBroadcastMessage("You can't do that in Battlegrounds and Arenas.")
	else
		if player:HasItem(spell_reset_token) == true or free_spell_reset == true or (player:GetCoinage() >= cost) then
		if (player:HasItem(spell_reset_token) == true or free_spell_reset == true) then		
			if not(free_spell_reset) then
			player:RemoveItem(spell_reset_token, 1)
			end
		else
			player:ModifyMoney(-cost)
		end
			--local noTEspells = {54785, 674, 50589, 107, 3127, 818050, 774994, 50581, 59671, 11417, 11420, 11418, 3567, 3566, 3563, 11419, 11416, 10059, 3565, 3562, 3561, 21849, 21850, 26991, 48470, 21562, 21564, 25782, 25916, 27141, 27681, 49360, 49359, 49361, 49358, 10143, 8121, 7763, 10937, 10938, 9884, 1373}
			-- commited list with general spells tab
			for s, sid in pairs(noTEspells) do
				if player:HasSpell(sid) then
					player:RemoveSpell(sid)
				end
			end
			for listloc,spec in ipairs(all_spell_lists) do
				for loc,spell in ipairs(spec) do
					local AE_cost = spell[2]
					local TE_cost = spell[3]
					local spellid = spell[1]
				
					if player:HasSpell(spellid) == true then
						player:RemoveSpell(spellid)
						player:AddItem(spell_essence, AE_cost)
						if TE_cost ~= 0 then
							player:Additem(talent_essence, TE_cost)
						end
						if player:HasAura(spellid) == true then
							player:RemoveAura(spellid)
						end
					end
				end
			end
			--custom mult part
			--player:RemoveItem(spell_essence, player:GetItemCount(spell_essence))
			--player:AddItem(spell_essence, player:GetLevel())
			CharDBExecute("UPDATE custom_resets SET ability_resets = ability_resets+1 WHERE char_guid = "..player:GetGUIDLow()..";")
			local temp_cost, temp_t_mult, temp_a_mult = GetMoneyForReset(player, 1)
			resetFrame_Refresh(AIO.Msg(), player,temp_t_mult, temp_a_mult+1):Send(player)
			--
			player:RemoveAura(774993)
			player:RemoveAura(774994)
			player:CastSpell(player, 65632)
			player:SendBroadcastMessage("Refund Complete for Spells")
		else
			player:SendBroadcastMessage("You are missing the required token to do this!")
		end
	end
end


function MyHandlers.ResetTalents(player)
	local cost = GetMoneyForReset(player,1)
	local all_talent_lists = {druid_balance_talents, druid_feral_talents, druid_restoration_talents,
							   hunter_beastmastery_talents, hunter_marksmanship_talents, hunter_survival_talents,
							   mage_arcane_talents, mage_fire_talents, mage_frost_talents,
							   paladin_holy_talents, paladin_protection_talents, paladin_retribution_talents,
							   priest_discipline_talents, priest_holy_talents, priest_shadow_talents,
							   rogue_assassination_talents, rogue_combat_talents, rogue_subtlety_talents,
							   shaman_elemental_talents, shaman_enhancement_talents, shaman_restoration_talents,
							   warlock_affliction_talents, warlock_demonology_talents, warlock_destruction_talents,
							   warrior_arms_talents, warrior_fury_talents, warrior_protection_talents}
	if (player:InArena() ==	true or player:InBattleground() == 	true) then
		player:SendBroadcastMessage("You can't do that in Battlegrounds and Arenas.")
	else						   
		if player:HasItem(talent_reset_token) == true or free_talent_reset == true or (player:GetCoinage() >= cost) then
		if (player:HasItem(talent_reset_token) == true or free_talent_reset == true) then		 
			player:RemoveItem(talent_reset_token, 1)
		else
			player:ModifyMoney(-cost)
		end
			for i,v in ipairs(all_talent_lists) do
			
				for listloc,talent in ipairs(v) do
					local spell_removed = false
					local rank_removed = 0
					local AE_cost = talent[3]
					local TE_cost = talent[4]
					for slot,spellid in ipairs(talent[2]) do
						if player:HasSpell(spellid) == true then
							spell_removed = true
							rank_removed = slot
							player:RemoveSpell(spellid)
						
							if player:HasAura(spellid) == true then
								player:RemoveAura(spellid)
							end
						
							player:SendBroadcastMessage("removing: "..spellid)
						end
					end

					if spell_removed == true then
						player:AddItem(talent_essence, (rank_removed*TE_cost))
						if AE_cost ~= 0 then
							player:AddItem(spell_essence, (rank_removed*AE_cost))
						end
					end
				end
			end
			--custom mult part
			--player:RemoveItem(talent_essence, player:GetItemCount(talent_essence))
			--player:AddItem(talent_essence, player:GetLevel()-9)
			CharDBExecute("UPDATE custom_resets SET talent_resets = talent_resets+1 WHERE char_guid = "..player:GetGUIDLow()..";")
			local temp_cost, temp_t_mult, temp_a_mult = GetMoneyForReset(player, 1)
			resetFrame_Refresh(AIO.Msg(), player,temp_t_mult+1, temp_a_mult):Send(player)
			--
			player:CastSpell(player, 65632)
			player:SendBroadcastMessage("Refund Complete for talents")
		else
			player:SendBroadcastMessage("You are missing the required token to do this!")
		end

	end
end

 function GetRightSpellTables(class,Spec)
local spell_count = nil
local spell_list = nil

	if class == "DRUID" and Spec == "BALANCE" then
		spell_count = druid_balance_spells_count
		spell_list = druid_balance_spells
	elseif class == "DRUID" and Spec == "FERAL" then
		spell_count = druid_feral_spells_count
		spell_list = druid_feral_spells
	elseif class == "DRUID" and Spec == "RESTORATION" then
		spell_count = druid_restoration_spells_count
		spell_list = druid_restoration_spells
	elseif class == "HUNTER" and Spec == "BEASTMASTERY" then
		spell_count = hunter_beastmastery_spells_count
		spell_list = hunter_beastmastery_spells
	elseif class == "HUNTER" and Spec == "MARKSMANSHIP" then
		spell_count = hunter_marksmanship_spells_count
		spell_list = hunter_marksmanship_spells
	elseif class == "HUNTER" and Spec == "SURVIVAL" then
		spell_count = hunter_survival_spells_count
		spell_list = hunter_survival_spells
	elseif class == "MAGE" and Spec == "ARCANE" then
		spell_count = mage_arcane_spells_count
		spell_list = mage_arcane_spells
	elseif class == "MAGE" and Spec == "FIRE" then
		spell_count = mage_fire_spells_count
		spell_list = mage_fire_spells
	elseif class == "MAGE" and Spec == "FROST" then
		spell_count = mage_frost_spells_count
		spell_list = mage_frost_spells
	elseif class == "PALADIN" and Spec == "HOLY" then
		spell_count = paladin_holy_spells_count
		spell_list = paladin_holy_spells
	elseif class == "PALADIN" and Spec == "RETRIBUTION" then
		spell_count = paladin_retribution_spells_count
		spell_list = paladin_retribution_spells
	elseif class == "PALADIN" and Spec == "PROTECTION" then
		spell_count = paladin_protection_spells_count
		spell_list = paladin_protection_spells
	elseif class == "PRIEST" and Spec == "DISCIPLINE" then
		spell_count = priest_discipline_spells_count
		spell_list = priest_discipline_spells
	elseif class == "PRIEST" and Spec == "HOLY" then
		spell_count = priest_holy_spells_count
		spell_list = priest_holy_spells
	elseif class == "PRIEST" and Spec == "SHADOW" then
		spell_count = priest_shadow_spells_count
		spell_list = priest_shadow_spells
	elseif class == "ROGUE" and Spec == "ASSASSINATION" then
		spell_count = rogue_assassination_spells_count
		spell_list = rogue_assassination_spells
	elseif class == "ROGUE" and Spec == "COMBAT" then
		spell_count = rogue_combat_spells_count
		spell_list = rogue_combat_spells
	elseif class == "ROGUE" and Spec == "SUBTLETY" then
		spell_count = rogue_subtlety_spells_count
		spell_list = rogue_subtlety_spells
	elseif class == "SHAMAN" and Spec == "ELEMENTAL" then
		spell_count = shaman_elemental_spells_count
		spell_list = shaman_elemental_spells
	elseif class == "SHAMAN" and Spec == "ENHANCEMENT" then
		spell_count = shaman_enhancement_spells_count
		spell_list = shaman_enhancement_spells
	elseif class == "SHAMAN" and Spec == "RESTORATION" then
		spell_count = shaman_restoration_spells_count
		spell_list = shaman_restoration_spells
	elseif class == "WARLOCK" and Spec == "AFFLICTION" then
		spell_count = warlock_affliction_spells_count
		spell_list = warlock_affliction_spells
	elseif class == "WARLOCK" and Spec == "DEMONOLOGY" then
		spell_count = warlock_demonology_spells_count
		spell_list = warlock_demonology_spells
	elseif class == "WARLOCK" and Spec == "DESTRUCTION" then
		spell_count = warlock_destruction_spells_count
		spell_list = warlock_destruction_spells
	elseif class == "WARRIOR" and Spec == "ARMS" then
		spell_count = warrior_arms_spells_count
		spell_list = warrior_arms_spells
	elseif class == "WARRIOR" and Spec == "FURY" then
		spell_count = warrior_fury_spells_count
		spell_list = warrior_fury_spells
	elseif class == "WARRIOR" and Spec == "PROTECTION" then
		spell_count = warrior_protection_spells_count
		spell_list = warrior_protection_spells
	elseif class == "GENERAL" and Spec == "GENERAL" then
		spell_count = general_spells_count
		spell_list = general_spells
	end
return spell_count, spell_list

end

function MyHandlers.SendAmountOfSpells(player, class, Spec)
	--AIO ADDITIONAL CHECK--
	local expectedData = {"string","string"}
	local values = {class,Spec}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--

	local pass_1, pass_2 = GetRightSpellTables(class,Spec)
	sendAmountOfSpells(AIO.Msg(), player, pass_1, pass_2):Send(player)

end

function sendAmountOfSpells(msg, player, spellCount, spellList)

	return msg:Add("sideBar", "GetSpellCount", spellCount, spellList)

end

function sendButtonToChangeSpells(msg, player, i)

	return msg:Add("sideBar", "ChangeLearnButton", i)

end


function MyHandlers.LearnThisSpell(player, got_spell, i,class,spec)

	--AIO ADDITIONAL CHECK--
	local expectedData = {{"number","number","number"},"number","string","string"}
	local values = {got_spell,i,class,spec}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--

	local successful = true
	local player_has_currency = true

	local currency_one = nil
	local currency_two = nil
	local spellID = nil
	local LevelReq = nil

	local countofspells, spells = GetRightSpellTables(class,spec)
	if not(spells) then
		successful = false
	else
	for k,v in pairs(spells) do
		if (v[1] == got_spell[1]) then
		currency_one = v[2]
		currency_two = v[3]
		spellID = v[1]
		LevelReq = v[4]
	end
	end
	end

	if not(spellID) or player:HasSpell(spellID) then
		successful = false
	end

	if (LevelReq > player:GetLevel()) then
		successful = false
	end
	
	if currency_one ~= 0 then
		if player:HasItem(spell_essence, currency_one) == false then
			player_has_currency = false
			successful = false
		end
	end
	
	if currency_two ~= 0 then
		if player:HasItem(talent_essence, currency_two) == false then
			player_has_currency = false
			successful = false
		end
	end
	
	if player_has_currency == true and currency_one ~= 0 then
		player:RemoveItem(spell_essence, currency_one)
	end
	
	if player_has_currency == true and currency_two ~= 0 then
		player:RemoveItem(talent_essence, currency_two)
	end
	
	if successful == true then
		player:CastSpell(player, 966006)
		player:LearnSpell(spellID)
		--player:SaveToDB()
	end
	
	if successful == false then
		player:SendBroadcastMessage("You do not have the required currency!")
		
	else
		sendButtonToChangeSpells(AIO.Msg(), player, i):Send(player)
	end
	
end


--unlearn this spell part--
function sendButtonToChangeSpellsBack(msg, player, i,spellID,currency_one,currency_two)
	return msg:Add("sideBar", "ChangeLearnButtonBack", i,spellID,currency_one,currency_two)

end

function MyHandlers.UnLearnThisSpell(player, got_spell, i,class,spec)

	--AIO ADDITIONAL CHECK--
	local expectedData = {"number","number","string","string"}
	local values = {got_spell,i,class,spec}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--

	local successful = true

	local currency_one = nil
	local currency_two = nil
	local spellID = nil
	local LevelReq = nil
	local spell = nil

	local countofspells, spells = GetRightSpellTables(class,spec)
	for k,v in pairs(spells) do
		if (v[1] == got_spell) then
		currency_one = v[2]
		currency_two = v[3]
		spellID = v[1]
		LevelReq = v[4]
	end
	end

	if (not(spellID)) or (LevelReq > player:GetLevel()) or (not(player:HasItem(scrollitem))) or (not(player:HasSpell(spellID))) then
		successful = false
	end
	
	if successful == false then
		player:SendBroadcastMessage("You can't unlearn this spell!")
		
	else
		player:RemoveItem(scrollitem,1)
		player:RemoveSpell(spellID)
		if (currency_one) then
		player:AddItem( spell_essence, currency_one )
		end
		if (currency_two) then
		player:AddItem( talent_essence, currency_two )
	end
		sendButtonToChangeSpellsBack(AIO.Msg(), player, i,spellID, currency_one, currency_two):Send(player)
	end
	
end
--end of unlearn this spell part--
function MyHandlers.GetAllBGs(player, ClassSpec)

	--AIO ADDITIONAL CHECK--
	local expectedData = {"string"}
	local values = {ClassSpec}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	--MAIN ACTION--

	local bgList = {druid_balance_bgs, druid_feral_bgs, druid_restoration_bgs,
	hunter_beastmastery_bgs, hunter_marksmanship_bgs, hunter_survival_bgs,
	mage_arcane_bgs, mage_fire_bgs, mage_frost_bgs,
	paladin_holy_bgs, paladin_protection_bgs, paladin_retribution_bgs,
	priest_discipline_bgs, priest_holy_bgs, priest_shadow_bgs,
	rogue_assassination_bgs, rogue_combat_bgs, rogue_subtlety_bgs,
	shaman_elemental_bgs, shaman_enhancement_bgs, shaman_restoration_bgs,
	warlock_affliction_bgs, warlock_demonology_bgs, warlock_destruction_bgs,
	warrior_arms_bgs, warrior_fury_bgs, warrior_protection_bgs}
	
	local talentList = {}
	local tabIndex = 0
	
	local ClassSpecList = {"DRUIDBALANCE", "DRUIDFERAL", "DRUIDRESTORATION",
						   "HUNTERBEASTMASTERY", "HUNTERMARKSMANSHIP", "HUNTERSURVIVAL",
						   "MAGEARCANE", "MAGEFIRE", "MAGEFROST",
						   "PALADINHOLY", "PALADINPROTECTION", "PALADINRETRIBUTION",
						   "PRIESTDISCIPLINE", "PRIESTHOLY", "PRIESTSHADOW",
						   "ROGUEASSASSINATION", "ROGUECOMBAT", "ROGUESUBTLETY",
						   "SHAMANELEMENTAL", "SHAMANENHANCEMENT", "SHAMANRESTORATION",
						   "WARLOCKAFFLICTION", "WARLOCK", "DEMONOLOGY", "WARLOCKDESTRUCTION",
						   "WARRIORARMS", "WARRIORFURY", "WARRIORPROTECTION"}
			
	local ListOfTalentLists = {druid_balance_talents, druid_feral_talents, druid_restoration_talents,
							   hunter_beastmastery_talents, hunter_marksmanship_talents, hunter_survival_talents,
							   mage_arcane_talents, mage_fire_talents, mage_frost_talents,
							   paladin_holy_talents, paladin_protection_talents, paladin_retribution_talents,
							   priest_discipline_talents, priest_holy_talents, priest_shadow_talents,
							   rogue_assassination_talents, rogue_combat_talents, rogue_subtlety_talents,
							   shaman_elemental_talents, shaman_enhancement_talents, shaman_restoration_talents,
							   warlock_affliction_talents, warlock_demonology_talents, warlock_destruction_talents,
							   warrior_arms_talents, warrior_fury_talents, warrior_protection_talents}
	local ListOfTabIndexes = {druid_balance_talents_tab, druid_feral_talents_tab, druid_restoration_talents_tab,
							   hunter_beastmastery_talents_tab, hunter_marksmanship_talents_tab, hunter_survival_talents_tab,
							   mage_arcane_talents_tab, mage_fire_talents_tab, mage_frost_talents_tab,
							   paladin_holy_talents_tab, paladin_protection_talents_tab, paladin_retribution_talents_tab,
							   priest_discipline_talents_tab, priest_holy_talents_tab, priest_shadow_talents_tab,
							   rogue_assassination_talents_tab, rogue_combat_talents_tab, rogue_subtlety_talents_tab,
							   shaman_elemental_talents_tab, shaman_enhancement_talents_tab, shaman_restoration_talents_tab,
							   warlock_affliction_talents_tab, warlock_demonology_talents_tab, warlock_destruction_talents_tab,
							   warrior_arms_talents_tab, warrior_fury_talents_tab, warrior_protection_talents_tab}
							   
	for i,v in ipairs(ClassSpecList) do
		if ClassSpec == v then
			talentList = ListOfTalentLists[i]
			tabIndex = ListOfTabIndexes[i]
		end
	end
	
	local known_talents_list = {}

	for i,v in ipairs(talentList) do
		local spellids = v[2]
		local know_a_spell = false
		
		for p,t in ipairs(spellids) do
			if player:HasSpell(t) == true then
				know_a_spell = p
			end
		end
		
		table.insert(known_talents_list, know_a_spell)
		
	end
	
	sendBGListToPlayer(AIO.Msg(), player, ClassSpec, bgList, talentList, known_talents_list, tabIndex):Send(player)

end


function sendBGListToPlayer(msg, player, ClassSpec, bgList, talentList, known_talents_list, tabIndex)

	return msg:Add("sideBar", "SetBackgroundImages", ClassSpec, bgList, talentList, known_talents_list, tabIndex)

end


function MyHandlers.LearnThisTalent(player, attached_talent, indexAt,ClassSpec)
	--AIO ADDITIONAL CHECK--
	local expectedData = {{"number","number","number",{},"number"},"number","string"}
	local values = {attached_talent,indexAt,ClassSpec}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	for k,v in pairs(attached_talent[4]) do
		expectedData = {"number"}
		values = {v}
	if not(DataTypeCheck(expectedData, values)) then
		return false
	end
	end
	--MAIN ACTION--

	local talentList = nil
	local successful = true
	local player_has_currency = true
	local currency_one = nil
	local currency_two = nil
	local spellID = nil
	local LevelReq = nil
	--preventing any spell learn hack--
	--HACKFIX, VERY FUCKING HACK FIX OF HACK--
		local ClassSpecList = {"DRUIDBALANCE", "DRUIDFERAL", "DRUIDRESTORATION",
						   "HUNTERBEASTMASTERY", "HUNTERMARKSMANSHIP", "HUNTERSURVIVAL",
						   "MAGEARCANE", "MAGEFIRE", "MAGEFROST",
						   "PALADINHOLY", "PALADINPROTECTION", "PALADINRETRIBUTION",
						   "PRIESTDISCIPLINE", "PRIESTHOLY", "PRIESTSHADOW",
						   "ROGUEASSASSINATION", "ROGUECOMBAT", "ROGUESUBTLETY",
						   "SHAMANELEMENTAL", "SHAMANENHANCEMENT", "SHAMANRESTORATION",
						   "WARLOCKAFFLICTION", "WARLOCK", "DEMONOLOGY", "WARLOCKDESTRUCTION",
						   "WARRIORARMS", "WARRIORFURY", "WARRIORPROTECTION"}
			
	local ListOfTalentLists = {druid_balance_talents, druid_feral_talents, druid_restoration_talents,
							   hunter_beastmastery_talents, hunter_marksmanship_talents, hunter_survival_talents,
							   mage_arcane_talents, mage_fire_talents, mage_frost_talents,
							   paladin_holy_talents, paladin_protection_talents, paladin_retribution_talents,
							   priest_discipline_talents, priest_holy_talents, priest_shadow_talents,
							   rogue_assassination_talents, rogue_combat_talents, rogue_subtlety_talents,
							   shaman_elemental_talents, shaman_enhancement_talents, shaman_restoration_talents,
							   warlock_affliction_talents, warlock_demonology_talents, warlock_destruction_talents,
							   warrior_arms_talents, warrior_fury_talents, warrior_protection_talents}
	------------------------------------------
		for i,v in ipairs(ClassSpecList) do
		if ClassSpec == v then
			talentList = ListOfTalentLists[i]
		end
		end
		for i,v in ipairs(talentList) do -- getting costs and id
		local spellids = v[2]
			for k,s in pairs(spellids) do
				if (attached_talent[1] == s) then
					spellID = s
			currency_one = v[3]
			currency_two = v[4]
			LevelReq = v[5]
				end
			end -- check for spellid

		end
	
	if not(spellID) or player:HasSpell(spellID) or not(talentList) then
		successful = false
	end

	if (LevelReq > player:GetLevel()) then
		successful = false
	end -- end of hackfix
	
	if currency_one ~= 0 then
		if player:HasItem(spell_essence, currency_one) == false then
			player_has_currency = false
			successful = false
		end
	end
	
	if currency_two ~= 0 then
		if player:HasItem(talent_essence, currency_two) == false then
			player_has_currency = false
			successful = false
		end
	end
	
	if player_has_currency == true and currency_one ~= 0 then
		player:RemoveItem(spell_essence, currency_one)
	end
	
	if player_has_currency == true and currency_two ~= 0 then
		player:RemoveItem(talent_essence, currency_two)
	end
	
	if successful == true then
		player:CastSpell(player, 966006)
		player:LearnSpell(spellID)
		--player:SaveToDB()
	end
	
	if successful == false then
		player:SendBroadcastMessage("You do not have the required currency!")
		SendGoBackTalent(AIO.Msg(), player, attached_talent, indexAt):Send(player)
		
	else
		sendUpdatedTalent(AIO.Msg(), player, attached_talent, indexAt):Send(player)
	end
	
end

function sendUpdatedTalent(msg, player, attached_talent, indexAt)

	return msg:Add("sideBar", "UpdateTalent", attached_talent, indexAt)

end

function SendGoBackTalent(msg, player, attached_talent, indexAt)
	return msg:Add("sideBar", "TalentGoBack", attached_talent, indexAt)
end

   --talent unlearning part--
function MyHandlers.UnLearnThisTalent(player, attached_talent, indexAt,ClassSpec)
  local talentList = nil
  local successful = true
  local currency_one = nil
  local currency_two = nil
  local spellID = nil
  local LevelReq = nil
  local TalentRank = nil
  local talents_ranks = nil
  local spellIDOriginal = nil
  --preventing any spell learn hack--
  --HACKFIX, VERY FUCKING HACK FIX OF HACK--
    local ClassSpecList = {"DRUIDBALANCE", "DRUIDFERAL", "DRUIDRESTORATION",
               "HUNTERBEASTMASTERY", "HUNTERMARKSMANSHIP", "HUNTERSURVIVAL",
               "MAGEARCANE", "MAGEFIRE", "MAGEFROST",
               "PALADINHOLY", "PALADINPROTECTION", "PALADINRETRIBUTION",
               "PRIESTDISCIPLINE", "PRIESTHOLY", "PRIESTSHADOW",
               "ROGUEASSASSINATION", "ROGUECOMBAT", "ROGUESUBTLETY",
               "SHAMANELEMENTAL", "SHAMANENHANCEMENT", "SHAMANRESTORATION",
               "WARLOCKAFFLICTION", "WARLOCK", "DEMONOLOGY", "WARLOCKDESTRUCTION",
               "WARRIORARMS", "WARRIORFURY", "WARRIORPROTECTION"}
      
  local ListOfTalentLists = {druid_balance_talents, druid_feral_talents, druid_restoration_talents,
                 hunter_beastmastery_talents, hunter_marksmanship_talents, hunter_survival_talents,
                 mage_arcane_talents, mage_fire_talents, mage_frost_talents,
                 paladin_holy_talents, paladin_protection_talents, paladin_retribution_talents,
                 priest_discipline_talents, priest_holy_talents, priest_shadow_talents,
                 rogue_assassination_talents, rogue_combat_talents, rogue_subtlety_talents,
                 shaman_elemental_talents, shaman_enhancement_talents, shaman_restoration_talents,
                 warlock_affliction_talents, warlock_demonology_talents, warlock_destruction_talents,
                 warrior_arms_talents, warrior_fury_talents, warrior_protection_talents}
  ------------------------------------------
    for i,v in ipairs(ClassSpecList) do
    if ClassSpec == v then
      talentList = ListOfTalentLists[i]
    end
    end
    for i,v in ipairs(talentList) do -- getting costs and id
    local spellids = v[2]
      for k,s in pairs(spellids) do
        if (attached_talent == s) then
          spellID = s
          spellIDOriginal = spellids
          currency_one = v[3]
          currency_two = v[4]
          LevelReq = v[5]
          TalentRank = k
          talents_ranks = talentList[i][1]
        end
      end -- check for spellid

    end
  
  if (not(spellID)) or (LevelReq > player:GetLevel()) or (not(player:HasSpell(spellID))) then
    successful = false
  end
  
  if successful == false then
    player:SendBroadcastMessage("You can't unlearn this talent!")
    
  else
    for k,v in pairs(spellIDOriginal) do
    player:RemoveSpell(v)
  end
    if (currency_one) then
    player:AddItem( spell_essence, currency_one*TalentRank)
    end
    if (currency_two) then
    player:AddItem( talent_essence, currency_two*TalentRank)
  end
    attached_talent = {spellIDOriginal[1],currency_one, currency_two,spellIDOriginal,talents_ranks}
    sendUnlearnedTalent(AIO.Msg(), player, attached_talent, indexAt):Send(player)
  end
  
end

function sendUnlearnedTalent(msg, player, attached_talent, indexAt)

  return msg:Add("sideBar", "UnLearnTalent", attached_talent, indexAt)

end
--end of the talent unlearning part--