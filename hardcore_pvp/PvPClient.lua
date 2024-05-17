
local AIO = AIO or require("AIO")


if AIO.AddAddon() then
    return
end


local MyHandlers = AIO.AddHandlers("PvP", {})


Framework = CreateFrame("Frame", "first_frame", UIParent, nil)
local FullLootFrame = Framework
FullLootFrame:SetSize(416, 310)
--FullLootFrame:SetScale(0.88) --making everything more or less fit standart sizes of blizz interfaces
FullLootFrame:SetMovable(true)
FullLootFrame:EnableMouse(true)
FullLootFrame:RegisterForDrag("LeftButton")
FullLootFrame:SetPoint("BOTTOMRIGHT", -270, 60)
FullLootFrame:SetToplevel(true)
FullLootFrame:SetClampedToScreen(true)
FullLootFrame:SetBackdrop({
	bgFile = "Interface\\AddOns\\AwAddons\\Textures\\misc\\loot",
	insets = { left = -30, right = -30, top = -101, bottom = -101}
	})
FullLootFrame:SetScript("OnDragStart", FullLootFrame.StartMoving)
FullLootFrame:SetScript("OnHide", FullLootFrame.StopMovingOrSizing)
FullLootFrame:SetScript("OnDragStop", FullLootFrame.StopMovingOrSizing)

FullLootFrame_scroll = CreateFrame("ScrollFrame", nil, FullLootFrame)
FullLootFrame_scroll:SetSize(500,198)
FullLootFrame_scroll:SetPoint("CENTER", -25, -25)
FullLootFrame_content = CreateFrame("Frame", nil, FullLootFrame)
FullLootFrame_content:SetSize(FullLootFrame_scroll:GetSize())
FullLootFrame_content:SetPoint("CENTER")

FullLootscrollbar = CreateFrame("Slider", nil, FullLootFrame_scroll, "UIPanelScrollBarTemplate") 
FullLootscrollbar:SetPoint("TOPLEFT", FullLootFrame, "TOPRIGHT", -79, -57) 
FullLootscrollbar:SetPoint("BOTTOMLEFT", FullLootFrame, "BOTTOMRIGHT", -79, 33) 

FullLootscrollbar:SetMinMaxValues(1, 1250) 
FullLootscrollbar:SetValueStep(1) 
FullLootscrollbar.scrollStep = 1
FullLootscrollbar:SetValue(0) 
FullLootscrollbar:SetWidth(16) 
FullLootscrollbar:SetScript("OnValueChanged", 
function (self, value) 
FullLootFrame_scroll:SetVerticalScroll(value) 
end) 
local FLscrollbg = FullLootscrollbar:CreateTexture(nil, "BACKGROUND") 
FLscrollbg:SetAllPoints(FullLootscrollbar) 
FLscrollbg:SetTexture(0, 0, 0, 0.4) 

FullLootFrame_scroll:SetScrollChild(FullLootFrame_content)
FullLootFrame:Hide()

local FullLootFrame_TitleText = FullLootFrame:CreateFontString("FullLootFrame_TitleText")
FullLootFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 12.2)
FullLootFrame_TitleText:SetSize(300, 5)
FullLootFrame_TitleText:SetFontObject(GameFontNormal)
FullLootFrame_TitleText:SetPoint("TOP", -15, -25)
FullLootFrame_TitleText:SetShadowOffset(1, -1)
FullLootFrame_TitleText:SetText("Unclaimed Belongings")
local FullLootFrame_CloseButton = CreateFrame("Button", "FullLootFrame_CloseButton", FullLootFrame, "UIPanelCloseButton")
FullLootFrame_CloseButton:SetPoint("TOPRIGHT", -55, -12)
FullLootFrame_CloseButton:EnableMouse(true)
--FullLootFrame_CloseButton:SetSize(31, 30)

 FullLootFrame:EnableMouseWheel(true)
        FullLootFrame:SetScript("OnMouseWheel", function(self, delta)
            if (FullLootscrollbar:IsVisible()) then
        local value = FullLootscrollbar:GetValue()
        FullLootscrollbar:SetValue(value-delta*50)
    end
        end)



local FullLoot_Button1 = CreateFrame("Button", "FullLoot_Button1", FullLootFrame_content, nil)
local FullLoot_Button2 = CreateFrame("Button", "FullLoot_Button2", FullLootFrame_content, nil)
local FullLoot_Button3 = CreateFrame("Button", "FullLoot_Button3", FullLootFrame_content, nil)
local FullLoot_Button4 = CreateFrame("Button", "FullLoot_Button4", FullLootFrame_content, nil)
local FullLoot_Button5 = CreateFrame("Button", "FullLoot_Button5", FullLootFrame_content, nil)
local FullLoot_Button6 = CreateFrame("Button", "FullLoot_Button6", FullLootFrame_content, nil)
local FullLoot_Button7 = CreateFrame("Button", "FullLoot_Button7", FullLootFrame_content, nil)
local FullLoot_Button8 = CreateFrame("Button", "FullLoot_Button8", FullLootFrame_content, nil)
local FullLoot_Button9 = CreateFrame("Button", "FullLoot_Button9", FullLootFrame_content, nil)
local FullLoot_Button10 = CreateFrame("Button", "FullLoot_Button10", FullLootFrame_content, nil)
local FullLoot_Button11 = CreateFrame("Button", "FullLoot_Button11", FullLootFrame_content, nil)
local FullLoot_Button12 = CreateFrame("Button", "FullLoot_Button12", FullLootFrame_content, nil)
local FullLoot_Button13 = CreateFrame("Button", "FullLoot_Button13", FullLootFrame_content, nil)
local FullLoot_Button14 = CreateFrame("Button", "FullLoot_Button14", FullLootFrame_content, nil)
local FullLoot_Button15 = CreateFrame("Button", "FullLoot_Button15", FullLootFrame_content, nil)
local FullLoot_Button16 = CreateFrame("Button", "FullLoot_Button16", FullLootFrame_content, nil)
local FullLoot_Button17 = CreateFrame("Button", "FullLoot_Button17", FullLootFrame_content, nil)
local FullLoot_Button18 = CreateFrame("Button", "FullLoot_Button18", FullLootFrame_content, nil)
local FullLoot_Button19 = CreateFrame("Button", "FullLoot_Button19", FullLootFrame_content, nil)
local FullLoot_Button20 = CreateFrame("Button", "FullLoot_Button20", FullLootFrame_content, nil)
local FullLoot_Button21 = CreateFrame("Button", "FullLoot_Button21", FullLootFrame_content, nil)
local FullLoot_Button22 = CreateFrame("Button", "FullLoot_Button22", FullLootFrame_content, nil)
local FullLoot_Button23 = CreateFrame("Button", "FullLoot_Button23", FullLootFrame_content, nil)
local FullLoot_Button24 = CreateFrame("Button", "FullLoot_Button24", FullLootFrame_content, nil)
local FullLoot_Button25 = CreateFrame("Button", "FullLoot_Button25", FullLootFrame_content, nil)

local FullLoot_Text1 = FullLoot_Button1:CreateFontString("FullLoot_Text1")
local FullLoot_Text2 = FullLoot_Button2:CreateFontString("FullLoot_Text2")
local FullLoot_Text3 = FullLoot_Button3:CreateFontString("FullLoot_Text3")
local FullLoot_Text4 = FullLoot_Button4:CreateFontString("FullLoot_Text4")
local FullLoot_Text5 = FullLoot_Button5:CreateFontString("FullLoot_Text5")
local FullLoot_Text6 = FullLoot_Button6:CreateFontString("FullLoot_Text6")
local FullLoot_Text7 = FullLoot_Button7:CreateFontString("FullLoot_Text7")
local FullLoot_Text8 = FullLoot_Button8:CreateFontString("FullLoot_Text8")
local FullLoot_Text9 = FullLoot_Button9:CreateFontString("FullLoot_Text9")
local FullLoot_Text10 = FullLoot_Button10:CreateFontString("FullLoot_Text10")
local FullLoot_Text11 = FullLoot_Button11:CreateFontString("FullLoot_Text11")
local FullLoot_Text12 = FullLoot_Button12:CreateFontString("FullLoot_Text12")
local FullLoot_Text13 = FullLoot_Button13:CreateFontString("FullLoot_Text13")
local FullLoot_Text14 = FullLoot_Button14:CreateFontString("FullLoot_Text14")
local FullLoot_Text15 = FullLoot_Button15:CreateFontString("FullLoot_Text15")
local FullLoot_Text16 = FullLoot_Button16:CreateFontString("FullLoot_Text16")
local FullLoot_Text17 = FullLoot_Button17:CreateFontString("FullLoot_Text17")
local FullLoot_Text18 = FullLoot_Button18:CreateFontString("FullLoot_Text18")
local FullLoot_Text19 = FullLoot_Button19:CreateFontString("FullLoot_Text19")
local FullLoot_Text20 = FullLoot_Button20:CreateFontString("FullLoot_Text20")
local FullLoot_Text21 = FullLoot_Button21:CreateFontString("FullLoot_Text21")
local FullLoot_Text22 = FullLoot_Button22:CreateFontString("FullLoot_Text22")
local FullLoot_Text23 = FullLoot_Button23:CreateFontString("FullLoot_Text23")
local FullLoot_Text24 = FullLoot_Button24:CreateFontString("FullLoot_Text24")
local FullLoot_Text25 = FullLoot_Button25:CreateFontString("FullLoot_Text25")

local FullLootIconTable = {}
local FullLoot_Icon1 = FullLoot_Button1:CreateTexture("FullLoot_Icon1")
local FullLoot_Icon2 = FullLoot_Button2:CreateTexture("FullLoot_Icon2")
local FullLoot_Icon3 = FullLoot_Button3:CreateTexture("FullLoot_Icon3")
local FullLoot_Icon4 = FullLoot_Button4:CreateTexture("FullLoot_Icon4")
local FullLoot_Icon5 = FullLoot_Button5:CreateTexture("FullLoot_Icon5")
local FullLoot_Icon6 = FullLoot_Button6:CreateTexture("FullLoot_Icon6")
local FullLoot_Icon7 = FullLoot_Button7:CreateTexture("FullLoot_Icon7")
local FullLoot_Icon8 = FullLoot_Button8:CreateTexture("FullLoot_Icon8")
local FullLoot_Icon9 = FullLoot_Button9:CreateTexture("FullLoot_Icon9")
local FullLoot_Icon10 = FullLoot_Button10:CreateTexture("FullLoot_Icon10")
local FullLoot_Icon11 = FullLoot_Button11:CreateTexture("FullLoot_Icon11")
local FullLoot_Icon12 = FullLoot_Button12:CreateTexture("FullLoot_Icon12")
local FullLoot_Icon13 = FullLoot_Button13:CreateTexture("FullLoot_Icon13")
local FullLoot_Icon14 = FullLoot_Button14:CreateTexture("FullLoot_Icon14")
local FullLoot_Icon15 = FullLoot_Button15:CreateTexture("FullLoot_Icon15")
local FullLoot_Icon16 = FullLoot_Button16:CreateTexture("FullLoot_Icon16")
local FullLoot_Icon17 = FullLoot_Button17:CreateTexture("FullLoot_Icon17")
local FullLoot_Icon18 = FullLoot_Button18:CreateTexture("FullLoot_Icon18")
local FullLoot_Icon19 = FullLoot_Button19:CreateTexture("FullLoot_Icon19")
local FullLoot_Icon20 = FullLoot_Button20:CreateTexture("FullLoot_Icon20")
local FullLoot_Icon21 = FullLoot_Button21:CreateTexture("FullLoot_Icon21")
local FullLoot_Icon22 = FullLoot_Button22:CreateTexture("FullLoot_Icon22")
local FullLoot_Icon23 = FullLoot_Button23:CreateTexture("FullLoot_Icon23")
local FullLoot_Icon24 = FullLoot_Button24:CreateTexture("FullLoot_Icon24")
local FullLoot_Icon25 = FullLoot_Button25:CreateTexture("FullLoot_Icon25")
for i = 1, 25 do
	table.insert(FullLootIconTable, _G["FullLoot_Icon"..i])
end

local FullLoot_ButtonTable = {FullLoot_Button1, FullLoot_Button2, FullLoot_Button3, FullLoot_Button4, FullLoot_Button5, 
FullLoot_Button6, FullLoot_Button7, FullLoot_Button8, FullLoot_Button9, FullLoot_Button10, FullLoot_Button11, FullLoot_Button12, 
FullLoot_Button13, FullLoot_Button14, FullLoot_Button15, FullLoot_Button16, FullLoot_Button17, FullLoot_Button18, FullLoot_Button19, 
FullLoot_Button20, FullLoot_Button21, FullLoot_Button22, FullLoot_Button23, FullLoot_Button24, FullLoot_Button25}

local FullLoot_TextTable = {FullLoot_Text1, FullLoot_Text2, FullLoot_Text3, FullLoot_Text4, FullLoot_Text5, 
FullLoot_Text6, FullLoot_Text7, FullLoot_Text8, FullLoot_Text9, FullLoot_Text10, FullLoot_Text11, FullLoot_Text12, 
FullLoot_Text13, FullLoot_Text14, FullLoot_Text15, FullLoot_Text16, FullLoot_Text17, FullLoot_Text18, FullLoot_Text19, 
FullLoot_Text20, FullLoot_Text21, FullLoot_Text22, FullLoot_Text23, FullLoot_Text24, FullLoot_Text25}


function MyHandlers.ReceiveItems(player,itemNumber, itemList, objectid)
	itemHoldList = {}
	playerKilledName = nil
	
	objectPass = objectid
	
	nullItems = 25 - itemNumber
	
	if playerKilledName ~= nil then
	
		FullLootFrame_TitleText:SetText("|cff230d21"..playerKilledName.."'s Belongings|r")
		
	else
	
		FullLootFrame_TitleText:SetText("Unclaimed Belongings")
	
	end
	
	repeat
	
		local FullLoot_Button_null = FullLoot_ButtonTable[itemNumber + nullItems]
		local FullLoot_Text_null = FullLoot_TextTable[itemNumber + nullItems]
		local FullLootIconTable_null = FullLootIconTable[itemNumber + nullItems]
		
		FullLoot_Button_null:Hide()
		FullLoot_Text_null:Hide()
		FullLootIconTable_null:Hide()
		
		nullItems = nullItems - 1
	
	until(nullItems <= 0)

	if itemNumber > 0 then
	
		if itemList[itemNumber][1] ~= nil and itemList[itemNumber][2] ~= nil and itemList[itemNumber][3] ~= nil then

			repeat
			local FullLoot_Button = FullLoot_ButtonTable[itemNumber]
			local FullLoot_Text = FullLoot_TextTable[itemNumber]
			local FullLoot_Icon = FullLootIconTable[itemNumber]
			
			FullLoot_Button:SetSize(256, 52)
			FullLoot_Button:SetPoint("TOP", 0, (-10-((itemNumber-1)*64)))
			FullLoot_Button:EnableMouse(true)
			FullLoot_Button:SetHighlightTexture("Interface/Buttons/UI-Listbox-Highlight")
			FullLoot_Button:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Misc\\lootbg",
             insets = {
            left = -102,
            right = -102,
            top = -34,
            bottom = -34}
                })
			item_idd = itemList[itemNumber][2]
			item_name = itemList[itemNumber][1]
			item_stuff = itemList[itemNumber][3]
			table.insert (itemHoldList, {FullLoot_Button, item_idd, item_name, item_stuff})
			

			function FullLoot_Button_Tooltip_OnEnter(self, motion)
				local item_rec = "Error, no item found"
				
				for i, v in ipairs(itemHoldList) do
					if v[1] == self then
						item_rec = v[2]
						break
					end
				end
			
				GameTooltip:SetOwner(self,"ANCHOR_RIGHT") 
				GameTooltip:SetHyperlink("item:"..item_rec..":0:0:0:0:0:0:0") 
				GameTooltip:Show()
			end
			FullLoot_Button:SetScript("OnEnter", FullLoot_Button_Tooltip_OnEnter)
			function FullLoot_Button_Tooltip_OnLeave(self, motion)
				GameTooltip:Hide()
			end
			FullLoot_Button:SetScript("OnLeave", FullLoot_Button_Tooltip_OnLeave)
			FullLoot_Text:SetFont("Fonts\\FRIZQT__.TTF", 14)
			FullLoot_Text:SetSize(200, 20)
			FullLoot_Text:SetPoint("CENTER", 20, 0)
			FullLoot_Text:SetShadowOffset(1, -1)
			local texture_x = "Interface\\Icons\\INV_Chest_Samurai"
			local name_x, link_x, quality_x, iLevel_x, reqLevel_x, class_x, subclass_x, maxStack_x, equipSlot_x, texture_x2, vendorPrice_x = GetItemInfo(itemList[itemNumber][2])
			if (texture_x2) then
				texture_x = texture_x2
			end
			FullLoot_Icon:SetWidth(32);               
        	FullLoot_Icon:SetHeight(34);
        	FullLoot_Icon:SetTexture(texture_x)
        	FullLoot_Icon:SetPoint("LEFT", 8, 0)
			FullLoot_Text:SetText(itemList[itemNumber][1].." x"..itemList[itemNumber][3]) -- edited
			FullLoot_Text:SetJustifyH("LEFT")
			

			function ClickItem(self)
				local item_rec = "Error, no item found"
				local item_link = 0
				local item_stuffy = 0
				local bag1, _ = GetContainerNumFreeSlots(0)
				local bag2, _ = GetContainerNumFreeSlots(1)
				local bag3, _ = GetContainerNumFreeSlots(2)
				local bag4, _ = GetContainerNumFreeSlots(3)
				local bag5, _ = GetContainerNumFreeSlots(4)
				local slots_open = bag1+bag2+bag3+bag4+bag5
				bagslot_free = true
				if slots_open == 0 then
					bagslot_free = false
				end
				
				
				
				if bagslot_free == true then
					
					for i, v in ipairs(itemHoldList) do
						if v[1] == self then
							item_rec = v[2]
							item_link = v[3]
							item_stuffy = v[4]
							break
						end
					end
					FullLoot_Button:Hide()
					FullLoot_Text:SetText("|cff9d9d9dLooted Item|r")
					FullLoot_Button:Disable()
					AIO.Handle("PvP", "AddPlayerItem", item_rec, item_stuffy, objectPass)
				else
				
					print("|cffFFFF00You don't have enough space in bags|r")
					
				end
			end
			FullLoot_Button:SetScript("OnMouseUp", ClickItem)
			
			FullLoot_Button:Show()
			FullLoot_Text:Show()
			FullLoot_Icon:Show()
			
			itemNumber = itemNumber - 1
			until(itemNumber <= 0)
			
		else
		
			local FullLoot_Button_null = FullLoot_ButtonTable[itemNumber]
			local FullLoot_Text_null = FullLoot_TextTable[itemNumber]
			local FullLootIconTable_null = FullLootIconTable[itemNumber]
			
			FullLoot_Button_null:Hide()
			FullLoot_Text_null:Hide()
			FullLootIconTable_null:Hide()
			
			itemNumber = itemNumber - 1
		
		end
		
	end
	
	FullLootFrame:Show()
end