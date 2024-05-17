function MassPurgeCheck(event, player)

	local player_guid = player:GetGUIDLow()

    local player_query_check = CharDBQuery("SELECT guid FROM purge_players WHERE guid = "..player_guid)
	
	if player_query_check == nil then
		player:SendBroadcastMessage("Performing character purge")
		
		
		-- ############ Removing all spell tomes from player ##########################
		--local all_tomes = WorldDBQuery('SELECT entry FROM item_template WHERE name like "%tome:%"')
		
		--if all_tomes == nil then
			--print("No tomes in the item_template")
		--end
		
		--local current_tome = all_tomes:GetInt32(0)
		
		--while player:HasItem(current_tome,1,true) == true do
			--player:RemoveItem(current_tome, 1)
		--end
		
		--local bool_nextRow = all_tomes:NextRow()
		
		--if bool_nextRow == true then
			--while bool_nextRow == true do
				
				--current_tome = all_tomes:GetInt32(0)
				
				--while player:HasItem(current_tome, 1, true) == true do
					--player:RemoveItem(current_tome, 1)
				--end
				--bool_nextRow = all_tomes:NextRow()
			--end
		--end
		
		
		-- #################### removing all spells from player ######################################
		local all_spell_lists = {druid_balance_spells, druid_feral_spells, druid_restoration_spells,
							   hunter_beastmastery_spells, hunter_marksmanship_spells, hunter_survival_spells,
							   mage_arcane_spells, mage_fire_spells, mage_frost_spells,
							   paladin_holy_spells, paladin_protection_spells, paladin_retribution_spells,
							   priest_discipline_spells, priest_holy_spells, priest_shadow_spells,
							   rogue_assassination_spells, rogue_combat_spells, rogue_subtlety_spells,
							   shaman_elemental_spells, shaman_enhancement_spells, shaman_restoration_spells,
							   warlock_affliction_spells, warlock_demonology_spells, warlock_destruction_spells,
							   warrior_arms_spells, warrior_fury_spells, warrior_protection_spells}
		
		--FROM ServerEBB.lua MyHandlers.ResetSpells(player)
		for s, sid in pairs(noTEspells) do -- noTEspells are now only in ServerEBB.lua
				if player:HasSpell(sid) then
					player:RemoveSpell(sid)
				end
			end
		--
		for listloc,spec in ipairs(all_spell_lists) do
			for loc,spell in ipairs(spec) do
				local spellid = spell[1]
				if player:HasSpell(spellid) == true then
					player:RemoveSpell(spellid)
					if player:HasAura(spellid) == true then
						player:RemoveAura(spellid)
					end
				end
			end
		end
		
		-- ############ Removing all talents from player ##############################################
		local all_talent_lists = {druid_balance_talents, druid_feral_talents, druid_restoration_talents,
							   hunter_beastmastery_talents, hunter_marksmanship_talents, hunter_survival_talents,
							   mage_arcane_talents, mage_fire_talents, mage_frost_talents,
							   paladin_holy_talents, paladin_protection_talents, paladin_retribution_talents,
							   priest_discipline_talents, priest_holy_talents, priest_shadow_talents,
							   rogue_assassination_talents, rogue_combat_talents, rogue_subtlety_talents,
							   shaman_elemental_talents, shaman_enhancement_talents, shaman_restoration_talents,
							   warlock_affliction_talents, warlock_demonology_talents, warlock_destruction_talents,
							   warrior_arms_talents, warrior_fury_talents, warrior_protection_talents}
							   
		for i,v in ipairs(all_talent_lists) do
			for listloc,talent in ipairs(v) do
				for slot,spellid in ipairs(talent[2]) do
					if player:HasSpell(spellid) == true then
						player:RemoveSpell(spellid)
						if player:HasAura(spellid) == true then
							player:RemoveAura(spellid)
						end
					end
				end
			end	
		end
		
		-- ############ adding appropriate amount of essences based on level ##########################
		local AE_count = player:GetItemCount(spell_essence, true)
		local TE_count = player:GetItemCount(talent_essence, true)
		local player_level = player:GetLevel()
		
		local AE_add_amount = player_level - AE_count
		local TE_add_amount = (player_level - 9) - TE_count
		
		if AE_add_amount < 0 then
			player:RemoveItem(spell_essence, -AE_add_amount)
		elseif AE_add_amount > 0 then
			player:AddItem(spell_essence, AE_add_amount)
		end
		
		if TE_add_amount < 0 then
			player:RemoveItem(talent_essence, -TE_add_amount)
		elseif TE_add_amount > 0 then
			player:AddItem(talent_essence, TE_add_amount)
		end
	
		player:SendBroadcastMessage("Purge complete")
		
		
		CharDBExecute("INSERT INTO purge_players(guid) VALUES ("..player_guid..")")
		
	end
	
	
	
end

local function add_player_list(event,player)
	local player_guid = player:GetGUIDLow()
	CharDBExecute("INSERT INTO purge_players(guid) VALUES ("..player_guid..")")

end

RegisterPlayerEvent(3, MassPurgeCheck)
RegisterPlayerEvent(30,add_player_list)

--Purge Command--
local function Asc_Purgeplayer(event, player, msg, Type, lang)
if msg:find("%%purge") then -- main message

local _,_,Type = msg:find("%%purge (%S+)")
	if not(Type) then
		player:SendBroadcastMessage("Syntax: %purge player, %purge all")
		return false
	end



if (player:GetGMRank() ~= 3) then
	if (player:GetGMRank() < 5) then
		player:SendBroadcastMessage("You're not allowed to do this")
		return false
	end
end

if (Type == "player") then

local Target = player:GetPlayerTarget()
if not(Target) then
	player:SendBroadcastMessage("You have to select a target to make a reset")
	return false 
end

if not(Target:ToPlayer()) then
	player:SendBroadcastMessage("Your target have to be a player")
	return false 
	end

CharDBExecute("DELETE FROM purge_players WHERE guid =  "..player:GetGUIDLow()..";")
player:SendBroadcastMessage("Your target kicked from game for relog. Purge is done")
Target:KickPlayer()

elseif (Type == "all") then
CharDBExecute("DELETE FROM purge_players;")
player:SendBroadcastMessage("You just purged everyone, make a restart to see the changes")
end

end
end

	RegisterPlayerEvent(18,Asc_Purgeplayer)