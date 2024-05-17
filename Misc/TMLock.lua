local function TMLock1(event, player) -- prevent using spells by gms rank 2
	if (player:GetGMRank() < 2) or (player:GetGMRank() > 3) then
		return false
	else
		--player:AddAura(6462, player)
		--player:AddAura(42201, player)
		player:SetFlag(150,0x00800000)
	end
end

local function TMLock2(event, player, newZone, newArea) -- Teleport rank2 gms to gmisland
	if (player:GetGMRank() ~= 2) then
		return false
	elseif (player:GetZoneId() == 876) then
		return false
	else
		player:Teleport(1, 16225.9, 16255, 13.0438, 4.35969)
	end
end

local function TMLock3(eventId, delay, repeats, player)
		--player:AddAura(6462, player)
		--player:AddAura(42201, player)
		--player:SetFlag(150,0x00800000)
		if (player:IsGMVisible()) then
		player:SetGMVisible(false)
		player:AddAura(37800, player)
	end
end

RegisterPlayerEvent(27, TMLock2) -- zonechange event
RegisterPlayerEvent(3, TMLock1) -- onlogin event

local function TimingChecks_GM(event,player) -- rank 3 .gm vis off all the time
	if (player:GetGMRank() ~= 3) then
		return false
	end
	player:RegisterEvent(TMLock3, 2000, 0)
end
RegisterPlayerEvent(28, TimingChecks_GM)
--RegisterPlayerEvent(3, TimingChecks_GM)