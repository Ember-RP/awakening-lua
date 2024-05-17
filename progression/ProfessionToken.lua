local ITEM_ID = 777998
local maxSkill = 300

local alchemy = 171
local bs = 164
local ench = 333
local eng = 202
local insc = 773
local jc = 755
local lw = 165
local tail = 197

local herb = 182
local mining = 186
local skin = 393

local cook = 185
local aid = 129
local fish = 356


function ProfessionToken_Gossip(event, plr, item)
if (plr:IsInCombat() == false) then
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/Trade_Alchemy:45:45:-25:1|t|rAlchemy", 0, 101, false, "Are you sure you want to choose Alchemy ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/Trade_Blacksmithing:45:45:-25:1|t|rBlacksmithing", 0, 102, false, "Are you sure you want to choose Blacksmithing ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/Trade_Engraving:45:45:-25:1|t|rEnchanting", 0, 103, false, "Are you sure you want to choose Enchanting ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/Trade_Engineering:45:45:-25:1|t|rEngineering", 0, 104, false, "Are you sure you want to choose Engineering ?")
	--plr:GossipMenuAddItem(0, "|TInterface/ICONS/inv_inscription_tradeskill01:45:45:-25:1|t|rInscription", 0, 105, false, "Are you sure you want to choose Inscription ?")
	--plr:GossipMenuAddItem(0, "|TInterface/ICONS/inv_misc_gem_01:45:45:-25:1|t|rJewelcrafting", 0, 106, false, "Are you sure you want to choose Jewelcrafting ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/inv_misc_armorkit_17:45:45:-25:1|t|rLeatherworking", 0, 107, false, "Are you sure you want to choose Leatherworking ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/Trade_Tailoring:45:45:-25:1w|t|rTailoring", 0, 108, false, "Are you sure you want to choose Tailoring ?")
	plr:GossipMenuAddItem(0, " ", 0, 100, 0)
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/spell_nature_naturetouchgrow:45:45:-25:1w|t|rHerbalism", 0, 111, false, "Are you sure you want to choose Herbalism ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/trade_mining:45:45:-25:1w|t|rMining", 0, 112, false, "Are you sure you want to choose Mining ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/inv_misc_pelt_wolf_01:45:45:-25:1w|t|rSkining", 0, 113, false, "Are you sure you want to choose Skining ?")
	plr:GossipMenuAddItem(0, " ", 0, 100, 0)
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/inv_misc_food_15:45:45:-25:1w|t|rCooking", 0, 121, false, "Are you sure you want to choose Cooking ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/spell_holy_sealofsacrifice:45:45:-25:1w|t|rFirst Aid", 0, 122, false, "Are you sure you want to choose First Aid ?")
	plr:GossipMenuAddItem(0, "|TInterface/ICONS/trade_fishing:45:45:-25:1w|t|rFishing", 0, 123, false, "Are you sure you want to choose Fishing ?")
	plr:GossipSendMenu(1, item)
	else
	plr:SendBroadcastMessage("You need to be out of combat.")
	end
end

function ProfessionToken_Event(event, plr, item, arg2, intid)
	if (intid > 100) then
	
		if (plr:HasItem(777998) == false) then
			plr:SendBroadcastMessage("You don't have enough tokens to complete this operation.")
		else
			if (intid == 101) then
				if(plr:GetSkillValue(alchemy) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(alchemy, 0, 375, 375)
				plr:LearnSpell(28596)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 102) then
				if(plr:GetSkillValue(bs) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(bs, 0, 375, 375)
				plr:LearnSpell(29844)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 103) then
				if(plr:GetSkillValue(ench) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(ench, 0, 375, 375)
				plr:LearnSpell(28029)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 104) then
				if(plr:GetSkillValue(eng) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(eng, 0, 375, 375)
				plr:LearnSpell(30350)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 105) then
				if(plr:GetSkillValue(insc) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(insc, 0, 375, 375)
				plr:LearnSpell(45361)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 106) then
				if(plr:GetSkillValue(jc) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else
				plr:SetSkill(jc, 0, 375, 375)
				plr:LearnSpell(28897)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 107) then
				if(plr:GetSkillValue(lw) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(lw, 0, 375, 375)
				plr:LearnSpell(32549)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 108) then
				if(plr:GetSkillValue(tail) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(tail, 0, 375, 375)
				plr:LearnSpell(26790)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			
			if (intid == 111) then
				if(plr:GetSkillValue(herb) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(herb, 0, 375, 375)
				plr:LearnSpell(28695)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 112) then
				if(plr:GetSkillValue(mining) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(mining, 0, 375, 375)
				plr:LearnSpell(29354)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 113) then
				if(plr:GetSkillValue(skin) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(skin, 0, 375, 375)
				plr:LearnSpell(32678)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			
			if (intid == 121) then
				if(plr:GetSkillValue(cook) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(cook, 0, 375, 375)
				plr:LearnSpell(33359)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 122) then
				if(plr:GetSkillValue(aid) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(aid, 0, 375, 375)
				plr:LearnSpell(27028)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			if (intid == 123) then
				if(plr:GetSkillValue(fish) == maxSkill) then plr:SendBroadcastMessage("You already maxed out this profession")
				else 
				plr:SetSkill(fish, 0, 375, 375)
				plr:LearnSpell(33095)
				plr:RemoveItem(ITEM_ID, 1)
				end
			end
			plr:GossipComplete()
			
		end
		else
		plr:SendBroadcastMessage("You've clicked on a separator, woops.")
	end
		
end


RegisterItemGossipEvent(ITEM_ID, 1, ProfessionToken_Gossip)
RegisterItemGossipEvent(ITEM_ID, 2, ProfessionToken_Event)