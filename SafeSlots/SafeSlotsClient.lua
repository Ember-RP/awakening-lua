local AIO = AIO or require("AIO")


if AIO.AddAddon() then
    return
end


local SlotIsuranceClient = AIO.AddHandlers("SlotIsurance", {})

local Slots = {
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
--name, button, is slot currently activated
local InsureCurrency = 98461
local SafeCostModifier = 3540
local function SafeSlotGetLostCost(itemlink)
    local cost = nil
    local _, _, _, iLevel = GetItemInfo(itemlink)
    cost = iLevel * SafeCostModifier
    return cost
end

                                                                                        --MAIN FRAME
local SafeSlots_Main = CreateFrame("FRAME", "SafeSlots_Main", UIParent,nil)
SafeSlots_Main:SetSize(512,512)
SafeSlots_Main:SetPoint("CENTER")

SafeSlots_Main:SetMovable(true)
SafeSlots_Main:EnableMouse(true)
SafeSlots_Main:RegisterForDrag("LeftButton")
SafeSlots_Main:SetClampedToScreen(true)
SafeSlots_Main:SetScript("OnDragStart", SafeSlots_Main.StartMoving)
SafeSlots_Main:SetScript("OnDragStop", SafeSlots_Main.StopMovingOrSizing)
SafeSlots_Main:SetFrameStrata("HIGH")

SafeSlots_Main:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SafeSlots",
    --insets = { left = -256, right = -256, top = -5, bottom = -5}
})

local SafeSlots_Main_CloseButton = CreateFrame("Button", "SafeSlots_Main_CloseButton", SafeSlots_Main, "UIPanelCloseButton")
SafeSlots_Main_CloseButton:SetPoint("TOPRIGHT", -82, -45) 
SafeSlots_Main_CloseButton:EnableMouse(true)
--SafeSlots_Main_CloseButton:SetSize(29, 29) 
SafeSlots_Main_CloseButton:SetScript("OnMouseUp", function()
    PlaySound("TalentScreenOpen")
    SafeSlots_Main:Hide()
    end)
local SafeSlots_Main_TitleText = SafeSlots_Main:CreateFontString("SafeSlots_Main_TitleText")
SafeSlots_Main_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 11)
SafeSlots_Main_TitleText:SetFontObject(GameFontNormal)
SafeSlots_Main_TitleText:SetPoint("TOP", 0, -55)
SafeSlots_Main_TitleText:SetShadowOffset(1,-1)
SafeSlots_Main_TitleText:SetText("Fel Commutation")

SafeSlots_Main:Hide()
                                                                                        --END OF MAIN FRAME

                                                                                        --MAIN FRAME SCRIPTS--

                                                                                        --END OF MAIN FRAME SCRIPTS--

                                                                                        --SLOT BUTTONS--
--loading same settings for all of the slot buttons
for i = 1, 16 do
_G["SafeSlot"..i] = CreateFrame("Button", "SafeSlot"..i, SafeSlots_Main, nil)
_G["SafeSlot"..i]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SlotBorder")
_G["SafeSlot"..i]:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SlotBorder_H")
_G["SafeSlot"..i]:SetSize(54,54)
end
for i = 17, 19 do
_G["SafeSlot"..i] = CreateFrame("Button", "SafeSlot"..i, SafeSlots_Main, nil)
_G["SafeSlot"..i]:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SlotBorder")
_G["SafeSlot"..i]:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SlotBorder_H")
_G["SafeSlot"..i]:SetSize(60,60)
end
--additional button textures
for i = 1, 19 do
_G["SafeSlot"..i.."_GlowTex"] = _G["SafeSlot"..i]:CreateTexture("SafeSlot"..i.."_GlowTex", "OVERLAY") 
_G["SafeSlot"..i.."_GlowTex"]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SlotBorder_active") 
_G["SafeSlot"..i.."_GlowTex"]:SetSize(_G["SafeSlot"..i]:GetSize())
_G["SafeSlot"..i.."_GlowTex"]:SetPoint("CENTER")
_G["SafeSlot"..i.."_GlowTex"]:SetBlendMode("ADD")
_G["SafeSlot"..i.."_GlowTex"]:Hide()
end
--setting up each button properly
SafeSlot1:SetPoint("CENTER", -100, 144)
SafeSlot2:SetPoint("CENTER", -121, 106)
SafeSlot3:SetPoint("CENTER", -134, 64)
SafeSlot4:SetPoint("CENTER", -140, 22)
SafeSlot5:SetPoint("CENTER", -140, -22)
SafeSlot6:SetPoint("CENTER", -134, -64)
SafeSlot7:SetPoint("CENTER", -121, -106)
SafeSlot8:SetPoint("CENTER", -100, -144)

SafeSlot9:SetPoint("CENTER", 103, 144)
SafeSlot10:SetPoint("CENTER", 124, 106)
SafeSlot11:SetPoint("CENTER", 137, 64)
SafeSlot12:SetPoint("CENTER", 143, 22)
SafeSlot13:SetPoint("CENTER", 143, -22)
SafeSlot14:SetPoint("CENTER", 137, -64)
SafeSlot15:SetPoint("CENTER", 124, -106)
SafeSlot16:SetPoint("CENTER", 103, -144)

SafeSlot17:SetPoint("CENTER", -43, -161)
SafeSlot18:SetPoint("CENTER", 3, -161)
SafeSlot19:SetPoint("CENTER", 46, -161)
                                                                                        --END OF SLOT BUTTONS

                                                                                        --SLOT BUTTONS SCRIPTS--
for i = 1, 19 do
    _G["SafeSlot"..i]:SetScript("OnClick", function(self) -- main action
        if not(SafeSlots_Main_Confirm:IsVisible()) then
            SafeSlots_Main_Confirm:Show()
            SafeSlots_Main_Confirm_ItemIcon.slot = self.slot
            elseif (SafeSlots_Main_Confirm_ItemIcon.slot) and SafeSlots_Main_Confirm_ItemIcon.slot == self.slot then
                SafeSlots_Main_Confirm:Hide()
            else
                SafeSlots_Main_Confirm_ItemIcon.slot = self.slot
            end
        end)


    _G["SafeSlot"..i]:SetScript("OnEnter", function(self) -- default tooltip text
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
        GameTooltip:SetText("|cffFFFFFF"..Slots[self.slot][1])
        if not(Slots[self.slot][3]) then
        GameTooltip:AddLine("Click on this slot to insure it")
        end
        GameTooltip:Show()
     end)

    _G["SafeSlot"..i]:SetScript("OnLeave", function(self) -- onleave script
        GameTooltip:Hide()
     end)
end
                                                                                        --END OF SLOT BUTTONS SCRIPTS--

                                                                                        --MODEL OF CHARACTER--
local SafeSlots_Main_PlayerModel = CreateFrame("PlayerModel", "SafeSlots_Main_PlayerModel", SafeSlots_Main)
SafeSlots_Main_PlayerModel:SetWidth(192);       
SafeSlots_Main_PlayerModel:SetHeight(256);
SafeSlots_Main_PlayerModel:SetPoint("CENTER", 0, -22)
SafeSlots_Main_PlayerModel:SetUnit("player")
SafeSlots_Main_PlayerModel:SetModelScale(1)
SafeSlots_Main_PlayerModel:SetPosition(0.0,0.0,0)
SafeSlots_Main_PlayerModel:SetCamera(1)
                                                                                        --END OF THE MODEL OF CHARACTER--

                                                                                        --MODEL OF CHARACTER SCRIPTS--
SafeSlots_Main_PlayerModel:RegisterEvent("UNIT_MODEL_CHANGED")
SafeSlots_Main_PlayerModel:SetScript("OnEvent", function(self,event,arg)
    if arg == "player" then
        self:RefreshUnit()
    end
    end)
                                                                                        --END OF MODEL OF CHARACTER SCRIPTS--

                                                                                        --Confirm Frame--
SafeSlots_Main_Confirm = CreateFrame("FRAME", "SafeSlots_Main_Confirm", SafeSlots_Main,nil)
SafeSlots_Main_Confirm:SetSize(512,512)
SafeSlots_Main_Confirm:SetPoint("CENTER")
SafeSlots_Main_Confirm:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SafeSlots_Window",
    --insets = { left = -256, right = -256, top = -5, bottom = -5}
})
SafeSlots_Main_Confirm:SetFrameStrata("DIALOG")
SafeSlots_Main_Confirm:Hide()

--[[local SafeSlots_Main_Confirm_CloseButton = CreateFrame("Button", "SafeSlots_Main_Confirm_CloseButton", SafeSlots_Main_Confirm, "UIPanelCloseButton")
SafeSlots_Main_Confirm_CloseButton:SetPoint("CENTER", 90, -2) 
SafeSlots_Main_Confirm_CloseButton:EnableMouse(true)
SafeSlots_Main_Confirm_CloseButton:SetSize(25, 25) 
SafeSlots_Main_Confirm_CloseButton:SetScript("OnMouseUp", function()
    PlaySound("TalentScreenOpen")
    SafeSlots_Main_Confirm:Hide()
    end)]]--

-- version of frame if your slot is activated
local SafeSlots_Main_Confirm_UnInsureButton = CreateFrame("Button", "SafeSlots_Main_Confirm_UnInsureButton", SafeSlots_Main_Confirm, "UIPanelButtonTemplate")
SafeSlots_Main_Confirm_UnInsureButton:SetWidth(120) 
SafeSlots_Main_Confirm_UnInsureButton:SetHeight(21) 
SafeSlots_Main_Confirm_UnInsureButton:SetPoint("CENTER", 0,-54) 
SafeSlots_Main_Confirm_UnInsureButton:RegisterForClicks("AnyUp") 
SafeSlots_Main_Confirm_UnInsureButton:SetText("Remove Commutation")


local SafeSlots_Main_Confirm_InsureButton = CreateFrame("Button", "SafeSlots_Main_Confirm_InsureButton", SafeSlots_Main_Confirm, "UIPanelButtonTemplate")
SafeSlots_Main_Confirm_InsureButton:SetWidth(120) 
SafeSlots_Main_Confirm_InsureButton:SetHeight(21) 
SafeSlots_Main_Confirm_InsureButton:SetPoint("CENTER", 0,-54) 
SafeSlots_Main_Confirm_InsureButton:RegisterForClicks("AnyUp") 
SafeSlots_Main_Confirm_InsureButton:SetText("Commute slot")


SafeSlots_Main_Confirm_ItemIcon = CreateFrame("Button", "SafeSlots_Main_Confirm_ItemIcon", SafeSlots_Main_Confirm, "SecureActionButtonTemplate")
SafeSlots_Main_Confirm_ItemIcon:SetSize(34, 34)
SafeSlots_Main_Confirm_ItemIcon:SetPoint("CENTER",-80,-23)
SafeSlots_Main_Confirm_ItemIcon:EnableMouse(true)
SafeSlots_Main_Confirm_ItemIcon:SetNormalTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot")
SafeSlots_Main_Confirm_ItemIcon:SetHighlightTexture("Interface\\BUTTONS\\ButtonHilight-Square")

local SafeSlots_Main_CostText = SafeSlots_Main_Confirm:CreateFontString("SafeSlots_Main_CostText")
SafeSlots_Main_CostText:SetFont("Fonts\\FRIZQT__.TTF", 12)
SafeSlots_Main_CostText:SetFontObject(GameFontNormal)
SafeSlots_Main_CostText:SetPoint("CENTER", 0, -15)
SafeSlots_Main_CostText:SetShadowOffset(1,-1)
-- 
                                                                                        --END OF CONFIRM FRAME--

                                                                                        --Confirm Frame Scripts--
-- main frame scripts--
SafeSlots_Main_Confirm:SetScript("OnUpdate", function(self)
    if (Slots[SafeSlots_Main_Confirm_ItemIcon.slot][3]) then-- player has insured slot
    local Link = GetInventoryItemLink("player", SafeSlots_Main_Confirm_ItemIcon.slot)
    if (Link) then
        local _, _, _, _, _, _, _, _, _, texture = GetItemInfo(Link)
        local gold,silver,copper = GetGoldForMoney(SafeSlotGetLostCost(Link))
        SafeSlots_Main_Confirm_ItemIcon:SetNormalTexture(texture)
        SafeSlots_Main_CostText:SetText("Losing this item\nwill cost you|r\n\n|cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r")
    else
        SafeSlots_Main_Confirm_ItemIcon:SetNormalTexture("Interface\\PaperDoll\\UI-Backpack-EmptySlot")
        SafeSlots_Main_CostText:SetText("This slot is empty")
    end

    SafeSlots_Main_Confirm_UnInsureButton:Show()
    SafeSlots_Main_Confirm_InsureButton:Hide()
     else-- player has not insured slot
        SafeSlots_Main_Confirm_ItemIcon:SetNormalTexture("Interface\\icons\\inv_custom_demonstears")
        SafeSlots_Main_CostText:SetText("Commutation cost:\n\n|cffa335ee[Demon's Tears]|r |cffFFFFFFx1|r")
            SafeSlots_Main_Confirm_UnInsureButton:Hide()
            SafeSlots_Main_Confirm_InsureButton:Show()
     end
    end)
-- main frame scripts--

--item icon scripts--
SafeSlots_Main_Confirm_ItemIcon:SetScript("OnEnter", function(self)
    GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
    local itemlink = GetInventoryItemLink("player", self.slot)
    if (itemlink and Slots[self.slot][3]) then
    GameTooltip:SetHyperlink(GetInventoryItemLink("player", self.slot))
    elseif Slots[self.slot][3] then
    GameTooltip:AddLine("Slot is empty")
    else
    end
    GameTooltip:Show()
    end)
SafeSlots_Main_Confirm_ItemIcon:SetScript("OnLeave", function()
    GameTooltip:Hide()
    end)

--insure item button script
SafeSlots_Main_Confirm_InsureButton:SetScript("OnUpdate", function(self)
    if ( GetItemCount(InsureCurrency) > 0) then
        self:Enable()
    else
        self:Disable()
    end
    end)
--end
                                                                                        --End Confirm Frame Scripts--

--ANIMATIONS--
SafeSlots_Main_Complete = SafeSlots_Main:CreateTexture(nil, "ARTWORK")
SafeSlots_Main_Complete:SetSize(SafeSlots_Main:GetSize())
SafeSlots_Main_Complete:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SafeSlotsHighlight")
SafeSlots_Main_Complete:SetPoint("CENTER")
SafeSlots_Main_Complete:SetBlendMode("ADD")
SafeSlots_Main_Complete:Hide()

SafeSlots_Main_Complete_Dialog = SafeSlots_Main_Confirm:CreateTexture(nil, "OVERLAY")
SafeSlots_Main_Complete_Dialog:SetSize(SafeSlots_Main:GetSize())
SafeSlots_Main_Complete_Dialog:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\SafeSlots\\SafeSlots_confirmH")
SafeSlots_Main_Complete_Dialog:SetPoint("CENTER")
SafeSlots_Main_Complete_Dialog:SetBlendMode("ADD")
SafeSlots_Main_Complete_Dialog:Hide()

local function SafeSlots_Main_Animgroup_End()
    BaseFrameFadeOut(SafeSlots_Main_Complete)
    BaseFrameFadeOut(SafeSlots_Main_Complete_Dialog)
    AIO.Handle("SlotIsurance", "GetSlotList")
end
SafeSlots_Main_Animgroup = SafeSlots_Main:CreateAnimationGroup()
local SafeSlots_Main_BlankAnim = SafeSlots_Main_Animgroup:CreateAnimation("Scale")
SafeSlots_Main_BlankAnim:SetDuration(0.5)
SafeSlots_Main_BlankAnim:SetOrder(1)
SafeSlots_Main_BlankAnim:SetEndDelay(0)
--SafeSlots_Main_BlankAnim:SetScale(1,1)
SafeSlots_Main_BlankAnim:SetScript("OnFinished", SafeSlots_Main_Animgroup_End)
SafeSlots_Main_BlankAnim:SetScript("OnStop", SafeSlots_Main_Animgroup_End)
SafeSlots_Main_BlankAnim:SetScript("OnPlay", function()
    BaseFrameFadeIn(SafeSlots_Main_Complete)
    BaseFrameFadeIn(SafeSlots_Main_Complete_Dialog)
    end)

local function SafeSlots_Init()
    SafeSlots_Main_PlayerModel:SetUnit("player")
    SafeSlots_Main_PlayerModel:SetCamera(1) -- model settings
    SafeSlots_Main_Confirm:Hide()
    for k,v in pairs(Slots) do
        if v[3] then
            BaseFrameFadeIn(_G[v[2].."_GlowTex"])
        else
            if (_G[v[2].."_GlowTex"]:IsVisible()) then
                BaseFrameFadeOut(_G[v[2].."_GlowTex"])
            else
                _G[v[2].."_GlowTex"]:Hide()
            end
        end
        _G[v[2]].slot = k -- button settings

    end
end
--END OF ANIMATIONS--

                                                                                                --AIO STUFF, SENDING PART--


SafeSlots_Main:SetScript("OnShow", function()
    AIO.Handle("SlotIsurance", "GetSlotList")
    end)

SafeSlots_Main_Confirm_UnInsureButton:SetScript("OnMouseDown",function(self)
    if (SafeSlots_Main_Confirm_ItemIcon.slot) then
        SafeSlots_Main_Animgroup:Stop()
        SafeSlots_Main_Animgroup:Play()
        AIO.Handle("SlotIsurance", "UnInsureSlot", SafeSlots_Main_Confirm_ItemIcon.slot)
        end
    end)
SafeSlots_Main_Confirm_InsureButton:SetScript("OnMouseDown",function(self)
    if ( GetItemCount(InsureCurrency) > 0) then
    SafeSlots_Main_Animgroup:Stop()
    SafeSlots_Main_Animgroup:Play()
        if (SafeSlots_Main_Confirm_ItemIcon.slot) then
        AIO.Handle("SlotIsurance", "InsureSlot", SafeSlots_Main_Confirm_ItemIcon.slot)
        end
    end
    end)

                                                                                                --AIO STUFF, GETTING PART--
function SlotIsuranceClient.SafeSlots_GetList(player, slotlist)
    Slots = slotlist
    SafeSlots_Init()
end

function SlotIsuranceClient.SafeSlots_Close(player)
    SafeSlots_Main:Hide()
end

function SlotIsuranceClient.SafeSlots_Init(player)
    SafeSlots_Main:Show()
end