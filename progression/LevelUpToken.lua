local itemid = 977019

local function gainLevels(event, delay, pCall, player)
	local levelToGive = 1
	local currentLevel = player:GetLevel()
	if (currentLevel < 1) then
		local newLevel = levelToGive + currentLevel
		player:GiveLevel(newLevel)
	end
end

local function fixTalents(event, delay, pCall, player)
	player:ResetTalents()
end

local function maxLevel(event, delay, pCall, player)
	player:SetLevel(60)
	player:AddItem(978021)
	player:AdvanceAllSkills(300)
	player:AdvanceSkill(176, 300)
	player:RegisterEvent(fixTalents, 500, 1, player)
end

local function LevelUpOnUse (event, player, item, target)
	if (player:HasItem(itemid) == true) then
		player:RemoveItem(itemid, 1)
		local AP = 59 - player:GetLevel()
		local TE = 59 - player:GetLevel()
		player:AddItem(383080, AP)
		if (player:GetLevel() >= 1 and player:GetLevel() <= 9) then
			player:AddItem(383081, 51)
		else
			player:AddItem(383081, TE)
		end
		player:RegisterEvent(gainLevels, 500, 5, player)
		player:RegisterEvent(maxLevel, 3000, 1, player)
		
	--else
	--	player:SendAreaTriggerMessage("|cffff0000You must be level 1!|r")
		--player:LogoutPlayer()
	end
end

RegisterItemEvent(itemid, 2, LevelUpOnUse)