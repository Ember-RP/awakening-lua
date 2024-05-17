local cityDictionary = {[1637] = true, [1638] = true, [1497] = true, [3487] = true, [1519] = true, [1537] = true, [1657] = true, [3557] = true }

local function killedPlayer(event, killer, killed)
	if (killer == killed) then
     		return false
	end
	thisArea = killer:GetAreaId()
	if (cityDictionary[thisArea] == true) then
		killer:AddItem(880000, 1)
	end
end

RegisterPlayerEvent(6, killedPlayer)