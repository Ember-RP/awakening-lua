local AIO = AIO or require("AIO")


if AIO.AddAddon() then
    return
end

local TutAIO = AIO.AddHandlers("TutAIO", {})

local TUTORIAL_TIPS = {
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_Tex1","|cffFFFFFFWelcome! |rAscension|cffFFFFFF is a progressive |rclassless|cffFFFFFF realm with 3 different servers in mind ranging from softcore to hardcore. |rSoftcore|cffFFFFFF being the most vanilla-like while the |rharder|cffFFFFFF difficulties introduce new mechanics such as hunger, same faction pvp, and even item drops on death. No matter where you decide to play you can expect to be able to fully live out your fantasy of a character truly unique to you!|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_Addons","|cffFFFFFFPlease, check your |raddons|cffFFFFFF enabled. Ascension |rrequire|cffFFFFFF you to use |rAscension AIO|cffFFFFFF and Ascension Resources addons. You can |rset|cffFFFFFF them as you wish, that is why you have two of Ascension Resources addons, |rone|cffFFFFFF is for using with default User Interface and the |rsecond|cffFFFFFF if you're mature player and have a lot of custom addons in your UI.|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexUpgrades","|cffFFFFFFOn Ascension, you have a lot of |rcustom|cffFFFFFF features. You may get access to them using our special |rCharacter Upgrades|cffFFFFFF panel on your |rMain Menu Bar|cffFFFFFF on trough |rquick access|cffFFFFFF frame on your screen.|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexStat","|cffFFFFFFIn Ascension you are able to allocate stat points into anything you want. Typically, as a rule: |rStrength|cffFFFFFF is for attack power, |rAgility|cffFFFFFF is less attack power but gives critical strike for physical abilities, |rstamina|cffFFFFFF is how much health you can have, |rspirit|cffFFFFFF is your mana regeneration and |rintellect|cffFFFFFF is your spell power and spell crit. With our classless system, however you will discover many more possibilities!|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexPortrait","|cffFFFFFFClassless system means that every user is able to use all 3 kinds of |rresources|cffFFFFFF, such as: |rmana|cffFFFFFF, |rrage|cffFFFFFF and |renergy|cffFFFFFF. To make it clear and easy to control we included all of them to your |rupdated player portrait|cffFFFFFF. Additional |rhorizontal|cffFFFFFF bar is for energy and |rvertical|cffFFFFFF one is for rage.|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_Ffa","|cffFFFFFFIn non-softcore realms there is |rFFA|cffFFFFFF PVP, this means that you can attack players within your own faction who are not in your group or a safe zone. Be |rcareful|cffFFFFFF out there!|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexProgress","|cffFFFFFFDing! You now have 2 |rability essences|cffFFFFFF! You may now purchase any |rspell|cffFFFFFF from the spell character advancement page. Simply click on the book then on the |rclass|cffFFFFFF which has the |rspell|cffFFFFFF you would like and finally on the left side of the window. Think of the possibilities!|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexReset","|cffFFFFFFBe sure to chose your skills and talents carefully, but since we beileve that the main |rgoal|cffFFFFFF of our realms is to give you an opportunity to try out |rnew builds|cffFFFFFF and |rideas|cffFFFFFF all the time, there is a full spell or talent |rreset|cffFFFFFF possibility which is also accessable trough User Interface.|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexFreeReset","|cffFFFFFFNeed a |rchange|cffFFFFFF? We’re here to help! Up until level 10 we have |rfree spell resets|cffFFFFFF to ensure you can play around with our system and feel what is right for you.|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_Enchant","|cffFFFFFF|rRandom enchants|cffFFFFFF! Ever wondered what it would be like to have more levels in a talent you really enjoy? Well we have that and more with our |rRandom Enchantment|cffFFFFFF system. You will periodically find gear that has an enchant that might be a rank of a talent or something else entirely! These enchants |rstack|cffFFFFFF as well! So, you can find and experiment with many different possibilities. Good luck on your drops!|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexResetNotFree","|cffFFFFFFFreedom isn’t free! The free resets are now over but fear not as you can reset your spell or talent choices by simply using |r[Ability purge]|cffFFFFFF or |r[Talent Purge]|cffFFFFFF. You start off with |r3 of each|cffFFFFFF but after you run out you can use gold to reset further but the cost increases over time.|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_TexLoot","|cffFFFFFFIn addition to FFA PVP we also have |rloot drop on death|cffFFFFFF for our medium and hardcore realms. There is a method to our madness so |rnot only your best stuff will drop|cffFFFFFF! You must also be within a certain level range to drop or get items to drop from others.|r"},
{"Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_FfaEnabled","|cffFFFFFF|rFFA|cffFFFFFF PVP is now |renabled|cffFFFFFF! You’ve honed your skills and talents in peace for 20 levels but now you will be able to kill and be killed by members of your |rown faction |cffFFFFFFor opposing. Hopefully you’ve chosen your skills wisely as you set out on your adventure and may the odds be ever in your favor!|r"},
    -- main tip -- TEX DONE
    -- Addon Settings -- TEX DONE
    -- Character Upgrades -- TEX DONE
    -- Stat Allocation -- TEX DONE
    -- Player Portrait -- TEX DONE
    -- FFA PVP -- TEX DONE
    -- level 2 Character Progression -- TEX DONE
    -- level 5 Reset spells/talents -- TEX DONE
    -- level 5 Free resets -- TEX DONE
    -- level 10 random enchants -- TEX DONE
    -- level 10 Free resets are over -- TEX DONE
    -- level 10 PvP loot on death -- TEX DONE
    -- level 20 FFA PVP is now enabled -- TEX DONE
}

local CURRENTTIP = 1
local MAXTIPS = 1

local Ascension_TutorialFrame = CreateFrame("Frame", "Ascension_TutorialFrame", UIParent, nil)
Ascension_TutorialFrame:SetSize(512,512)
--Ascension_TutorialFrame:SetAllPoints()
Ascension_TutorialFrame:SetPoint("CENTER",450,50)
Ascension_TutorialFrame:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\Tutorial",
})
Ascension_TutorialFrame:Hide()

Ascension_TutorialFrame:SetFrameStrata("TOOLTIP")

local Ascension_TutorialFrame_CloseButton = CreateFrame("Button", "Ascension_TutorialFrame_CloseButton", Ascension_TutorialFrame, "UIPanelCloseButton")
Ascension_TutorialFrame_CloseButton:SetPoint("CENTER", 169, 116) 
Ascension_TutorialFrame_CloseButton:EnableMouse(true)
--Ascension_TutorialFrame_CloseButton:SetSize(25, 25) 
Ascension_TutorialFrame_CloseButton:SetScript("OnClick", function()
    PlaySound("igMainMenuOptionCheckBoxOn")
    Ascension_TutorialFrame:Hide()
    end)

local Ascension_TutorialFrame_TitleText = Ascension_TutorialFrame:CreateFontString("Ascension_TutorialFrame_TitleText")
Ascension_TutorialFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 12.2)
Ascension_TutorialFrame_TitleText:SetPoint("CENTER", 15, 116)
Ascension_TutorialFrame_TitleText:SetFontObject(GameFontNormal)
Ascension_TutorialFrame_TitleText:SetShadowOffset(1,-1)
Ascension_TutorialFrame_TitleText:SetText("Ascension Survival Guide")

local Ascension_TutorialFrameTexture = Ascension_TutorialFrame:CreateTexture(nil, "ARTWORK")
Ascension_TutorialFrameTexture:SetSize(Ascension_TutorialFrame:GetSize())
Ascension_TutorialFrameTexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Tutorial\\tutorial_Tex1")
Ascension_TutorialFrameTexture:SetPoint("CENTER",Ascension_TutorialFrame,0,0)

local Ascension_TutorialFrame_TextBox = CreateFrame("EditBox",nil,Ascension_TutorialFrame)
Ascension_TutorialFrame_TextBox:SetWidth(330)
Ascension_TutorialFrame_TextBox:SetHeight(30)
Ascension_TutorialFrame_TextBox:SetFontObject(GameFontNormal)

Ascension_TutorialFrame_TextBox:SetMaxLetters(420)
Ascension_TutorialFrame_TextBox:SetIndentedWordWrap(false)
Ascension_TutorialFrame_TextBox:SetMultiLine(true)
Ascension_TutorialFrame_TextBox:SetMaxResize(843, 80)
Ascension_TutorialFrame_TextBox:ClearFocus(self)
Ascension_TutorialFrame_TextBox:SetAutoFocus(false)
Ascension_TutorialFrame_TextBox:EnableMouse(false)
Ascension_TutorialFrame_TextBox:SetPoint("CENTER",Ascension_TutorialFrame,7,-40)
Ascension_TutorialFrame_TextBox:SetFont("Fonts\\FRIZQT__.TTF", 12)
Ascension_TutorialFrame_TextBox:SetJustifyH("CENTER")
Ascension_TutorialFrame_TextBox:SetText("|cffFFFFFFAscension is a progressive Classless project, starting from Vanilla progressing through the expansions. The realms vary from softcore: just the Vanilla world with Classless systems to hardcore with elements like Hunger, High risk death, and Randomly Enchanted items.|r")

local Ascension_TutorialFrame_NextButton = CreateFrame("Button", "Ascension_TutorialFrame_NextButton", Ascension_TutorialFrame, nil)
Ascension_TutorialFrame_NextButton:SetSize(26, 26)
Ascension_TutorialFrame_NextButton:SetPoint("CENTER",110,-103)
Ascension_TutorialFrame_NextButton:EnableMouse(true)

Ascension_TutorialFrame_NextButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up")
Ascension_TutorialFrame_NextButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down")
Ascension_TutorialFrame_NextButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled")
Ascension_TutorialFrame_NextButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

local Ascension_TutorialFrame_PrevButton = CreateFrame("Button", "Ascension_TutorialFrame_PrevButton", Ascension_TutorialFrame, nil)
Ascension_TutorialFrame_PrevButton:SetSize(26, 26)
Ascension_TutorialFrame_PrevButton:SetPoint("CENTER",-105,-103)
Ascension_TutorialFrame_PrevButton:EnableMouse(true)

Ascension_TutorialFrame_PrevButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up")
Ascension_TutorialFrame_PrevButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down")
Ascension_TutorialFrame_PrevButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled")
Ascension_TutorialFrame_PrevButton:SetHighlightTexture("Interface\\Buttons\\UI-Common-MouseHilight")

 Ascension_TutorialFrame_NextButton.Text = Ascension_TutorialFrame_NextButton:CreateFontString("Ascension_TutorialFrame_NextButton.Text")
--Ascension_TutorialFrame_NextButton.Text:SetFont("Fonts\\FRIZQT__.TTF", 12.2)
Ascension_TutorialFrame_NextButton.Text:SetPoint("CENTER",-30, 0)
Ascension_TutorialFrame_NextButton.Text:SetFontObject(GameFontHighlightSmall)
Ascension_TutorialFrame_NextButton.Text:SetShadowOffset(1,-1)
Ascension_TutorialFrame_NextButton.Text:SetText("Next")

 Ascension_TutorialFrame_PrevButton.Text = Ascension_TutorialFrame_PrevButton:CreateFontString("Ascension_TutorialFrame_PrevButton.Text")
--Ascension_TutorialFrame_PrevButton.Text:SetFont("Fonts\\FRIZQT__.TTF", 12.2)
Ascension_TutorialFrame_PrevButton.Text:SetPoint("CENTER",30, 0)
Ascension_TutorialFrame_PrevButton.Text:SetFontObject(GameFontHighlightSmall)
Ascension_TutorialFrame_PrevButton.Text:SetShadowOffset(1,-1)
Ascension_TutorialFrame_PrevButton.Text:SetText("Prev")


--SCRIPTS PART--
Ascension_TutorialFrame_PrevButton:SetScript("OnUpdate", function(self)
    if (CURRENTTIP == 1) and self:IsEnabled() then
        self:Disable()
        elseif (CURRENTTIP ~= 1) then
            self:Enable()
    end
    end)

Ascension_TutorialFrame_NextButton:SetScript("OnUpdate", function(self)
    if (CURRENTTIP == MAXTIPS) and self:IsEnabled() then
        self:Disable()
        elseif (CURRENTTIP < MAXTIPS) then
            self:Enable()
    end
    end)

Ascension_TutorialFrame_PrevButton:SetScript("OnClick", function()
CURRENTTIP = CURRENTTIP -1 
    end)

Ascension_TutorialFrame_NextButton:SetScript("OnClick", function()
CURRENTTIP = CURRENTTIP +1
    end)

Ascension_TutorialFrame:SetScript("OnUpdate", function(self)
    if (Ascension_TutorialFrame_TextBox:GetText() ~= TUTORIAL_TIPS[CURRENTTIP][2]) then
        Ascension_TutorialFrameTexture:SetTexture(TUTORIAL_TIPS[CURRENTTIP][1])
        Ascension_TutorialFrame_TextBox:SetText(TUTORIAL_TIPS[CURRENTTIP][2])
    end
    end)

 function TutAIO.InitFrame(player,currtip,maxtips) -- AIO
    CURRENTTIP = currtip
    MAXTIPS = maxtips
    Ascension_TutorialFrame:Show()
 end