local function TaxiCheatScroll(event, player, item, target)
	player:SetTaxiCheat(true)
	player:SendNotification("|cffFF6600 You're now free to choose any flight path you want! |r")
	player:CastSpell(player, 51908, false)
	--player:RemoveAura(70571)
	if not(CharDBQuery("SELECT guid FROM custom_taxicheat WHERE guid = "..player:GetGUIDLow()..";")) then
		CharDBExecute("INSERT INTO custom_taxicheat VALUES ("..player:GetGUIDLow()..");")
	end
end

RegisterItemEvent(977025, 2, TaxiCheatScroll)

RegisterPlayerEvent(3, function(event,player)
	if CharDBQuery("SELECT guid FROM custom_taxicheat WHERE guid = "..player:GetGUIDLow()..";") then
		player:SetTaxiCheat(true)
	end
	end)