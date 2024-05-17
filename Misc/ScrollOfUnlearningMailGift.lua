local Gift_Text = "Your feats in Azeroth will never be forgotten. We hope that this humble reward will help you along your way!"
local Gift_Subject = "To the Great Hero of Azeroth!"
local function ScrollGift(event, player, oldLevel)
	if ((oldLevel+1)%10 == 0) then
		SendMail( Gift_Subject, Gift_Text, player:GetGUIDLow(), 0, 61, 0, 0, 0, 1101243, 1)
	end
end

RegisterPlayerEvent(13, ScrollGift)