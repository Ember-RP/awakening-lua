local AIO = AIO or require("AIO")


if AIO.AddAddon() then
    return
end


local MyHandlers = AIO.AddHandlers("sideBar", {})

local scrollitem = 1101243
--fading function

FramesToFade = {}

function BaseFrameFade(frame, mode)
    if (frame) then
        frame.FadeTimer = 0
        if (frame.time) then
          frame.TimeToFade = frame.time
        else
        frame.TimeToFade = 3
      end
        frame.FadeMode = mode
        table.insert(FramesToFade, frame)
    end
end

function BaseFrameFadeIn(frame, mode)
    BaseFrameFade(frame, "IN")
    frame:Show()
end

function BaseFrameFadeOut(frame, mode)
    BaseFrameFade(frame, "OUT")
    --frame:Show()
end

function BaseFading(elapsed)
    for k,frame in pairs(FramesToFade) do
        frame.FadeTimer = frame.FadeTimer + 0.1
        if (frame.FadeTimer < frame.TimeToFade) then
            if (frame.FadeMode == "IN") then
            frame:SetAlpha(frame.FadeTimer/frame.TimeToFade)
            elseif (frame.FadeMode == "OUT") then
                frame:SetAlpha((frame.TimeToFade-frame.FadeTimer)/frame.TimeToFade)
            end
        else
            if ( frame.FadeMode == "IN" ) then
                frame:SetAlpha(1.0);
            elseif ( frame.FadeMode == "OUT" ) then
                frame:SetAlpha(0);
                frame:Hide()
            end
            table.remove(FramesToFade, k)
        end
    end
    end

fadingFunc = CreateFrame("FRAME", "fadingFunc")
fadingFunc:SetScript("OnUpdate", BaseFading)
--end of fading function

--[[TEMP RESET COINAGE AMOUNT]]--
--talent reset cost, ability reset cost, level modifier--
--[[local Reset_Level = {
    [0] = {2500, 2700, 105},
    [10] = {5000, 7500, 150},
    [20] = {7500, 10000, 2150},
    [30] = {50000,150000,3250},
    [40] = {150000,300000,9250},
    [50] = {300000,1000000,10550},
    [60] = {500000,2500000,20000},
}

local function GetMoneyForReset(purgemissing)
    -- 1 - talent cost
    -- 2 - ability cost
for k,v in pairs(Reset_Level) do
    if (UnitLevel("player") >= k) and (UnitLevel("player") < k+10) then
        local talent_cost = Reset_Level[k][purgemissing] + Reset_Level[k][3]*(UnitLevel("player")-k)

        local talent_cost_gold = floor(abs(talent_cost / 10000))
        local talent_cost_silver = floor(abs(mod(talent_cost / 100, 100)))
        local talent_cost_cooper = floor(abs(mod(talent_cost, 100)))
        return talent_cost, talent_cost_gold, talent_cost_silver, talent_cost_cooper
    end
end
--]]
--[[TEMP RESET COINAGE AMOUNT]]--
local function CanBeUnlearned(slot, item)
    -- item check
    -- player has spell check
    local spellname,rank,spellid = GameTooltip:GetSpell()
    if (GameTooltip:GetSpell() and IsSpellLearned(spellid) and (GetItemCount(scrollitem) > 0)) then
        return true
    end
    return false
end

Framework_Base = CreateFrame("Frame", "sideBar", UIParent, nil)
local sideBar = Framework_Base
sideBar:SetFrameStrata("LOW")
        sideBar:SetSize(912, 456)
        sideBar:SetMovable(true)
        sideBar:EnableMouse(true)
        sideBar:RegisterForDrag("LeftButton")
        sideBar:SetPoint("CENTER", 0, 0)
        sideBar:SetClampedToScreen(true)
        sideBar:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\misc\\main",}) 

    sideBar:SetScript("OnUpdate" , function() 
    local itemCount_sb = GetItemCount(383080) or 0
    sideBar.Text_Ability:SetText("|cffE1AB18Ability Essence: |cffFFFFFF"..itemCount_sb)
    local itemCount_sb2 = GetItemCount(383081) or 0
    sideBar.Text_Talent:SetText("|cffE1AB18Talent Essence: |cffFFFFFF"..itemCount_sb2)
    local itemCount_sb_r = GetItemCount(383082) or 0
    sideBar.Text_Ability_Reset:SetText("|cffE1AB18Ability Resets: |cffFFFFFF"..itemCount_sb_r)
    local itemCount_sb2_r = GetItemCount(383083) or 0
    sideBar.Text_Talent_Reset:SetText("|cffE1AB18Talent Resets: |cffFFFFFF"..itemCount_sb2_r)
    end)
        
    sideBar:SetScript("OnDragStart", sideBar.StartMoving)
    sideBar:SetScript("OnHide", sideBar.StopMovingOrSizing)
    sideBar:SetScript("OnDragStop", sideBar.StopMovingOrSizing)
    sideBar:EnableKeyboard(1)
    sideBar:SetScript("OnKeyDown", function(self, arg1)
    if (arg1 == "ESCAPE") then
        self:Hide()
    end
    end)

    AIO.SavePosition(sideBar)
    local ui_w, ui_h = UIParent:GetSize()
    local ui_diff = 1
    local uiScale = 1

        local MainFrame_ButtonModels_Ulduar1 = CreateFrame("Model", "MainFrame_ButtonModels_Ulduar1", sideBar)
        MainFrame_ButtonModels_Ulduar1:SetWidth(ui_w*30/100);               
        MainFrame_ButtonModels_Ulduar1:SetHeight(ui_h*41.5/100);
        MainFrame_ButtonModels_Ulduar1:SetPoint("CENTER", sideBar, "CENTER", 170, 5)
        MainFrame_ButtonModels_Ulduar1:SetModel("Creature\\Tempscarletcrusaderheavy\\scarletcrusaderheavy.m2")
        MainFrame_ButtonModels_Ulduar1:SetModelScale(0.3)
        MainFrame_ButtonModels_Ulduar1:SetCamera(0)
        MainFrame_ButtonModels_Ulduar1:SetPosition(0.0,0.0,2)
        MainFrame_ButtonModels_Ulduar1:SetAlpha(0.4)

        local MainFrame_ButtonModels_Ulduar2 = CreateFrame("Model", "MainFrame_ButtonModels_Ulduar2", sideBar)
        MainFrame_ButtonModels_Ulduar2:SetWidth(ui_w*22/100);               
        MainFrame_ButtonModels_Ulduar2:SetHeight(ui_h*41.5/100);
        MainFrame_ButtonModels_Ulduar2:SetPoint("CENTER", sideBar, "CENTER", -180, 5)
        MainFrame_ButtonModels_Ulduar2:SetModel("Creature\\Tempscarletcrusaderheavy\\scarletcrusaderheavy.m2")
        MainFrame_ButtonModels_Ulduar2:SetModelScale(0.3)
        MainFrame_ButtonModels_Ulduar2:SetCamera(0)
        MainFrame_ButtonModels_Ulduar2:SetPosition(0.0,0.0,2)
        MainFrame_ButtonModels_Ulduar2:SetAlpha(0.4)
        MainFrame_ButtonModels_Ulduar2:SetFacing(0.1)

        local MainFrame_ButtonModels_Ulduar3 = CreateFrame("Model", "MainFrame_ButtonModels_Ulduar3", sideBar)
        MainFrame_ButtonModels_Ulduar3:SetWidth(ui_w*34.4/100);               
        MainFrame_ButtonModels_Ulduar3:SetHeight(ui_h*52/100);
        MainFrame_ButtonModels_Ulduar3:SetPoint("CENTER", sideBar, "CENTER", 0, 10)
        MainFrame_ButtonModels_Ulduar3:SetModel("Creature\\Tempscarletcrusaderheavy\\scarletcrusaderheavy.m2")
        MainFrame_ButtonModels_Ulduar3:SetModelScale(0.3)
        MainFrame_ButtonModels_Ulduar3:SetCamera(0)
        MainFrame_ButtonModels_Ulduar3:SetPosition(0.0,0.0,2)
        MainFrame_ButtonModels_Ulduar3:SetAlpha(0.4)
        MainFrame_ButtonModels_Ulduar3:SetFacing(0.1)
        --MainFrame_ButtonModels_Ulduar1:Hide()
        sideBar:Hide()
        sideBar:SetScript("OnShow", function()
                 if (GetCVar("useUiScale") == "1") then
                ui_diff = 1
                uiScale = GetCVar("uiScale")
            else
                --SetCVar("useUiScale","1")
                SetCVar("uiScale","1")
                ui_diff = ui_h/768
                uiScale = 1
                end -- resolution and uiscale fix
            MainFrame_ButtonModels_Ulduar1:SetModel("World\\Expansion02\\doodads\\ulduar\\ul_statue_03.m2")
            MainFrame_ButtonModels_Ulduar1:SetModelScale(0.23)
            MainFrame_ButtonModels_Ulduar1:SetPosition(-0.27,0.0,1.662/uiScale*ui_diff)
            MainFrame_ButtonModels_Ulduar1:SetFacing(-0.3)
            MainFrame_ButtonModels_Ulduar1:SetAlpha(0.8)

            MainFrame_ButtonModels_Ulduar2:SetModel("World\\Expansion02\\doodads\\ulduar\\ul_smallstatue_druid.m2")
            MainFrame_ButtonModels_Ulduar2:SetModelScale(0.17)
            MainFrame_ButtonModels_Ulduar2:SetPosition(0.1,0.0,1.785/uiScale*ui_diff)
            MainFrame_ButtonModels_Ulduar2:SetFacing(3.9)
            MainFrame_ButtonModels_Ulduar2:SetAlpha(0.8)

            MainFrame_ButtonModels_Ulduar3:SetModel("World\\Expansion02\\doodads\\ulduar\\ul_statue_02.m2")
            MainFrame_ButtonModels_Ulduar3:SetModelScale(0.17)
            MainFrame_ButtonModels_Ulduar3:SetPosition(0.05,0.0,1.685/uiScale*ui_diff)
            MainFrame_ButtonModels_Ulduar3:SetFacing(3.6)
            MainFrame_ButtonModels_Ulduar3:SetAlpha(0.8)
            end)
    
    sideBar.Text_Ability = sideBar:CreateFontString()
    sideBar.Text_Ability:SetFontObject(GameFontNormal)
    sideBar.Text_Ability:SetPoint("BOTTOM", sideBar,  -190, 90);
    sideBar.Text_Ability:SetFont("Fonts\\MORPHEUS.TTF", 15, "OUTLINE")
    --MainFrame.Text_Ability:Hide()

    sideBar.Text_Talent = sideBar:CreateFontString()
    sideBar.Text_Talent:SetFontObject(GameFontNormal)
    sideBar.Text_Talent:SetPoint("BOTTOM", sideBar,  -190, 65);
    sideBar.Text_Talent:SetFont("Fonts\\MORPHEUS.TTF", 15, "OUTLINE")
    --MainFrame.Text_Talent:Hide()

        sideBar.Text_Ability_Reset = sideBar:CreateFontString()
    sideBar.Text_Ability_Reset:SetFontObject(GameFontNormal)
    sideBar.Text_Ability_Reset:SetPoint("BOTTOM", sideBar,  190, 90);
    sideBar.Text_Ability_Reset:SetFont("Fonts\\MORPHEUS.TTF", 15, "OUTLINE")
    --MainFrame.Text_Ability_Reset:Hide()

    sideBar.Text_Talent_Reset = sideBar:CreateFontString()
    sideBar.Text_Talent_Reset:SetFontObject(GameFontNormal)
    sideBar.Text_Talent_Reset:SetPoint("BOTTOM", sideBar,  190, 65);
    sideBar.Text_Talent_Reset:SetFont("Fonts\\MORPHEUS.TTF", 15, "OUTLINE")
    --MainFrame.Text_Talent_Reset:Hide()

        sideBar.Text_Title = sideBar:CreateFontString()
    sideBar.Text_Title:SetFontObject(GameFontNormal)
    sideBar.Text_Title:SetPoint("BOTTOM", sideBar,  -2, 120);
    sideBar.Text_Title:SetFont("Fonts\\MORPHEUS.TTF", 15)
    sideBar.Text_Title:SetShadowOffset(0, -1)
    sideBar.Text_Title:SetText("|cff230d21Character Upgrades|r")
    --MainFrame.Text_Title:Hide()

   local sideBar_CloseButton = CreateFrame("Button", "sideBar_CloseButton", sideBar, "UIPanelCloseButton")
    sideBar_CloseButton:SetPoint("TOPRIGHT", -121, -55) --edited
    sideBar_CloseButton:EnableMouse(true)
    --sideBar_CloseButton:SetSize(29, 29) --edited
    sideBar_CloseButton:SetScript("OnMouseUp", function()
        PlaySound("Glyph_MajorDestroy")
        BaseFrameFadeOut(sideBar)
        end)

    sideBar.Text_CheckBox = sideBar:CreateFontString()
    sideBar.Text_CheckBox:SetFontObject(GameFontNormal)
    sideBar.Text_CheckBox:SetPoint("BOTTOM", sideBar,  -2, 70);
    sideBar.Text_CheckBox:SetFont("Fonts\\FRIZQT__.TTF", 12)
    sideBar.Text_CheckBox:SetShadowOffset(0, -1)
    sideBar.Text_CheckBox:SetText("|cffFFFFFFEnable/disable quick access to\ncharacter progression menu|r")
    --edited
    --edited
	
	
    --[[TRAINING FRAME]]--
     local TrainingFrame = CreateFrame("Frame", "TrainingFrame", UIParent, nil)
        TrainingFrame:SetSize(950, 860)
        --TrainingFrame:SetMovable(true)
        TrainingFrame:EnableMouse(true)
        --TrainingFrame:RegisterForDrag("LeftButton")
        TrainingFrame:SetPoint("CENTER", 0, 45)
        TrainingFrame:SetFrameStrata("DIALOG")
        --TrainingFrame:SetClampedToScreen(true)
        TrainingFrame:EnableMouseWheel(true)
        TrainingFrame:SetScript("OnMouseWheel", function(self, delta)
            if (scrollbar:IsVisible()) then
        local value = scrollbar:GetValue()
        scrollbar:SetValue(value-delta*30)
    end
        end)
        TrainingFrame:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\progress",}) --edited
        TrainingFrame:Hide()

        TrainingFrame_model = CreateFrame("Model", "TrainingFrame_model", TrainingFrame)
        TrainingFrame_model:SetWidth(560);               
        TrainingFrame_model:SetHeight(655);
        TrainingFrame_model:SetPoint("CENTER", TrainingFrame, "CENTER", -105, -30)
        TrainingFrame_model:SetModel("World\\Expansion01\\doodads\\theexodar\\passivedoodads\\paladin_energy_fx\\exodar_paladin_shrine_energyfx.m2")
        TrainingFrame_model:SetModelScale(0.04)
        TrainingFrame_model:SetCamera(0)
        TrainingFrame_model:SetPosition(0.075,0.09,0)
        TrainingFrame_model:SetAlpha(0.002)
        TrainingFrame_model:SetFacing(0.1)
        TrainingFrame_model:Hide()

        TrainingFrame_model2 = CreateFrame("Model", "TrainingFrame_model2", TrainingFrame)
        TrainingFrame_model2:SetWidth(560);               
        TrainingFrame_model2:SetHeight(655);
        TrainingFrame_model2:SetPoint("CENTER", TrainingFrame, "CENTER", -105, -30)
        TrainingFrame_model2:SetModel("World\\Expansion01\\doodads\\netherstorm\\crackeffects\\netherstormcracksmokeblue.m2")
        TrainingFrame_model2:SetModelScale(0.2)
        TrainingFrame_model2:SetCamera(0)
        TrainingFrame_model2:SetPosition(0.18,0.20,0)
        TrainingFrame_model2:SetAlpha(0.8)
        TrainingFrame_model2:SetFacing(0.1)
        TrainingFrame_model2:Hide()


        TrainingFrame_SelectedTitle = CreateFrame("Frame", "TrainingFrame_SelectedTitle", TrainingFrame, nil)
        TrainingFrame_SelectedTitle:SetSize(TrainingFrame:GetSize())
        TrainingFrame_SelectedTitle:SetPoint("CENTER",0,0)

        local TrainingFrame_SelectedTitle_Stars1 = CreateFrame("Model", "TrainingFrame_SelectedTitle_Stars1", TrainingFrame_SelectedTitle)
        TrainingFrame_SelectedTitle_Stars1:SetWidth(560);               
        TrainingFrame_SelectedTitle_Stars1:SetHeight(655);
        TrainingFrame_SelectedTitle_Stars1:SetPoint("CENTER", TrainingFrame, "CENTER", -105, -30)
        TrainingFrame_SelectedTitle_Stars1:SetModel("Creature\\Tempscarletcrusaderheavy\\scarletcrusaderheavy.m2")
        TrainingFrame_SelectedTitle_Stars1:SetModelScale(0.3)
        TrainingFrame_SelectedTitle_Stars1:SetCamera(0)
        TrainingFrame_SelectedTitle_Stars1:SetPosition(0.0,0.0,2)
        TrainingFrame_SelectedTitle_Stars1:SetAlpha(0.4)
        TrainingFrame_SelectedTitle_Stars1:SetFacing(0.1)
        TrainingFrame_SelectedTitle_Stars1:Hide()


        local TrainingFrame_SelectedTitle_Stars1_glow = CreateFrame("Model", "TrainingFrame_SelectedTitle_Stars1_glow", TrainingFrame_SelectedTitle)
        TrainingFrame_SelectedTitle_Stars1_glow:SetWidth(256);               
        TrainingFrame_SelectedTitle_Stars1_glow:SetHeight(256);
        TrainingFrame_SelectedTitle_Stars1_glow:SetPoint("CENTER", TrainingFrame_SelectedTitle_Stars1, "CENTER", -160, 0)
        TrainingFrame_SelectedTitle_Stars1_glow:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")
        TrainingFrame_SelectedTitle_Stars1_glow:SetModelScale(0.02)
        TrainingFrame_SelectedTitle_Stars1_glow:SetCamera(0)
        TrainingFrame_SelectedTitle_Stars1_glow:SetPosition(0.075,0.09,0)
        TrainingFrame_SelectedTitle_Stars1_glow:SetAlpha(0.7)
        TrainingFrame_SelectedTitle_Stars1_glow:SetFacing(0)
        TrainingFrame_SelectedTitle_Stars1_glow:Hide()

        local TrainingFrame_SelectedTitle_Stars2 = CreateFrame("Model", "TrainingFrame_SelectedTitle_Stars2", TrainingFrame_SelectedTitle)
        TrainingFrame_SelectedTitle_Stars2:SetWidth(560);               
        TrainingFrame_SelectedTitle_Stars2:SetHeight(655);
        TrainingFrame_SelectedTitle_Stars2:SetPoint("CENTER", TrainingFrame, "CENTER", 230, -30)
        TrainingFrame_SelectedTitle_Stars2:SetModel("Creature\\Tempscarletcrusaderheavy\\scarletcrusaderheavy.m2")
        TrainingFrame_SelectedTitle_Stars2:SetModelScale(0.3)
        TrainingFrame_SelectedTitle_Stars2:SetCamera(0)
        TrainingFrame_SelectedTitle_Stars2:SetPosition(0.0,0.0,2)
        TrainingFrame_SelectedTitle_Stars2:SetAlpha(0.4)
        TrainingFrame_SelectedTitle_Stars2:SetFacing(0.1)
        TrainingFrame_SelectedTitle_Stars2:Hide()


        local TrainingFrame_SelectedTitle_Stars2_glow = CreateFrame("Model", "TrainingFrame_SelectedTitle_Stars2_glow", TrainingFrame_SelectedTitle)
        TrainingFrame_SelectedTitle_Stars2_glow:SetWidth(256);               
        TrainingFrame_SelectedTitle_Stars2_glow:SetHeight(256);
        TrainingFrame_SelectedTitle_Stars2_glow:SetPoint("CENTER", TrainingFrame_SelectedTitle_Stars2, "CENTER", -160, 0)
        TrainingFrame_SelectedTitle_Stars2_glow:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")
        TrainingFrame_SelectedTitle_Stars2_glow:SetModelScale(0.02)
        TrainingFrame_SelectedTitle_Stars2_glow:SetCamera(0)
        TrainingFrame_SelectedTitle_Stars2_glow:SetPosition(0.075,0.09,0)
        TrainingFrame_SelectedTitle_Stars2_glow:SetAlpha(0.7)
        TrainingFrame_SelectedTitle_Stars2_glow:SetFacing(0)
        TrainingFrame_SelectedTitle_Stars2_glow:Hide()

        TrainingFrame_SelectedTitle:SetScript("OnShow", function()
                 if (GetCVar("useUiScale") == "1") then
                ui_diff = 1
                uiScale = GetCVar("uiScale")
            else
                --SetCVar("useUiScale","1")
                SetCVar("uiScale","1")
                ui_diff = ui_h/768
                uiScale = 1
                end -- resolution and uiscale fix
            TrainingFrame_SelectedTitle_Stars1:SetModel("Particles\\Lootfx2.m2")
            TrainingFrame_SelectedTitle_Stars1:SetModelScale(0.1)
            TrainingFrame_SelectedTitle_Stars1:SetPosition(0.2,0.0,1.85/uiScale*ui_diff)
            TrainingFrame_SelectedTitle_Stars1:SetAlpha(0.8)
            TrainingFrame_SelectedTitle_Stars2:SetModel("Particles\\Lootfx2.m2")
            TrainingFrame_SelectedTitle_Stars2:SetModelScale(0.1)
            TrainingFrame_SelectedTitle_Stars2:SetPosition(0.2,0.0,1.85/uiScale*ui_diff)
            TrainingFrame_SelectedTitle_Stars2:SetAlpha(0.8)
            end)

        local TrainingFrame_SelectedTitle_Glow = TrainingFrame_SelectedTitle:CreateTexture("TrainingFrame_SelectedTitle_Glow") 
        TrainingFrame_SelectedTitle_Glow:SetAllPoints() 
        TrainingFrame_SelectedTitle_Glow:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_cover_glow") 
        TrainingFrame_SelectedTitle_Glow:SetSize(TrainingFrame_SelectedTitle:GetSize())
        TrainingFrame_SelectedTitle_Glow:Hide()

        --[[07032017local TrainingFrame_SelectedTitle_Spells = TrainingFrame_SelectedTitle:CreateTexture("TrainingFrame_SelectedTitle_Spells")  08032017
        --TrainingFrame_SelectedTitle_Spells:SetAllPoints() 
        TrainingFrame_SelectedTitle_Spells:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\spellicon") 
        TrainingFrame_SelectedTitle_Spells:SetPoint("CENTER", TrainingFrame_SelectedTitle, "CENTER", -114, 55)
        TrainingFrame_SelectedTitle_Spells:SetSize(64,64)]]-- 08032017
        font_TrainingFrame_SelectedTitle_Spells = TrainingFrame_SelectedTitle:CreateFontString("TrainingFrame_SelectedTitle_Spells")
        font_TrainingFrame_SelectedTitle_Spells:SetFontObject(GameFontNormal)
        font_TrainingFrame_SelectedTitle_Spells:SetShadowOffset(1, -1)
        font_TrainingFrame_SelectedTitle_Spells:SetText("Click to display spells")
        font_TrainingFrame_SelectedTitle_Spells:SetPoint("CENTER", TrainingFrame_SelectedTitle, "CENTER", -114, -300)
        font_TrainingFrame_SelectedTitle_Spells:Hide()
        --TrainingFrame_SelectedTitle_Spells:Hide()

        --[[07032017local TrainingFrame_SelectedTitle_Talents = TrainingFrame_SelectedTitle:CreateTexture("TrainingFrame_SelectedTitle_Talents")  08032017
        --TrainingFrame_SelectedTitle_Talents:SetAllPoints() 
        TrainingFrame_SelectedTitle_Talents:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\talenticon") 
        TrainingFrame_SelectedTitle_Talents:SetPoint("CENTER", TrainingFrame_SelectedTitle, "CENTER", -114, 55)
        TrainingFrame_SelectedTitle_Talents:SetSize(64,64)]]-- 08032017
        font_TrainingFrame_SelectedTitle_Talents = TrainingFrame_SelectedTitle:CreateFontString("TrainingFrame_SelectedTitle_Talents")
        font_TrainingFrame_SelectedTitle_Talents:SetFontObject(GameFontNormal)
        --font_TrainingFrame_SelectedTitle_Talents:SetFont("Fonts\\MORPHEUS.TTF", 22, "OUTLINE")
        font_TrainingFrame_SelectedTitle_Talents:SetShadowOffset(1, -1)
        font_TrainingFrame_SelectedTitle_Talents:SetText("Click to display talents")
        font_TrainingFrame_SelectedTitle_Talents:SetPoint("CENTER", TrainingFrame_SelectedTitle, "CENTER", -114, -300)
        font_TrainingFrame_SelectedTitle_Talents:Hide()
        --TrainingFrame_SelectedTitle_Talents:Hide()
        
        --TrainingFrame:SetScript("OnDragStart", TrainingFrame.StartMoving)
        --TrainingFrame:SetScript("OnHide", TrainingFrame.StopMovingOrSizing)
        --TrainingFrame:SetScript("OnDragStop", TrainingFrame.StopMovingOrSizing)
        TrainingFrame:EnableKeyboard(1)
        TrainingFrame:SetScript("OnKeyDown", function(self, arg1)
        if (arg1 == "ESCAPE") then
        self:Hide()
        end
        end)

    AIO.SavePosition(sideBar)
		
		--AIO.SavePosition(TrainingFrame)
		
		
	--[[Skill Frame]]
	local StatFrame = CreateFrame("Frame", "StatFrame", UIParent, nil)
        StatFrame:SetSize(430, 480) --edited
        --StatFrame:SetScale(0.88)--making everything more or less fit standart sizes of blizz interfaces
        StatFrame:SetMovable(true)
        StatFrame:EnableMouse(true)
        StatFrame:RegisterForDrag("LeftButton")
        StatFrame:SetPoint("CENTER")
        StatFrame:SetClampedToScreen(true)
        StatFrame:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\allocation"}) --edited
        StatFrame:Hide()
        
        StatFrame:SetScript("OnDragStart", StatFrame.StartMoving)
        StatFrame:SetScript("OnHide", StatFrame.StopMovingOrSizing)
        StatFrame:SetScript("OnDragStop", StatFrame.StopMovingOrSizing)
        StatFrame_model = CreateFrame("Model", "StatFrame_model", StatFrame)
        StatFrame_model:SetWidth(256);               
        StatFrame_model:SetHeight(256);
        StatFrame_model:SetPoint("BOTTOM", StatFrame, "CENTER", 15, -350)
        StatFrame_model:SetModel("World\\Kalimdor\\silithus\\passivedoodads\\ahnqirajglow\\quirajglow.m2")
        StatFrame_model:SetModelScale(0.02)
        StatFrame_model:SetCamera(0)
        StatFrame_model:SetPosition(0.075,0.09,0)
        StatFrame_model:SetAlpha(0.7)
        StatFrame_model:SetFacing(0)

        StatFrame:EnableKeyboard(1)
        StatFrame:SetScript("OnKeyDown", function(self, arg1)
        if (arg1 == "ESCAPE") then
        self:Hide()
        end
        end)
		
		AIO.SavePosition(StatFrame)
	
		
	-- training button
        --[[local sideBarOpeningFrameButton = CreateFrame("Button", "sideBarOpeningFrameButton", UIParent)
        sideBarOpeningFrameButton:SetSize(256, 128)
        sideBarOpeningFrameButton:SetPoint("CENTER", -60, 50)
        sideBarOpeningFrameButton:EnableMouse(true)
        sideBarOpeningFrameButton:SetMovable(true)
        sideBarOpeningFrameButton:EnableMouse(true)
        sideBarOpeningFrameButton:RegisterForDrag("LeftButton")
        sideBarOpeningFrameButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\mainb")
        sideBarOpeningFrameButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\mainb_h")

        local sideBarOpeningFrameButton_text = sideBarOpeningFrameButton:CreateFontString("sideBarOpeningFrameButton_text") -- edited
        sideBarOpeningFrameButton_text:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE") -- edited
        sideBarOpeningFrameButton_text:SetSize(250, 5)
        sideBarOpeningFrameButton_text:SetPoint("CENTER", 0, 3) -- edited
        sideBarOpeningFrameButton_text:SetText("Character Upgrades") -- edited
        sideBarOpeningFrameButton:SetFontString(sideBarOpeningFrameButton_text)
        --sideBarOpeningFrameButton:SetPushedTexture("Interface/Buttons/CheckButtonHilight")
        local function sideBarOpeningFrameButton_pushed(self)
            if not(sideBar:IsVisible()) then
            BaseFrameFadeIn(sideBar)
        else
            BaseFrameFadeOut(sideBar)
        end
        end
        sideBarOpeningFrameButton:SetScript("OnMouseUp", sideBarOpeningFrameButton_pushed)
        sideBarOpeningFrameButton:SetScript("OnDragStart", sideBar.StartMoving)
        sideBarOpeningFrameButton:SetScript("OnHide", sideBar.StopMovingOrSizing)
        sideBarOpeningFrameButton:SetScript("OnDragStop", sideBar.StopMovingOrSizing)]]--
        LFDMicroButton:Hide()
        local TOOLTIP_AWAKENING = "Using this menu you'll be\nable to reset your spells or talents,\nto get new abilities and allocate\nstats of your character"
        function togglesiderframe()
            TrainingFrame:Hide() StatFrame:Hide()
            if not(sideBar:IsVisible()) then
            PlaySound("Glyph_MajorCreate")
            BaseFrameFadeIn(sideBar)
        else
            PlaySound("Glyph_MajorDestroy")
            BaseFrameFadeOut(sideBar)
        end
        end
        CharUpdatesMicroButton = CreateFrame("Button","CharUpdatesMicroButton",MainMenuBarArtFrame, "MainMenuBarMicroButton") 
        CharUpdatesMicroButton:SetPoint("BOTTOMLEFT", PVPMicroButton, "BOTTOMRIGHT", -3, 0)
                    CharUpdatesMicroButton:SetNormalTexture("Interface/Buttons/UI-MicroButton-Abilities-Up")
            CharUpdatesMicroButton:SetPushedTexture("Interface/Buttons/UI-MicroButton-Abilities-Down")
            CharUpdatesMicroButton:SetDisabledTexture("Interface/Buttons/UI-MicroButton-Abilities-Disabled")
            CharUpdatesMicroButton:SetHighlightTexture("Interface\\Buttons\\UI-MicroButton-Hilight");
        
        CharUpdatesMicroButton:SetScript("OnClick",function(self)
             togglesiderframe()
             SetButtonPulse(CharUpdatesMicroButton, 0, 1);  --Stop the button pulse
            SetButtonPulse(TrainingButton_fast, 0, 1);
            SetButtonPulse(AllocateButton_fast, 0, 1);
            end)
        CharUpdatesMicroButton:SetScript("OnEnter",function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:AddLine("|cffFFFFFFOpen Character Upgrades|r")
            GameTooltip:AddLine(TOOLTIP_AWAKENING)
            GameTooltip:Show()
            end)
        CharUpdatesMicroButton:SetScript("OnLeave",function(self)
            GameTooltip:Hide()
            end)

        --PULSE BUTTON IF PLAYER HAVE MORE THAN 2 ABILITY OR TALENT ESSENCES OR UNUSED STATS
        CharUpdatesMicroButton:RegisterEvent("PLAYER_LEVEL_UP")
        CharUpdatesMicroButton:SetScript("OnEvent", function(self,event,level)
            local itemCount_ability = GetItemCount(383080) or 0
            local itemCount_talent = GetItemCount(383081) or 0
            if (itemCount_ability >= 2) or (itemCount_talent >= 1) or (level == 2) or (level == 10) then
            SetButtonPulse(CharUpdatesMicroButton, 60, 1);
            SetButtonPulse(TrainingButton_fast, 60, 1);
            SetButtonPulse(AllocateButton_fast, 60, 1);
            end
        end)
        --SetBinding("I", togglesiderframe())

        --fast acces to frames--
       local fastaccessframe = CreateFrame("frame", "fastaccessframe", UIParent)
        fastaccessframe:SetSize(210,210)
        fastaccessframe:SetPoint("LEFT", 0, -80)
        --fastaccessframe:EnableMouse(true)
        fastaccessframe:SetMovable(true)
        --[[fastaccessframe:EnableMouse(true)
        fastaccessframe:RegisterForDrag("LeftButton")
        fastaccessframe:SetScript("OnDragStart", fastaccessframe.StartMoving)
        fastaccessframe:SetScript("OnHide", fastaccessframe.StopMovingOrSizing)
        fastaccessframe:SetScript("OnDragStop", fastaccessframe.StopMovingOrSizing)]]--
        fastaccessframe:SetFrameStrata("BACKGROUND")
        fastaccessframe:SetBackdrop({
           bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Misc\\fastbuttonHighlight",
                }) -- edited
        fastaccessframe:Hide()
        AIO.SavePosition(fastaccessframe)
        --fastaccessframe:SetScript

            local TrainingButton_fast = CreateFrame("Button", "TrainingButton_fast", fastaccessframe)
         TrainingButton_fast:SetSize(80, 80)
        TrainingButton_fast:SetPoint("CENTER", -40, 0)
        TrainingButton_fast:EnableMouse(true)
        TrainingButton_fast:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbutton")
        TrainingButton_fast:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbuttonhighlight")
        TrainingButton_fast:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Misc\\spell_Paladin_divinecircle",
             insets = {
            left = 18,
            right = 18,
            top = 18,
            bottom = 18}
                }) -- edited
        --TrainingButton_fast:SetMovable(true)
        TrainingButton_fast:RegisterForDrag("LeftButton")
        TrainingButton_fast:SetScript("OnDragStart", function(self) fastaccessframe:StartMoving() end)
        TrainingButton_fast:SetScript("OnHide", function(self) fastaccessframe:StopMovingOrSizing() end)
        TrainingButton_fast:SetScript("OnDragStop", function(self) fastaccessframe:StopMovingOrSizing() end)


            local AllocateButton_fast = CreateFrame("Button", "AllocateButton_fast", fastaccessframe)
        AllocateButton_fast:SetSize(64, 64)
        AllocateButton_fast:SetPoint("CENTER", 40, 10)
        AllocateButton_fast:EnableMouse(true)
        AllocateButton_fast:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbutton")
        AllocateButton_fast:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbuttonhighlight")
        AllocateButton_fast:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Misc\\Spell_Priest_Chakra",
             insets = {
            left = 14,
            right = 14,
            top = 14,
            bottom = 14}
                }) -- edited
        AllocateButton_fast:RegisterForDrag("LeftButton")
        AllocateButton_fast:SetScript("OnDragStart", function(self) fastaccessframe:StartMoving() end)
        AllocateButton_fast:SetScript("OnHide", function(self) fastaccessframe:StopMovingOrSizing() end)
        AllocateButton_fast:SetScript("OnDragStop", function(self) fastaccessframe:StopMovingOrSizing() end)


             local ResetButton_fast = CreateFrame("Button", "ResetButton_fast", fastaccessframe)
        ResetButton_fast:SetSize(52, 52)
        ResetButton_fast:SetPoint("CENTER", -20, -17)
        ResetButton_fast:EnableMouse(true)
        ResetButton_fast:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbutton")
        ResetButton_fast:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbuttonhighlight")
        ResetButton_fast:SetBackdrop({
            bgFile = "Interface\\Icons\\inv_custom_talentpurge",
             insets = {
            left = 12,
            right = 12,
            top = 12,
            bottom = 12}
                }) -- edited
        ResetButton_fast:SetFrameLevel(3)
        ResetButton_fast:RegisterForDrag("LeftButton")
        ResetButton_fast:SetScript("OnDragStart", function(self) fastaccessframe:StartMoving() end)
        ResetButton_fast:SetScript("OnHide", function(self) fastaccessframe:StopMovingOrSizing() end)
        ResetButton_fast:SetScript("OnDragStop", function(self) fastaccessframe:StopMovingOrSizing() end)

        --[[local ResetButton_fast_T = CreateFrame("Button", "ResetButton_fast_T", fastaccessframe)
        ResetButton_fast_T:SetSize(46, 46)
        ResetButton_fast_T:SetPoint("CENTER", -30, -30)
        ResetButton_fast_T:EnableMouse(true)
        ResetButton_fast_T:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbutton")
        ResetButton_fast_T:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\roundbuttonhighlight")
        ResetButton_fast_T:SetBackdrop({
            bgFile = "Interface\\Icons\\Ability_Marksmanship",
             insets = {
            left = 11,
            right = 11,
            top = 11,
            bottom = 11}
                }) -- edited
        ResetButton_fast_T:SetFrameLevel(3)]]--

        local fastaccessframe_h = fastaccessframe:CreateTexture(nil, "ARTWORK")
        fastaccessframe_h:SetSize(fastaccessframe:GetSize())
        fastaccessframe_h:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\fastbuttonHighlight_h")
        fastaccessframe_h:SetPoint("CENTER")
        fastaccessframe_h:Hide()
                fastaccessframe:SetScript("OnEnter", function()
            if not(fastaccessframe_h:IsVisible()) then
                BaseFrameFadeIn(fastaccessframe_h)
            end
            end)
                fastaccessframe:SetScript("OnLEave", function()
            if (fastaccessframe_h:IsVisible()) then
                BaseFrameFadeOut(fastaccessframe_h)
            end
            end)

        local sideBar_CheckBox = CreateFrame("CheckButton", "sideBar_CheckBox", sideBar, "ChatConfigSmallCheckButtonTemplate")
    sideBar_CheckBox:ClearAllPoints()
    sideBar_CheckBox:SetPoint("LEFT", sideBar.Text_CheckBox, -20, 0)
    sideBar_CheckBox:RegisterForClicks("AnyUp")
    sideBar_CheckBox:SetScript("OnClick", function(self)
        PlaySound("igMainMenuOptionCheckBoxOn")
        if not(self:GetChecked()) then
        fastaccessframe:Hide()
        table.remove(fastacc_var,1)
        table.insert(fastacc_var,1, 1)
        --print(fastacc_var[1])
    else
        fastaccessframe:Show()
        table.remove(fastacc_var,1)
        table.insert(fastacc_var,1, 2)
        --print(fastacc_var[1])
    end
        end)

    if not(fastacc_var) or (fastacc_var[1] == 2) then
        fastacc_var = {}
        sideBar_CheckBox:SetChecked(1)
        table.remove(fastacc_var,1)
        table.insert(fastacc_var,1, 2)
        fastaccessframe:Show()
    else
        fastaccessframe:Hide()
    end
            CharUpdatesMicroButton:SetScript("OnUpdate", function()
            if (fastacc_var[1] == 1) and (fastaccessframe:IsVisible()) then
                fastaccessframe:Hide()
                sideBar_CheckBox:SetChecked(0)
            end
            end)
    AIO.AddSavedVar("fastacc_var")


        --end of fast acces--
        
    local TrainingButton = CreateFrame("Button", "TrainingButton", sideBar)
        TrainingButton:SetSize(128, 64)
        TrainingButton:SetPoint("CENTER", 0, 20)
        TrainingButton:EnableMouse(true)
        TrainingButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        TrainingButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b_h")
        TrainingButton:SetFrameLevel(3)

        local TrainingButton_text = TrainingButton:CreateFontString("TrainingButton_text") -- edited
        TrainingButton_text:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE") -- edited
        TrainingButton_text:SetSize(250, 5)
        TrainingButton_text:SetPoint("CENTER", 0, 0) -- edited
        TrainingButton_text:SetText("Character Advancement") -- edited
        TrainingButton:SetFontString(TrainingButton_text)
        --TrainingButton:SetPushedTexture("Interface/Buttons/CheckButtonHilight")
        local function Training_button_pushed(self)
            SetButtonPulse(CharUpdatesMicroButton, 0, 1);  --Stop the button pulse
            SetButtonPulse(TrainingButton_fast, 0, 1);
            SetButtonPulse(AllocateButton_fast, 0, 1);

            if not(TrainingFrame:IsVisible()) then
                PlaySound("Glyph_MinorCreate")
            TrainingFrame:Show() StatFrame:Hide() ResetFrame_main:Hide()
        else
            PlaySound("Glyph_MinorDestroy")
            TrainingFrame:Hide()
        end
        end
        
        TrainingButton:SetScript("OnMouseUp", Training_button_pushed)
        
        local function TrainingButton_Tooltip_OnEnter(self, motion)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFCharacter Advancement|r\nLearn new skills, or allocate skill points\nto improve existing ones.")
            GameTooltip:Show()
        end
        TrainingButton:SetScript("OnEnter", TrainingButton_Tooltip_OnEnter)
        local function TrainingButton_Tooltip_OnLeave(self, motion)
            GameTooltip:Hide()
        end
        TrainingButton:SetScript("OnLeave", TrainingButton_Tooltip_OnLeave)
        
        
    -- stat allocation button
    local StatAllocationButton = CreateFrame("Button", StatAllocationButton, sideBar)
        StatAllocationButton:SetSize(128, 64)
        StatAllocationButton:SetPoint("CENTER", -200, -43)
        StatAllocationButton:EnableMouse(true)
        StatAllocationButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        StatAllocationButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b_h")
        StatAllocationButton:SetFrameLevel(3)
local StatAllocationButton_text = StatAllocationButton:CreateFontString("StatAllocationButton_text") -- edited
        StatAllocationButton_text:SetFont("Fonts\\MORPHEUS.TTF", 17, "OUTLINE") -- edited
        StatAllocationButton_text:SetSize(190, 5)
        StatAllocationButton_text:SetPoint("CENTER", 0, 0) -- edited
        StatAllocationButton_text:SetText("Stat Allocation") -- edited
        StatAllocationButton:SetFontString(StatAllocationButton_text)
        local function StatAllocation_button_pushed(self)
            SetButtonPulse(CharUpdatesMicroButton, 0, 1);  --Stop the button pulse
            SetButtonPulse(TrainingButton_fast, 0, 1);
            SetButtonPulse(AllocateButton_fast, 0, 1);
            PlaySound("igQuestCancel")
            if not(StatFrame:IsVisible()) then
            StatFrame:Show() TrainingFrame:Hide() ResetFrame_main:Hide()
            AIO.Handle("sideBar", "ReceivePlayerStats")
        else
            StatFrame:Hide()
        end
        end
        StatAllocationButton:SetScript("OnMouseUp",StatAllocation_button_pushed)
        local function StatAllocationButton_Tooltip_OnEnter(self, motion)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFStat Allocation|r\nManage allocation of your attribute\npoints.")
            GameTooltip:Show()
        end
        StatAllocationButton:SetScript("OnEnter", StatAllocationButton_Tooltip_OnEnter)
        local function StatAllocationButton_Tooltip_OnLeave(self, motion)
            GameTooltip:Hide()
        end

        StatAllocationButton:SetScript("OnLeave", StatAllocationButton_Tooltip_OnLeave)

        local function ResetButtonFast_Tooltip_OnEnter(self, motion)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFReset Spells/Talents|r\nUse your tokens or gold to refund\nyour Spells or Talents.")
            GameTooltip:Show()
        end
local function ResetButtonFast_Tooltip_OnLeave(self)
            GameTooltip:Hide()
        end

            local ResetUpgradesButton = CreateFrame("Button", "ResetUpgradesButton", sideBar)
        ResetUpgradesButton:SetSize(128, 64)
        ResetUpgradesButton:SetPoint("CENTER", 230, -43)
        ResetUpgradesButton:EnableMouse(true)
        ResetUpgradesButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        ResetUpgradesButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b_h")
        ResetUpgradesButton:SetFrameLevel(3)

        local ResetUpgradesButton_text = ResetUpgradesButton:CreateFontString("ResetUpgradesButton_text") -- edited
        ResetUpgradesButton_text:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE") -- edited
        ResetUpgradesButton_text:SetSize(250, 5)
        ResetUpgradesButton_text:SetPoint("CENTER", 0, 0) -- edited
        ResetUpgradesButton_text:SetText("Resets Spells/Talents") -- edited
        ResetUpgradesButton:SetFontString(ResetUpgradesButton_text)
        --ResetUpgradesButton:SetPushedTexture("Interface/Buttons/CheckButtonHilight")
        ResetUpgradesButton:SetScript("OnMouseUp", function()
            PlaySound("TalentScreenOpen")
                if not(ResetFrame_main:IsVisible()) then
                ResetFrame_main:Show() StatFrame:Hide() TrainingFrame:Hide()
                AIO.Handle("sideBar", "GetMults")
                else
                ResetFrame_main:Hide()
                end
            end)
        ResetUpgradesButton:SetScript("OnEnter", ResetButtonFast_Tooltip_OnEnter)
        ResetUpgradesButton:SetScript("OnLeave", ResetButtonFast_Tooltip_OnLeave)
        
        
    -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- ResetGui Frame -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
    --[[MAIN FRAME SCRIPTS]]--
local Ability_ResetMult = 0
local Talent_ResetMult = 0

local Reset_Level = {
    [0] = {2500, 2700, 105},
    [10] = {5000, 7500, 150},
    [20] = {7500, 10000, 2150},
    [30] = {50000,150000,3250},
    [40] = {150000,300000,9250},
    [50] = {300000,1000000,10550},
    [60] = {350000,1500000,20000},
    [70] = {500000,2500000,20000},
    [80] = {500000,2500000,20000},
}

local function GetMoneyForReset(purgetype)
local tokencount = nil
local mult = nil
local purge_cost = nil
local next_purge_cost = nil
--getting type of reset and token amount
    if (purgetype == 2) then
        mult = Ability_ResetMult
        tokencount = GetItemCount(383082)
        elseif (purgetype == 1) then
        mult = Talent_ResetMult
        tokencount = GetItemCount(383083)
    end
--player has enough tokens to make a reset
    if (tokencount > 1) then -- player has more than 1 token, show both costs in tokens
        purge_cost = "token"
        next_purge_cost = "token"
        return purge_cost, next_purge_cost
    else--player has not enough tokens to make a reset
for k,v in pairs(Reset_Level) do
    if (UnitLevel("player") >= k) and (UnitLevel("player") < k+10) then
        if (tokencount == 1) then -- player has one token, show current cost in tokens and next in gold
            purge_cost = "token"
            next_purge_cost = Reset_Level[k][purgetype] + Reset_Level[k][3]*(UnitLevel("player")-k+mult*2)
        else
            purge_cost = Reset_Level[k][purgetype] + Reset_Level[k][3]*(UnitLevel("player")-k+mult*2)
            next_purge_cost = Reset_Level[k][purgetype] + Reset_Level[k][3]*(UnitLevel("player")-k+(mult+1)*2)
         end
         --cap
         if (tonumber(purge_cost)) then
           if (purge_cost>Reset_Level[k][purgetype]*1.75) then
            purge_cost = Reset_Level[k][purgetype]*1.75
            end
        end
        if (tonumber(next_purge_cost)) then
            if (next_purge_cost>Reset_Level[k][purgetype]*1.75) then
            next_purge_cost = Reset_Level[k][purgetype]*1.75
            end
        end
         --end cap
        return purge_cost, next_purge_cost
    end
end
end -- end of the main "if"
end

 function GetGoldForMoney(cost)
    local c_gold,c_silver,c_copper = 0
            c_gold = floor(abs(cost / 10000))
            c_silver = floor(abs(mod(cost / 100, 100)))
            c_copper = floor(abs(mod(cost, 100)))
            return c_gold,c_silver,c_copper
end

    --additional frames scripts
    local function ResetFrame_GetAmountOfResets()
        ResetFrame_AmountOfResets_Count:SetText("|cffFFFFFF"..Ability_ResetMult+Talent_ResetMult.."|r")
        local levelrange_min = 0
        local levelrange_max = 0

        for k,v in pairs(Reset_Level) do
        if (UnitLevel("player") >= k) and (UnitLevel("player") < k+10) then
            levelrange_min = k
            levelrange_max = k+10
            if (k==0) then
                levelrange_min = 1
            end
        end
        end

        ResetFrame_AmountOfResets_Count_Text:SetText("|cffE1AB18Resets you had on level |cffFF4E00["..levelrange_min.."-"..levelrange_max.."]|r")
    end
    local function ResetFrame_GetPurgeCost(typeofpurge)
        local cost, nexcost, dialogtext,dialogtext_2 = nil
        if (typeofpurge == "talent") then
            cost, nexcost = GetMoneyForReset(1)
            if (cost == "token") then
                dialogText = "|cffE1AB18Reset: |TInterface\\Icons\\inv_custom_talentpurge.blp:14:14:0:0|t|cffFFFFFFx1"
            else
                local gold,silver,copper = GetGoldForMoney(cost)
                dialogText = "|cffE1AB18Reset: |cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"
            end
            if (nexcost == "token") then
                  dialogText_2 = "|cffE1AB18Next Reset: |TInterface\\Icons\\inv_custom_talentpurge.blp:14:14:0:0|t|cffFFFFFFx1"
            else
                local gold,silver,copper = GetGoldForMoney(nexcost)
                dialogText_2 = "|cffE1AB18Next Reset: |cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"
            end
            ResetFrame_TalentFrame_Cost:SetText(dialogText)
            ResetFrame_TalentFrame_NextCost:SetText(dialogText_2)
            elseif (typeofpurge == "ability") then

                if not(UnitLevel("player") < 10) then
                cost, nexcost = GetMoneyForReset(2)
            if (cost == "token") then
                dialogText = "|cffE1AB18Reset: |TInterface\\Icons\\inv_custom_abilitypurge.blp:14:14:0:0|t|cffFFFFFFx1"
            else
                local gold,silver,copper = GetGoldForMoney(cost)
                dialogText = "|cffE1AB18Reset: |cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"
            end
            if (nexcost == "token") then
                  dialogText_2 = "|cffE1AB18Next Reset: |TInterface\\Icons\\inv_custom_abilitypurge.blp:14:14:0:0|t|cffFFFFFFx1"
            else
                local gold,silver,copper = GetGoldForMoney(nexcost)
                dialogText_2 = "|cffE1AB18Next Reset: |cffFFFFFF"..gold.."|TInterface\\MONEYFRAME\\UI-GoldIcon.blp:11:11:0:-1|t "..silver.."|TInterface\\MONEYFRAME\\UI-SilverIcon.blp:11:11:0:-1|t "..copper.."|TInterface\\MONEYFRAME\\UI-CopperIcon.blp:11:11:0:-1|t|r"
            end
            ResetFrame_AbilityFrame_Cost:SetText(dialogText)
            ResetFrame_AbilityFrame_NextCost:SetText(dialogText_2)
                else
                    ResetFrame_AbilityFrame_Cost:SetText("Free")
                    ResetFrame_AbilityFrame_NextCost:SetText("Free")
                end
        end
    end
---[[MAIN FRAME SETTINGS]]---
function MyHandlers.ResetFrame_Init(player, t_mult, a_mult)
    Ability_ResetMult = a_mult
    Talent_ResetMult = t_mult
ResetFrame_GetAmountOfResets()
ResetFrame_GetPurgeCost("talent")
ResetFrame_GetPurgeCost("ability")
if not(ResetFrame_AmountOfResets:IsVisible()) then
BaseFrameFadeIn(ResetFrame_AmountOfResets)
BaseFrameFadeIn(ResetFrame_TalentFrame)
BaseFrameFadeIn(ResetFrame_AbilityFrame)
end
if (GetMoneyForReset(1) == "token") or (GetMoneyForReset(1) <= GetMoney()) then
    ResetFrame_main_TalentResetButton:Enable()
else
    ResetFrame_main_TalentResetButton:Disable()
    end
if (GetMoneyForReset(2) == "token") or (GetMoneyForReset(2) <= GetMoney()) or (UnitLevel("player") < 10) then
    ResetFrame_main_AbilityResetButton:Enable()
else
    ResetFrame_main_AbilityResetButton:Disable()
    end
end

local ResetFrame_main = CreateFrame("Frame", "ResetFrame_main", UIParent, nil)
ResetFrame_main:SetSize(380,400)
ResetFrame_main:SetPoint("CENTER")

ResetFrame_main:SetMovable(true)
ResetFrame_main:EnableMouse(true)
ResetFrame_main:EnableKeyboard(true)
ResetFrame_main:RegisterForDrag("LeftButton")
ResetFrame_main:SetFrameStrata("MEDIUM")
ResetFrame_main:SetClampedToScreen(true)
ResetFrame_main:SetScript("OnDragStart", ResetFrame_main.StartMoving)
ResetFrame_main:SetScript("OnHide", ResetFrame_main.StopMovingOrSizing)
ResetFrame_main:SetScript("OnDragStop", ResetFrame_main.StopMovingOrSizing)
ResetFrame_main:SetScript("OnShow", ResetFrame_Init)
ResetFrame_main:SetScript("OnKeyDown", function(self, arg1)
    if (arg1 == "ESCAPE") then
        self:Hide()
    end
    end)
ResetFrame_main:Hide()
AIO.SavePosition(ResetFrame_main)

ResetFrame_main:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_main",
    insets = { left = -40, right = -40, top = -40, bottom = -40}
})

local ResetFrame_main_CloseButton = CreateFrame("Button", "ResetFrame_main_CloseButton", ResetFrame_main, "UIPanelCloseButton")
ResetFrame_main_CloseButton:SetPoint("TOPRIGHT", -13.5, 11) 
ResetFrame_main_CloseButton:EnableMouse(true)
--ResetFrame_main_CloseButton:SetSize(29, 29) 
ResetFrame_main_CloseButton:SetScript("OnMouseUp", function()
    PlaySound("TalentScreenOpen")
    ResetFrame_main:Hide()
    end)
local ResetFrame_main_TitleText = ResetFrame_main:CreateFontString("ResetFrame_main_TitleText")
ResetFrame_main_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 12.2)
ResetFrame_main_TitleText:SetFontObject(GameFontNormal)
ResetFrame_main_TitleText:SetPoint("TOP", 0, 2)
ResetFrame_main_TitleText:SetShadowOffset(1,-1)
ResetFrame_main_TitleText:SetText("Reset Menu")

local ResetFrame_main_TalentResetButton = CreateFrame("Button", "ResetFrame_main_TalentResetButton", ResetFrame_main, nil)
ResetFrame_main_TalentResetButton:SetWidth(120) 
ResetFrame_main_TalentResetButton:SetHeight(28) 
ResetFrame_main_TalentResetButton:SetPoint("BOTTOM", -85,-5) 
ResetFrame_main_TalentResetButton:RegisterForClicks("AnyUp") 
ResetFrame_main_TalentResetButton:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")
ResetFrame_main_TalentResetButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")
ResetFrame_main_TalentResetButton:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button-pressed")

ResetFrame_main_TalentResetButton.Text_Talent = ResetFrame_main_TalentResetButton:CreateFontString()
ResetFrame_main_TalentResetButton.Text_Talent:SetFontObject(GameFontNormal)
ResetFrame_main_TalentResetButton.Text_Talent:SetPoint("CENTER", ResetFrame_main_TalentResetButton,  0, 0);
ResetFrame_main_TalentResetButton.Text_Talent:SetFont("Fonts\\FRIZQT__.TTF", 11)
ResetFrame_main_TalentResetButton.Text_Talent:SetText("Reset Talents")
ResetFrame_main_TalentResetButton:SetFontString(ResetFrame_main_TalentResetButton.Text_Talent)

ResetFrame_main_TalentResetButton:SetScript("OnDisable", function(self)
        ResetFrame_main_TalentResetButton.Text_Talent:SetText("|cff6b625bReset Talents|r")
    end)
ResetFrame_main_TalentResetButton:SetScript("OnEnable", function(self)
        ResetFrame_main_TalentResetButton.Text_Talent:SetText("Reset Talents")
    end)
ResetFrame_main_TalentResetButton:Disable()

local ResetFrame_main_AbilityResetButton = CreateFrame("Button", "ResetFrame_main_AbilityResetButton", ResetFrame_main, nil)
ResetFrame_main_AbilityResetButton:SetWidth(120) 
ResetFrame_main_AbilityResetButton:SetHeight(28) 
ResetFrame_main_AbilityResetButton:SetPoint("BOTTOM", 85,-5) 
ResetFrame_main_AbilityResetButton:RegisterForClicks("AnyUp") 
ResetFrame_main_AbilityResetButton:SetText("Reset Spells")
ResetFrame_main_AbilityResetButton:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")
ResetFrame_main_AbilityResetButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button")
ResetFrame_main_AbilityResetButton:SetPushedTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\dark-goldframe-button-pressed")

ResetFrame_main_AbilityResetButton.Text_Ability = ResetFrame_main_AbilityResetButton:CreateFontString()
ResetFrame_main_AbilityResetButton.Text_Ability:SetFontObject(GameFontNormal)
ResetFrame_main_AbilityResetButton.Text_Ability:SetPoint("CENTER", ResetFrame_main_AbilityResetButton,  0, 0);
ResetFrame_main_AbilityResetButton.Text_Ability:SetFont("Fonts\\FRIZQT__.TTF", 11)
ResetFrame_main_AbilityResetButton.Text_Ability:SetText("Reset Spells")
--ResetFrame_main_AbilityResetButton.Text_Ability:SetDisabledFontObject(GameFontNormal)
ResetFrame_main_AbilityResetButton:SetFontString(ResetFrame_main_AbilityResetButton.Text_Ability)

ResetFrame_main_AbilityResetButton:SetScript("OnDisable", function(self)
        ResetFrame_main_AbilityResetButton.Text_Ability:SetText("|cff6b625bReset Spells|r")
    end)
ResetFrame_main_AbilityResetButton:SetScript("OnEnable", function(self)
        ResetFrame_main_AbilityResetButton.Text_Ability:SetText("Reset Spells")
    end)
ResetFrame_main_AbilityResetButton:Disable()

--dialog frame--
    --[[Reset Frame]]
       local ResetFrame = CreateFrame("Frame", "ResetFrame", ResetFrame_main, nil)
        ResetFrame:SetSize(256,100)
        ResetFrame:SetPoint("BOTTOM", 0, -100)
        ResetFrame:SetClampedToScreen(true)
        ResetFrame:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\misc\\dialogframe",})
        --ResetFrame:Hide()
        

        local ResetDialog_text = ResetFrame:CreateFontString("ResetDialog_text") -- edited
        ResetDialog_text:SetFont("Fonts\\MORPHEUS.TTF", 15, "OUTLINE") -- edited
        ResetDialog_text:SetSize(300, 500)
        ResetDialog_text:SetPoint("CENTER", 0, 22) -- edited
        ResetDialog_text:SetText("|cffE1AB18You are going to reset spells|r") -- edited

                local ResetButton_yes = CreateFrame("Button", "ResetButton_yes", ResetFrame)
        ResetButton_yes:SetSize(64, 30)
        ResetButton_yes:SetPoint("CENTER", -30, -15)
        ResetButton_yes:EnableMouse(true)
        --ResetButton_yes:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        ResetButton_yes:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")
        ResetButton_yes:SetFrameLevel(3)
        ResetButton_yes:Hide()

        local ResetButton_yes_text = ResetButton_yes:CreateFontString("ResetButton_yes_text") -- edited
        ResetButton_yes_text:SetFont("Fonts\\MORPHEUS.TTF", 19, "OUTLINE") -- edited
        ResetButton_yes_text:SetSize(250, 5)
        ResetButton_yes_text:SetPoint("CENTER", 0, 0) -- edited
        ResetButton_yes_text:SetText("Yes") -- edited
        ResetButton_yes:SetFontString(ResetButton_yes_text)

        local ResetButton_yesTalents = CreateFrame("Button", "ResetButton_yesTalents", ResetFrame)
        ResetButton_yesTalents:SetSize(64, 30)
        ResetButton_yesTalents:SetPoint("CENTER", -30, -15)
        ResetButton_yesTalents:EnableMouse(true)
        --ResetButton_yesTalents:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        ResetButton_yesTalents:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")
        ResetButton_yesTalents:SetFrameLevel(3)
        ResetButton_yesTalents:Hide()

        local ResetButton_yesTalents_text = ResetButton_yesTalents:CreateFontString("ResetButton_yesTalents_text") -- edited
        ResetButton_yesTalents_text:SetFont("Fonts\\MORPHEUS.TTF", 19, "OUTLINE") -- edited
        ResetButton_yesTalents_text:SetSize(250, 5)
        ResetButton_yesTalents_text:SetPoint("CENTER", 0, 0) -- edited
        ResetButton_yesTalents_text:SetText("Yes") -- edited
        ResetButton_yesTalents:SetFontString(ResetButton_yesTalents_text)

        ResetButton_yes:SetScript("OnMouseUp", function()
            PlaySound("igMainMenuOptionCheckBoxOn")
            if (TrainingFrame:IsVisible()) then
                TrainingFrame:Hide()
            end
         Reset_spells_button()
         ResetFrame:Hide()
         end)
        ResetButton_yesTalents:SetScript("OnMouseUp", function()
            PlaySound("igMainMenuOptionCheckBoxOn")
            if (TrainingFrame:IsVisible()) then
                TrainingFrame:Hide()
            end
         Reset_talents_button()
         ResetFrame:Hide()
         end)


        local ResetButton_No = CreateFrame("Button", "ResetButton_No", ResetFrame)
        ResetButton_No:SetSize(64, 30)
        ResetButton_No:SetPoint("CENTER", 30, -15)
        ResetButton_No:EnableMouse(true)
        --ResetButton_No:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        ResetButton_No:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")
        ResetButton_No:SetFrameLevel(3)
        ResetButton_No:SetScript("OnMouseUp", function()
            PlaySound("igMainMenuOptionCheckBoxOn")
            ResetFrame:Hide()
            end)

        local ResetButton_No_text = ResetButton_No:CreateFontString("ResetButton_No_text") -- edited
        ResetButton_No_text:SetFont("Fonts\\MORPHEUS.TTF", 19, "OUTLINE") -- edited
        ResetButton_No_text:SetSize(250, 5)
        ResetButton_No_text:SetPoint("CENTER", 0, 0) -- edited
        ResetButton_No_text:SetText("No") -- edited
        ResetButton_No:SetFontString(ResetButton_No_text)
        ResetFrame:Hide()

        ResetFrame_Animgroup2 = ResetFrame:CreateAnimationGroup()
        local ResetFrame_Scale2 = ResetFrame_Animgroup2:CreateAnimation("Scale")
        ResetFrame_Scale2:SetDuration(0.5)
        ResetFrame_Scale2:SetOrder(1)
        ResetFrame_Scale2:SetEndDelay(0)
        ResetFrame_Scale2:SetScale(10,1)

        ResetFrame_Animgroup = ResetFrame:CreateAnimationGroup()
        local ResetFrame_Scale1 = ResetFrame_Animgroup:CreateAnimation("Scale")
        ResetFrame_Scale1:SetDuration(0)
        ResetFrame_Scale1:SetOrder(1)
        ResetFrame_Scale1:SetEndDelay(0.5)
        ResetFrame_Scale1:SetScale(0.1,1)
        ResetFrame_Animgroup:SetScript("OnPlay", function()
            ResetFrame_Animgroup2:Play()
            end)

--button scripts --
local function ResetButton_button_pushed(self)
          PlaySound("igMainMenuOptionCheckBoxOn")
            if (TrainingFrame:IsVisible()) then
                TrainingFrame:Hide()
            end
            if not(ResetButton_yes:IsVisible()) then
            ResetDialog_text:SetText("|cffE1AB18You are going to reset spells|r")
            ResetFrame:Show()
            ResetFrame_Animgroup:Play()
            ResetButton_yesTalents:Hide()
            ResetButton_yes:Show()
        else
            ResetFrame:Hide()
        end
        end
local function ResetButton_Tooltip_OnEnter(self, motion)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFReset Spells|r\nUse your tokens to refund your Spells.")
            GameTooltip:Show()
            BaseFrameFadeIn(ResetFrame_main_AbilityResetButton_Highlight)
        end
local function ResetButton_Tooltip_OnLeave(self)
            GameTooltip:Hide()
            BaseFrameFadeOut(ResetFrame_main_AbilityResetButton_Highlight)
        end
local function ResetButton_t_button_pushed(self)
             PlaySound("igMainMenuOptionCheckBoxOn")
                if (TrainingFrame:IsVisible()) then
                TrainingFrame:Hide()
            end
            if not(ResetButton_yesTalents:IsVisible()) then
            ResetDialog_text:SetText("|cffE1AB18You are going to reset talents|r")
            ResetFrame:Show()
            ResetFrame_Animgroup:Play()
            ResetButton_yesTalents:Show()
            ResetButton_yes:Hide()
        else
            ResetFrame:Hide()
        end
        end
local function ResetButton_t_Tooltip_OnEnter(self, motion)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFReset Talents|r\nUse your tokens to refund your Talents.")
            GameTooltip:Show()
            BaseFrameFadeIn(ResetFrame_main_TalentResetButton_Highlight)
        end
local function ResetButton_t_Tooltip_OnLeave(self)
            GameTooltip:Hide()
            BaseFrameFadeOut(ResetFrame_main_TalentResetButton_Highlight)
        end

ResetFrame_main_AbilityResetButton_Highlight = ResetFrame_main:CreateTexture(nil, "ARTWORK")
ResetFrame_main_AbilityResetButton_Highlight:SetHeight(64)
ResetFrame_main_AbilityResetButton_Highlight:SetWidth(250)
ResetFrame_main_AbilityResetButton_Highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_buttonhighlight")
ResetFrame_main_AbilityResetButton_Highlight:SetPoint("BOTTOM",85,-23)
ResetFrame_main_AbilityResetButton_Highlight:SetBlendMode("ADD")
ResetFrame_main_AbilityResetButton_Highlight:Hide()

ResetFrame_main_TalentResetButton_Highlight = ResetFrame_main:CreateTexture(nil, "ARTWORK")
ResetFrame_main_TalentResetButton_Highlight:SetHeight(64)
ResetFrame_main_TalentResetButton_Highlight:SetWidth(250)
ResetFrame_main_TalentResetButton_Highlight:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_buttonhighlight")
ResetFrame_main_TalentResetButton_Highlight:SetPoint("BOTTOM",-85,-23)
ResetFrame_main_TalentResetButton_Highlight:SetBlendMode("ADD")
ResetFrame_main_TalentResetButton_Highlight:Hide()

ResetFrame_main_AbilityResetButton:SetScript("OnMouseUp", ResetButton_button_pushed)
ResetFrame_main_AbilityResetButton:SetScript("OnEnter", ResetButton_Tooltip_OnEnter)
ResetFrame_main_AbilityResetButton:SetScript("OnLeave", ResetButton_Tooltip_OnLeave)
ResetFrame_main_TalentResetButton:SetScript("OnMouseUp", ResetButton_t_button_pushed)
ResetFrame_main_TalentResetButton:SetScript("OnEnter", ResetButton_t_Tooltip_OnEnter)
ResetFrame_main_TalentResetButton:SetScript("OnLeave", ResetButton_t_Tooltip_OnLeave)
--------------Additional Frames------------------
    --
ResetFrame_AmountOfResets = CreateFrame("Frame", "ResetFrame_main", ResetFrame_main, nil)
ResetFrame_AmountOfResets:SetSize(450,113)
ResetFrame_AmountOfResets:SetPoint("TOP",0,-6)
ResetFrame_AmountOfResets:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_resetcountframe",
})
ResetFrame_AmountOfResets:Hide()
local ResetFrame_AmountOfResets_Count = ResetFrame_AmountOfResets:CreateFontString("ResetFrame_AmountOfResets_Count")
ResetFrame_AmountOfResets_Count:SetFont("Fonts\\MORPHEUS.TTF", 17, "OUTLINE")
ResetFrame_AmountOfResets_Count:SetSize(300, 500)
ResetFrame_AmountOfResets_Count:SetPoint("CENTER", 2, 20)
ResetFrame_AmountOfResets_Count:SetText("|cffE1AB180|r")
local ResetFrame_AmountOfResets_Count_Text = ResetFrame_AmountOfResets:CreateFontString("ResetFrame_AmountOfResets_Count_Text")
ResetFrame_AmountOfResets_Count_Text:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE")
ResetFrame_AmountOfResets_Count_Text:SetSize(300, 500)
ResetFrame_AmountOfResets_Count_Text:SetPoint("CENTER", 2, -17)
ResetFrame_AmountOfResets_Count_Text:SetText("|cffFFFFFFResets you had on last 10 levels|r")
--talent frame
ResetFrame_TalentFrame = CreateFrame("Frame", "ResetFrame_main", ResetFrame_main, nil)
ResetFrame_TalentFrame:SetSize(512,128)
ResetFrame_TalentFrame:SetPoint("CENTER",-8,15)
ResetFrame_TalentFrame:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_Talentframe",
})
ResetFrame_TalentFrame:Hide()
local ResetFrame_TalentFrame_Cost = ResetFrame_TalentFrame:CreateFontString("ResetFrame_TalentFrame_Cost")
ResetFrame_TalentFrame_Cost:SetFont("Fonts\\MORPHEUS.TTF", 12, "OUTLINE")
ResetFrame_TalentFrame_Cost:SetSize(300, 500)
ResetFrame_TalentFrame_Cost:SetPoint("CENTER", 8, 13)
ResetFrame_TalentFrame_Cost:SetText("|cffE1AB18You are going to reset talents|r")

local ResetFrame_TalentFrame_NextCost = ResetFrame_TalentFrame:CreateFontString("ResetFrame_TalentFrame_NextCost")
ResetFrame_TalentFrame_NextCost:SetFont("Fonts\\MORPHEUS.TTF", 12, "OUTLINE")
ResetFrame_TalentFrame_NextCost:SetSize(300, 500)
ResetFrame_TalentFrame_NextCost:SetPoint("CENTER", 8, -19)
ResetFrame_TalentFrame_NextCost:SetText("|cffE1AB18You are going to reset talents|r")

--ability frame
ResetFrame_AbilityFrame = CreateFrame("Frame", "ResetFrame_main", ResetFrame_main, nil)
ResetFrame_AbilityFrame:SetSize(512,128)
ResetFrame_AbilityFrame:SetPoint("BOTTOM",-8,45)
ResetFrame_AbilityFrame:SetBackdrop({
    bgFile = "Interface\\AddOns\\AwAddons\\Textures\\ResetFrame\\reset_abilityframe",
})
ResetFrame_AbilityFrame:Hide()
local ResetFrame_AbilityFrame_Cost = ResetFrame_AbilityFrame:CreateFontString("ResetFrame_AbilityFrame_Cost")
ResetFrame_AbilityFrame_Cost:SetFont("Fonts\\MORPHEUS.TTF", 12, "OUTLINE")
ResetFrame_AbilityFrame_Cost:SetSize(300, 500)
ResetFrame_AbilityFrame_Cost:SetPoint("CENTER", 8, 13)
ResetFrame_AbilityFrame_Cost:SetText("|cffE1AB18You are going to reset spells|r")

local ResetFrame_AbilityFrame_NextCost = ResetFrame_AbilityFrame:CreateFontString("ResetFrame_AbilityFrame_NextCost")
ResetFrame_AbilityFrame_NextCost:SetFont("Fonts\\MORPHEUS.TTF", 12, "OUTLINE")
ResetFrame_AbilityFrame_NextCost:SetSize(300, 500)
ResetFrame_AbilityFrame_NextCost:SetPoint("CENTER", 8, -19)
ResetFrame_AbilityFrame_NextCost:SetText("|cffE1AB18You are going to reset spells|r")
   --[[local ResetButton = CreateFrame("Button", "ResetButton", sideBar)
        ResetButton:SetSize(128, 64)
        ResetButton:SetPoint("CENTER", 230, -43)
        ResetButton:EnableMouse(true)
        ResetButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        ResetButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b_h")
        ResetButton:SetFrameLevel(3)
        local ResetButton_text = ResetButton:CreateFontString("ResetButton_text") -- edited
        ResetButton_text:SetFont("Fonts\\MORPHEUS.TTF", 17, "OUTLINE") -- edited
        ResetButton_text:SetSize(190, 5)
        ResetButton_text:SetPoint("CENTER", 0, 0) -- edited
        ResetButton_text:SetText("Reset abilities") -- edited
        ResetButton:SetFontString(ResetButton_text)]]--
        --ResetButton:SetScript("OnMouseUp", ResetButton_button_pushed)
        --ResetButton:SetScript("OnEnter", ResetButton_Tooltip_OnEnter)
        --ResetButton:SetScript("OnLeave", ResetButton_Tooltip_OnLeave)

        --[[local ResetButton_t = CreateFrame("Button", "ResetButton_t", sideBar)
        ResetButton_t:SetSize(128, 64)
        ResetButton_t:SetPoint("CENTER", -200, -43)
        ResetButton_t:EnableMouse(true)
        ResetButton_t:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b")
        ResetButton_t:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\main_b_h")
        ResetButton_t:SetFrameLevel(3)
        local ResetButton_t_text = ResetButton_t:CreateFontString("ResetButton_t_text") -- edited
        ResetButton_t_text:SetFont("Fonts\\MORPHEUS.TTF", 17, "OUTLINE") -- edited
        ResetButton_t_text:SetSize(190, 5)
        ResetButton_t_text:SetPoint("CENTER", 0, 0) -- edited
        ResetButton_t_text:SetText("Reset talents") -- edited
        ResetButton_t:SetFontString(ResetButton_t_text)]]--
        --ResetButton_t:SetScript("OnMouseUp", ResetButton_t_button_pushed)
        --ResetButton_t:SetScript("OnEnter", ResetButton_t_Tooltip_OnEnter)
        --ResetButton_t:SetScript("OnLeave", ResetButton_t_Tooltip_OnLeave)

        --scritps for fast buttons
        TrainingButton_fast:SetScript("OnMouseUp", Training_button_pushed)
        TrainingButton_fast:SetScript("OnEnter", TrainingButton_Tooltip_OnEnter)
        TrainingButton_fast:SetScript("OnLeave", TrainingButton_Tooltip_OnLeave)
        AllocateButton_fast:SetScript("OnMouseUp",StatAllocation_button_pushed)
        AllocateButton_fast:SetScript("OnEnter", StatAllocationButton_Tooltip_OnEnter)
        AllocateButton_fast:SetScript("OnLeave", StatAllocationButton_Tooltip_OnLeave)
        ResetButton_fast:SetScript("OnMouseUp", function()
            PlaySound("TalentScreenOpen")
                if not(ResetFrame_main:IsVisible()) then
                ResetFrame_main:Show() StatFrame:Hide() TrainingFrame:Hide()
                AIO.Handle("sideBar", "GetMults")
                else
                ResetFrame_main:Hide()
                end
            end)
        ResetButton_fast:SetScript("OnEnter", ResetButtonFast_Tooltip_OnEnter)
        ResetButton_fast:SetScript("OnLeave", ResetButtonFast_Tooltip_OnLeave)
        --[[ResetButton_fast_T:SetScript("OnMouseUp", function()
         if not(sideBar:IsVisible()) then
            togglesiderframe()
        end
            ResetButton_t_button_pushed()
            end)
        ResetButton_fast_T:SetScript("OnEnter", ResetButton_t_Tooltip_OnEnter)
        ResetButton_fast_T:SetScript("OnLeave", ResetButton_t_Tooltip_OnLeave)]]--
		
	-- ================================ SPECIFIC UI SECTIONS ==============================================
	
	--[[ StatFrame UI ]]
	
    local StatFrame_CloseButton = CreateFrame("Button", "StatFrame_CloseButton", StatFrame, "UIPanelCloseButton")
        StatFrame_CloseButton:SetPoint("TOPRIGHT", -40, -24.5)  --edited
        StatFrame_CloseButton:EnableMouse(true)
        --StatFrame_CloseButton:SetSize(29, 29) --edited
        StatFrame_CloseButton:SetScript("OnMouseUp", function(self)
            PlaySound("igQuestCancel")
            StatFrame:Hide()
            end)
       
    --[[local StatFrame_TitleBar = CreateFrame("Frame", "StatFrame_TitleBar", StatFrame, nil)
        StatFrame_TitleBar:SetSize(135, 25)
        StatFrame_TitleBar:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 16,
            tileSize = 16,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
        StatFrame_TitleBar:SetPoint("TOP", 0, 9)]]-- edited
                local StatFrame_TitleText = StatFrame:CreateFontString("StatFrame_TitleText") -- edited
        StatFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 12.2) -- edited
        StatFrame_TitleText:SetFontObject(GameFontNormal)
        StatFrame_TitleText:SetSize(190, 5)
        StatFrame_TitleText:SetPoint("TOP", 0, -37) -- edited
        StatFrame_TitleText:SetText("Stat Allocation") -- edited
       
    local StatFrame_Panel_Str = CreateFrame("Frame", "StatFrame_Panel_Str", StatFrame, nil) -- edited
        StatFrame_Panel_Str:SetSize(450, 116) -- edited
        StatFrame_Panel_Str:SetPoint("CENTER", 0, 120) -- edited
        StatFrame_Panel_Str:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\allocationbuttonframe"}) -- edited

        --edited--
            local StatFrame_Panel_Sta = CreateFrame("Frame", "StatFrame_Panel_Sta", StatFrame, nil)
        StatFrame_Panel_Sta:SetSize(450, 116) -- edited
        StatFrame_Panel_Sta:SetPoint("CENTER", 0, 62) -- edited
        StatFrame_Panel_Sta:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\allocationbuttonframe"}) -- edited
            local StatFrame_Panel_Agi = CreateFrame("Frame", "StatFrame_Panel_Agi", StatFrame, nil)
        StatFrame_Panel_Agi:SetSize(450, 116) -- edited
        StatFrame_Panel_Agi:SetPoint("CENTER", 0, 4) -- edited
        StatFrame_Panel_Agi:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\allocationbuttonframe"}) -- edited

            local StatFrame_Panel_Int = CreateFrame("Frame", "StatFrame_Panel_Int", StatFrame, nil)
        StatFrame_Panel_Int:SetSize(450, 116) -- edited
        StatFrame_Panel_Int:SetPoint("CENTER", 0, -54) -- edited
        StatFrame_Panel_Int:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\allocationbuttonframe"}) -- edited

            local StatFrame_Panel_Spi = CreateFrame("Frame", "StatFrame_Panel_Spi", StatFrame, nil)
        StatFrame_Panel_Spi:SetSize(450, 116) -- edited
        StatFrame_Panel_Spi:SetPoint("CENTER", 0, -112) -- edited
        StatFrame_Panel_Spi:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\allocationbuttonframe"}) -- edited

        --textures
        local StatFrame_Panel_Str_Ico = CreateFrame("FRAME", "StatFrame_Panel_Str_Ico", StatFrame_Panel_Str, nil)
        StatFrame_Panel_Str_Ico:SetWidth(58);               
        StatFrame_Panel_Str_Ico:SetHeight(58);
        StatFrame_Panel_Str_Ico:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\strength"})
        StatFrame_Panel_Str_Ico:SetPoint("CENTER", -105,4)
        StatFrame_Panel_Str_Ico:EnableMouse(true)

            local StatFrame_Panel_Sta_Ico = CreateFrame("FRAME", "StatFrame_Panel_Sta_Ico", StatFrame_Panel_Sta, nil)
        StatFrame_Panel_Sta_Ico:SetWidth(58);               
        StatFrame_Panel_Sta_Ico:SetHeight(58);
        StatFrame_Panel_Sta_Ico:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\stamina"})
        StatFrame_Panel_Sta_Ico:SetPoint("CENTER", -105,4)
        StatFrame_Panel_Sta_Ico:EnableMouse(true)

            local StatFrame_Panel_Agi_Ico = CreateFrame("FRAME", "StatFrame_Panel_Agi_Ico", StatFrame_Panel_Agi, nil)
        StatFrame_Panel_Agi_Ico:SetWidth(58);               
        StatFrame_Panel_Agi_Ico:SetHeight(58);
        StatFrame_Panel_Agi_Ico:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\agility"})
        StatFrame_Panel_Agi_Ico:SetPoint("CENTER", -105,4)
        StatFrame_Panel_Agi_Ico:EnableMouse(true)

            local StatFrame_Panel_Int_Ico = CreateFrame("FRAME", "StatFrame_Panel_Int_Ico", StatFrame_Panel_Int, nil)
        StatFrame_Panel_Int_Ico:SetWidth(58);               
        StatFrame_Panel_Int_Ico:SetHeight(58);
        StatFrame_Panel_Int_Ico:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\intellect"})
        StatFrame_Panel_Int_Ico:SetPoint("CENTER", -105,4)
        StatFrame_Panel_Int_Ico:EnableMouse(true)

            local StatFrame_Panel_Spi_Ico = CreateFrame("FRAME", "StatFrame_Panel_Spi_Ico", StatFrame_Panel_Spi, nil)
        StatFrame_Panel_Spi_Ico:SetWidth(58);               
        StatFrame_Panel_Spi_Ico:SetHeight(58);
        StatFrame_Panel_Spi_Ico:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\Allocation\\spirit"})
        StatFrame_Panel_Spi_Ico:SetPoint("CENTER", -105,4)
        StatFrame_Panel_Spi_Ico:EnableMouse(true)


        local StatFrame_Panel_Str_Ico_h = StatFrame_Panel_Str_Ico:CreateTexture(nil, "ARTWORK")
        StatFrame_Panel_Str_Ico_h:SetWidth(58);               
        StatFrame_Panel_Str_Ico_h:SetHeight(58);
        StatFrame_Panel_Str_Ico_h:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Allocation\\strength_h")
        StatFrame_Panel_Str_Ico_h:SetPoint("CENTER")
        StatFrame_Panel_Str_Ico_h:SetBlendMode("ALPHAKEY")

            local StatFrame_Panel_Sta_Ico_h = StatFrame_Panel_Sta_Ico:CreateTexture(nil, "ARTWORK")
        StatFrame_Panel_Sta_Ico_h:SetWidth(58);               
        StatFrame_Panel_Sta_Ico_h:SetHeight(58);
        StatFrame_Panel_Sta_Ico_h:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Allocation\\stamina_h")
        StatFrame_Panel_Sta_Ico_h:SetPoint("CENTER")
        StatFrame_Panel_Sta_Ico_h:SetBlendMode("ALPHAKEY")

            local StatFrame_Panel_Agi_Ico_h = StatFrame_Panel_Agi_Ico:CreateTexture(nil, "ARTWORK")
        StatFrame_Panel_Agi_Ico_h:SetWidth(58);               
        StatFrame_Panel_Agi_Ico_h:SetHeight(58);
        StatFrame_Panel_Agi_Ico_h:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Allocation\\agility_h")
        StatFrame_Panel_Agi_Ico_h:SetPoint("CENTER")
        StatFrame_Panel_Agi_Ico_h:SetBlendMode("ALPHAKEY")

            local StatFrame_Panel_Int_Ico_h = StatFrame_Panel_Int_Ico:CreateTexture(nil, "ARTWORK")
        StatFrame_Panel_Int_Ico_h:SetWidth(58);               
        StatFrame_Panel_Int_Ico_h:SetHeight(58);
        StatFrame_Panel_Int_Ico_h:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Allocation\\intellect_h")
        StatFrame_Panel_Int_Ico_h:SetPoint("CENTER")
        StatFrame_Panel_Int_Ico_h:SetBlendMode("ALPHAKEY")

            local StatFrame_Panel_Spi_Ico_h = StatFrame_Panel_Spi_Ico:CreateTexture(nil, "ARTWORK")
        StatFrame_Panel_Spi_Ico_h:SetWidth(58);               
        StatFrame_Panel_Spi_Ico_h:SetHeight(58);
        StatFrame_Panel_Spi_Ico_h:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\Allocation\\spirit_h")
        StatFrame_Panel_Spi_Ico_h:SetPoint("CENTER")
        StatFrame_Panel_Spi_Ico_h:SetBlendMode("ALPHAKEY")

        StatFrame_Panel_Str_Ico_h:Hide()
        StatFrame_Panel_Sta_Ico_h:Hide()
        StatFrame_Panel_Agi_Ico_h:Hide()
        StatFrame_Panel_Int_Ico_h:Hide()
        StatFrame_Panel_Spi_Ico_h:Hide()

                StatFrame_Panel_Str_Ico:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFStrength|r\nStrength increases |cffFFFFFFattack power|r and is the most important\nstat for plate armor-wearing classes in the |cffFFFFFFdamage-dealing|r or |cffFFFFFFtank|r role.\nStrength also converts into |cffFFFFFFparry|r.")
            GameTooltip:Show()
            StatFrame_Panel_Str_Ico_h:Show()
            end)
        StatFrame_Panel_Str_Ico:SetScript("OnLeave", function(self)
            GameTooltip:Hide()
            StatFrame_Panel_Str_Ico_h:Hide()
            end)
                StatFrame_Panel_Sta_Ico:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFStamina|r\nStamina is the source of all |cffFFFFFFhealth|r.\nMost armor has stamina on it, and all classes\nand specializations wear armor with stamina on it,\nbut |cffFFFFFFtanks|r generally have the most.")
            GameTooltip:Show()StatFrame_Panel_Sta_Ico_h:Show()
            end)
        StatFrame_Panel_Sta_Ico:SetScript("OnLeave", function(self)
            GameTooltip:Hide()StatFrame_Panel_Sta_Ico_h:Hide()
            end)
                StatFrame_Panel_Agi_Ico:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFAgility|r\nAgility increases |cffFFFFFFmelee|r and |cffFFFFFFranged attack power|r,\nand is the most important stat for leather armor\nand mail armor-wearing classes in the\n|cffFFFFFFdamage-dealing|r or |cffFFFFFFtank|r role.")
            GameTooltip:Show()StatFrame_Panel_Agi_Ico_h:Show()
            end)
        StatFrame_Panel_Agi_Ico:SetScript("OnLeave", function(self)
            GameTooltip:Hide()StatFrame_Panel_Agi_Ico_h:Hide()
            end)
                StatFrame_Panel_Int_Ico:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFIntellect|r\nIntellect increases |cffFFFFFFspell critical chance|r, |cffFFFFFFamount of mana|r and is the most\nimportant stat for mana-using classes\nwearing any armor type in the\n|cffFFFFFFdamage-dealing|r (ranged spell caster) or |cffFFFFFFhealer|r role.")
            GameTooltip:Show()StatFrame_Panel_Int_Ico_h:Show()
            end)
        StatFrame_Panel_Int_Ico:SetScript("OnLeave", function(self)
            GameTooltip:Hide()StatFrame_Panel_Int_Ico_h:Hide()
            end)
                StatFrame_Panel_Spi_Ico:SetScript("OnEnter", function(self)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("|cffFFFFFFSpirit|r\nSpirit is the |cffFFFFFFhealer-only|r stat,\nand increases their mana regeneration.")
            GameTooltip:Show()StatFrame_Panel_Spi_Ico_h:Show()
            end)
        StatFrame_Panel_Spi_Ico:SetScript("OnLeave", function(self)
            GameTooltip:Hide()StatFrame_Panel_Spi_Ico_h:Hide()
            end)
        --edited--
        --[[local StatFrame_PointsPanel = CreateFrame("Frame", "StatFrame_PointsPanel", StatFrame, nil)
        StatFrame_PointsPanel:SetSize(170, 25)
        StatFrame_PointsPanel:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 16,
            tileSize = 16,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
		StatFrame_PointsPanel:SetPoint("LEFT", 14, 6)]]--
		
		
	-- Stat Names
        --[[local StatNames = CreateFrame("Button", "StatNames", StatFrame, nil)
        StatNames:SetSize(60, 100)
        StatNames:SetPoint("TOPLEFT", 15, -37.5)]]-- edited
        local Strength_Text = StatFrame_Panel_Str:CreateFontString("Strength_Text") -- edited
        Strength_Text:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE") -- edited
        Strength_Text:SetSize(137, 5)
        Strength_Text:SetPoint("TOP", 0, -35)
        Strength_Text:SetText("|cffE1AB18Strength|r")

        local Allocation_Fast_Text = StatFrame_Panel_Str:CreateFontString("Allocation_Fast_Text") -- edited
        Allocation_Fast_Text:SetFont("Fonts\\FRIZQT__.TTF", 12) -- edited
        Allocation_Fast_Text:SetSize(500, 5)
        Allocation_Fast_Text:SetPoint("TOP", 0, -10)
        Allocation_Fast_Text:SetText("|cffE1AB18Hold |cffFFFFFFShift|cffE1AB18 to allocate 10 points per stat|r")

        local Stamina_Text = StatFrame_Panel_Sta:CreateFontString("Stamina_Text") -- edited
        Stamina_Text:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE") -- edited
        Stamina_Text:SetSize(137, 5)
        Stamina_Text:SetPoint("TOP", 0, -35)
        Stamina_Text:SetText("|cffE1AB18Stamina|r")
        local Agility_Text = StatFrame_Panel_Agi:CreateFontString("Agility_Text") -- edited
        Agility_Text:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE") -- edited
        Agility_Text:SetSize(137, 5)
        Agility_Text:SetPoint("TOP", 0, -35)
        Agility_Text:SetText("|cffE1AB18Agility|r")
        local Intellect_Text = StatFrame_Panel_Int:CreateFontString("Intellect_Text") -- edited
        Intellect_Text:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE") -- edited
        Intellect_Text:SetSize(137, 5)
        Intellect_Text:SetPoint("TOP", 0, -35)
        Intellect_Text:SetText("|cffE1AB18Intellect|r")
        local Spirit_Text = StatFrame_Panel_Spi:CreateFontString("Spirit_Text") -- edited
        Spirit_Text:SetFont("Fonts\\MORPHEUS.TTF", 14, "OUTLINE") -- edited
        Spirit_Text:SetSize(137, 5)
        Spirit_Text:SetPoint("TOP", 0, -35)
        Spirit_Text:SetText("|cffE1AB18Spirit|r")
        local Stat_Text = StatFrame:CreateFontString("Stat_Text") -- edited
        Stat_Text:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE") -- edited
        Stat_Text:SetSize(250, 5)
        Stat_Text:SetPoint("BOTTOM", 0, 76)
        Stat_Text:SetText("|cffE1AB18Available Stat Points:|r")
       
        --FontStrings for stat values
        local Str_Value = StatFrame_Panel_Str:CreateFontString("Str_Value")
        Str_Value:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE")
        Str_Value:SetSize(137, 5)
        Str_Value:SetPoint("TOP", 0, -56)
        local Sta_Value = StatFrame_Panel_Sta:CreateFontString("Sta_Value")
        Sta_Value:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE")
        Sta_Value:SetSize(137, 5)
        Sta_Value:SetPoint("TOP", 0, -56)
        local Agi_Value = StatFrame_Panel_Agi:CreateFontString("Agi_Value")
        Agi_Value:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE")
        Agi_Value:SetSize(137, 5)
        Agi_Value:SetPoint("TOP", 0, -56)
        local Inte_Value = StatFrame_Panel_Int:CreateFontString("Inte_Value")
        Inte_Value:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE")
        Inte_Value:SetSize(137, 5)
        Inte_Value:SetPoint("TOP", 0, -56)
        local Spi_Value = StatFrame_Panel_Spi:CreateFontString("Spi_Value")
        Spi_Value:SetFont("Fonts\\MORPHEUS.TTF", 16, "OUTLINE")
        Spi_Value:SetSize(137, 5)
        Spi_Value:SetPoint("TOP", 0, -56)
        
        local Stat_Value = StatFrame:CreateFontString("Stat_Value")
        Stat_Value:SetFont("Fonts\\MORPHEUS.TTF", 18, "OUTLINE")
        Stat_Value:SetSize(70, 5)
        Stat_Value:SetPoint("BOTTOM", 0, 43)--edited all
		
		
	function MyHandlers.GetStatValues(player, stats)
	
		Str_Value:SetText(stats[1])
        Sta_Value:SetText(stats[2])
        Agi_Value:SetText(stats[3])
        Inte_Value:SetText(stats[4])
        Spi_Value:SetText(stats[5])
		Stat_Value:SetText(stats[6])
		
	end
	
	function Increase_stats(self)
        PlaySound("igMainMenuOptionCheckBoxOn")
	
		local stat = nil
        local amount = nil
        if (IsShiftKeyDown()) then
            amount = 10
        end
	
		if self == Inc_Str then
		
			stat = 1
			
		elseif self == Inc_Sta then
		
			stat = 2
			
		elseif self == Inc_Agi then
		
			stat = 3
			
		elseif self == Inc_Inte then
		
			stat = 4
			
		elseif self == Inc_Spi then
		
			stat = 5
		end
			
		AIO.Handle("sideBar", "AddStats", stat, amount)

	
	end
	
	function Reduce_stats(self)
        PlaySound("igMainMenuOptionCheckBoxOn")
	
		local stat = nil
         local amount = nil
        if (IsShiftKeyDown()) then
            amount = 10
        end
	
		if self == Dec_Str then
		
			stat = 1
			
		elseif self == Dec_Sta then
		
			stat = 2
			
		elseif self == Dec_Agi then
		
			stat = 3
			
		elseif self == Dec_Inte then
		
			stat = 4
			
		elseif self == Dec_Spi then
		
			stat = 5
			
		end	
		AIO.Handle("sideBar", "ReduceStats", stat, amount)

	
	end
	
	Inc_Str = CreateFrame("Button", "Inc_Str", StatFrame_Panel_Str, nil)
        Inc_Str:SetSize(23, 23)
        Inc_Str:SetPoint("CENTER", 60, -2)
        Inc_Str:EnableMouse(true)
        Inc_Str:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Up")
        Inc_Str:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Inc_Str:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Down")
        --Inc_Str:SetScript("OnMouseUp", Increase_stats)
       
    Dec_Str = CreateFrame("Button", "Dec_Str", StatFrame_Panel_Str, nil)
        Dec_Str:SetSize(23, 23)
        Dec_Str:SetPoint("CENTER", -60, -2)
        Dec_Str:EnableMouse(true)
        Dec_Str:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Up")
        Dec_Str:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Dec_Str:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Down")
        --Dec_Str:SetScript("OnMouseUp", Reduce_stats)
       
    Inc_Sta = CreateFrame("Button", "Inc_Sta", StatFrame_Panel_Sta, nil)
        Inc_Sta:SetSize(23, 23)
        Inc_Sta:SetPoint("CENTER", 60, -2)
        Inc_Sta:EnableMouse(true)
        Inc_Sta:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Up")
        Inc_Sta:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Inc_Sta:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Down")
        --Inc_Sta:SetScript("OnMouseUp", Increase_stats)
       
    Dec_Sta = CreateFrame("Button", "Dec_Sta", StatFrame_Panel_Sta, nil)
        Dec_Sta:SetSize(23, 23)
        Dec_Sta:SetPoint("CENTER", -60, -2)
        Dec_Sta:EnableMouse(true)
        Dec_Sta:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Up")
        Dec_Sta:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Dec_Sta:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Down")
        --Dec_Sta:SetScript("OnMouseUp", Reduce_stats)
       
    Inc_Agi = CreateFrame("Button", "Inc_Agi", StatFrame_Panel_Agi, nil)
        Inc_Agi:SetSize(23, 23)
        Inc_Agi:SetPoint("CENTER", 60, -2)
        Inc_Agi:EnableMouse(true)
        Inc_Agi:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Up")
        Inc_Agi:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Inc_Agi:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Down")
        --Inc_Agi:SetScript("OnMouseUp", Increase_stats)
       
    Dec_Agi = CreateFrame("Button", "Dec_Agi", StatFrame_Panel_Agi, nil)
        Dec_Agi:SetSize(23, 23)
        Dec_Agi:SetPoint("CENTER", -60, -2)
        Dec_Agi:EnableMouse(true)
        Dec_Agi:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Up")
        Dec_Agi:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Dec_Agi:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Down")
        --Dec_Agi:SetScript("OnMouseUp", Reduce_stats)
       
    Inc_Inte = CreateFrame("Button", "Inc_Inte", StatFrame_Panel_Int, nil)
        Inc_Inte:SetSize(23, 23)
        Inc_Inte:SetPoint("CENTER", 60, -2)
        Inc_Inte:EnableMouse(true)
        Inc_Inte:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Up")
        Inc_Inte:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Inc_Inte:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Down")
        --Inc_Inte:SetScript("OnMouseUp", Increase_stats)
       
    Dec_Inte = CreateFrame("Button", "Dec_Inte", StatFrame_Panel_Int, nil)
        Dec_Inte:SetSize(23, 23)
        Dec_Inte:SetPoint("CENTER", -60, -2)
        Dec_Inte:EnableMouse(true)
        Dec_Inte:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Up")
        Dec_Inte:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Dec_Inte:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Down")
        --Dec_Inte:SetScript("OnMouseUp", Reduce_stats)
       
    Inc_Spi = CreateFrame("Button", "Inc_Spi", StatFrame_Panel_Spi, nil)
        Inc_Spi:SetSize(23, 23)
        Inc_Spi:SetPoint("CENTER", 60, -2)
        Inc_Spi:EnableMouse(true)
        Inc_Spi:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Up")
        Inc_Spi:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Inc_Spi:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-NextPage-Down")
        --Inc_Spi:SetScript("OnMouseUp", Increase_stats)
       
    Dec_Spi = CreateFrame("Button", "Dec_Spi", StatFrame_Panel_Spi, nil)
        Dec_Spi:SetSize(23, 23)
        Dec_Spi:SetPoint("CENTER", -60, -2)
        Dec_Spi:EnableMouse(true)
        Dec_Spi:SetNormalTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Up")
        Dec_Spi:SetHighlightTexture("Interface/BUTTONS/UI-Panel-MinimizeButton-Highlight")
        Dec_Spi:SetPushedTexture("Interface/BUTTONS/UI-SpellbookIcon-PrevPage-Down")
        --Dec_Spi:SetScript("OnMouseUp", Reduce_stats)
        --edited all
        
	
        Inc_Str:SetScript("OnMouseUp", Increase_stats)
       
    
        Dec_Str:SetScript("OnMouseUp", Reduce_stats)
       
    
        Inc_Sta:SetScript("OnMouseUp", Increase_stats)
       
   
        Dec_Sta:SetScript("OnMouseUp", Reduce_stats)
       
   
        Inc_Agi:SetScript("OnMouseUp", Increase_stats)
       
 
        Dec_Agi:SetScript("OnMouseUp", Reduce_stats)
       
   
        Inc_Inte:SetScript("OnMouseUp", Increase_stats)
       
  
        Dec_Inte:SetScript("OnMouseUp", Reduce_stats)
       
   
        Inc_Spi:SetScript("OnMouseUp", Increase_stats)
       
   
        Dec_Spi:SetScript("OnMouseUp", Reduce_stats)
		
		
	--[[ Reset UI ]]
	
	
	function Reset_spells_button(self)
        display_stuff(GeneralStuff)
	if not(TrainingFrame:IsVisible()) then
		AIO.Handle("sideBar", "ResetSpells")
	end
	end
	
	function Reset_talents_button(self)
        display_stuff(GeneralStuff)
	if not(TrainingFrame:IsVisible()) then
		AIO.Handle("sideBar", "ResetTalents")
	end
	end
	
	
	--[[local ResetFrame_CloseButton = CreateFrame("Button", "ResetFrame_CloseButton", ResetFrame, "UIPanelCloseButton")
		ResetFrame_CloseButton:SetPoint("TOPRIGHT", -5, -5)
		ResetFrame_CloseButton:EnableMouse(true)
		ResetFrame_CloseButton:SetSize(27, 27)
		
	local ResetFrame_TitleBar = CreateFrame("Frame", "ResetFrame_TitleBar", ResetFrame, nil)
        ResetFrame_TitleBar:SetSize(135, 25)
        ResetFrame_TitleBar:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 16,
            tileSize = 16,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
		ResetFrame_TitleBar:SetPoint("TOP", 0, 9)
		local ResetFrame_TitleText = ResetFrame_TitleBar:CreateFontString("ResetFrame_TitleText")
        ResetFrame_TitleText:SetFont("Fonts\\FRIZQT__.TTF", 13)
        ResetFrame_TitleText:SetSize(225, 5)
        ResetFrame_TitleText:SetPoint("CENTER", 0, 0)
        ResetFrame_TitleText:SetText("|cffFFC125Reset Spells/Talents|r")
		
		
	local Reset_Spells = CreateFrame("Button", "Reset_Spells", ResetFrame, nil)
        Reset_Spells:SetSize(100, 50)
        Reset_Spells:SetPoint("CENTER", -60, -20)
        Reset_Spells:EnableMouse(true)
		local texture_spell = Reset_Spells:CreateTexture("Spell_Texture")
		texture_spell:SetAllPoints(Reset_Spells)
		texture_spell:SetTexture(0.5, 1, 1, 0.5)
        Reset_Spells:SetNormalTexture(texture_spell)
		local font_spell = Reset_Spells:CreateFontString("Spell_Font")
		font_spell:SetFont("Fonts\\FRIZQT__.TTF", 11)
		font_spell:SetShadowOffset(1, -1)
		Reset_Spells:SetFontString(font_spell)
		Reset_Spells:SetText("Spells Reset")
        Reset_Spells:SetScript("OnMouseUp", Reset_spells_button)
		
	local Reset_Talents = CreateFrame("Button", "Reset_Talents", ResetFrame, nil)
        Reset_Talents:SetSize(100, 50)
        Reset_Talents:SetPoint("CENTER", 60, -20)
        Reset_Talents:EnableMouse(true)
		local texture_talent = Reset_Talents:CreateTexture("Talent_Texture")
		texture_talent:SetAllPoints(Reset_Talents)
		texture_talent:SetTexture(0.5, 1, 1, 0.5)
        Reset_Talents:SetNormalTexture(texture_talent)
		local font_talent = Reset_Talents:CreateFontString("Talent_Font")
		font_talent:SetFont("Fonts\\FRIZQT__.TTF", 11)
		font_talent:SetShadowOffset(1, -1)
		Reset_Talents:SetFontString(font_talent)
		Reset_Talents:SetText("Talents Reset")
        Reset_Talents:SetScript("OnMouseUp", Reset_talents_button)]]--
		
		
		
	--[[ Character Advancement UI ]]
	spec_displaying = "ALL"
	frame_displaying = "BASIC"
	function display_stuff(self)
        PlaySound("TalentScreenOpen")
	
		local all_buttons = {BalanceDruid, FeralDruid, RestorationDruid, BeastMasteryHunter, MarksmanshipHunter, SurvivalHunter,
		ArcaneMage, FireMage, FrostMage, HolyPaladin, ProtectionPaladin, RetributionPaladin,
		DisciplinePriest, HolyPriest, ShadowPriest, AssassinationRogue, CombatRogue, SubtletyRogue,
		ElementalShaman, EnhancementShaman, RestorationShaman, AfflictionWarlock, DemonologyWarlock, DestructionWarlock,
		ArmsWarrior, FuryWarrior, ProtectionWarrior, GeneralStuff}
		
		local all_textures = {texture_BalanceDruid, texture_FeralDruid, texture_RestorationDruid, texture_BeastMasteryHunter, texture_MarksmanshipHunter, texture_SurvivalHunter,
		texture_ArcaneMage,texture_FireMage,texture_FrostMage,texture_HolyPaladin, texture_ProtectionPaladin, texture_RetributionPaladin,
		texture_DisciplinePriest, texture_HolyPriest, texture_ShadowPriest, texture_AssassinationRogue, texture_CombatRogue, texture_SubtletyRogue,
		texture_ElementalShaman, texture_EnhancementShaman, texture_RestorationShaman, texture_AfflictionWarlock, texture_DemonologyWarlock, texture_DestructionWarlock,
		texture_ArmsWarrior, texture_FuryWarrior, texture_ProtectionWarrior, texture_GeneralStuff}
		
		local all_texture_values = {{1, .49, .04,},{1, .49, .04,},{1, .49, .04,},{.67, .83, .45},{.67, .83, .45},{.67, .83, .45},
		{.41, .8, .94},{.41, .8, .94},{.41, .8, .94},{.96, .55, .73},{.96, .55, .73},{.96, .55, .73},
		{1, 1, 1},{1, 1, 1},{1, 1, 1},{1, .96, .41},{1, .96, .41},{1, .96, .41},
		{0, .44, .87},{0, .44, .87},{0, .44, .87},{.58, .51, .79},{.58, .51, .79},{.58, .51, .79},
		{.78, .61, .43},{.78, .61, .43},{.78, .61, .43},{.4,.4,.4}}

	
		for i,v in ipairs(all_buttons) do
			if self == v then
				 all_textures[i]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button")
                all_textures[i]:SetVertexColor(all_texture_values[i][1], all_texture_values[i][2], all_texture_values[i][3], .8)
				spec_displaying = v
			else
				  all_textures[i]:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
                all_textures[i]:SetVertexColor(all_texture_values[i][1], all_texture_values[i][2], all_texture_values[i][3], .8)
			end
		end

        DisplaySpellsButton:Enable()
        DisplayTalentsButton:Enable()
        BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars1)
        TrainingFrame_SelectedTitle_Stars1_glow:Show()
        BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars2)
        TrainingFrame_SelectedTitle_Stars2_glow:Show()
        BaseFrameFadeIn(TrainingFrame_SelectedTitle_Glow)
		
		frame_displaying = "BASIC"
		display_frame_CA()
	
	end
	
	
	
    local TrainingFrame_CloseButton = CreateFrame("Button", "TrainingFrame_CloseButton", TrainingFrame, "UIPanelCloseButton")
        TrainingFrame_CloseButton:SetPoint("TOPRIGHT", -63, -112)
        TrainingFrame_CloseButton:EnableMouse(true)
        TrainingFrame_CloseButton:SetSize(31, 31)
        TrainingFrame_CloseButton:SetFrameStrata("FULLSCREEN_DIALOG")
        TrainingFrame_CloseButton:SetScript("OnMouseUp", function()
            PlaySound("Glyph_MinorCreate")
            TrainingFrame:Hide()
            end)
		
		
	--[[local TrainingFrame_TitleBar = CreateFrame("Frame", "TrainingFrame_TitleBar", TrainingFrame, nil)
        TrainingFrame_TitleBar:SetSize(180, 25)
        TrainingFrame_TitleBar:SetBackdrop({
            bgFile = "Interface/CHARACTERFRAME/UI-Party-Background",
            edgeFile = "Interface/DialogFrame/UI-DialogBox-Border",
            tile = true,
            edgeSize = 16,
            tileSize = 16,
            insets = { left = 5, right = 5, top = 5, bottom = 5 }
        })
		TrainingFrame_TitleBar:SetPoint("TOP", -90, 9)]]--
		 local TrainingFrame_TitleText = TrainingFrame:CreateFontString("TrainingFrame_TitleText")
        TrainingFrame_TitleText:SetFont("Fonts\\MORPHEUS.TTF", 17, "OUTLINE")
        --TrainingFrame_TitleText:SetSize(225, 255)
        TrainingFrame_TitleText:SetPoint("TOPRIGHT",-135, -97)
        TrainingFrame_TitleText:SetText("|cffFFC125Character|nProgression|r")

	 -- ####################################### Spec Buttons ##############################  
BalanceDruid = CreateFrame("Button", "TrainingFrame_BalanceDruid", TrainingFrame, nil)
        BalanceDruid:SetSize(234, 25.5)
        BalanceDruid:SetPoint("TOPRIGHT", -68.5, -136)
        BalanceDruid:EnableMouse(true)
        texture_BalanceDruid = BalanceDruid:CreateTexture("BalanceDruid")
        texture_BalanceDruid:SetAllPoints(BalanceDruid)
                texture_BalanceDruid:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_BalanceDruid:SetVertexColor(1, .49, .04, .8)
        BalanceDruid:SetNormalTexture(texture_BalanceDruid)
        BalanceDruid:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_BalanceDruid = BalanceDruid:CreateFontString("BalanceDruid_Font")
        font_BalanceDruid:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_BalanceDruid:SetShadowOffset(1, -1)
        BalanceDruid:SetFontString(font_BalanceDruid)
        BalanceDruid:SetText("Balance Druid")
        BalanceDruid:SetScript("OnMouseUp",  display_stuff) 
        
    FeralDruid = CreateFrame("Button", "TrainingFrame_FeralDruid", TrainingFrame, nil)
        FeralDruid:SetSize(234, 25.5)
        FeralDruid:SetPoint("TOPRIGHT", -68.5, -159.5)
        FeralDruid:EnableMouse(true)
        texture_FeralDruid = BalanceDruid:CreateTexture("FeralDruid")
        texture_FeralDruid:SetAllPoints(FeralDruid)
                texture_FeralDruid:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_FeralDruid:SetVertexColor(1, .49, .04, .8)
        FeralDruid:SetNormalTexture(texture_FeralDruid)
        FeralDruid:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_FeralDruid = FeralDruid:CreateFontString("FeralDruid_Font")
        font_FeralDruid:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_FeralDruid:SetShadowOffset(1, -1)
        FeralDruid:SetFontString(font_FeralDruid)
        FeralDruid:SetText("Feral Druid")
        FeralDruid:SetScript("OnMouseUp",  display_stuff)

    RestorationDruid = CreateFrame("Button", "TrainingFrame_RestorationDruid", TrainingFrame, nil)
        RestorationDruid:SetSize(234, 25.5)
        RestorationDruid:SetPoint("TOPRIGHT", -68.5, -183)
        RestorationDruid:EnableMouse(true)
        texture_RestorationDruid = RestorationDruid:CreateTexture("RestorationDruid")
        texture_RestorationDruid:SetAllPoints(RestorationDruid)
                texture_RestorationDruid:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_RestorationDruid:SetVertexColor(1, .49, .04, .8)
        RestorationDruid:SetNormalTexture(texture_RestorationDruid)
        RestorationDruid:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_RestorationDruid = RestorationDruid:CreateFontString("RestorationDruid_Font")
        font_RestorationDruid:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_RestorationDruid:SetShadowOffset(1, -1)
        RestorationDruid:SetFontString(font_RestorationDruid)
        RestorationDruid:SetText("Restoration Druid")
        RestorationDruid:SetScript("OnMouseUp",  display_stuff) 
        
        
    BeastMasteryHunter = CreateFrame("Button", "TrainingFrame_BeastMasteryHunter", TrainingFrame, nil)
        BeastMasteryHunter:SetSize(234, 25.5)
        BeastMasteryHunter:SetPoint("TOPRIGHT", -68.5, -206,5)
        BeastMasteryHunter:EnableMouse(true)
        texture_BeastMasteryHunter = BeastMasteryHunter:CreateTexture("BeastMasteryHunter")
        texture_BeastMasteryHunter:SetAllPoints(BeastMasteryHunter)
                texture_BeastMasteryHunter:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_BeastMasteryHunter:SetVertexColor(.67, .83, .45, .8)
        BeastMasteryHunter:SetNormalTexture(texture_BeastMasteryHunter)
        BeastMasteryHunter:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_BeastMasteryHunter = BeastMasteryHunter:CreateFontString("BeastMasteryHunter_Font")
        font_BeastMasteryHunter:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_BeastMasteryHunter:SetShadowOffset(1, -1)
        BeastMasteryHunter:SetFontString(font_BeastMasteryHunter)
        BeastMasteryHunter:SetText("Beast Mastery Hunter")
        BeastMasteryHunter:SetScript("OnMouseUp",  display_stuff)
        
    
    MarksmanshipHunter = CreateFrame("Button", "TrainingFrame_MarksmanshipHunter", TrainingFrame, nil)
        MarksmanshipHunter:SetSize(234, 25.5)
        MarksmanshipHunter:SetPoint("TOPRIGHT", -68.5, -230)
        MarksmanshipHunter:EnableMouse(true)
        texture_MarksmanshipHunter = MarksmanshipHunter:CreateTexture("MarksmanshipHunter")
        texture_MarksmanshipHunter:SetAllPoints(MarksmanshipHunter)
                texture_MarksmanshipHunter:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_MarksmanshipHunter:SetVertexColor(.67, .83, .45, .8)
        MarksmanshipHunter:SetNormalTexture(texture_MarksmanshipHunter)
        MarksmanshipHunter:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_MarksmanshipHunter = MarksmanshipHunter:CreateFontString("MarksmanshipHunter_Font")
        font_MarksmanshipHunter:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_MarksmanshipHunter:SetShadowOffset(1, -1)
        MarksmanshipHunter:SetFontString(font_MarksmanshipHunter)
        MarksmanshipHunter:SetText("Marksmanship Hunter")
        MarksmanshipHunter:SetScript("OnMouseUp",  display_stuff)
        
        
    SurvivalHunter = CreateFrame("Button", "TrainingFrame_SurvivalHunter", TrainingFrame, nil)
        SurvivalHunter:SetSize(234, 25.5)
        SurvivalHunter:SetPoint("TOPRIGHT", -68.5, -253,5)
        SurvivalHunter:EnableMouse(true)
        texture_SurvivalHunter = MarksmanshipHunter:CreateTexture("SurvivalHunter")
        texture_SurvivalHunter:SetAllPoints(SurvivalHunter)
                texture_SurvivalHunter:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_SurvivalHunter:SetVertexColor(.67, .83, .45, .8)
        SurvivalHunter:SetNormalTexture(texture_SurvivalHunter)
        SurvivalHunter:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_SurvivalHunter = SurvivalHunter:CreateFontString("SurvivalHunter_Font")
        font_SurvivalHunter:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_SurvivalHunter:SetShadowOffset(1, -1)
        SurvivalHunter:SetFontString(font_SurvivalHunter)
        SurvivalHunter:SetText("Survival Hunter")
        SurvivalHunter:SetScript("OnMouseUp",  display_stuff)
        
        
    ArcaneMage = CreateFrame("Button", "TrainingFrame_ArcaneMage", TrainingFrame, nil)
        ArcaneMage:SetSize(234, 25.5)
        ArcaneMage:SetPoint("TOPRIGHT", -68.5, -277)
        ArcaneMage:EnableMouse(true)
        texture_ArcaneMage = ArcaneMage:CreateTexture("FireMage")
        texture_ArcaneMage:SetAllPoints(ArcaneMage)
                texture_ArcaneMage:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_ArcaneMage:SetVertexColor(.41, .8, .94, .8)
        ArcaneMage:SetNormalTexture(texture_ArcaneMage)
        ArcaneMage:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_ArcaneMage = ArcaneMage:CreateFontString("ArcaneMage_Font")
        font_ArcaneMage:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_ArcaneMage:SetShadowOffset(1, -1)
        ArcaneMage:SetFontString(font_ArcaneMage)
        ArcaneMage:SetText("Arcane Mage")
        ArcaneMage:SetScript("OnMouseUp",  display_stuff)
    
        
    FireMage = CreateFrame("Button", "TrainingFrame_FireMage", TrainingFrame, nil)
        FireMage:SetSize(234, 25.5)
        FireMage:SetPoint("TOPRIGHT", -68.5, -300.5)
        FireMage:EnableMouse(true)
        texture_FireMage = FireMage:CreateTexture("FireMage")
        texture_FireMage:SetAllPoints(FireMage)
                texture_FireMage:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_FireMage:SetVertexColor(.41, .8, .94, .8)
        FireMage:SetNormalTexture(texture_FireMage)
        FireMage:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_FireMage = FireMage:CreateFontString("FireMage_Font")
        font_FireMage:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_FireMage:SetShadowOffset(1, -1)
        FireMage:SetFontString(font_FireMage)
        FireMage:SetText("Fire Mage")
        FireMage:SetScript("OnMouseUp",  display_stuff)
        
        
    FrostMage = CreateFrame("Button", "TrainingFrame_FrostMage", TrainingFrame, nil)
        FrostMage:SetSize(234, 25.5)
        FrostMage:SetPoint("TOPRIGHT", -68.5, -324)
        FrostMage:EnableMouse(true)
        texture_FrostMage = FrostMage:CreateTexture("FrostMage")
        texture_FrostMage:SetAllPoints(FrostMage)
                texture_FrostMage:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_FrostMage:SetVertexColor(.41, .8, .94, .8)
        FrostMage:SetNormalTexture(texture_FrostMage)
        FrostMage:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_FrostMage = FrostMage:CreateFontString("FrostMage_Font")
        font_FrostMage:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_FrostMage:SetShadowOffset(1, -1)
        FrostMage:SetFontString(font_FrostMage)
        FrostMage:SetText("Frost Mage")
        FrostMage:SetScript("OnMouseUp",  display_stuff)
        
    HolyPaladin = CreateFrame("Button", "TrainingFrame_HolyPaladin", TrainingFrame, nil)
        HolyPaladin:SetSize(234, 25.5)
        HolyPaladin:SetPoint("TOPRIGHT", -68.5, -347,5)
        HolyPaladin:EnableMouse(true)
        texture_HolyPaladin = HolyPaladin:CreateTexture("HolyPaladin")
        texture_HolyPaladin:SetAllPoints(HolyPaladin)
                texture_HolyPaladin:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_HolyPaladin:SetVertexColor(.96, .55, .73, .8)
        HolyPaladin:SetNormalTexture(texture_HolyPaladin)
        HolyPaladin:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_HolyPaladin = HolyPaladin:CreateFontString("HolyPaladin_Font")
        font_HolyPaladin:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_HolyPaladin:SetShadowOffset(1, -1)
        HolyPaladin:SetFontString(font_HolyPaladin)
        HolyPaladin:SetText("Holy Paladin")
        HolyPaladin:SetScript("OnMouseUp",  display_stuff)
        
        
    ProtectionPaladin = CreateFrame("Button", "TrainingFrame_ProtectionPaladin", TrainingFrame, nil)
        ProtectionPaladin:SetSize(234, 25.5)
        ProtectionPaladin:SetPoint("TOPRIGHT", -68.5, -371)
        ProtectionPaladin:EnableMouse(true)
        texture_ProtectionPaladin = ProtectionPaladin:CreateTexture("ProtectionPaladin")
        texture_ProtectionPaladin:SetAllPoints(ProtectionPaladin)
                texture_ProtectionPaladin:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_ProtectionPaladin:SetVertexColor(.96, .55, .73, .8)
        ProtectionPaladin:SetNormalTexture(texture_ProtectionPaladin)
        ProtectionPaladin:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_ProtectionPaladin = ProtectionPaladin:CreateFontString("ProtectionPaladin_Font")
        font_ProtectionPaladin:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_ProtectionPaladin:SetShadowOffset(1, -1)
        ProtectionPaladin:SetFontString(font_ProtectionPaladin)
        ProtectionPaladin:SetText("Protection Paladin")
        ProtectionPaladin:SetScript("OnMouseUp",  display_stuff)
        
        
    RetributionPaladin = CreateFrame("Button", "TrainingFrame_RetributionPaladin", TrainingFrame, nil)
        RetributionPaladin:SetSize(234, 25.5)
        RetributionPaladin:SetPoint("TOPRIGHT", -68.5, -394,5)
        RetributionPaladin:EnableMouse(true)
        texture_RetributionPaladin = RetributionPaladin:CreateTexture("RetributionPaladin")
        texture_RetributionPaladin:SetAllPoints(RetributionPaladin)
                texture_RetributionPaladin:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_RetributionPaladin:SetVertexColor(.96, .55, .73, .8)
        RetributionPaladin:SetNormalTexture(texture_RetributionPaladin)
        RetributionPaladin:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_RetributionPaladin = RetributionPaladin:CreateFontString("RetributionPaladin_Font")
        font_RetributionPaladin:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_RetributionPaladin:SetShadowOffset(1, -1)
        RetributionPaladin:SetFontString(font_RetributionPaladin)
        RetributionPaladin:SetText("Retribution Paladin")
        RetributionPaladin:SetScript("OnMouseUp",  display_stuff)
        
        
    DisciplinePriest = CreateFrame("Button", "TrainingFrame_DisciplinePriest", TrainingFrame, nil)
        DisciplinePriest:SetSize(234, 25.5)
        DisciplinePriest:SetPoint("TOPRIGHT", -68.5, -418)
        DisciplinePriest:EnableMouse(true)
        texture_DisciplinePriest = DisciplinePriest:CreateTexture("DisciplinePriest")
        texture_DisciplinePriest:SetAllPoints(DisciplinePriest)
                texture_DisciplinePriest:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_DisciplinePriest:SetVertexColor(1, 1, 1, .8)
        DisciplinePriest:SetNormalTexture(texture_DisciplinePriest)
        DisciplinePriest:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_DisciplinePriest = DisciplinePriest:CreateFontString("DisciplinePriest_Font")
        font_DisciplinePriest:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_DisciplinePriest:SetShadowOffset(1, -1)
        DisciplinePriest:SetFontString(font_DisciplinePriest)
        DisciplinePriest:SetText("Discipline Priest")
        DisciplinePriest:SetScript("OnMouseUp",  display_stuff)
        
        
    HolyPriest = CreateFrame("Button", "TrainingFrame_HolyPriest", TrainingFrame, nil)
        HolyPriest:SetSize(234, 25.5)
        HolyPriest:SetPoint("TOPRIGHT", -68.5, -441,5)
        HolyPriest:EnableMouse(true)
        texture_HolyPriest = HolyPriest:CreateTexture("HolyPriest")
        texture_HolyPriest:SetAllPoints(HolyPriest)
                texture_HolyPriest:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_HolyPriest:SetVertexColor(1, 1, 1, .8)
        HolyPriest:SetNormalTexture(texture_HolyPriest)
        HolyPriest:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_HolyPriest = HolyPriest:CreateFontString("HolyPriest_Font")
        font_HolyPriest:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_HolyPriest:SetShadowOffset(1, -1)
        HolyPriest:SetFontString(font_HolyPriest)
        HolyPriest:SetText("Holy Priest")
        HolyPriest:SetScript("OnMouseUp",  display_stuff)
        
        
    ShadowPriest = CreateFrame("Button", "TrainingFrame_ShadowPriest", TrainingFrame, nil)
        ShadowPriest:SetSize(234, 25.5)
        ShadowPriest:SetPoint("TOPRIGHT", -68.5, -465)
        ShadowPriest:EnableMouse(true)
        texture_ShadowPriest = ShadowPriest:CreateTexture("ShadowPriest")
        texture_ShadowPriest:SetAllPoints(ShadowPriest)
                texture_ShadowPriest:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_ShadowPriest:SetVertexColor(1, 1, 1, .8)
        ShadowPriest:SetNormalTexture(texture_ShadowPriest)
        ShadowPriest:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_ShadowPriest = ShadowPriest:CreateFontString("ShadowPriest_Font")
        font_ShadowPriest:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_ShadowPriest:SetShadowOffset(1, -1)
        ShadowPriest:SetFontString(font_ShadowPriest)
        ShadowPriest:SetText("Shadow Priest")
        ShadowPriest:SetScript("OnMouseUp",  display_stuff)
        
        
    AssassinationRogue = CreateFrame("Button", "TrainingFrame_AssassinationRogue", TrainingFrame, nil)
        AssassinationRogue:SetSize(234, 25.5)
        AssassinationRogue:SetPoint("TOPRIGHT", -68.5, -488,5)
        AssassinationRogue:EnableMouse(true)
        texture_AssassinationRogue = AssassinationRogue:CreateTexture("AssassinationRogue")
        texture_AssassinationRogue:SetAllPoints(AssassinationRogue)
                texture_AssassinationRogue:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_AssassinationRogue:SetVertexColor(1, .96, .41, .8)
        AssassinationRogue:SetNormalTexture(texture_AssassinationRogue)
        AssassinationRogue:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_AssassinationRogue = AssassinationRogue:CreateFontString("AssassinationRogue_Font")
        font_AssassinationRogue:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_AssassinationRogue:SetShadowOffset(1, -1)
        AssassinationRogue:SetFontString(font_AssassinationRogue)
        AssassinationRogue:SetText("Assassination Rogue")
        AssassinationRogue:SetScript("OnMouseUp",  display_stuff)
        
        
    CombatRogue = CreateFrame("Button", "TrainingFrame_CombatRogue", TrainingFrame, nil)
        CombatRogue:SetSize(234, 25.5)
        CombatRogue:SetPoint("TOPRIGHT", -68.5, -512)
        CombatRogue:EnableMouse(true)
        texture_CombatRogue = CombatRogue:CreateTexture("CombatRogue")
        texture_CombatRogue:SetAllPoints(CombatRogue)
                texture_CombatRogue:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_CombatRogue:SetVertexColor(1, .96, .41, .8)
        CombatRogue:SetNormalTexture(texture_CombatRogue)
        CombatRogue:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_CombatRogue = CombatRogue:CreateFontString("CombatRogue_Font")
        font_CombatRogue:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_CombatRogue:SetShadowOffset(1, -1)
        CombatRogue:SetFontString(font_CombatRogue)
        CombatRogue:SetText("Combat Rogue")
        CombatRogue:SetScript("OnMouseUp",  display_stuff)
        
        
    SubtletyRogue = CreateFrame("Button", "TrainingFrame_SubtletyRogue", TrainingFrame, nil)
        SubtletyRogue:SetSize(234, 25.5)
        SubtletyRogue:SetPoint("TOPRIGHT", -68.5, -535,5)
        SubtletyRogue:EnableMouse(true)
        texture_SubtletyRogue = SubtletyRogue:CreateTexture("SubtletyRogue")
        texture_SubtletyRogue:SetAllPoints(SubtletyRogue)
                texture_SubtletyRogue:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_SubtletyRogue:SetVertexColor(1, .96, .41, .8)
        SubtletyRogue:SetNormalTexture(texture_SubtletyRogue)
        SubtletyRogue:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_SubtletyRogue = SubtletyRogue:CreateFontString("SubtletyRogue_Font")
        font_SubtletyRogue:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_SubtletyRogue:SetShadowOffset(1, -1)
        SubtletyRogue:SetFontString(font_SubtletyRogue)
        SubtletyRogue:SetText("Subtlety Rogue")
        SubtletyRogue:SetScript("OnMouseUp",  display_stuff)
        
        
    ElementalShaman = CreateFrame("Button", "TrainingFrame_ElementalShaman", TrainingFrame, nil)
        ElementalShaman:SetSize(234, 25.5)
        ElementalShaman:SetPoint("TOPRIGHT", -68.5, -559)
        ElementalShaman:EnableMouse(true)
        texture_ElementalShaman = ElementalShaman:CreateTexture("ElementalShaman")
        texture_ElementalShaman:SetAllPoints(ElementalShaman)
                texture_ElementalShaman:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_ElementalShaman:SetVertexColor(0, .44, .87, .8)
        ElementalShaman:SetNormalTexture(texture_ElementalShaman)
        ElementalShaman:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_ElementalShaman = ElementalShaman:CreateFontString("ElementalShaman_Font")
        font_ElementalShaman:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_ElementalShaman:SetShadowOffset(1, -1)
        ElementalShaman:SetFontString(font_ElementalShaman)
        ElementalShaman:SetText("Elemental Shaman")
        ElementalShaman:SetScript("OnMouseUp",  display_stuff)
        
        
    EnhancementShaman = CreateFrame("Button", "TrainingFrame_EnhancementShaman", TrainingFrame, nil)
        EnhancementShaman:SetSize(234, 25.5)
        EnhancementShaman:SetPoint("TOPRIGHT", -68.5, -582,5)
        EnhancementShaman:EnableMouse(true)
        texture_EnhancementShaman = EnhancementShaman:CreateTexture("EnhancementShaman")
        texture_EnhancementShaman:SetAllPoints(EnhancementShaman)
                texture_EnhancementShaman:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_EnhancementShaman:SetVertexColor(0, .44, .87, .8)
        EnhancementShaman:SetNormalTexture(texture_EnhancementShaman)
        EnhancementShaman:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_EnhancementShaman = EnhancementShaman:CreateFontString("EnhancementShaman_Font")
        font_EnhancementShaman:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_EnhancementShaman:SetShadowOffset(1, -1)
        EnhancementShaman:SetFontString(font_EnhancementShaman)
        EnhancementShaman:SetText("Enhancement Shaman")
        EnhancementShaman:SetScript("OnMouseUp",  display_stuff)
        
        
    RestorationShaman = CreateFrame("Button", "TrainingFrame_RestorationShaman", TrainingFrame, nil)
        RestorationShaman:SetSize(234, 25.5)
        RestorationShaman:SetPoint("TOPRIGHT", -68.5, -606)
        RestorationShaman:EnableMouse(true)
        texture_RestorationShaman = RestorationShaman:CreateTexture("RestorationShaman")
        texture_RestorationShaman:SetAllPoints(RestorationShaman)
                texture_RestorationShaman:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_RestorationShaman:SetVertexColor(0, .44, .87, .8)
        RestorationShaman:SetNormalTexture(texture_RestorationShaman)
        RestorationShaman:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_RestorationShaman = RestorationShaman:CreateFontString("RestorationShaman_Font")
        font_RestorationShaman:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_RestorationShaman:SetShadowOffset(1, -1)
        RestorationShaman:SetFontString(font_RestorationShaman)
        RestorationShaman:SetText("Restoration Shaman")
        RestorationShaman:SetScript("OnMouseUp",  display_stuff)
        
        
    AfflictionWarlock = CreateFrame("Button", "TrainingFrame_AfflictionWarlock", TrainingFrame, nil)
        AfflictionWarlock:SetSize(234, 25.5)
        AfflictionWarlock:SetPoint("TOPRIGHT", -68.5, -629,5)
        AfflictionWarlock:EnableMouse(true)
        texture_AfflictionWarlock = AfflictionWarlock:CreateTexture("AfflictionWarlock")
        texture_AfflictionWarlock:SetAllPoints(AfflictionWarlock)
                texture_AfflictionWarlock:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_AfflictionWarlock:SetVertexColor(.58, .51, .79, .8)
        AfflictionWarlock:SetNormalTexture(texture_AfflictionWarlock)
        AfflictionWarlock:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_AfflictionWarlock = AfflictionWarlock:CreateFontString("AfflictionWarlock_Font")
        font_AfflictionWarlock:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_AfflictionWarlock:SetShadowOffset(1, -1)
        AfflictionWarlock:SetFontString(font_AfflictionWarlock)
        AfflictionWarlock:SetText("Affliction Warlock")
        AfflictionWarlock:SetScript("OnMouseUp",  display_stuff)
        
    DemonologyWarlock = CreateFrame("Button", "TrainingFrame_DemonologyWarlock", TrainingFrame, nil)
        DemonologyWarlock:SetSize(234, 25.5)
        DemonologyWarlock:SetPoint("TOPRIGHT", -68.5, -653)
        DemonologyWarlock:EnableMouse(true)
        texture_DemonologyWarlock = DemonologyWarlock:CreateTexture("DemonologyWarlock")
        texture_DemonologyWarlock:SetAllPoints(DemonologyWarlock)
                texture_DemonologyWarlock:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_DemonologyWarlock:SetVertexColor(.58, .51, .79, .8)
        DemonologyWarlock:SetNormalTexture(texture_DemonologyWarlock)
        DemonologyWarlock:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_DemonologyWarlock = DemonologyWarlock:CreateFontString("DemonologyWarlock_Font")
        font_DemonologyWarlock:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_DemonologyWarlock:SetShadowOffset(1, -1)
        DemonologyWarlock:SetFontString(font_DemonologyWarlock)
        DemonologyWarlock:SetText("Demonology Warlock")
        DemonologyWarlock:SetScript("OnMouseUp",  display_stuff)
        
        
    DestructionWarlock = CreateFrame("Button", "TrainingFrame_DestructionWarlock", TrainingFrame, nil)
        DestructionWarlock:SetSize(234, 25.5)
        DestructionWarlock:SetPoint("TOPRIGHT", -68.5, -676,5)
        DestructionWarlock:EnableMouse(true)
        texture_DestructionWarlock = DestructionWarlock:CreateTexture("DestructionWarlock")
        texture_DestructionWarlock:SetAllPoints(DestructionWarlock)
                texture_DestructionWarlock:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_DestructionWarlock:SetVertexColor(.58, .51, .79, .8)
        DestructionWarlock:SetNormalTexture(texture_DestructionWarlock)
        DestructionWarlock:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_DestructionWarlock = DestructionWarlock:CreateFontString("DestructionWarlock_Font")
        font_DestructionWarlock:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_DestructionWarlock:SetShadowOffset(1, -1)
        DestructionWarlock:SetFontString(font_DestructionWarlock)
        DestructionWarlock:SetText("Destruction Warlock")
        DestructionWarlock:SetScript("OnMouseUp",  display_stuff)
        
        
    ArmsWarrior = CreateFrame("Button", "TrainingFrame_ArmsWarrior", TrainingFrame, nil)
        ArmsWarrior:SetSize(234, 25.5)
        ArmsWarrior:SetPoint("TOPRIGHT", -68.5, -700)
        ArmsWarrior:EnableMouse(true)
        texture_ArmsWarrior = ArmsWarrior:CreateTexture("ArmsWarrior")
        texture_ArmsWarrior:SetAllPoints(ArmsWarrior)
                texture_ArmsWarrior:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_ArmsWarrior:SetVertexColor(.78, .61, .43, .8)
        ArmsWarrior:SetNormalTexture(texture_ArmsWarrior)
        ArmsWarrior:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_ArmsWarrior = ArmsWarrior:CreateFontString("ArmsWarrior_Font")
        font_ArmsWarrior:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_ArmsWarrior:SetShadowOffset(1, -1)
        ArmsWarrior:SetFontString(font_ArmsWarrior)
        ArmsWarrior:SetText("Arms Warrior")
        ArmsWarrior:SetScript("OnMouseUp",  display_stuff)
        
        
    FuryWarrior = CreateFrame("Button", "TrainingFrame_FuryWarrior", TrainingFrame, nil)
        FuryWarrior:SetSize(234, 25.5)
        FuryWarrior:SetPoint("TOPRIGHT", -68.5, -723,5)
        FuryWarrior:EnableMouse(true)
        texture_FuryWarrior = FuryWarrior:CreateTexture("FuryWarrior")
        texture_FuryWarrior:SetAllPoints(FuryWarrior)
                texture_FuryWarrior:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_FuryWarrior:SetVertexColor(.78, .61, .43, .8)
        FuryWarrior:SetNormalTexture(texture_FuryWarrior)
        FuryWarrior:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_FuryWarrior = FuryWarrior:CreateFontString("FuryWarrior_Font")
        font_FuryWarrior:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_FuryWarrior:SetShadowOffset(1, -1)
        FuryWarrior:SetFontString(font_FuryWarrior)
        FuryWarrior:SetText("Fury Warrior")
        FuryWarrior:SetScript("OnMouseUp",  display_stuff)
        
        
    ProtectionWarrior = CreateFrame("Button", "TrainingFrame_ProtectionWarrior", TrainingFrame, nil)
        ProtectionWarrior:SetSize(234, 25.5)
        ProtectionWarrior:SetPoint("TOPRIGHT", -68.5, -747)
        ProtectionWarrior:EnableMouse(true)
        texture_ProtectionWarrior = ProtectionWarrior:CreateTexture("ProtectionWarrior")
        texture_ProtectionWarrior:SetAllPoints(ProtectionWarrior)
                texture_ProtectionWarrior:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_ProtectionWarrior:SetVertexColor(.78, .61, .43, .8)
        ProtectionWarrior:SetNormalTexture(texture_ProtectionWarrior)
        ProtectionWarrior:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_ProtectionWarrior = ProtectionWarrior:CreateFontString("ProtectionWarrior_Font")
        font_ProtectionWarrior:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_ProtectionWarrior:SetShadowOffset(1, -1)
        ProtectionWarrior:SetFontString(font_ProtectionWarrior)
        ProtectionWarrior:SetText("Protection Warrior")
        ProtectionWarrior:SetScript("OnMouseUp",  display_stuff)
        
    GeneralStuff = CreateFrame("Button", "TrainingFrame_GeneralStuff", TrainingFrame, nil)
        GeneralStuff:SetSize(234, 25.5)
        GeneralStuff:SetPoint("TOPRIGHT", -68.5, -770,5)
        GeneralStuff:EnableMouse(true)
        texture_GeneralStuff = GeneralStuff:CreateTexture("GeneralStuff")
        texture_GeneralStuff:SetAllPoints(GeneralStuff)
                texture_GeneralStuff:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h")
        texture_GeneralStuff:SetVertexColor(.4, .4, .4, .8)
        GeneralStuff:SetNormalTexture(texture_GeneralStuff)
        GeneralStuff:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\button_h2")
                font_GeneralStuff = GeneralStuff:CreateFontString("GeneralStuff_Font")
        font_GeneralStuff:SetFont("Fonts\\FRIZQT__.TTF", 11)
        font_GeneralStuff:SetShadowOffset(1, -1)
        GeneralStuff:SetFontString(font_GeneralStuff)
        GeneralStuff:SetText("General")
        GeneralStuff:SetScript("OnMouseUp",  display_stuff)
		
		spec_displaying = GeneralStuff
		
		
	-- ####################################### Frame Handling ##############################	
	
	function display_frame_CA()
	
		if frame_displaying == "BASIC" then
		TrainingFrame:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\progress",})
			-- shows
			DisplaySpellsButton:Show()
			DisplayTalentsButton:Show()
            TrainingFrame.Text_Ability:Hide()

            ProgressionBlueBookBorder:Hide()
            ProgressionPurpleBookBorder:Hide()
            TrainingFrame_model:Hide()
            TrainingFrame_model2:Hide()
			
			--hides
			for i,v in ipairs(all_spell_slots) do
				v[1]:Hide()
			end
			scrollframe:Hide()
			scrollbar:Hide()
			top_left_bg:Hide()
			top_right_bg:Hide()
			bottom_left_bg:Hide()
			bottom_right_bg:Hide()
			current_talenList = {}
			current_known_talents_list = {}
			
		elseif frame_displaying == "SPELLS" then
		
			--shows
			for i,v in ipairs(all_spell_slots) do
				v[1]:Show()
			end
			
			--hides
			DisplaySpellsButton:Hide()
			DisplayTalentsButton:Hide()
			scrollframe:Hide()
			scrollbar:Hide()
			
		elseif frame_displaying == "TALENTS" then
		
			--shows
			scrollframe:Show()
			scrollbar:Show()
			
			--hides
			DisplaySpellsButton:Hide()
			DisplayTalentsButton:Hide()
			for i,v in ipairs(all_spell_slots) do
				v[1]:Hide()
			end
		end
	
	end
	
	function display_next_frame_CA(self)
        PlaySound("TalentScreenClose")
	
		if self == DisplaySpellsButton then
		
			frame_displaying = "SPELLS"
            TrainingFrame:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_inside_blue",})
            ProgressionBlueBookBorder:Show()
            TrainingFrame.Text_Ability:Show()
            --TrainingFrameBorder:SetFrameStrata("FULLSCREEN")
			
			local all_buttons = {BalanceDruid, FeralDruid, RestorationDruid, BeastMasteryHunter, MarksmanshipHunter, SurvivalHunter,
				ArcaneMage, FireMage, FrostMage, HolyPaladin, ProtectionPaladin, RetributionPaladin,
				DisciplinePriest, HolyPriest, ShadowPriest, AssassinationRogue, CombatRogue, SubtletyRogue,
				ElementalShaman, EnhancementShaman, RestorationShaman, AfflictionWarlock, DemonologyWarlock, DestructionWarlock,
				ArmsWarrior, FuryWarrior, ProtectionWarrior, GeneralStuff}
				
			local all_pass_varis = {{"DRUID", "BALANCE"}, {"DRUID", "FERAL"}, {"DRUID", "RESTORATION"},
			{"HUNTER", "BEASTMASTERY"},{"HUNTER", "MARKSMANSHIP"}, {"HUNTER", "SURVIVAL"},
			{"MAGE", "ARCANE"}, {"MAGE", "FIRE"}, {"MAGE", "FROST"},
			{"PALADIN", "HOLY"}, {"PALADIN", "PROTECTION"}, {"PALADIN", "RETRIBUTION"},
			{"PRIEST", "DISCIPLINE"}, {"PRIEST", "HOLY"}, {"PRIEST", "SHADOW"},
			{"ROGUE", "ASSASSINATION"}, {"ROGUE", "COMBAT"}, {"ROGUE", "SUBTLETY"},
			{"SHAMAN", "ELEMENTAL"}, {"SHAMAN", "ENHANCEMENT"}, {"SHAMAN", "RESTORATION"},
			{"WARLOCK", "AFFLICTION"}, {"WARLOCK", "DEMONOLOGY"}, {"WARLOCK", "DESTRUCTION"},
			{"WARRIOR", "ARMS"}, {"WARRIOR", "FURY"}, {"WARRIOR", "PROTECTION"},
			{"GENERAL", "GENERAL"}}
			
			for i,v in ipairs(all_buttons) do
				if spec_displaying == v then
					AIO.Handle("sideBar", "SendAmountOfSpells", all_pass_varis[i][1], all_pass_varis[i][2])
                    sideBar.CurrentSpellSpec = {all_pass_varis[i][1], all_pass_varis[i][2]}
				end
			end
		
		end
		
		display_frame_CA()
	
	end
	
	function display_talents(self)
        PlaySound("TalentScreenClose")
	
		if spec_displaying ~= GeneralStuff then
			frame_displaying = "TALENTS"
            TrainingFrame:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_inside_purple",})
            ProgressionPurpleBookBorder:Show()
            TrainingFrame.Text_Ability:Show()
            --TrainingFrameBorder:SetFrameStrata("FULLSCREEN")
			
			local all_buttons = {BalanceDruid, FeralDruid, RestorationDruid, BeastMasteryHunter, MarksmanshipHunter, SurvivalHunter,
				ArcaneMage, FireMage, FrostMage, HolyPaladin, ProtectionPaladin, RetributionPaladin,
				DisciplinePriest, HolyPriest, ShadowPriest, AssassinationRogue, CombatRogue, SubtletyRogue,
				ElementalShaman, EnhancementShaman, RestorationShaman, AfflictionWarlock, DemonologyWarlock, DestructionWarlock,
				ArmsWarrior, FuryWarrior, ProtectionWarrior, GeneralStuff}
			
			local all_pass_varis = {"DRUIDBALANCE", "DRUIDFERAL", "DRUIDRESTORATION",
			"HUNTERBEASTMASTERY", "HUNTERMARKSMANSHIP", "HUNTERSURVIVAL",
			"MAGEARCANE", "MAGEFIRE", "MAGEFROST",
			"PALADINHOLY", "PALADINPROTECTION", "PALADINRETRIBUTION",
			"PRIESTDISCIPLINE", "PRIESTHOLY", "PRIESTSHADOW",
			"ROGUEASSASSINATION", "ROGUECOMBAT", "ROGUESUBTLETY",
			"SHAMANELEMENTAL", "SHAMANENHANCEMENT", "SHAMANRESTORATION",
			"WARLOCKAFFLICTION", "WARLOCK", "DEMONOLOGY", "WARLOCKDESTRUCTION",
			"WARRIORARMS", "WARRIORFURY", "WARRIORPROTECTION"}
			local ClassSpec = nil
			for i,v in ipairs(all_buttons) do

				if v == spec_displaying then
					ClassSpec = all_pass_varis[i]
					
					break
				end
			end
			AIO.Handle("sideBar", "GetAllBGs", ClassSpec)
            sideBar.CurrentTalentSpec = ClassSpec
			display_frame_CA()
		end
	
	end
	
	current_talentList = {}
	current_known_talents_list = {}
	
	function MyHandlers.SetBackgroundImages(player, ClassSpec, bgList, talentList, known_talents_list, tabIndex)
	
		local all_pass_varis = {"DRUIDBALANCE", "DRUIDFERAL", "DRUIDRESTORATION",
			"HUNTERBEASTMASTERY", "HUNTERMARKSMANSHIP", "HUNTERSURVIVAL",
			"MAGEARCANE", "MAGEFIRE", "MAGEFROST",
			"PALADINHOLY", "PALADINPROTECTION", "PALADINRETRIBUTION",
			"PRIESTDISCIPLINE", "PRIESTHOLY", "PRIESTSHADOW",
			"ROGUEASSASSINATION", "ROGUECOMBAT", "ROGUESUBTLETY",
			"SHAMANELEMENTAL", "SHAMANENHANCEMENT", "SHAMANRESTORATION",
			"WARLOCKAFFLICTION", "WARLOCK", "DEMONOLOGY", "WARLOCKDESTRUCTION",
			"WARRIORARMS", "WARRIORFURY", "WARRIORPROTECTION"}
		current_talentList = talentList
		current_known_talents_list = known_talents_list	
			
		for i,v in ipairs(all_pass_varis) do
		
			if v == ClassSpec then
				
				top_left_bg_t:SetTexture(bgList[i][1]) 
				top_left_bg:Show()
				
				top_right_bg_t:SetTexture(bgList[i][2]) 
				top_right_bg:Show()

				bottom_left_bg_t:SetTexture(bgList[i][3]) 
				bottom_left_bg:Show()

				bottom_right_bg_t:SetTexture(bgList[i][4]) 
				bottom_right_bg:Show()
			end
		end
		
		for i,v in ipairs(button_on_off_state) do
			button_on_off_state[i] = false
		end
		on_talent = 1
		talent_index = 1
		for i,v in ipairs(talentList) do
			local player_knows_a_talent = false
			local player_talent_known = 0
			local learn_text = "|cff6b625bLearn|r"
			local learn_tooltip = "Requires: Level "..v[5]
			local learn_texture = {.3, .3, .3}
			local attach_it = false
			local number_of_ranks = v[1]
			local tabIndexee = tabIndex
			
			local spellIds = v[2]
			local AE_cost = v[3]
			local TE_cost = v[4]
			local requiredLevel = v[5]
			local column = v[6]
			local talent_ID = v[7]
            local BG_New = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg"
            local BG_Color = {0.46,0.36,0.34,1}
			
			local get_spell_link = GetSpellLink(spellIds[1])
			local name,_, icon, _,_,_,_ = GetSpellInfo(spellIds[1])
			
			if known_talents_list[i] ~= false then
				player_knows_a_talent = true
				player_talent_known = known_talents_list[i]
			end
			
			if requiredLevel <= UnitLevel("player") then
			
				learn_tooltip = "Cost: "..AE_cost.." AE "..TE_cost.." TE"
			
				if player_knows_a_talent == true then
			
					get_spell_link = "|cffFFFFFF|Hspell:"..spellIds[player_talent_known].."|h[Talent]|h|r"
					BG_Color = {1,1,1,1}
					if player_talent_known == number_of_ranks then
						learn_tooltip = "Maxed Out"
						learn_texture = {1, 1, 0}
						learn_text = "|cff6b625bMax|r"
                        BG_New = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank_max"
					else
						attach_it = {spellIds[player_talent_known + 1],AE_cost,TE_cost,spellIds,number_of_ranks}
						learn_texture = {0, .5, 0}
						learn_text = "|cffE1AB18Upgrade|r"
                        BG_New = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank"
					end
				else
				
					learn_text="Learn" -- used for talent texts
					
					attach_it = {spellIds[1],AE_cost,TE_cost,spellIds,number_of_ranks}
				
				end
			
			end
		
			local button_using = (((requiredLevel - 10) / 5) * 4) + column
			all_talent_slot_buttons[button_using]:SetBackdrop({
				bgFile = icon
			})
            all_talent_slot_buttons[button_using]:SetBackdropColor(unpack(BG_Color))
            all_talent_slots[button_using]:SetBackdrop({
                        bgFile = BG_New,
                         insets = {
                        left = -11,
                        right = -11,
                        top = -11,
                        bottom = -11}
                        })
            all_talent_slot_buttons[button_using].HyperLink = get_spell_link

			local talent_indexee = talent_index
			local function talent_icon_tooltip_Enter(self, motion)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				if self.HyperLink ~= nil then
					GameTooltip:SetHyperlink(self.HyperLink)
				else
					GameTooltip:SetTalent(tabIndexee, talent_indexee, false, false, nil)
				end
				GameTooltip:Show()
                --for unlearn spell
                --[[local red, green, blue, alpha = self:GetBackdropColor()
                if (red) and (red > 0.98) then
                BaseFrameFadeIn(self.UnlearnTex)
                GameTooltip:AppendText("\n|cffFF0000Click on the icon to use |cff00FF00[Scroll of unlearning]|r")
                end]]--
                -- end
                -- for ranks with learned talents
                if self.HyperLink ~= nil then
                    GameTooltip:AppendText("\nRank "..all_talent_FrameNumber[button_using]:GetText().."/"..number_of_ranks.."")
                end
			end
			all_talent_slot_buttons[button_using]:SetScript("OnEnter", talent_icon_tooltip_Enter)
			local function talent_icon_tooltip_OnLeave(self)
                --for unlearn talent
                --[[if (self.UnlearnTex:IsVisible()) then
                BaseFrameFadeOut(self.UnlearnTex)
                end]]--
                -- end
				GameTooltip:Hide()
			end
			all_talent_slot_buttons[button_using]:SetScript("OnLeave", talent_icon_tooltip_OnLeave)
			
			all_learn_talent_buttons_t[button_using]:SetTexture(learn_texture[1], learn_texture[2], learn_texture[3], 0)
			
			local function learn_button_tooltip_Enter(self, motion)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(learn_tooltip)
				GameTooltip:Show()
			end
			all_learn_talent_buttons[button_using]:SetScript("OnEnter", learn_button_tooltip_Enter)
			local function learn_button_tooltip_Leave(self, motion)
				GameTooltip:Hide()
			end
			all_learn_talent_buttons[button_using]:SetScript("OnLeave", learn_button_tooltip_Leave)
			
			all_attached_talent[button_using] = attach_it
			
			all_learn_talent_buttons[button_using]:SetText(learn_text)
			
			all_talent_FrameNumber[button_using]:SetText(player_talent_known)

			button_on_off_state[button_using] = true 
			on_talent = on_talent + 1
			talent_index = talent_index + 1
		
		end
		for i,v in ipairs(button_on_off_state) do
		
			if v == true then
				all_talent_slots[i]:Show()
		
				all_talent_slot_buttons[i]:Show()
				
				all_learn_talent_buttons[i]:Show()
				
				all_talent_FrameNumber[i]:Show()
			else
				all_talent_slots[i]:Hide()
		
				all_talent_slot_buttons[i]:Hide()
				
				all_learn_talent_buttons[i]:Hide()
				
				all_talent_FrameNumber[i]:Hide()
			end
		end
		
		content:Show()
	end
	
	function upgrade_talent(self)
        PlaySound("igMainMenuOptionCheckBoxOn")
		local talent_attached = false
		local indexAt
	
		for i,v in ipairs(all_learn_talent_buttons) do
			if v == self then
				talent_attached = all_attached_talent[i]
				all_attached_talent[i] = nil
				indexAt = i
				break
			end
		end
		
		
		
		if talent_attached ~= false then
			AIO.Handle("sideBar","LearnThisTalent",talent_attached,indexAt,sideBar.CurrentTalentSpec)
		end
	
	end
	
	function MyHandlers.TalentGoBack(player, attached_talent, indexAt)
		all_attached_talent[indexAt] = attached_talent
	end
	
	function MyHandlers.UpdateTalent(player, attached_talent, indexAt)
		
		local AE_cost = attached_talent[2]
		local TE_cost = attached_talent[3]
		local all_spellIds = attached_talent[4]
		local talents_ranks = attached_talent[5]
		local previous_spellId = attached_talent[1]
		
		local texture_changed = {0, .5, 0}
		local text_changed = "|cffE1AB18Upgrade|r"
		local learn_tooltip = nil
		local attached_talent = nil
        local BG_File = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg"
		local FN = 1
        local BG_Color_U = {0.46,0.36,0.34,1}


		for i,v in ipairs(all_spellIds) do
			if v == previous_spellId then
				FN = i
				if i == talents_ranks then
					texture_changed = {1, 1, 0}
					learn_tooltip = "Maxed Out" -- used for talent texts
					text_changed = "|cff6b625bMax|r"
                    all_talent_slot_buttons[indexAt].HyperLink = "|cffFFFFFF|Hspell:"..all_spellIds[i].."|h[Talent]|h|r"
                    BG_File = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank_max"
                    BG_Color_U = {1,1,1,1}
				else
                    all_talent_slot_buttons[indexAt].HyperLink = "|cffFFFFFF|Hspell:"..all_spellIds[i].."|h[Talent]|h|r"
					attached_talent = {all_spellIds[i + 1],AE_cost, TE_cost,all_spellIds,talents_ranks}
                    BG_File = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_rank"
                    BG_Color_U = {1,1,1,1}
				end
				break
			end
		end
		
		if learn_tooltip ~= nil then
			local function learn_button_tooltip_Enter(self, motion)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(learn_tooltip)
				GameTooltip:Show()
			end
			all_learn_talent_buttons[indexAt]:SetScript("OnEnter", learn_button_tooltip_Enter)
		end

		all_attached_talent[indexAt] = attached_talent
		
		
		all_learn_talent_buttons[indexAt]:SetText(text_changed)
			
		all_talent_FrameNumber[indexAt]:SetText(FN)

        all_talent_slots[indexAt]:SetBackdrop({
                        bgFile = BG_File,
                         insets = {
                        left = -11,
                        right = -11,
                        top = -11,
                        bottom = -11}
                        })
        all_talent_slot_buttons[indexAt]:SetBackdropColor(unpack(BG_Color_U))
		
		--all_learn_talent_buttons_t[indexAt]:SetTexture(texture_changed[1], texture_changed[2], texture_changed[3], 1)
		
	end
	--begin of the client talent unlearn part--
    function unlearn_talent(self)
        PlaySound("igMainMenuOptionCheckBoxOn")
    local talent_attached = false
    local indexAt
  
    for i,v in ipairs(all_talent_slot_buttons) do
      if v == self then
       spellName, spellRank, spellID = GameTooltip:GetSpell()
        talent_attached = spellID
        indexAt = i
        break
      end
    end
    
    if talent_attached ~= false then
      AIO.Handle("sideBar","UnLearnThisTalent",talent_attached,indexAt,sideBar.CurrentTalentSpec)
    end
  
  end

    function MyHandlers.UnLearnTalent(player, attached_talent, indexAt)
        
        local AE_cost = attached_talent[2]
        local TE_cost = attached_talent[3]
        local all_spellIds = attached_talent[4]
        local spellId = attached_talent[1]
        
        local texture_changed = {0, .5, 0}
        local text_changed = "|cffFFFFFFLearn|r"
        local learn_tooltip = nil
        local BG_File = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg"
        local FN = 0
        local BG_Color_U = {0.46,0.36,0.34,1}

        all_talent_slot_buttons[indexAt].HyperLink = "|cffFFFFFF|Hspell:"..all_spellIds[1].."|h[Talent]|h|r"
        
        if learn_tooltip ~= nil then
            local function learn_button_tooltip_Enter(self, motion)
                GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
                GameTooltip:SetText(learn_tooltip)
                GameTooltip:Show()
            end
            all_learn_talent_buttons[indexAt]:SetScript("OnEnter", learn_button_tooltip_Enter)
        end

        all_attached_talent[indexAt] = attached_talent
        
        
        all_learn_talent_buttons[indexAt]:SetText(text_changed)
            
        all_talent_FrameNumber[indexAt]:SetText(FN)

        all_talent_slots[indexAt]:SetBackdrop({
                        bgFile = BG_File,
                         insets = {
                        left = -11,
                        right = -11,
                        top = -11,
                        bottom = -11}
                        })
        all_talent_slot_buttons[indexAt]:SetBackdropColor(unpack(BG_Color_U))
        
        --all_learn_talent_buttons_t[indexAt]:SetTexture(texture_changed[1], texture_changed[2], texture_changed[3], 1)
        
    end
    -- end of the client talent unlearn part--
	function MyHandlers.GetSpellCount(player, spellCount, spellList)
	
		local start_ticker = 1
		
		repeat
			local spellId = spellList[start_ticker][1]
			local spellCostAE = spellList[start_ticker][2]
			local spellCostTE = spellList[start_ticker][3]
			local RequiredLevel = spellList[start_ticker][4]
			local name, rank, icon, _,_,_,_ = GetSpellInfo(spellId)
			local player_knows = IsSpellLearned(spellId)
			local learn_tooltip = "Cost: "..spellCostAE.." AE "..spellCostTE.." TE"
			local learn_texture = {.9, .2, .1}
            local learn_text = "Learn" -- used for spell texts
			local attach_it = {spellId, spellCostAE, spellCostTE}
			if player_knows == true then
				learn_tooltip = "Already Known"
                learn_text = "|cff6b625bLearn|r"
				learn_texture = {.3, .3, .3}
				attach_it = nil
			elseif RequiredLevel > UnitLevel("player") then
				learn_tooltip = "Requires: Level "..RequiredLevel
                learn_text = "|cff6b625bLearn|r"
				learn_texture = {.3, .3, .3}
				attach_it = nil
			end
			
			 -- spell_desc = GetSpellDescription(spellId) -- Doesn't work? Added in cata... lame
		
			all_spell_slot_buttons[start_ticker]:SetBackdrop({
				bgFile = icon
			})
			local get_spell_link = GetSpellLink(spellId)
			local function spell_icon_tooltip_Enter(self, motion)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetHyperlink(get_spell_link)
				GameTooltip:Show()
                --for unlearn spell
                if (CanBeUnlearned()) then
                GameTooltip:AppendText("\n|cffFF0000Click on the icon to use |cff00FF00[Scroll of unlearning]|r")
                BaseFrameFadeIn(_G[self:GetName().."_UnlearnTex"])
                all_spell_slot_buttons_UnLearnEffect:SetPoint("CENTER",self,"CENTER",0,0)
                BaseFrameFadeIn(all_spell_slot_buttons_UnLearnEffect)
                end
			end
			all_spell_slot_buttons[start_ticker]:SetScript("OnEnter", spell_icon_tooltip_Enter)
			local function spell_icon_tooltip_OnLeave(self)
				GameTooltip:Hide()
                -- for unlearn spell
                if (_G[self:GetName().."_UnlearnTex"]:IsVisible()) then
                BaseFrameFadeOut(_G[self:GetName().."_UnlearnTex"])
                BaseFrameFadeOut(all_spell_slot_buttons_UnLearnEffect)
                end
			end
			all_spell_slot_buttons[start_ticker]:SetScript("OnLeave", spell_icon_tooltip_OnLeave)
			
			--all_learn_spell_buttons_t[start_ticker]:SetTexture(learn_texture[1], learn_texture[2], learn_texture[3], 1)
			
			local function learn_button_tooltip_Enter(self, motion)
				GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
				GameTooltip:SetText(learn_tooltip)
				GameTooltip:Show()
			end
			all_learn_spell_buttons[start_ticker]:SetScript("OnEnter", learn_button_tooltip_Enter)
			local function learn_button_tooltip_Leave(self, motion)
				GameTooltip:Hide()
			end
			all_learn_spell_buttons[start_ticker]:SetScript("OnLeave", learn_button_tooltip_Leave)
			
			all_attached_spells[start_ticker] = attach_it
			
			all_learn_spell_buttons[start_ticker]:SetText(learn_text)

			start_ticker = start_ticker + 1
		
		until start_ticker == spellCount + 1
		
		repeat
			all_spell_slot_buttons[start_ticker]:SetBackdrop({
				bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackgroundold"
			})
			
			
			all_spell_slot_buttons[start_ticker]:SetScript("OnEnter", nil)
			
			
			all_spell_slot_buttons[start_ticker]:SetScript("OnLeave", nil)
			
			all_learn_spell_buttons[start_ticker]:SetScript("OnEnter", nil)
			
			all_learn_spell_buttons[start_ticker]:SetScript("OnLeave", nil)
		
			--all_learn_spell_buttons_t[start_ticker]:SetTexture(.3, .3, .3, 1)
			all_learn_spell_buttons[start_ticker]:SetText("|cff6b625bEmpty|r")
			all_attached_spells[start_ticker] = nil
			start_ticker = start_ticker + 1
		until start_ticker == 36 + 1
	
	end
	
	function learn_spell(self)
	   PlaySound("igMainMenuOptionCheckBoxOn")
       local got_spell = nil
       local got_index
       --check for preventing hacks
       local class, spec = unpack(sideBar.CurrentSpellSpec)

		for i,v in ipairs(all_learn_spell_buttons) do
			if self == v then
				got_spell = all_attached_spells[i]
				all_attached_spells[i] = nil
                got_index = i
			end
		end
	
      if got_spell ~= nil then
       AIO.Handle("sideBar", "LearnThisSpell", got_spell, got_index, class,spec)
       end
	end
	
	function MyHandlers.ChangeLearnButton(player, i)
	
		local function learn_button_tooltip_Enter(self, motion)
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:SetText("Already Known")
			GameTooltip:Show()
		end
        all_learn_spell_buttons[i]:SetText("|cff6b625bLearn|r")
		all_learn_spell_buttons[i]:SetScript("OnEnter", learn_button_tooltip_Enter)

		--all_learn_spell_buttons_t[i]:SetTexture(.3, .3, .3, 1)
		all_attached_spells[i] = nil
	end

    --unlearn spell part--
        function unlearn_spell(self)
             if (CanBeUnlearned()) then
       PlaySound("igMainMenuOptionCheckBoxOn")
       local got_spell = nil
       local got_index
       --check for preventing hacks
       local class, spec = unpack(sideBar.CurrentSpellSpec)

        for i,v in ipairs(all_spell_slot_buttons) do
            if self == v then
                spellName, spellRank, spellID = GameTooltip:GetSpell()
                got_spell = spellID
                got_index = i
            end
        end
    
      if got_spell ~= nil then
       AIO.Handle("sideBar", "UnLearnThisSpell", got_spell, got_index, class,spec)
       end
   end
    end

    function MyHandlers.ChangeLearnButtonBack(player, i, spellid,cost_one,cost_two)
        local AE_cost = cost_one
        local TE_cost = cost_two
        local spell = spellid
        local function learn_button_tooltip_Enter(self, motion)
            GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
            GameTooltip:SetText("Cost: "..AE_cost.." AE "..TE_cost.." TE")
            GameTooltip:Show()
        end
        BaseFrameFadeOut(_G[all_spell_slot_buttons[i]:GetName().."_UnlearnTex"])
        BaseFrameFadeOut(all_spell_slot_buttons_UnLearnEffect)
        all_learn_spell_buttons[i]:SetText("|cffFFFFFFLearn|r")
        all_learn_spell_buttons[i]:SetScript("OnEnter", learn_button_tooltip_Enter)
        all_attached_spells[i] = {spell, cost_one, cost_two}
    end
    --end of unlearn spell part--
	
	-- ####################################### Basic Frame ##############################	
	 local ProgressionPurpleCovertexture = TrainingFrame:CreateTexture() 
    ProgressionPurpleCovertexture:SetAllPoints() 
    ProgressionPurpleCovertexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_cover_purple") 
    ProgressionPurpleCovertexture:SetSize(TrainingFrame:GetSize())
    ProgressionPurpleCovertexture:Hide()

    local ProgressionBlueCovertexture = TrainingFrame:CreateTexture() 
    ProgressionBlueCovertexture:SetAllPoints() 
    ProgressionBlueCovertexture:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_cover_Blue") 
    ProgressionBlueCovertexture:SetSize(TrainingFrame:GetSize())
    ProgressionBlueCovertexture:Hide()

    CreateFrame("Frame", "TrainingFrameBorder", TrainingFrame, nil)
    --TrainingFrameBorder:SetFrameStrata("DIALOG")
    --TrainingFrameBorder:SetBackdrop({
            --bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_frame",})
    TrainingFrameBorder:SetSize(TrainingFrame:GetSize())
    TrainingFrameBorder:SetPoint("CENTER",0,0)
    TrainingFrameBorder:SetFrameStrata("FULLSCREEN") -- a bit tricky, but I lost huge part of my work in photoshop so I had to do that ._.

        TrainingFrame.Text_Ability = TrainingFrameBorder:CreateFontString()
TrainingFrame.Text_Ability:SetFontObject(GameFontNormal)
TrainingFrame.Text_Ability:SetPoint("BOTTOM", TrainingFrame,  75, 67);
TrainingFrame.Text_Ability:SetFont("Fonts\\FRIZQT__.TTF", 12)
local itemCount = GetItemCount(383080) or 0
local itemCount2 = GetItemCount(383080) or 0
TrainingFrame.Text_Ability:SetText("|cffE1AB18AE: |cffFFFFFF"..itemCount.." |cffE1AB18TE: |cffFFFFFF"..itemCount2)
TrainingFrame.Text_Ability:Hide()


    local ProgressionBlueBookBorder = TrainingFrameBorder:CreateTexture("ProgressionBlueBookBorder", "BACKGROUND") 
    ProgressionBlueBookBorder:SetAllPoints() 
    ProgressionBlueBookBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_add_blue") 
    ProgressionBlueBookBorder:SetSize(TrainingFrame:GetSize())
    ProgressionBlueBookBorder:SetVertexColor(1,1, 1, .7)
    ProgressionBlueBookBorder:Hide()

        local ProgressionPurpleBookBorder = TrainingFrameBorder:CreateTexture("ProgressionPurpleBookBorder", "BACKGROUND") 
    ProgressionPurpleBookBorder:SetAllPoints() 
    ProgressionPurpleBookBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_add_Purple") 
    ProgressionPurpleBookBorder:SetSize(TrainingFrame:GetSize())
    ProgressionPurpleBookBorder:SetVertexColor(1,1, 1, 1)
    ProgressionPurpleBookBorder:Hide()

    local ProgressionAdditionalBorder = TrainingFrameBorder:CreateTexture("ProgressionAdditionalBorder", "DIALOG") 
    ProgressionAdditionalBorder:SetAllPoints() 
    ProgressionAdditionalBorder:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\progress_frame") 
    ProgressionAdditionalBorder:SetSize(TrainingFrame:GetSize())
    ProgressionAdditionalBorder:SetVertexColor(1,1, 1, 1)

    --ProgressionFrametexture:ClearAllPoints()
    
    DisplaySpellsButton = CreateFrame("Button", "TrainingFrame_DisplaySpellsButton", TrainingFrame, nil)
        DisplaySpellsButton:SetSize(200, 250)
        DisplaySpellsButton:SetPoint("CENTER", -250, -20)
        DisplaySpellsButton:EnableMouse(true)
        texture_DisplaySpellsButton = DisplaySpellsButton:CreateTexture("DisplaySpellsButton")
        texture_DisplaySpellsButton:SetAllPoints(DisplaySpellsButton)
        texture_DisplaySpellsButton:SetTexture(.9, .2, .2, 0)
        texture_DisplaySpellsButton_p = DisplaySpellsButton:CreateTexture("DisplaySpellsButton_p")
        texture_DisplaySpellsButton_p:SetAllPoints(DisplaySpellsButton)
        texture_DisplaySpellsButton_p:SetTexture(.9, .2, .2, 0)
        DisplaySpellsButton:SetNormalTexture(texture_DisplaySpellsButton)
        DisplaySpellsButton:SetPushedTexture(texture_DisplaySpellsButton_p)
        font_DisplaySpellsButton = DisplaySpellsButton:CreateFontString("DisplaySpellsButton_Font")
        font_DisplaySpellsButton:SetFont("Fonts\\MORPHEUS.TTF", 30, "OUTLINE")
        font_DisplaySpellsButton:SetShadowOffset(1, -1)
        DisplaySpellsButton:SetFontString(font_DisplaySpellsButton)
        --DisplaySpellsButton:SetText("Show|nSpells")
        DisplaySpellsButton:SetScript("OnMouseUp",  display_next_frame_CA)
        DisplaySpellsButton:SetScript("OnEnter", function(self)
           BaseFrameFadeIn(ProgressionBlueCovertexture)
            BaseFrameFadeIn(TrainingFrame_model2)
             BaseFrameFadeOut(TrainingFrame_SelectedTitle_Stars1)
            TrainingFrame_SelectedTitle_Stars1_glow:Hide()
            BaseFrameFadeOut(TrainingFrame_SelectedTitle_Stars2)
            TrainingFrame_SelectedTitle_Stars2_glow:Hide()
            BaseFrameFadeOut(TrainingFrame_SelectedTitle_Glow)
            BaseFrameFadeIn(font_TrainingFrame_SelectedTitle_Spells)
            --BaseFrameFadeIn(TrainingFrame_SelectedTitle_Spells)
            end)
        DisplaySpellsButton:SetScript("OnLeave", function()
           BaseFrameFadeOut(ProgressionBlueCovertexture)
          BaseFrameFadeOut(TrainingFrame_model2)
            BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars1)
            TrainingFrame_SelectedTitle_Stars1_glow:Show()
            BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars2)
            TrainingFrame_SelectedTitle_Stars2_glow:Show()
            BaseFrameFadeIn(TrainingFrame_SelectedTitle_Glow)
            BaseFrameFadeOut(font_TrainingFrame_SelectedTitle_Spells)
            --BaseFrameFadeOut(TrainingFrame_SelectedTitle_Spells)
            end)
        
        
    DisplayTalentsButton = CreateFrame("Button", "TrainingFrame_DisplayTalentsButton", TrainingFrame, nil)
        DisplayTalentsButton:SetSize(200, 250)
        DisplayTalentsButton:SetPoint("CENTER", 22, -20)
        DisplayTalentsButton:EnableMouse(true)
        texture_DisplayTalentsButton = DisplayTalentsButton:CreateTexture("DisplayTalentsButton")
        texture_DisplayTalentsButton:SetAllPoints(DisplayTalentsButton)
        texture_DisplayTalentsButton:SetTexture(.9, .2, .2, 0)
        texture_DisplayTalentsButton_p = DisplayTalentsButton:CreateTexture("DisplayTalentsButton_p")
        texture_DisplayTalentsButton_p:SetAllPoints(DisplayTalentsButton)
        texture_DisplayTalentsButton_p:SetTexture(.9, .2, .2, 0)
        DisplayTalentsButton:SetNormalTexture(texture_DisplayTalentsButton)
        DisplayTalentsButton:SetPushedTexture(texture_DisplayTalentsButton_p)
        font_DisplayTalentsButton = DisplayTalentsButton:CreateFontString("DisplayTalentsButton_Font")
        font_DisplayTalentsButton:SetFont("Fonts\\MORPHEUS.TTF", 30, "OUTLINE")
        font_DisplayTalentsButton:SetShadowOffset(1, -1)
        DisplayTalentsButton:SetFontString(font_DisplayTalentsButton)
        --DisplayTalentsButton:SetText("Show\nTalents")
        DisplayTalentsButton:SetScript("OnMouseUp",  display_talents)
        DisplayTalentsButton:SetScript("OnEnter", function(self)
           BaseFrameFadeIn(ProgressionPurpleCovertexture)
           BaseFrameFadeIn(TrainingFrame_model)
           BaseFrameFadeOut(TrainingFrame_SelectedTitle_Stars1)
            TrainingFrame_SelectedTitle_Stars1_glow:Hide()
            BaseFrameFadeOut(TrainingFrame_SelectedTitle_Stars2)
            TrainingFrame_SelectedTitle_Stars2_glow:Hide()
            BaseFrameFadeOut(TrainingFrame_SelectedTitle_Glow)
            BaseFrameFadeIn(font_TrainingFrame_SelectedTitle_Talents)
            --BaseFrameFadeIn(TrainingFrame_SelectedTitle_Talents)
            end)
        DisplayTalentsButton:SetScript("OnLeave", function()
           BaseFrameFadeOut(ProgressionPurpleCovertexture)
           BaseFrameFadeOut(TrainingFrame_model)
                      BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars1)
            TrainingFrame_SelectedTitle_Stars1_glow:Show()
            BaseFrameFadeIn(TrainingFrame_SelectedTitle_Stars2)
            TrainingFrame_SelectedTitle_Stars2_glow:Show()
            BaseFrameFadeIn(TrainingFrame_SelectedTitle_Glow)
            BaseFrameFadeOut(font_TrainingFrame_SelectedTitle_Talents)
            --BaseFrameFadeOut(TrainingFrame_SelectedTitle_Talents)
            end)
        DisplaySpellsButton:Disable()
DisplayTalentsButton:Disable()

TrainingFrame:SetScript("OnUpdate" , function() 
                    local itemCount_t = GetItemCount(383080) or 0
    local itemCount2_t = GetItemCount(383081) or 0
    TrainingFrame.Text_Ability:SetText("|cffFFFFFF"..itemCount_t.." |cffE1AB18|TInterface\\Icons\\inv_custom_abilityessence.blp:15:15:0:0|t|r    |cffFFFFFF"..itemCount2_t.." |cffE1AB18|TInterface\\Icons\\inv_custom_talentessence.blp:15:15:0:0|t |cffFFFFFF")

                if not(DisplaySpellsButton:IsVisible()) then
            TrainingFrame_SelectedTitle_Stars1:Hide()
            TrainingFrame_SelectedTitle_Stars1_glow:Hide()
            TrainingFrame_SelectedTitle_Stars2:Hide()
            TrainingFrame_SelectedTitle_Stars2_glow:Hide()
            TrainingFrame_SelectedTitle_Glow:Hide()
        end
            end)

TrainingFrame:SetScript("OnHide" , function()
    display_stuff(GeneralStuff)
    end)
        
		
		
	-- ####################################### Spells Frame ##############################	
	
	Spell_slot1 = CreateFrame("Frame", "TrainingFrame_Spell_slot1", TrainingFrame, nil)
	Spell_slot1Button = CreateFrame("Button", "TrainingFrame_Spell_slot1Button", Spell_slot1, nil)
	Spell_slot1ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot1ButtonL", Spell_slot1, nil)
	Spell_slot1ButtonLT = Spell_slot1ButtonL:CreateTexture("Spell_slot1ButtonLT")
	Spell_slot1ButtonF = Spell_slot1ButtonL:CreateFontString("Spell_slot1ButtonF")
	Spell_slot1_AttachedSpell = nil
	
	Spell_slot2 = CreateFrame("Frame", "TrainingFrame_Spell_slot2", TrainingFrame, nil)
	Spell_slot2Button = CreateFrame("Button", "TrainingFrame_Spell_slot2Button", Spell_slot2, nil)
	Spell_slot2ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot2ButtonL", Spell_slot2, nil)
	Spell_slot2ButtonLT = Spell_slot2ButtonL:CreateTexture("Spell_slot2ButtonLT")
	Spell_slot2ButtonF = Spell_slot2ButtonL:CreateFontString("Spell_slot2ButtonF")
	Spell_slot2_AttachedSpell = nil
	
	Spell_slot3 = CreateFrame("Frame", "TrainingFrame_Spell_slot3", TrainingFrame, nil)
	Spell_slot3Button = CreateFrame("Button", "TrainingFrame_Spell_slot3Button", Spell_slot3, nil)
	Spell_slot3ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot3ButtonL", Spell_slot3, nil)
	Spell_slot3ButtonLT = Spell_slot3ButtonL:CreateTexture("Spell_slot3ButtonLT")
	Spell_slot3ButtonF = Spell_slot3ButtonL:CreateFontString("Spell_slot3ButtonF")
	Spell_slot3_AttachedSpell = nil
	
	Spell_slot4 = CreateFrame("Frame", "TrainingFrame_Spell_slot4", TrainingFrame, nil)
	Spell_slot4Button = CreateFrame("Button", "TrainingFrame_Spell_slot4Button", Spell_slot4, nil)
	Spell_slot4ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot4ButtonL", Spell_slot4, nil)
	Spell_slot4ButtonLT = Spell_slot4ButtonL:CreateTexture("Spell_slot4ButtonLT")
	Spell_slot4ButtonF = Spell_slot1ButtonL:CreateFontString("Spell_slot4ButtonF")
	Spell_slot4_AttachedSpell = nil
	
	Spell_slot5 = CreateFrame("Frame", "TrainingFrame_Spell_slot5", TrainingFrame, nil)
	Spell_slot5Button = CreateFrame("Button", "TrainingFrame_Spell_slot5Button", Spell_slot5, nil)
	Spell_slot5ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot5ButtonL", Spell_slot5, nil)
	Spell_slot5ButtonLT = Spell_slot5ButtonL:CreateTexture("Spell_slot5ButtonLT")
	Spell_slot5ButtonF = Spell_slot5ButtonL:CreateFontString("Spell_slot5ButtonF")
	Spell_slot5_AttachedSpell = nil
	
	Spell_slot6 = CreateFrame("Frame", "TrainingFrame_Spell_slot6", TrainingFrame, nil)
	Spell_slot6Button = CreateFrame("Button", "TrainingFrame_Spell_slot6Button", Spell_slot6, nil)
	Spell_slot6ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot6ButtonL", Spell_slot6, nil)
	Spell_slot6ButtonLT = Spell_slot6ButtonL:CreateTexture("Spell_slot6ButtonLT")
	Spell_slot6ButtonF = Spell_slot6ButtonL:CreateFontString("Spell_slot6ButtonF")
	Spell_slot6_AttachedSpell = nil
	
	Spell_slot7 = CreateFrame("Frame", "TrainingFrame_Spell_slot7", TrainingFrame, nil)
	Spell_slot7Button = CreateFrame("Button", "TrainingFrame_Spell_slot7Button", Spell_slot7, nil)
	Spell_slot7ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot7ButtonL", Spell_slot7, nil)
	Spell_slot7ButtonLT = Spell_slot7ButtonL:CreateTexture("Spell_slot7ButtonLT")
	Spell_slot7ButtonF = Spell_slot7ButtonL:CreateFontString("Spell_slot7ButtonF")
	Spell_slot7_AttachedSpell = nil
	
	Spell_slot8 = CreateFrame("Frame", "TrainingFrame_Spell_slot8", TrainingFrame, nil)
	Spell_slot8Button = CreateFrame("Button", "TrainingFrame_Spell_slot8Button", Spell_slot8, nil)
	Spell_slot8ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot8ButtonL", Spell_slot8, nil)
	Spell_slot8ButtonLT = Spell_slot8ButtonL:CreateTexture("Spell_slot8ButtonLT")
	Spell_slot8ButtonF = Spell_slot8ButtonL:CreateFontString("Spell_slot8ButtonF")
	Spell_slot8_AttachedSpell = nil
	
	Spell_slot9 = CreateFrame("Frame", "TrainingFrame_Spell_slot9", TrainingFrame, nil)
	Spell_slot9Button = CreateFrame("Button", "TrainingFrame_Spell_slot9Button", Spell_slot9, nil)
	Spell_slot9ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot9ButtonL", Spell_slot9, nil)
	Spell_slot9ButtonLT = Spell_slot9ButtonL:CreateTexture("Spell_slot9ButtonLT")
	Spell_slot9ButtonF = Spell_slot9ButtonL:CreateFontString("Spell_slot9ButtonF")
	Spell_slot9_AttachedSpell = nil
	
	Spell_slot10 = CreateFrame("Frame", "TrainingFrame_Spell_slot10", TrainingFrame, nil)
	Spell_slot10Button = CreateFrame("Button", "TrainingFrame_Spell_slot10Button", Spell_slot10, nil)
	Spell_slot10ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot10ButtonL", Spell_slot10, nil)
	Spell_slot10ButtonLT = Spell_slot10ButtonL:CreateTexture("Spell_slot10ButtonLT")
	Spell_slot10ButtonF = Spell_slot10ButtonL:CreateFontString("Spell_slot10ButtonF")
	Spell_slot10_AttachedSpell = nil
	
	Spell_slot11 = CreateFrame("Frame", "TrainingFrame_Spell_slot11", TrainingFrame, nil)
	Spell_slot11Button = CreateFrame("Button", "TrainingFrame_Spell_slot11Button", Spell_slot11, nil)
	Spell_slot11ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot11ButtonL", Spell_slot11, nil)
	Spell_slot11ButtonLT = Spell_slot11ButtonL:CreateTexture("Spell_slot11ButtonLT")
	Spell_slot11ButtonF = Spell_slot11ButtonL:CreateFontString("Spell_slot11ButtonF")
	Spell_slot11_AttachedSpell = nil
	
	Spell_slot12 = CreateFrame("Frame", "TrainingFrame_Spell_slot12", TrainingFrame, nil)
	Spell_slot12Button = CreateFrame("Button", "TrainingFrame_Spell_slot12Button", Spell_slot12, nil)
	Spell_slot12ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot12ButtonL", Spell_slot12, nil)
	Spell_slot12ButtonLT = Spell_slot12ButtonL:CreateTexture("Spell_slot12ButtonLT")
	Spell_slot12ButtonF = Spell_slot12ButtonL:CreateFontString("Spell_slot12ButtonF")
	Spell_slot12_AttachedSpell = nil
	
	Spell_slot13 = CreateFrame("Frame", "TrainingFrame_Spell_slot13", TrainingFrame, nil)
	Spell_slot13Button = CreateFrame("Button", "TrainingFrame_Spell_slot13Button", Spell_slot13, nil)
	Spell_slot13ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot13ButtonL", Spell_slot13, nil)
	Spell_slot13ButtonLT = Spell_slot13ButtonL:CreateTexture("Spell_slot13ButtonLT")
	Spell_slot13ButtonF = Spell_slot13ButtonL:CreateFontString("Spell_slot13ButtonF")
	Spell_slot13_AttachedSpell = nil
	
	Spell_slot14 = CreateFrame("Frame", "TrainingFrame_Spell_slot14", TrainingFrame, nil)
	Spell_slot14Button = CreateFrame("Button", "TrainingFrame_Spell_slot14Button", Spell_slot14, nil)
	Spell_slot14ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot14ButtonL", Spell_slot14, nil)
	Spell_slot14ButtonLT = Spell_slot14ButtonL:CreateTexture("Spell_slot14ButtonLT")
	Spell_slot14ButtonF = Spell_slot14ButtonL:CreateFontString("Spell_slot14ButtonF")
	Spell_slot14_AttachedSpell = nil
	
	Spell_slot15 = CreateFrame("Frame", "TrainingFrame_Spell_slot15", TrainingFrame, nil)
	Spell_slot15Button = CreateFrame("Button", "TrainingFrame_Spell_slot15Button", Spell_slot15, nil)
	Spell_slot15ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot15ButtonL", Spell_slot15, nil)
	Spell_slot15ButtonLT = Spell_slot15ButtonL:CreateTexture("Spell_slot15ButtonLT")
	Spell_slot15ButtonF = Spell_slot15ButtonL:CreateFontString("Spell_slot15ButtonF")
	Spell_slot15_AttachedSpell = nil
	
	Spell_slot16 = CreateFrame("Frame", "TrainingFrame_Spell_slot16", TrainingFrame, nil)
	Spell_slot16Button = CreateFrame("Button", "TrainingFrame_Spell_slot16Button", Spell_slot16, nil)
	Spell_slot16ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot16ButtonL", Spell_slot16, nil)
	Spell_slot16ButtonLT = Spell_slot16ButtonL:CreateTexture("Spell_slot16ButtonLT")
	Spell_slot16ButtonF = Spell_slot16ButtonL:CreateFontString("Spell_slot16ButtonF")
	Spell_slot16_AttachedSpell = nil
	
	Spell_slot17 = CreateFrame("Frame", "TrainingFrame_Spell_slot17", TrainingFrame, nil)
	Spell_slot17Button = CreateFrame("Button", "TrainingFrame_Spell_slot17Button", Spell_slot17, nil)
	Spell_slot17ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot17ButtonL", Spell_slot17, nil)
	Spell_slot17ButtonLT = Spell_slot17ButtonL:CreateTexture("Spell_slot17ButtonLT")
	Spell_slot17ButtonF = Spell_slot17ButtonL:CreateFontString("Spell_slot17ButtonF")
	Spell_slot17_AttachedSpell = nil
	
	Spell_slot18 = CreateFrame("Frame", "TrainingFrame_Spell_slot18", TrainingFrame, nil)
	Spell_slot18Button = CreateFrame("Button", "TrainingFrame_Spell_slot18Button", Spell_slot18, nil)
	Spell_slot18ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot18ButtonL", Spell_slot18, nil)
	Spell_slot18ButtonLT = Spell_slot18ButtonL:CreateTexture("Spell_slot18ButtonLT")
	Spell_slot18ButtonF = Spell_slot18ButtonL:CreateFontString("Spell_slot18ButtonF")
	Spell_slot18_AttachedSpell = nil
	
	Spell_slot19 = CreateFrame("Frame", "TrainingFrame_Spell_slot19", TrainingFrame, nil)
	Spell_slot19Button = CreateFrame("Button", "TrainingFrame_Spell_slot19Button", Spell_slot19, nil)
	Spell_slot19ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot19ButtonL", Spell_slot19, nil)
	Spell_slot19ButtonLT = Spell_slot19ButtonL:CreateTexture("Spell_slot19ButtonLT")
	Spell_slot19ButtonF = Spell_slot19ButtonL:CreateFontString("Spell_slot19ButtonF")
	Spell_slot19_AttachedSpell = nil
	
	Spell_slot20 = CreateFrame("Frame", "TrainingFrame_Spell_slot20", TrainingFrame, nil)
	Spell_slot20Button = CreateFrame("Button", "TrainingFrame_Spell_slot20Button", Spell_slot20, nil)
	Spell_slot20ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot20ButtonL", Spell_slot20, nil)
	Spell_slot20ButtonLT = Spell_slot20ButtonL:CreateTexture("Spell_slot20ButtonLT")
	Spell_slot20ButtonF = Spell_slot20ButtonL:CreateFontString("Spell_slot20ButtonF")
	Spell_slot20_AttachedSpell = nil
	
	Spell_slot21 = CreateFrame("Frame", "TrainingFrame_Spell_slot21", TrainingFrame, nil)
	Spell_slot21Button = CreateFrame("Button", "TrainingFrame_Spell_slot21Button", Spell_slot21, nil)
	Spell_slot21ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot21ButtonL", Spell_slot21, nil)
	Spell_slot21ButtonLT = Spell_slot21ButtonL:CreateTexture("Spell_slot21ButtonLT")
	Spell_slot21ButtonF = Spell_slot21ButtonL:CreateFontString("Spell_slot21ButtonF")
	Spell_slot21_AttachedSpell = nil
	
	Spell_slot22 = CreateFrame("Frame", "TrainingFrame_Spell_slot22", TrainingFrame, nil)
	Spell_slot22Button = CreateFrame("Button", "TrainingFrame_Spell_slot22Button", Spell_slot22, nil)
	Spell_slot22ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot22ButtonL", Spell_slot22, nil)
	Spell_slot22ButtonLT = Spell_slot22ButtonL:CreateTexture("Spell_slot22ButtonLT")
	Spell_slot22ButtonF = Spell_slot22ButtonL:CreateFontString("Spell_slot22ButtonF")
	Spell_slot22_AttachedSpell = nil
	
	Spell_slot23 = CreateFrame("Frame", "TrainingFrame_Spell_slot23", TrainingFrame, nil)
	Spell_slot23Button = CreateFrame("Button", "TrainingFrame_Spell_slot23Button", Spell_slot23, nil)
	Spell_slot23ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot23ButtonL", Spell_slot23, nil)
	Spell_slot23ButtonLT = Spell_slot23ButtonL:CreateTexture("Spell_slot23ButtonLT")
	Spell_slot23ButtonF = Spell_slot23ButtonL:CreateFontString("Spell_slot23ButtonF")
	Spell_slot23_AttachedSpell = nil
	
	Spell_slot24 = CreateFrame("Frame", "TrainingFrame_Spell_slot24", TrainingFrame, nil)
	Spell_slot24Button = CreateFrame("Button", "TrainingFrame_Spell_slot24Button", Spell_slot24, nil)
	Spell_slot24ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot24ButtonL", Spell_slot24, nil)
	Spell_slot24ButtonLT = Spell_slot24ButtonL:CreateTexture("Spell_slot24ButtonLT")
	Spell_slot24ButtonF = Spell_slot24ButtonL:CreateFontString("Spell_slot24ButtonF")
	Spell_slot24_AttachedSpell = nil
	
	Spell_slot25 = CreateFrame("Frame", "TrainingFrame_Spell_slot25", TrainingFrame, nil)
	Spell_slot25Button = CreateFrame("Button", "TrainingFrame_Spell_slot25Button", Spell_slot25, nil)
	Spell_slot25ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot25ButtonL", Spell_slot25, nil)
	Spell_slot25ButtonLT = Spell_slot25ButtonL:CreateTexture("Spell_slot25ButtonLT")
	Spell_slot25ButtonF = Spell_slot25ButtonL:CreateFontString("Spell_slot25ButtonF")
	Spell_slot25_AttachedSpell = nil
	
	Spell_slot26 = CreateFrame("Frame", "TrainingFrame_Spell_slot26", TrainingFrame, nil)
	Spell_slot26Button = CreateFrame("Button", "TrainingFrame_Spell_slot26Button", Spell_slot26, nil)
	Spell_slot26ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot26ButtonL", Spell_slot26, nil)
	Spell_slot26ButtonLT = Spell_slot26ButtonL:CreateTexture("Spell_slot26ButtonLT")
	Spell_slot26ButtonF = Spell_slot26ButtonL:CreateFontString("Spell_slot26ButtonF")
	Spell_slot26_AttachedSpell = nil
	
	Spell_slot27 = CreateFrame("Frame", "TrainingFrame_Spell_slot27", TrainingFrame, nil)
	Spell_slot27Button = CreateFrame("Button", "TrainingFrame_Spell_slot27Button", Spell_slot27, nil)
	Spell_slot27ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot27ButtonL", Spell_slot27, nil)
	Spell_slot27ButtonLT = Spell_slot27ButtonL:CreateTexture("Spell_slot27ButtonLT")
	Spell_slot27ButtonF = Spell_slot27ButtonL:CreateFontString("Spell_slot27ButtonF")
	Spell_slot27_AttachedSpell = nil
	
	Spell_slot28 = CreateFrame("Frame", "TrainingFrame_Spell_slot28", TrainingFrame, nil)
	Spell_slot28Button = CreateFrame("Button", "TrainingFrame_Spell_slot28Button", Spell_slot28, nil)
	Spell_slot28ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot28ButtonL", Spell_slot28, nil)
	Spell_slot28ButtonLT = Spell_slot28ButtonL:CreateTexture("Spell_slot28ButtonLT")
	Spell_slot28ButtonF = Spell_slot28ButtonL:CreateFontString("Spell_slot28ButtonF")
	Spell_slot28_AttachedSpell = nil
	
	Spell_slot29 = CreateFrame("Frame", "TrainingFrame_Spell_slot29", TrainingFrame, nil)
	Spell_slot29Button = CreateFrame("Button", "TrainingFrame_Spell_slot29Button", Spell_slot29, nil)
	Spell_slot29ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot29ButtonL", Spell_slot29, nil)
	Spell_slot29ButtonLT = Spell_slot29ButtonL:CreateTexture("Spell_slot29ButtonLT")
	Spell_slot29ButtonF = Spell_slot29ButtonL:CreateFontString("Spell_slot29ButtonF")
	Spell_slot29_AttachedSpell = nil
	
	Spell_slot30 = CreateFrame("Frame", "TrainingFrame_Spell_slot30", TrainingFrame, nil)
	Spell_slot30Button = CreateFrame("Button", "TrainingFrame_Spell_slot30Button", Spell_slot30, nil)
	Spell_slot30ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot30ButtonL", Spell_slot30, nil)
	Spell_slot30ButtonLT = Spell_slot30ButtonL:CreateTexture("Spell_slot30ButtonLT")
	Spell_slot30ButtonF = Spell_slot30ButtonL:CreateFontString("Spell_slot30ButtonF")
	Spell_slot30_AttachedSpell = nil
	
	Spell_slot31 = CreateFrame("Frame", "TrainingFrame_Spell_slot31", TrainingFrame, nil)
	Spell_slot31Button = CreateFrame("Button", "TrainingFrame_Spell_slot31Button", Spell_slot31, nil)
	Spell_slot31ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot31ButtonL", Spell_slot31, nil)
	Spell_slot31ButtonLT = Spell_slot31ButtonL:CreateTexture("Spell_slot31ButtonLT")
	Spell_slot31ButtonF = Spell_slot31ButtonL:CreateFontString("Spell_slot31ButtonF")
	Spell_slot31_AttachedSpell = nil
	
	Spell_slot32 = CreateFrame("Frame", "TrainingFrame_Spell_slot32", TrainingFrame, nil)
	Spell_slot32Button = CreateFrame("Button", "TrainingFrame_Spell_slot32Button", Spell_slot32, nil)
	Spell_slot32ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot32ButtonL", Spell_slot32, nil)
	Spell_slot32ButtonLT = Spell_slot32ButtonL:CreateTexture("Spell_slot32ButtonLT")
	Spell_slot32ButtonF = Spell_slot32ButtonL:CreateFontString("Spell_slot32ButtonF")
	Spell_slot32_AttachedSpell = nil
	
	Spell_slot33 = CreateFrame("Frame", "TrainingFrame_Spell_slot33", TrainingFrame, nil)
	Spell_slot33Button = CreateFrame("Button", "TrainingFrame_Spell_slot33Button", Spell_slot33, nil)
	Spell_slot33ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot33ButtonL", Spell_slot33, nil)
	Spell_slot33ButtonLT = Spell_slot33ButtonL:CreateTexture("Spell_slot33ButtonLT")
	Spell_slot33ButtonF = Spell_slot33ButtonL:CreateFontString("Spell_slot33ButtonF")
	Spell_slot33_AttachedSpell = nil
	
	Spell_slot34 = CreateFrame("Frame", "TrainingFrame_Spell_slot34", TrainingFrame, nil)
	Spell_slot34Button = CreateFrame("Button", "TrainingFrame_Spell_slot34Button", Spell_slot34, nil)
	Spell_slot34ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot34ButtonL", Spell_slot34, nil)
	Spell_slot34ButtonLT = Spell_slot34ButtonL:CreateTexture("Spell_slot34ButtonLT")
	Spell_slot34ButtonF = Spell_slot34ButtonL:CreateFontString("Spell_slot34ButtonF")
	Spell_slot34_AttachedSpell = nil
	
	Spell_slot35 = CreateFrame("Frame", "TrainingFrame_Spell_slot35", TrainingFrame, nil)
	Spell_slot35Button = CreateFrame("Button", "TrainingFrame_Spell_slot35Button", Spell_slot35, nil)
	Spell_slot35ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot35ButtonL", Spell_slot35, nil)
	Spell_slot35ButtonLT = Spell_slot35ButtonL:CreateTexture("Spell_slot35ButtonLT")
	Spell_slot35ButtonF = Spell_slot35ButtonL:CreateFontString("Spell_slot35ButtonF")
	Spell_slot35_AttachedSpell = nil
	
	Spell_slot36 = CreateFrame("Frame", "TrainingFrame_Spell_slot36", TrainingFrame, nil)
	Spell_slot36Button = CreateFrame("Button", "TrainingFrame_Spell_slot36Button", Spell_slot36, nil)
	Spell_slot36ButtonL = CreateFrame("Button", "TrainingFrame_Spell_slot36ButtonL", Spell_slot36, nil)
	Spell_slot36ButtonLT = Spell_slot36ButtonL:CreateTexture("Spell_slot36ButtonLT")
	Spell_slot36ButtonF = Spell_slot36ButtonL:CreateFontString("Spell_slot36ButtonF")
	Spell_slot36_AttachedSpell = nil
	
	all_spell_slots = {
    {Spell_slot1, -300, -160}, {Spell_slot2, -220, -160}, {Spell_slot3, -140, -160}, {Spell_slot4, -60, -160}, {Spell_slot5, 20, -160}, {Spell_slot6, 100, -160}, 
    {Spell_slot7, -300, -260}, {Spell_slot8, -220, -260}, {Spell_slot9, -140, -260}, {Spell_slot10, -60, -260}, {Spell_slot11, 20, -260}, {Spell_slot12, 100, -260},
    {Spell_slot13, -300, -360}, {Spell_slot14, -220, -360}, {Spell_slot15, -140, -360}, {Spell_slot16, -60, -360}, {Spell_slot17, 20, -360}, {Spell_slot18, 100, -360}, 
    {Spell_slot19, -300, -460}, {Spell_slot20, -220, -460}, {Spell_slot21, -140, -460}, {Spell_slot22, -60, -460}, {Spell_slot23, 20, -460}, {Spell_slot24, 100, -460},
    {Spell_slot25, -300, -560}, {Spell_slot26, -220, -560}, {Spell_slot27, -140, -560}, {Spell_slot28, -60, -560}, {Spell_slot29, 20, -560}, {Spell_slot30, 100, -560},
    {Spell_slot31, -300, -660}, {Spell_slot32, -220, -660}, {Spell_slot33, -140, -660}, {Spell_slot34, -60, -660}, {Spell_slot35, 20, -660}, {Spell_slot36, 100, -660}}
	
	all_spell_slot_buttons = {Spell_slot1Button, Spell_slot2Button, Spell_slot3Button, Spell_slot4Button,
	Spell_slot5Button, Spell_slot6Button, Spell_slot7Button, Spell_slot8Button,
	Spell_slot9Button, Spell_slot10Button, Spell_slot11Button, Spell_slot12Button,
	Spell_slot13Button, Spell_slot14Button, Spell_slot15Button, Spell_slot16Button,
	Spell_slot17Button, Spell_slot18Button, Spell_slot19Button, Spell_slot20Button,
	Spell_slot21Button, Spell_slot22Button, Spell_slot23Button, Spell_slot24Button,
	Spell_slot25Button, Spell_slot26Button, Spell_slot27Button, Spell_slot28Button,
	Spell_slot29Button, Spell_slot30Button, Spell_slot31Button, Spell_slot32Button,
	Spell_slot33Button, Spell_slot34Button, Spell_slot35Button, Spell_slot36Button}
	
	all_learn_spell_buttons = {Spell_slot1ButtonL, Spell_slot2ButtonL, Spell_slot3ButtonL, Spell_slot4ButtonL,
	Spell_slot5ButtonL, Spell_slot6ButtonL, Spell_slot7ButtonL, Spell_slot8ButtonL,
	Spell_slot9ButtonL, Spell_slot10ButtonL, Spell_slot11ButtonL, Spell_slot12ButtonL,
	Spell_slot13ButtonL, Spell_slot14ButtonL, Spell_slot15ButtonL, Spell_slot16ButtonL,
	Spell_slot17ButtonL, Spell_slot18ButtonL, Spell_slot19ButtonL, Spell_slot20ButtonL,
	Spell_slot21ButtonL, Spell_slot22ButtonL, Spell_slot23ButtonL, Spell_slot24ButtonL,
	Spell_slot25ButtonL, Spell_slot26ButtonL, Spell_slot27ButtonL, Spell_slot28ButtonL,
	Spell_slot29ButtonL, Spell_slot30ButtonL, Spell_slot31ButtonL, Spell_slot32ButtonL,
	Spell_slot33ButtonL, Spell_slot34ButtonL, Spell_slot35ButtonL, Spell_slot36ButtonL}
	
	all_learn_spell_buttons_t = {Spell_slot1ButtonLT, Spell_slot2ButtonLT, Spell_slot3ButtonLT, Spell_slot4ButtonLT,
	Spell_slot5ButtonLT, Spell_slot6ButtonLT, Spell_slot7ButtonLT, Spell_slot8ButtonLT,
	Spell_slot9ButtonLT, Spell_slot10ButtonLT, Spell_slot11ButtonLT, Spell_slot12ButtonLT,
	Spell_slot13ButtonLT, Spell_slot14ButtonLT, Spell_slot15ButtonLT, Spell_slot16ButtonLT,
	Spell_slot17ButtonLT, Spell_slot19ButtonLT, Spell_slot18ButtonLT, Spell_slot20ButtonLT,
	Spell_slot21ButtonLT, Spell_slot22ButtonLT, Spell_slot23ButtonLT, Spell_slot24ButtonLT,
	Spell_slot25ButtonLT, Spell_slot26ButtonLT, Spell_slot27ButtonLT, Spell_slot28ButtonLT,
	Spell_slot29ButtonLT, Spell_slot30ButtonLT, Spell_slot31ButtonLT, Spell_slot32ButtonLT,
	Spell_slot33ButtonLT, Spell_slot34ButtonLT, Spell_slot35ButtonLT, Spell_slot36ButtonLT}
	
	all_learn_spell_buttons_f = {Spell_slot1ButtonF, Spell_slot2ButtonF, Spell_slot3ButtonF, Spell_slot4ButtonF,
	Spell_slot5ButtonF, Spell_slot6ButtonF, Spell_slot7ButtonF, Spell_slot8ButtonF,
	Spell_slot9ButtonF, Spell_slot10ButtonF, Spell_slot11ButtonF, Spell_slot12ButtonF,
	Spell_slot13ButtonF, Spell_slot14ButtonF, Spell_slot15ButtonF, Spell_slot16ButtonF,
	Spell_slot17ButtonF, Spell_slot18ButtonF, Spell_slot19ButtonF, Spell_slot20ButtonF,
	Spell_slot21ButtonF, Spell_slot22ButtonF, Spell_slot23ButtonF, Spell_slot24ButtonF,
	Spell_slot25ButtonF, Spell_slot26ButtonF, Spell_slot27ButtonF, Spell_slot28ButtonF,
	Spell_slot29ButtonF, Spell_slot30ButtonF, Spell_slot31ButtonF, Spell_slot32ButtonF,
	Spell_slot33ButtonF, Spell_slot34ButtonF, Spell_slot35ButtonF, Spell_slot36ButtonF}
	
	all_attached_spells = {Spell_slot1_AttachedSpell, Spell_slot2_AttachedSpell, Spell_slot3_AttachedSpell, Spell_slot4_AttachedSpell,
	Spell_slot5_AttachedSpell, Spell_slot6_AttachedSpell, Spell_slot7_AttachedSpell, Spell_slot8_AttachedSpell,
	Spell_slot9_AttachedSpell, Spell_slot10_AttachedSpell, Spell_slot11_AttachedSpell, Spell_slot12_AttachedSpell,
	Spell_slot13_AttachedSpell, Spell_slot14_AttachedSpell, Spell_slot15_AttachedSpell, Spell_slot16_AttachedSpell,
	Spell_slot17_AttachedSpell, Spell_slot18_AttachedSpell, Spell_slot19_AttachedSpell, Spell_slot20_AttachedSpell,
	Spell_slot21_AttachedSpell, Spell_slot22_AttachedSpell, Spell_slot23_AttachedSpell, Spell_slot24_AttachedSpell,
	Spell_slot25_AttachedSpell, Spell_slot26_AttachedSpell, Spell_slot27_AttachedSpell, Spell_slot28_AttachedSpell,
	Spell_slot29_AttachedSpell, Spell_slot30_AttachedSpell, Spell_slot31_AttachedSpell, Spell_slot32_AttachedSpell,
	Spell_slot33_AttachedSpell, Spell_slot34_AttachedSpell, Spell_slot35_AttachedSpell, Spell_slot36_AttachedSpell}
	
	for i,v in ipairs(all_spell_slots) do
        v[1]:SetSize(50, 50)
        v[1]:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackground",
            edgeFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackground-Border",
            edgeSize = 15
        })
        v[1]:SetPoint("TOP", v[2], v[3])
        v[1]:Hide()
    end
    
    for i,v in ipairs(all_spell_slot_buttons) do
        v:SetSize(40, 40)
        v:SetPoint("CENTER")
        v:EnableMouse(true)
        v:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackground"
        })
        v:SetScript("OnMouseUp",  unlearn_spell)
        --v:SetScript("OnMouseUp",  nil)

        _G[v:GetName().."_UnlearnTex"] = v:CreateTexture() 
        _G[v:GetName().."_UnlearnTex"]:SetAllPoints()
        _G[v:GetName().."_UnlearnTex"]:SetSize(v:GetSize())
        _G[v:GetName().."_UnlearnTex"]:SetPoint("CENTER",0,0)
        _G[v:GetName().."_UnlearnTex"]:SetTexture("Interface\\Icons\\inv_custom_scrollofunlearning") 
        _G[v:GetName().."_UnlearnTex"]:Hide()

        if (i == 1) then
            all_spell_slot_buttons_UnLearnEffect = CreateFrame("Model", "all_spell_slot_buttons_UnLearnEffect", v)
            all_spell_slot_buttons_UnLearnEffect:SetWidth(256);       
            all_spell_slot_buttons_UnLearnEffect:SetHeight(256);
            all_spell_slot_buttons_UnLearnEffect:SetPoint("CENTER", v, "CENTER", 0, 0)
            all_spell_slot_buttons_UnLearnEffect:SetModel("World\\Expansion01\\doodads\\netherstorm\\crackeffects\\netherstormcracksmokeblue.m2")
            all_spell_slot_buttons_UnLearnEffect:SetModelScale(0.035)
            all_spell_slot_buttons_UnLearnEffect:SetCamera(0)
            all_spell_slot_buttons_UnLearnEffect:SetPosition(0.08,0.087,0)
            --all_spell_slot_buttons_UnLearnEffect:SetAlpha(0.8)
            all_spell_slot_buttons_UnLearnEffect:SetFacing(0.1)
            all_spell_slot_buttons_UnLearnEffect:Hide()
        end
    end
    
    for i,v in ipairs(all_learn_spell_buttons) do
        v:SetSize(50, 20)
        v:SetPoint("CENTER", 0, -42)
        v:EnableMouse(true)
        v:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")
        v:SetScript("OnMouseUp",  learn_spell)
    end
    
    for i,v in ipairs(all_learn_spell_buttons_t) do
        v:SetAllPoints(all_learn_spell_buttons[i])
        --v:SetTexture("Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonflag")
        all_learn_spell_buttons[i]:SetNormalTexture(v)
    end
    
    for i,v in ipairs(all_learn_spell_buttons_f) do
        v:SetFont("Fonts\\MORPHEUS.TTF", 15, "OUTLINE")
        v:SetShadowOffset(1, -1)
        all_learn_spell_buttons[i]:SetFontString(v)
        all_learn_spell_buttons[i]:SetText("|cffFFFFFFLearn|r")
    end
		
		
	-- ####################################### Talents Frame ##############################	

	 --scrollframe 
    scrollframe = CreateFrame("ScrollFrame", nil, TrainingFrame) 
    scrollframe:SetPoint("TOPLEFT", 95, -135) 
    scrollframe:SetSize(500, 650)
    TrainingFrame.scrollframe = scrollframe 
    scrollframe:Hide()
     
    --scrollbar 
    scrollbar = CreateFrame("Slider", nil, scrollframe, "UIPanelScrollBarTemplate") 
    scrollbar:SetPoint("TOPLEFT", scrollframe, "TOPRIGHT", 33, 0) 
    scrollbar:SetPoint("BOTTOMLEFT", scrollframe, "BOTTOMRIGHT", 33, 0) 
    scrollbar:SetMinMaxValues(0, 670) 
    scrollbar:SetValueStep(1) 
    scrollbar.scrollStep = 1
    scrollbar:SetValue(0) 
    scrollbar:SetWidth(16) 
    scrollbar:SetFrameStrata("FULLSCREEN")
    scrollbar:SetScript("OnValueChanged", 
    function (self, value) 
    self:GetParent():SetVerticalScroll(value) 
    end) 
    local scrollbg = scrollbar:CreateTexture(nil, "BACKGROUND") 
    scrollbg:SetAllPoints(scrollbar) 
    scrollbg:SetTexture(0, 0, 0, 0.4) 
    TrainingFrame.scrollbar = scrollbar 
    scrollbar:Hide()
    
	
	
	 
	
	-- backgrounds
    top_left_bg = CreateFrame("Frame", nil, TrainingFrame) 
    top_left_bg:SetSize(305, 402) 
    top_left_bg:SetPoint("TOPLEFT", 90, -138)
    top_left_bg_t = top_left_bg:CreateTexture() 
    top_left_bg_t:SetAllPoints() 
    top_left_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-TopLeft") 
    top_left_bg.texture = top_left_bg_t 
    top_left_bg:Hide()
    
    top_right_bg = CreateFrame("Frame", nil, TrainingFrame) 
    top_right_bg:SetSize(305, 402) 
    top_right_bg:SetPoint("TOPLEFT", 395, -138)
    top_right_bg_t = top_right_bg:CreateTexture() 
    top_right_bg_t:SetAllPoints() 
    top_right_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-TopRight") 
    top_right_bg.texture = top_right_bg_t 
    top_right_bg:Hide()
    
    bottom_left_bg = CreateFrame("Frame", nil, TrainingFrame) 
    bottom_left_bg:SetSize(305, 402) 
    bottom_left_bg:SetPoint("TOPLEFT", 90, -540)
    bottom_left_bg_t = bottom_left_bg:CreateTexture() 
    bottom_left_bg_t:SetAllPoints() 
    bottom_left_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-BottomLeft") 
    bottom_left_bg.texture = bottom_left_bg_t 
    bottom_left_bg:Hide()
    
    bottom_right_bg = CreateFrame("Frame", nil, TrainingFrame) 
    bottom_right_bg:SetSize(305, 402) 
    bottom_right_bg:SetPoint("TOPLEFT", 395, -540)
    bottom_right_bg_t = bottom_right_bg:CreateTexture() 
    bottom_right_bg_t:SetAllPoints() 
    bottom_right_bg_t:SetTexture("Interface\\TalentFrame\\MageFire-BottomRight") 
    bottom_right_bg.texture = bottom_right_bg_t
    bottom_right_bg:Hide()
	
	--content frame 
	content = CreateFrame("Frame", nil, scrollframe) 
	content:SetSize(500, 1320)  
	scrollframe.content = content 
	content:Hide()
	 
	scrollframe:SetScrollChild(content)
	
	all_talent_slots = {}
	
	all_talent_slot_buttons = {}
	
	all_learn_talent_buttons = {}
	
	all_learn_talent_buttons_t = {}
	
	all_learn_talent_buttons_f = {}
	
	all_attached_talent = {}
	
	all_talent_FrameNumber = {}
	
	all_talent_FNF = {}
	
	button_on_off_state = {} 
	
	local max_number_of_buttons = 44
	
	local button_making = 1
	
	repeat
	
		local talent_slot = CreateFrame("Frame", "TrainingFrame_talent_slot1", content, nil)
		table.insert(all_talent_slots, talent_slot)
		local talent_slotButton = CreateFrame("Button", "TrainingFrame_talent_slotButton", talent_slot, nil)
		table.insert(all_talent_slot_buttons, talent_slotButton)
		local talent_slotButtonL = CreateFrame("Button", "TrainingFrame_talent_slotButtonL", talent_slot, nil)
		table.insert(all_learn_talent_buttons, talent_slotButtonL)
		local talent_slotButtonLT = talent_slotButtonL:CreateTexture("talent_slotButtonLT")
		table.insert(all_learn_talent_buttons_t, talent_slotButtonLT)
		local talent_slotButtonF = talent_slotButtonL:CreateFontString("talent_slotButtonF")
		table.insert(all_learn_talent_buttons_f, talent_slotButtonF)
		local talent_slot_AttachedTalent = nil
		table.insert(all_attached_talent, talent_slot_AttachedTalent)
		local talent_slotFrameNumber = CreateFrame("Button", "TrainingFrame_talent_slotFrameNumber", talent_slot, nil)
		table.insert(all_talent_FrameNumber, talent_slotFrameNumber)
		local talent_slotFNF = talent_slotFrameNumber:CreateFontString("talent_stotFNF")
		table.insert(all_talent_FNF, talent_slotFNF)
		table.insert(button_on_off_state, false)
		
	
		button_making = button_making + 1
	until(button_making > max_number_of_buttons)
	

	
	
	
	 all_talent_coords = {{-165, -83}, {-40, -83}, {85, -83}, {210, -83},
                         {-165, -191}, {-40, -191}, {85, -191}, {210, -191},
                         {-165, -299}, {-40, -299}, {85, -299}, {210, -299},
                         {-165, -407}, {-40, -407}, {85, -407}, {210, -407},
                         {-165, -515}, {-40, -515}, {85, -515}, {210, -515},
                         {-165, -623}, {-40, -623}, {85, -623}, {210, -623},
                         {-165, -731}, {-40, -731}, {85, -731}, {210, -731},
                         {-165, -839}, {-40, -839}, {85, -839}, {210, -839},
                         {-165, -947}, {-40, -947}, {85, -947}, {210, -947},
                         {-165, -1055}, {-40, -1055}, {85, -1055}, {210, -1055},
                         {-165, -1163}, {-40, -1163}, {85, -1163}, {210, -1163}}
	
	
	for i,v in ipairs(all_talent_slots) do
        v:SetSize(56, 56)
        v:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_bg",
            insets = {
            left = -11,
            right = -11,
            top = -11,
            bottom = -11}
        })
        v:SetPoint("TOP", all_talent_coords[i][1], all_talent_coords[i][2])
        v:Show()
    end
    
    for i,v in ipairs(all_talent_slot_buttons) do
        v:SetSize(48, 48)
        v:SetPoint("CENTER")
        v:EnableMouse(true)
        v:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\buttonbackgroundold"
        })
        --v:SetScript("OnMouseUp",  unlearn_talent)
        v:SetScript("OnMouseUp",  nil)

        --[[_G[v:GetName().."_UnlearnTex"] = v:CreateTexture() 
        _G[v:GetName().."_UnlearnTex"]:SetAllPoints()
        _G[v:GetName().."_UnlearnTex"]:SetSize(v:GetSize())
        _G[v:GetName().."_UnlearnTex"]:SetPoint("CENTER",0,0)
        _G[v:GetName().."_UnlearnTex"]:SetTexture("Interface\\Icons\\inv_custom_scrollofunlearning") 
        _G[v:GetName().."_UnlearnTex"]:Hide()
        v.UnlearnTex = _G[v:GetName().."_UnlearnTex"]]--
    end
    
    for i,v in ipairs(all_learn_talent_buttons) do
        v:SetSize(50, 20)
        v:SetPoint("CENTER", 0, -42)
        v:EnableMouse(true)
        v:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\misc\\dialog_glow")
        v:SetScript("OnMouseUp",  upgrade_talent)
    end
    
    for i,v in ipairs(all_learn_talent_buttons_t) do
        v:SetAllPoints(all_learn_talent_buttons[i])
        all_learn_talent_buttons[i]:SetText("|cffE1AB18Learn|r")
        all_learn_talent_buttons[i]:SetNormalTexture(v)
    end
    
    for i,v in ipairs(all_learn_talent_buttons_f) do
        v:SetFont("Fonts\\MORPHEUS.TTF", 15, "OUTLINE")
        v:SetShadowOffset(1, -1)
        all_learn_talent_buttons[i]:SetFontString(v)
        all_learn_talent_buttons[i]:SetText("Learn")
    end
    
    for i,v in ipairs(all_talent_FrameNumber) do
        v:SetSize(16, 16)
        v:SetBackdrop({
            bgFile = "Interface\\AddOns\\AwAddons\\Textures\\progress\\talent_fn",
             insets = {
            left = -7,
            right = -7,
            top = -7,
            bottom = -7}
        })
        v:EnableMouse(false)
        v:SetPoint("BOTTOMRIGHT", 2, -1)
    end
    
    for i,v in ipairs(all_talent_FNF) do
        v:SetFont("Fonts\\FRIZQT__.ttf", 13)
        v:SetPoint("CENTER",0,-1)
        v:SetShadowOffset(1, 1)
        all_talent_FrameNumber[i]:SetFontString(v)
        all_talent_FrameNumber[i]:SetText(" ")
    end

    --extra buttons for a spellbookframe--
    local SpellBook_SkillTabOverFlowButton = CreateFrame("Button", "SpellBook_SkillTabOverFlowButton", SpellBookFrame, nil)
SpellBook_SkillTabOverFlowButton:SetSize(25,50)
SpellBook_SkillTabOverFlowButton:SetPoint("TOPLEFT", SpellBookSkillLineTab1, 0, 49)
SpellBook_SkillTabOverFlowButton:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\spellbook_forward")
SpellBook_SkillTabOverFlowButton:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\spellbook_forward_d")
SpellBook_SkillTabOverFlowButton:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\spellbook_forward_h")
SpellBook_SkillTabOverFlowButton:SetScript("OnUpdate", function(self)
    if (_G["SpellBookSkillLineTab"..GetNumSpellTabs()]) and (_G["SpellBookSkillLineTab"..GetNumSpellTabs()]:IsVisible()) then
        self:Disable()
    elseif (GetNumSpellTabs() > 7) then
        self:Enable()
    end
    end)
SpellBook_SkillTabOverFlowButton:SetScript("OnClick", function(self)
    if (self:IsEnabled()) then
    skilltab_pagenum = skilltab_pagenum +1
    SpellBookFrame_PlayOpenSound()
    SpellBookFrame_Update()
end
    end)

local SpellBook_SkillTabOverFlowButton_b = CreateFrame("Button", "SpellBook_SkillTabOverFlowButton_b", SpellBookFrame, nil)
SpellBook_SkillTabOverFlowButton_b:SetSize(25,50)
SpellBook_SkillTabOverFlowButton_b:SetPoint("BOTTOMLEFT", SpellBookSkillLineTab7, 0, -49)
SpellBook_SkillTabOverFlowButton_b:SetNormalTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\spellbook_back")
SpellBook_SkillTabOverFlowButton_b:SetDisabledTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\spellbook_back_d")
SpellBook_SkillTabOverFlowButton_b:SetHighlightTexture("Interface\\AddOns\\AwAddons\\Textures\\Misc\\spellbook_back_h")
SpellBook_SkillTabOverFlowButton_b:SetScript("OnUpdate", function(self)
    if (skilltab_pagenum == 1) then
        self:Disable()
            else
        self:Enable()
    end
    end)
SpellBook_SkillTabOverFlowButton_b:SetScript("OnClick", function(self)
    if (self:IsEnabled()) then
skilltab_pagenum = skilltab_pagenum -1
SpellBookFrame_PlayOpenSound()
SpellBookFrame_Update()
end
    end)

SpellBook_SkillTabOverFlowButton:Disable()
SpellBook_SkillTabOverFlowButton_b:Disable()
