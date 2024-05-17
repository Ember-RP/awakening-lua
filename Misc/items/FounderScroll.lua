local function Scroll(event, player, item, target)
	player:SetKnownTitle(210)
	player:SendNotification("|cffFF6600 Thanks for becoming a founder! |r")
	player:CastSpell(player, 55420, false)
end

RegisterItemEvent(977020, 2, Scroll)