-- Function to create a UI panel with unlearned professions
function CreateUnlearnedProfessionsPanel(notLearnedProfessions)
    -- Create the frame for unlearned professions
    local unlearnedFrame = CreateFrame("Frame", "UnlearnedProfessionsFrame", TradeSkillFrame)
    unlearnedFrame:SetSize(200, 200)
    unlearnedFrame:SetPoint("TOPLEFT", TradeSkillFrame, "TOPRIGHT", 10, 0)

    -- Add a background to the frame
    unlearnedFrame.texture = unlearnedFrame:CreateTexture(nil, "BACKGROUND")
    unlearnedFrame.texture:SetAllPoints(unlearnedFrame)
    unlearnedFrame.texture:SetColorTexture(0, 0, 0, 0.5) -- Semi-transparent black

    -- Add a title to the frame
    local title = unlearnedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    title:SetPoint("TOP", unlearnedFrame, "TOP", 0, -10)
    title:SetText("Unlearned Professions")

    -- Fetch unlearned professions and add them as text
    -- local unlearnedProfessions = GetUnlearnedProfessions()
    for i, item in ipairs(notLearnedProfessions) do
        local professionText = unlearnedFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
        professionText:SetPoint("TOP", title, "BOTTOM", 0, -15 * i)
        professionText:SetText(item.name)
    end

    -- Initially hide the frame
    unlearnedFrame:Hide()

    return unlearnedFrame
end

function CreateProfessionUI(professionItemsNotKnown)
    print("here")

    -- Create a tab button
    local professionTab = CreateFrame("Button", "ProfessionTabButton", TradeSkillFrame)
    professionTab:SetSize(32, 32)
    professionTab:SetPoint("TOPLEFT", TradeSkillFrame, "TOPRIGHT", -40, -40)
    -- Set the icon texture
    professionTab.icon = professionTab:CreateTexture(nil, "ARTWORK")
    professionTab.icon:SetAllPoints()
    professionTab.icon:SetTexture("Interface\\ICONS\\INV_Misc_Book_09")

    -- Create the unlearned professions panel but keep it hidden initially
    local unlearnedProfessionsFrame = CreateUnlearnedProfessionsPanel(professionItemsNotKnown)

    -- Set up the button click event to toggle the unlearned professions panel
    professionTab:SetScript("OnClick", function()
      print("works")
        if unlearnedProfessionsFrame:IsShown() then
            unlearnedProfessionsFrame:Hide()
        else
            unlearnedProfessionsFrame:Show()
        end
    end)
end

