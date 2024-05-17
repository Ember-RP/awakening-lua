--[[LIST OF FUNCTIONS WE HAVE client->Server for this protection to be enabled.
TheClassMaskingSolution/TooltipCorrectorServer.lua
tTHandler.HasSpellID(player, spellid) -- done
tTHandler.CostGrabber(player, spellid) -- done

EnchantReRoll/EnchantReRollS.lua
MyHandlers.ReforgeItem(player,bag,slot) -- done
MyHandlers.ReforgeItem_Prep(player,bag,slot) -- done
MyHandlers.SetItem(player,bag,slot) -- done

extra_buttons_bar/ServerEBB.lua
MyHandlers.AddStats(player, stat, s_amount) -- done
MyHandlers.ReduceStats(player, stat, s_amount) -- done
MyHandlers.SendAmountOfSpells(player, class, Spec) -- done
MyHandlers.GetAllBGs(player, ClassSpec) -- done
MyHandlers.LearnThisTalent(player, attached_talent, indexAt,ClassSpec) -- done
MyHandlers.UnLearnThisTalent(player, attached_talent, indexAt,ClassSpec)
MyHandlers.LearnThisSpell(player, got_spell, i,class,spec) -- done
MyHandlers.UnLearnThisSpell(player, got_spell, i,class,spec) -- done

hardcore_pvp/PvPServer.lua
MyHandlers.AddPlayerItem(player, itemEntry, itemCount, object) -- done
]]--
local valid_types = {
    ["nil"] = true,
    ["number"] = true,
    ["string"] = true,
    ["boolean"] = true,
    ["table"] = true,
    ["function"] = true,
    ["thread"] = true,
    ["userdata"] = true,
}
 function DataTypeCheck(fmt, args)
    for k, expected in pairs(fmt) do
        local exp_type = type(expected)
        if exp_type == "string" then
            assert(valid_types[expected], "invalid type in fmt: "..tostring(expected))
            local typ = type(args[k])
            if typ ~= expected then
                return false, string.format("%s was of type %s, %s expected", tostring(k), typ, expected)
            end
        elseif exp_type == "table" then
            local typ = type(args[k])
            if typ ~= exp_type then
                return false, string.format("%s was of type %s, %s expected", tostring(k), typ, exp_type)
            end
            local succ, err = DataTypeCheck(expected, args[k])
            if not succ then
                return succ, err
            end
        else
            error("unknown expecatation in fmt: "..tostring(expected))
        end
    end
    return true
end
 
 
--[[some example usage
local fmt = {"number", "string", {}, {"number", "string", ke = {}}}
local arg = {1, "asd", {}, {1,"str", ke = {}}}
print(DataTypeCheck(fmt, arg))]]--