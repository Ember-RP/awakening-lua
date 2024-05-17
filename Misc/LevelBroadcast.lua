local function OnLevel(event, player, oldLevel)
if (player:GetLevel() == 10) then
   player:SendBroadcastMessage("You can now pick your first talents!")
elseif (player:GetLevel() == 2) then
   player:SendBroadcastMessage("You can now pick your first ability in the Character Advancement page.")
  end
end
RegisterPlayerEvent(13, OnLevel)