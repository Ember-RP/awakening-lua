local AIO = AIO or require("AIO")


local TutAIO = AIO.AddHandlers("TutAIO", {})

local function TutorialStuff_SendHelp(event, player, oldLevel)

if (oldLevel == 1) then
TutorialAio(AIO.Msg(), player,7,7):Send(player)
elseif (oldLevel == 4) then
TutorialAio(AIO.Msg(), player,8,9):Send(player)
elseif (oldLevel == 9) then
TutorialAio(AIO.Msg(), player,10,12):Send(player)
elseif (oldLevel == 19) then
TutorialAio(AIO.Msg(), player,13,13):Send(player)
end


end


RegisterPlayerEvent(13, TutorialStuff_SendHelp)

RegisterPlayerEvent(30, function(event,player)
	TutorialAio(AIO.Msg(), player,1,6):Send(player)
	end)

function TutorialAio(msg,player,currtip,maxtips)
	return msg:Add("TutAIO", "InitFrame", currtip,maxtips)
end