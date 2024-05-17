local AIO = AIO or require("AIO")


if AIO.AddAddon() then
    return
end


local MyHandlers = AIO.AddHandlers("EnchantReRoll", {})

local Reforge_Spell = 964998
--[[MAIN FRAME SCRIPTS]]--
local function EnchantReRollMain_RollButton_Check(self,elapsed)
    if (EnchantReRollMain.item) then
self:Enable()
    else
self:Disable()
    end
    end
-- gets last item player locked to send slot and bug id to server
local function EnchantReRollMain_GetLastLockedItem(self,event,bag,slot)
if (bag and slot) then
    if (bag == 0) then
    EnchantReRollMain.Bag = 255
    EnchantReRollMain.Slot = slot+22
    else
    EnchantReRollMain.Bag = bag+18
    EnchantReRollMain.Slot = slot-1
    end
elseif (bag and (slot == nil)) then
EnchantReRollMain.Bag = 255
EnchantReRollMain.Slot = bag-1
end
    end

local function EnchantReRollMain_Reforge_CastSuccess(self,event,unit,spellname)
    local name = GetSpellInfo(964998)
    if (spellname == name) and (unit == "player") then
        if (EnchantReRollMain.item and EnchantReRollMain_RollButton.Bag and EnchantReRollMain_RollButton.Slot) then
            AIO.Handle("EnchantReRoll", "ReforgeItem", EnchantReRollMain_RollButton.Bag, EnchantReRollMain_RollButton.Slot)
            PlaySound("Glyph_MajorDestroy")
        end
    end
end

 function MyHandlers.EnchantReRollMain_Reforge(player,neweffect) -- AIO
--Set up strings from server
EnchantReRollMain.itemEffectName2 = GetSpellInfo(neweffect)

if (not(EnchantReRollMain.itemEffectName2)) or (EnchantReRollMain.itemEffectName2 == "Enchanting") then
    EnchantReRollMain.itemEffectName2 = "Enhant Reforged"
    neweffect = 964998
    end

EnchantReRollMain.itemEffect2 = "|Hspell:"..neweffect.."|h["..EnchantReRollMain.itemEffectName2.."]|h"
EnchantReRollMain_Item_EffectAFrame_BaseEffectAText:SetText("|cff00FF00"..EnchantReRollMain.itemEffect2.."|r")
--Play Reforge Animations
EnchantReRollMain_Item_EffectAFrame_Animgroup:Stop()
EnchantReRollMain_Item_EffectAFrame_Animgroup2:Stop()
BaseFrameFadeIn(EnchantReRollMain_Item_EffectAFrame)
EnchantReRollMain_Item_EffectAFrame_Animgroup:Play()
BaseFrameFadeIn(EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture)
end
---[[MAIN FRAME SETTINGS]]---
FrameMain = CreateFrame("Frame", "EnchantReRollMain", UIParent, nil)
local EnchantReRollMain = FrameMain
EnchantReRollMain:SetSize(420,420)
EnchantReRollMain:SetPoint("CENTER")

EnchantReRollMain:SetMovable(true)
EnchantReRollMain:EnableMouse(true)
EnchantReRollMain:RegisterForDrag("LeftButton")
EnchantReRollMain:SetClampedToScreen(true)
EnchantReRollMain:SetScript("OnDragStart", EnchantReRollMain.StartMoving)
EnchantReRollMain:SetScript("OnHide", EnchantReRollMain.StopMovingOrSizing)
EnchantReRollMain:SetScript("OnDragStop", EnchantReRollMain.StopMovingOrSizing)
EnchantReRollMain:RegisterEvent("ITEM_LOCKED")
EnchantReRollMain:SetScript("OnEvent", EnchantReRollMain_GetLastLockedItem)
--EnchantReRollMain:Hide()

EnchantReRollMain:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\enchant\\enchants_main",
    insets = { left = -40, right = -40, top = -40, bottom = -40}
})
EnchantReRollMain:Hide()

local EnchantReRollMain_CloseButton = CreateFrame("Button", "EnchantReRollMain_CloseButton", EnchantReRollMain, "UIPanelCloseButton")
EnchantReRollMain_CloseButton:SetPoint("TOPRIGHT", -19, -15) 
EnchantReRollMain_CloseButton:EnableMouse(true)
EnchantReRollMain_CloseButton:SetSize(25, 25) 
EnchantReRollMain_CloseButton:SetScript("OnClick", function()
    PlaySound("igMainMenuOptionCheckBoxOn")
    EnchantReRollMain:Hide()
    end)

local EnchantReRollMain_RollButton = CreateFrame("Button", "EnchantReRollMain_RollButton", EnchantReRollMain, "UIPanelButtonTemplate")
EnchantReRollMain_RollButton:SetWidth(120) 
EnchantReRollMain_RollButton:SetHeight(22) 
EnchantReRollMain_RollButton:SetPoint("BOTTOM", 0,90) 
EnchantReRollMain_RollButton:RegisterForClicks("AnyUp") 
EnchantReRollMain_RollButton:SetText("Reforge item")
EnchantReRollMain_RollButton:Disable()
EnchantReRollMain_RollButton:RegisterEvent("UNIT_SPELLCAST_SUCCEEDED")
EnchantReRollMain_RollButton:SetScript("OnEvent", EnchantReRollMain_Reforge_CastSuccess)
EnchantReRollMain_RollButton:SetScript("OnUpdate", EnchantReRollMain_RollButton_Check)
EnchantReRollMain_RollButton:SetScript("OnMouseDown",function()
    if (EnchantReRollMain.item and EnchantReRollMain_RollButton.Bag and EnchantReRollMain_RollButton.Slot) then
    PlaySound("igMainMenuOptionCheckBoxOn")
    AIO.Handle("EnchantReRoll", "ReforgeItem_Prep", EnchantReRollMain_RollButton.Bag, EnchantReRollMain_RollButton.Slot)
end
    end)

local EnchantReRollMain_TitleText = EnchantReRollMain:CreateFontString("EnchantReRollMain_TitleText")
EnchantReRollMain_TitleText:SetFont("Fonts\\MORPHEUS.TTF", 15)
EnchantReRollMain_TitleText:SetPoint("TOP", 0, -6)
EnchantReRollMain_TitleText:SetShadowOffset(0,0)
EnchantReRollMain_TitleText:SetText("|cff110011Enchant Reforge|r")

local EnchantReRollMain_CostText = EnchantReRollMain:CreateFontString("EnchantReRollMain_TitleText")
EnchantReRollMain_CostText:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE")
EnchantReRollMain_CostText:SetShadowOffset(1, -1)
EnchantReRollMain_CostText:SetPoint("BOTTOM", 0, 125)
EnchantReRollMain_CostText:SetShadowOffset(0,0)

EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture = EnchantReRollMain:CreateTexture(nil, "ARTWORK")
EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture:SetHeight(EnchantReRollMain:GetHeight()+80)
EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture:SetWidth(EnchantReRollMain:GetWidth()+80)
EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\enchants_ReforgeEffect")
EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture:SetPoint("CENTER",EnchantReRollMain,0,0)
EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture:SetBlendMode("ADD")
EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture:Hide()

--[[ITEM FRAME SCRIPTS]]--
 function MyHandlers.EnchantReRoll_PlaceItem(player,item,nameeffect,cost,bag,slot) -- AIO
--Setting up item to the button
PlaySound("Glyph_MajorCreate")
local name, itemlink, _, _, _, _, _, _, _, texture, _ = GetItemInfo(item)
ClearCursor()
EnchantReRollMain_Item.Button:SetNormalTexture(texture)
EnchantReRollMain.item = item
EnchantReRollMain.itemEffectName = GetSpellInfo(nameeffect)

if (not(EnchantReRollMain.itemEffectName)) or (EnchantReRollMain.itemEffectName == "Enchanting") then
    EnchantReRollMain.itemEffectName = "This item is ready to be enchanted"
    nameeffect = 964998
    end

EnchantReRollMain.itemEffect = "|Hspell:"..nameeffect.."|h["..EnchantReRollMain.itemEffectName.."]|h"
EnchantReRollMain.itemCost = cost
--For Reforge
EnchantReRollMain_RollButton.Slot = slot
EnchantReRollMain_RollButton.Bag = bag
--cost
 local gold,silver,copper = GetGoldForMoney(EnchantReRollMain.itemCost)
--Play animations
EnchantReRollMain_Item_EffectFrame_BaseEffectText:SetText("|cff00FF00"..EnchantReRollMain.itemEffect.."|r")
EnchantReRollMain_CostText:SetText("|cffE1AB18Reforge cost: |cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r")
EnchantReRollMain_Item_BackgroundTexture:SetAlpha(1.0)
BaseFrameFadeIn(EnchantReRollMain_Item_BackgroundTexture_Effect)
BaseFrameFadeIn(EnchantReRollMain_Item_EffectFrame)
EnchantReRollMain_Item_EffectFrame_Animgroup:Play()
end

local function EnchantReRoll_ShowLink(self)
    if (EnchantReRollMain.item) then
GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
GameTooltip:SetHyperlink(EnchantReRollMain.item)
GameTooltip:Show()
    end
    end

 function  MyHandlers.EnchantReRoll_Init(player)
    PlaySound("Glyph_MajorCreate")
BaseFrameFadeIn(EnchantReRollMain)
end
 function  MyHandlers.EnchantReRoll_Close(player)
    if (EnchantReRollMain:IsVisible()) then
        PlaySound("igMainMenuOptionCheckBoxOn")
        EnchantReRollMain:Hide()
end
end
---[[ITEM FRAME SETTINGS]]---

local EnchantReRollMain_Item = CreateFrame("Frame", "EnchantReRollMain_Item", EnchantReRollMain, nil)
EnchantReRollMain_Item:SetSize(108,108)
EnchantReRollMain_Item:SetPoint("CENTER", 0, 130)
EnchantReRollMain_Item:SetFrameStrata("HIGH")
EnchantReRollMain_Item:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\enchant\\itemslot",
    })

EnchantReRollMain_Item.Button = CreateFrame("Button", "EnchantReRollMain_Item.Button", EnchantReRollMain_Item, nil)
EnchantReRollMain_Item.Button:SetSize(34, 34)
EnchantReRollMain_Item.Button:SetPoint("CENTER",0,0)
EnchantReRollMain_Item.Button:EnableMouse(true)
EnchantReRollMain_Item.Button:SetFrameStrata("HIGH")
--EnchantReRollMain_Item.Button:SetNormalTexture("Interface\\Icons\\INV_Chest_Samurai")
EnchantReRollMain_Item.Button:SetHighlightTexture("Interface\\BUTTONS\\ButtonHilight-Square")
--EnchantReRollMain_Item.Button:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Down")
EnchantReRollMain_Item.Button:SetScript("OnMouseDown",function()
    local Type, data, subType, subData = GetCursorInfo()
    if (Type == "item") and EnchantReRollMain.Bag and EnchantReRollMain.Slot then
        AIO.Handle("EnchantReRoll", "SetItem", EnchantReRollMain.Bag, EnchantReRollMain.Slot) -- AIO part
    else
        --Remove Item and animations
EnchantReRollMain_Item.Button:SetNormalTexture(nil)
EnchantReRollMain.item = nil
EnchantReRollMain_Item_BackgroundTexture:SetAlpha(0.6)
EnchantReRollMain_CostText:SetText("")
BaseFrameFadeOut(EnchantReRollMain_Item_BackgroundTexture_Effect)
BaseFrameFadeOut(EnchantReRollMain_Item_EffectFrame)
    end
    end)
EnchantReRollMain_Item.Button:SetScript("OnEnter",EnchantReRoll_ShowLink)
EnchantReRollMain_Item.Button:SetScript("OnLeave", function()
    GameTooltip:Hide()
end)

EnchantReRollMain_Item_Border = EnchantReRollMain_Item.Button:CreateTexture(nil, "OVERLAY")
EnchantReRollMain_Item_Border:SetSize(EnchantReRollMain_Item:GetSize())
EnchantReRollMain_Item_Border:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\itemborder")
EnchantReRollMain_Item_Border:SetPoint("CENTER",1,-2)

EnchantReRollMain_Item_Background = CreateFrame("FRAME","EnchantReRollMain_Item_Background",EnchantReRollMain)
EnchantReRollMain_Item_Background:SetSize(EnchantReRollMain:GetSize())
EnchantReRollMain_Item_Background:SetPoint("CENTER")
EnchantReRollMain_Item_Background:SetFrameStrata("MEDIUM")

EnchantReRollMain_Item_BackgroundTexture = EnchantReRollMain_Item_Background:CreateTexture(nil, "BACKGROUND")
EnchantReRollMain_Item_BackgroundTexture:SetSize(256,64)
EnchantReRollMain_Item_BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\itemHighlight")
EnchantReRollMain_Item_BackgroundTexture:SetPoint("CENTER",EnchantReRollMain_Item,0,-5)
EnchantReRollMain_Item_BackgroundTexture:SetBlendMode("ADD")
EnchantReRollMain_Item_BackgroundTexture:SetAlpha(0.6)

EnchantReRollMain_Item_BackgroundTexture_Effect = CreateFrame("Model", "EnchantReRollMain_Item_BackgroundTexture_Effect", EnchantReRollMain_Item_Background)
EnchantReRollMain_Item_BackgroundTexture_Effect:SetWidth(256);       
EnchantReRollMain_Item_BackgroundTexture_Effect:SetHeight(256);
EnchantReRollMain_Item_BackgroundTexture_Effect:SetPoint("CENTER", EnchantReRollMain_Item, "CENTER", 0, -20)
EnchantReRollMain_Item_BackgroundTexture_Effect:SetModel("World\\Expansion01\\doodads\\netherstorm\\crackeffects\\netherstormcracksmokeblue.m2")
EnchantReRollMain_Item_BackgroundTexture_Effect:SetModelScale(0.07)
EnchantReRollMain_Item_BackgroundTexture_Effect:SetCamera(0)
EnchantReRollMain_Item_BackgroundTexture_Effect:SetPosition(0.08,0.10,0)
--EnchantReRollMain_Item_BackgroundTexture_Effect:SetAlpha(0.8)
EnchantReRollMain_Item_BackgroundTexture_Effect:SetFacing(0.1)
EnchantReRollMain_Item_BackgroundTexture_Effect:Hide()

--[ITEM FRAME EFFECT SCRIPTS]--
local function EnchantReRollMain_Item_EffectFrame_ShowLink(self)
GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
GameTooltip:SetHyperlink(EnchantReRollMain.itemEffect)
GameTooltip:Show()
    end

local function EnchantReRollMain_Item_EffectAFrame_ShowLink(self)
GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
GameTooltip:SetHyperlink(EnchantReRollMain.itemEffect2)
GameTooltip:Show()
end

local function EnchantReRollMain_Item_EffectAFrame_Animgroup_End(self)
BaseFrameFadeOut(EnchantReRollMain_Item_EffectAFrame)
BaseFrameFadeOut(EnchantReRollMain_Item_EffectAFrame_ReforgeCompleteTexture)
EnchantReRollMain.itemEffect = EnchantReRollMain.itemEffect2
EnchantReRollMain_Item_EffectFrame_BaseEffectText:SetText("|cff00FF00"..EnchantReRollMain.itemEffect.."|r")
    end
--[ITEM FRAME EFFECT]--

local EnchantReRollMain_Item_EffectFrame = CreateFrame("Frame", "EnchantReRollMain_Item_EffectFrame", EnchantReRollMain, nil)
EnchantReRollMain_Item_EffectFrame:SetSize(100,44)
EnchantReRollMain_Item_EffectFrame:SetPoint("CENTER", 0, 57)
EnchantReRollMain_Item_EffectFrame:SetFrameStrata("HIGH")
EnchantReRollMain_Item_EffectFrame:EnableMouse(true)
EnchantReRollMain_Item_EffectFrame:SetScript("OnEnter", EnchantReRollMain_Item_EffectFrame_ShowLink)
EnchantReRollMain_Item_EffectFrame:SetScript("OnLeave", function()
    GameTooltip:Hide()
    end)
EnchantReRollMain_Item_EffectFrame:Hide()

local EnchantReRollMain_Item_EffectFrame_BackgroundTexture = EnchantReRollMain_Item_EffectFrame:CreateTexture(nil, "BACKGROUND")
EnchantReRollMain_Item_EffectFrame_BackgroundTexture:SetSize(EnchantReRollMain:GetSize())
EnchantReRollMain_Item_EffectFrame_BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\enchants_textH")
EnchantReRollMain_Item_EffectFrame_BackgroundTexture:SetPoint("CENTER",EnchantReRollMain,0,0)
--EnchantReRollMain_Item_EffectFrame_BackgroundTexture:SetBlendMode("ADD")

EnchantReRollMain_Item_EffectFrame_BaseEffectText = EnchantReRollMain_Item_EffectFrame:CreateFontString("EnchantReRollMain_TitleText")
EnchantReRollMain_Item_EffectFrame_BaseEffectText:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE")
EnchantReRollMain_Item_EffectFrame_BaseEffectText:SetShadowOffset(1, -1)
EnchantReRollMain_Item_EffectFrame_BaseEffectText:SetSize(200,14)
EnchantReRollMain_Item_EffectFrame_BaseEffectText:SetPoint("CENTER", EnchantReRollMain, 0, 57)
EnchantReRollMain_Item_EffectFrame_BaseEffectText:SetShadowOffset(0,0)

--effect animations
EnchantReRollMain_Item_EffectFrame_Animgroup2 = EnchantReRollMain_Item_EffectFrame:CreateAnimationGroup()
local EnchantReRollMain_Item_EffectFrame_Scale2 = EnchantReRollMain_Item_EffectFrame_Animgroup2:CreateAnimation("Scale")
EnchantReRollMain_Item_EffectFrame_Scale2:SetDuration(0.5)
EnchantReRollMain_Item_EffectFrame_Scale2:SetOrder(1)
EnchantReRollMain_Item_EffectFrame_Scale2:SetEndDelay(0)
EnchantReRollMain_Item_EffectFrame_Scale2:SetScale(10,1)

EnchantReRollMain_Item_EffectFrame_Animgroup = EnchantReRollMain_Item_EffectFrame:CreateAnimationGroup()
local EnchantReRollMain_Item_EffectFrame_Scale1 = EnchantReRollMain_Item_EffectFrame_Animgroup:CreateAnimation("Scale")
EnchantReRollMain_Item_EffectFrame_Scale1:SetDuration(0)
EnchantReRollMain_Item_EffectFrame_Scale1:SetOrder(1)
EnchantReRollMain_Item_EffectFrame_Scale1:SetEndDelay(0.5)
EnchantReRollMain_Item_EffectFrame_Scale1:SetScale(0.1,1)
EnchantReRollMain_Item_EffectFrame_Animgroup:SetScript("OnPlay", function()
    EnchantReRollMain_Item_EffectFrame_Animgroup2:Play()
    end)

--[ITEM FRAME APPLIED EFFECT]--
local EnchantReRollMain_Item_EffectAFrame = CreateFrame("Frame", "EnchantReRollMain_Item_EffectAFrame", EnchantReRollMain, nil)
EnchantReRollMain_Item_EffectAFrame:SetSize(100,44)
EnchantReRollMain_Item_EffectAFrame:SetPoint("CENTER", 0, -20)
EnchantReRollMain_Item_EffectAFrame:SetFrameStrata("MEDIUM")
EnchantReRollMain_Item_EffectAFrame:EnableMouse(true)
EnchantReRollMain_Item_EffectAFrame:SetScript("OnEnter", EnchantReRollMain_Item_EffectAFrame_ShowLink)
EnchantReRollMain_Item_EffectAFrame:SetScript("OnLeave", function()
    GameTooltip:Hide()
    end)
EnchantReRollMain_Item_EffectAFrame:Hide()

local EnchantReRollMain_Item_EffectAFrame_BackgroundTexture = EnchantReRollMain_Item_EffectAFrame:CreateTexture(nil, "BACKGROUND")
EnchantReRollMain_Item_EffectAFrame_BackgroundTexture:SetSize(EnchantReRollMain:GetSize())
EnchantReRollMain_Item_EffectAFrame_BackgroundTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\enchant\\enchants_textH")
EnchantReRollMain_Item_EffectAFrame_BackgroundTexture:SetPoint("CENTER",EnchantReRollMain,0,-67)
EnchantReRollMain_Item_EffectAFrame_BackgroundTexture:SetBlendMode("ADD")

EnchantReRollMain_Item_EffectAFrame_BaseEffectAText = EnchantReRollMain_Item_EffectAFrame:CreateFontString("EnchantReRollMain_TitleText")
EnchantReRollMain_Item_EffectAFrame_BaseEffectAText:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE")
EnchantReRollMain_Item_EffectAFrame_BaseEffectAText:SetShadowOffset(1, -1)
EnchantReRollMain_Item_EffectAFrame_BaseEffectAText:SetSize(200,14)
EnchantReRollMain_Item_EffectAFrame_BaseEffectAText:SetPoint("CENTER", EnchantReRollMain, 0,-11)
EnchantReRollMain_Item_EffectAFrame_BaseEffectAText:SetShadowOffset(0,0)

--effectA animations
EnchantReRollMain_Item_EffectAFrame_Animgroup2 = EnchantReRollMain_Item_EffectAFrame:CreateAnimationGroup()
local EnchantReRollMain_Item_EffectAFrame_Scale2 = EnchantReRollMain_Item_EffectAFrame_Animgroup2:CreateAnimation("Scale")
EnchantReRollMain_Item_EffectAFrame_Scale2:SetDuration(1.5)
EnchantReRollMain_Item_EffectAFrame_Scale2:SetOrder(1)
EnchantReRollMain_Item_EffectAFrame_Scale2:SetEndDelay(2)
EnchantReRollMain_Item_EffectAFrame_Scale2:SetScale(10,1)
EnchantReRollMain_Item_EffectAFrame_Scale2:SetScript("OnFinished", EnchantReRollMain_Item_EffectAFrame_Animgroup_End)
EnchantReRollMain_Item_EffectAFrame_Scale2:SetScript("OnStop", EnchantReRollMain_Item_EffectAFrame_Animgroup_End)

EnchantReRollMain_Item_EffectAFrame_Animgroup = EnchantReRollMain_Item_EffectAFrame:CreateAnimationGroup()
local EnchantReRollMain_Item_EffectAFrame_Scale1 = EnchantReRollMain_Item_EffectAFrame_Animgroup:CreateAnimation("Scale")
EnchantReRollMain_Item_EffectAFrame_Scale1:SetDuration(0)
EnchantReRollMain_Item_EffectAFrame_Scale1:SetOrder(1)
EnchantReRollMain_Item_EffectAFrame_Scale1:SetEndDelay(3.5)
EnchantReRollMain_Item_EffectAFrame_Scale1:SetScale(0.1,1)
EnchantReRollMain_Item_EffectAFrame_Animgroup:SetScript("OnPlay", function()
    EnchantReRollMain_Item_EffectAFrame_Animgroup2:Play()
    end)