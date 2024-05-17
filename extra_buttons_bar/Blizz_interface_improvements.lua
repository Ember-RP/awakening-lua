local AIO = AIO or require("AIO")


if AIO.AddAddon() then
    return
end

local MicroButtons = {
        AchievementMicroButton,
        QuestLogMicroButton,
        SocialsMicroButton,
        PVPMicroButton
}
local MicroButtons2 = {
        LFDMicroButton,
        MainMenuMicroButton,
        HelpMicroButton
    }

BI_i = CreateFrame("Frame", nil, UIParent)
BI_i:SetScript("OnUpdate", function()
    if (PlayerTalentFrame) then
    if (PlayerTalentFrame:IsVisible()) then
        PlayerTalentFrameTab2:Hide()
        PlayerTalentFrameTab3:Hide()
        PlayerTalentFrameTab4:Hide()
    end
end

    if (InspectFrame) then
    if (InspectFrameTab3:IsVisible()) then
    InspectFrameTab3:Hide()
    end
    end

    if (FriendsFrameTab2:IsVisible()) then
    FriendsFrameTab2:Hide()
    end
    
    --[[if (LFDMicroButton:IsVisible()) then
        LFDMicroButton:Hide()
        CharUpdatesMicroButton:Show()
    end]]
    if (TalentMicroButton:IsVisible()) then
        TalentMicroButton:Hide()
        CharUpdatesMicroButton:Show()
        --moving all buttons to right
        LFDMicroButton:Show()
        for i = 1, #MicroButtons do
            if (i == 1) then
                MicroButtons[i]:SetPoint("BOTTOMLEFT", SpellbookMicroButton, "BOTTOMRIGHT", -3, 0)
            else
            MicroButtons[i]:SetPoint("BOTTOMLEFT", MicroButtons[i-1], "BOTTOMRIGHT", -3, 0)
        end
        end

        --shitty code, lol
         for i = 1, #MicroButtons2 do
            if (i == 1) then
                MicroButtons2[i]:SetPoint("BOTTOMLEFT", CharUpdatesMicroButton, "BOTTOMRIGHT", -3, 0)
            else
            MicroButtons2[i]:SetPoint("BOTTOMLEFT", MicroButtons2[i-1], "BOTTOMRIGHT", -3, 0)
        end
        end

    end

    if (UnitLevel("player") >= 10) then
    if (UnitIsGhost("player")) and not(DeathCapitalTeleportButton:IsVisible()) then
            local zonenamename, zonetype = GetInstanceInfo()
            if not(zonetype == "pvp") then
            DeathCapitalTeleportButton:Show()
            end
        elseif not(UnitIsGhost("player")) and (DeathCapitalTeleportButton:IsVisible()) then
        DeathCapitalTeleportButton:Hide()
    end
end
    end)
BI_i:Show()

--Pet talents tab
table.insert(UnitPopupMenus["PET"], table.getn(UnitPopupMenus["PET"]), "ASCENSION_PETTALENTS");
UnitPopupButtons["ASCENSION_PETTALENTS"] = {text = "Pet Talents", dist = 0}
hooksecurefunc("UnitPopup_OnClick", function (self)
    local name = UIDROPDOWNMENU_INIT_MENU.name
    if (name == MC_PLAYER) then return end
    if (self.value == "ASCENSION_PETTALENTS") then
      ToggleTalentFrame()
    end
  end);

function IsSpellLearned(entry)
    local spellname = GetSpellInfo(entry)
    local done = false
    local known = false
    local i = 1
    local id = nil
    if not(spellname) then
      return false
    end
    spellname = string.gsub(spellname,"%(Rank %d+%)","");
    while not done do
        local name = GetSpellName(i,BOOKTYPE_SPELL);
        if not name then
        done=true;
            elseif (name==spellname) then
            known = true
            end
        i = i+1;
    end
return known
end

--pet status bar--
--[[function Asc_PetPaperDollFrame_Update()
    local hasPetUI, canGainXP = HasPetUI();
    if ( not hasPetUI ) then
        return;
    end
    PetModelFrame:SetUnit("pet");
    if ( UnitCreatureFamily("pet") ) then
        PetLevelText:SetFormattedText(UNIT_TYPE_LEVEL_TEMPLATE,UnitLevel("pet"),UnitCreatureFamily("pet"));
    end
    if ( PetPaperDollFramePetFrame:IsShown() ) then
        PetNameText:SetText(UnitName("pet"));
    end
    PetExpBar_Update();
    PetPaperDollFrame_SetResistances();
    PetPaperDollFrame_SetStats();
    PaperDollFrame_SetDamage(PetDamageFrame, "Pet");
    PaperDollFrame_SetArmor(PetArmorFrame, "Pet");
    PaperDollFrame_SetAttackPower(PetAttackPowerFrame, "Pet");
    PetPaperDollFrame_SetSpellBonusDamage();

    if ( GetPetFoodTypes() ) then
        PetPaperDollPetInfo:Show();
    else
        PetPaperDollPetInfo:Hide();
    end
end
ActionButton_UpdateUsable = Asc_PetPaperDollFrame_Update]]--

--[[function Asc_PetFrame_SetHappiness ()
    local happiness, damagePercentage = GetPetHappiness();
    local hasPetUI, isHunterPet = HasPetUI();
    if ( not damagePercentage) then
        PetFrameHappiness:Hide();
        return; 
    end
    PetFrameHappiness:Show();

    --custom hapiness indicator 
    if (damagePercentage > 100) then
        happiness = 3
        elseif (damagePercentage == 100) then
            happiness = 2
        else
            happiness = 1
        end
    --end
    if ( happiness == 1 ) then
        PetFrameHappinessTexture:SetTexCoord(0.375, 0.5625, 0, 0.359375);
    elseif ( happiness == 2 ) then
        PetFrameHappinessTexture:SetTexCoord(0.1875, 0.375, 0, 0.359375);
    elseif ( happiness == 3 ) then
        PetFrameHappinessTexture:SetTexCoord(0, 0.1875, 0, 0.359375);
    end
    PetFrameHappiness.tooltip = _G["PET_HAPPINESS"..happiness];
    PetFrameHappiness.tooltipDamage = format(PET_DAMAGE_PERCENTAGE, damagePercentage);
end

PetFrame_SetHappiness = Asc_PetFrame_SetHappiness]]--