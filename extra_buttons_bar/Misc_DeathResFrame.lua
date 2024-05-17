local AIO = AIO or require("AIO")

if AIO.AddAddon() then
    return
end

local MyHandlers = AIO.AddHandlers("DeathRessurect", {})

DeathCapitalTeleportButton = CreateFrame("Button", "DeathCapitalTeleportButton", UIParent, nil) 
DeathCapitalTeleportButton:SetWidth(200) 
DeathCapitalTeleportButton:SetHeight(100) 
DeathCapitalTeleportButton:SetPoint("TOP", 0,-20) 
DeathCapitalTeleportButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\pvprev")
--font
local DeathCapitalTeleportButton_text = DeathCapitalTeleportButton:CreateFontString("TicketMasterFrame_Title")
DeathCapitalTeleportButton_text:SetFontObject(GameFontNormal)
DeathCapitalTeleportButton_text:SetText("Resurrect\nin a capital city")
DeathCapitalTeleportButton_text:SetPoint("CENTER",32,0)
--
DeathCapitalTeleportButton:SetFontString(DeathCapitalTeleportButton_text)
DeathCapitalTeleportButton:RegisterForClicks("AnyUp") 
DeathCapitalTeleportButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\pvprev_h")
DeathCapitalTeleportButton:SetScript("OnClick", function()
DeathDialog:Show()
end)
DeathCapitalTeleportButton:Hide()

local DeathDialog = CreateFrame("Frame", "DeathDialog",DeathCapitalTeleportButton,nil)
DeathDialog:ClearAllPoints()
DeathDialog:SetBackdrop(StaticPopup1:GetBackdrop())
DeathDialog:SetHeight(115)
DeathDialog:SetWidth(390)
DeathDialog:SetPoint("TOP", UIParent, 0, -215)
DeathDialog:Hide()

DeathDialog.text = DeathDialog:CreateFontString(nil, "BACKGROUND", "GameFontHighlight")
--DeathDialog.text:SetAllPoints()
DeathDialog.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
DeathDialog.text:SetText("Are you sure you want to be resurrected in a City? All of your items\n will take 100% durability damage,\n and you will be\n afflicted by 10 minutes of Resurrection Sickness.")
DeathDialog.text:SetPoint("TOP",0,-20)


DeathDialog.Alert = DeathDialog:CreateTexture("DeathDialog.Alert") 
--DeathDialog.Alert:SetAllPoints() 
DeathDialog.Alert:SetTexture("Interface\\DialogFrame\\UI-Dialog-Icon-AlertNew") 
DeathDialog.Alert:SetSize(48,48)
DeathDialog.Alert:SetPoint("LEFT",24,0)

DeathDialog.Yes = CreateFrame("Button", nil, DeathDialog, "StaticPopupButtonTemplate") 
DeathDialog.Yes:SetWidth(110) 
DeathDialog.Yes:SetHeight(19) 
DeathDialog.Yes:SetPoint("BOTTOM", -60,15) 
DeathDialog.Yes:SetScript("OnClick", function()
  AIO.Handle("DeathRessurect", "Ressurect")
  DeathDialog:Hide()
  end)


DeathDialog.No = CreateFrame("Button", nil, DeathDialog, "StaticPopupButtonTemplate") 
DeathDialog.No:SetWidth(110) 
DeathDialog.No:SetHeight(19) 
DeathDialog.No:SetPoint("BOTTOM", 60,15) 
DeathDialog.No:SetScript("OnClick", function()
  DeathDialog:Hide()
  end)

DeathDialog.Yes.text = DeathDialog.Yes:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
DeathDialog.Yes.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
DeathDialog.Yes.text:SetText("Accept")
DeathDialog.Yes.text:SetPoint("CENTER",0,1)

DeathDialog.No.text = DeathDialog.No:CreateFontString(nil, "BACKGROUND", "GameFontNormal")
DeathDialog.No.text:SetFont("Fonts\\FRIZQT__.TTF", 11)
DeathDialog.No.text:SetText("Cancel")
DeathDialog.No.text:SetPoint("CENTER",0,1)

DeathDialog.Yes:SetFontString(DeathDialog.Yes.text)
DeathDialog.No:SetFontString(DeathDialog.No.text)

DeathDialog:SetScript("OnShow", function(self)
PlaySound("igMainMenuOpen")
end)
DeathDialog:SetScript("OnHide", function(self)
PlaySound("igMainMenuClose")
end)