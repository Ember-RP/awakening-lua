local AIO = AIO or require("AIO")

local SlotIsuranceServer = AIO.AddHandlers("SlotIsurance", {})
--!NOTE: SERVERSIDE SLOTS STARTS FROM 0, NOT FROM 1.
--!SO HEAD AND OTHER SLOTS HAVE SLOTNUMBER-1

--Slot table Structure:
--PLAYERGUID, head, neck, shoulder etc (0 or 1)
local InsureCurrency = 98461

--[[
SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for custom_iteminsurance
-- ----------------------------
DROP TABLE IF EXISTS `custom_iteminsurance`;
CREATE TABLE `custom_iteminsurance` (
  `playerguid` int(30) NOT NULL DEFAULT '0',
  `slot0` int(1) NOT NULL DEFAULT '0',
  `slot1` int(1) NOT NULL DEFAULT '0',
  `slot2` int(1) NOT NULL DEFAULT '0',
  `slot3` int(1) NOT NULL DEFAULT '0',
  `slot4` int(1) NOT NULL DEFAULT '0',
  `slot5` int(1) NOT NULL DEFAULT '0',
  `slot6` int(1) NOT NULL DEFAULT '0',
  `slot7` int(1) NOT NULL DEFAULT '0',
  `slot8` int(1) NOT NULL DEFAULT '0',
  `slot9` int(1) NOT NULL DEFAULT '0',
  `slot10` int(1) NOT NULL DEFAULT '0',
  `slot11` int(1) NOT NULL DEFAULT '0',
  `slot12` int(1) NOT NULL DEFAULT '0',
  `slot13` int(1) NOT NULL DEFAULT '0',
  `slot14` int(1) NOT NULL DEFAULT '0',
  `slot15` int(1) NOT NULL DEFAULT '0',
  `slot16` int(1) NOT NULL DEFAULT '0',
  `slot17` int(1) NOT NULL DEFAULT '0',
  `slot18` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`playerguid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
]]--

function SlotIsuranceServer.GetSlotList(player)
    if not(GreedyDemonCheck(player)) then
      return false
    end

   local Slots = { -- Empty ARRAY
    [1] = {"Head", "SafeSlot1", false},
    [2] = {"Neck", "SafeSlot2", false},
    [3] = {"Shoulder", "SafeSlot3", false},
    [4] = {"Body", "SafeSlot6", false},
    [5] = {"Chest", "SafeSlot5", false},
    [6] = {"Waist", "SafeSlot10", false},
    [7] = {"Legs", "SafeSlot11", false},
    [8] = {"Feet", "SafeSlot12", false},
    [9] = {"Wrist", "SafeSlot8", false},
    [10] = {"Hand", "SafeSlot9", false},
    [11] = {"Finger", "SafeSlot13", false},
    [12] = {"Finger", "SafeSlot14", false},
    [13] = {"Trinket", "SafeSlot15", false},
    [14] = {"Trinket", "SafeSlot16", false},
    [15] = {"Back", "SafeSlot4", false},
    [16] = {"Main Hand", "SafeSlot17", false},
    [17] = {"Off Hand", "SafeSlot18", false},
    [18] = {"Ranged", "SafeSlot19", false},
    [19] = {"Tabard", "SafeSlot7", false},
                }

    local SlotlistSQL = CharDBQuery("SELECT slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, slot13, slot14, slot15, slot16, slot17, slot18 FROM custom_iteminsurance WHERE playerguid = "..player:GetGUIDLow()..";")
    
    if (SlotlistSQL) then
        for i = 0, 18 do
            if (SlotlistSQL:GetInt32(i) == 1) then
                Slots[i+1][3] = true
            end
        end
    end
    SafeSlots_SendList(AIO.Msg(), player,Slots):Send(player)
    end

 function SafeSlots_SendList(msg,player,SlotList)
    return msg:Add("SlotIsurance", "SafeSlots_GetList", SlotList)
end

function SlotIsuranceServer.InsureSlot(player,slot)
    --AIO ADDITIONAL CHECK--
    local expectedData = {"number"}
    local values = {slot}
    if not(DataTypeCheck(expectedData, values)) then
        return false
    end
    --MAIN ACTION--
    if not(GreedyDemonCheck(player)) then
      return false
    end

    slot = slot - 1 
    if (player:GetItemCount(InsureCurrency) < 1) then
        player:SendBroadcastMessage("You don't have enough Demon's Tears to do that!")
        return false
    end

    local SlotSQL = CharDBQuery("SELECT slot"..slot.." FROM custom_iteminsurance WHERE playerguid = "..player:GetGUIDLow()..";")
    if (SlotSQL and (SlotSQL:GetInt32(0) == 1)) then
        player:SendBroadcastMessage("You have already insured that slot")
        return false
    end

    player:RemoveItem(InsureCurrency, 1)

    if (SlotSQL) then
        CharDBExecute("UPDATE custom_iteminsurance SET slot"..slot.." = 1 WHERE playerguid = "..player:GetGUIDLow()..";")
    else
        CharDBExecute("INSERT IGNORE INTO custom_iteminsurance (playerguid, slot"..slot..") VALUES ("..player:GetGUIDLow()..", 1);")
    end

    --SlotIsuranceServer.GetSlotList(player)
    end

function SlotIsuranceServer.UnInsureSlot(player,slot)
    --AIO ADDITIONAL CHECK--
    local expectedData = {"number"}
    local values = {slot}
    if not(DataTypeCheck(expectedData, values)) then
        return false
    end
    --MAIN ACTION--
    if not(GreedyDemonCheck(player)) then
      return false
    end

    slot = slot - 1 
    local SlotSQL = CharDBQuery("SELECT slot"..slot.." FROM custom_iteminsurance WHERE playerguid = "..player:GetGUIDLow()..";")

    if not(SlotSQL) then
        return false
    end

    if (SlotSQL:GetInt32(0) == 0) then
        player:SendBroadcastMessage("You have already removed insurance from that slot")
        return false
    end

    CharDBExecute("UPDATE custom_iteminsurance SET slot"..slot.." = 0 WHERE playerguid = "..player:GetGUIDLow()..";")
    player:AddItem(InsureCurrency)
    --SlotIsuranceServer.GetSlotList(player)
end


--GOSSIP PART
local GreedyDemon = 75120
local GreedyDemon_menu = 45004

   function SafeSlots_CloseMenu(msg,player)
  return msg:Add("SlotIsurance", "SafeSlots_Close")
end

   function SafeSlots_OpenMenu(msg,player)
  return msg:Add("SlotIsurance", "SafeSlots_Init")
end

local function OnGossipHello_GreedyDemon(event, player, Demon)
player:GossipClearMenu()
if (Demon:GetOwner() == player) then
SafeSlots_OpenMenu(AIO.Msg(), player):Send(player)
end
player:GossipSendMenu(1, Demon, GreedyDemon_menu) 
player:GossipComplete()
end
RegisterCreatureGossipEvent(GreedyDemon, 1, OnGossipHello_GreedyDemon)

 function GreedyDemonCheck(player)
  local Demon = nil
  Demon = player:GetNearestCreature(3, GreedyDemon)
  if (Demon) and (Demon:GetOwner() == player) then
    return true
  end
  SafeSlots_CloseMenu(AIO.Msg(), player):Send(player)
  return false
  end

local function PlayerIsFar(event, creature, unit)
  for k,player in pairs(creature:GetPlayersInRange(20)) do
    GreedyDemonCheck(player)
  end
end
 RegisterCreatureEvent(GreedyDemon, 27, PlayerIsFar)