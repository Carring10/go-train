-- Declare variables to store known skills and unknown items
local knownSkills = {}
local professionItemsNotKnown = {}

-- Update profession data when a new profession window is opened
function updateProfessionData()
    -- Clear the tables to reset for new profession data
    knownSkills = {}
    professionItemsNotKnown = {}

    local tradeskillName, currentLevel, maxLevel, skillLineModifier = GetTradeSkillLine()

    for i = 1, GetNumTradeSkills() do
        local name, type, _, _, _, _ = GetTradeSkillInfo(i)
        if (name and type ~= "header") then
            table.insert(knownSkills, name)
        end
    end

    print("KNOWN SKILLS:")
    for _, name in ipairs(knownSkills) do
        print(name)
    end
end

-- Event handler for profession window
function OnEvent(self, event, ...)
    print(event)
    if event == "TRADE_SKILL_SHOW" then
        -- Update the profession data when a new profession window is shown
        updateProfessionData()
    elseif event == "TRADE_SKILL_CLOSE" then
        -- Clear data when profession window is closed
        knownSkills = {}
        professionItemsNotKnown = {}
    end
end

-- Initialize the event frame
function initializeEventFrame()
    local frame = CreateFrame("Frame")
    frame:RegisterEvent("TRADE_SKILL_SHOW")
    frame:RegisterEvent("TRADE_SKILL_CLOSE")
    frame:SetScript("OnEvent", OnEvent)
end

-- Set the craftable items for the current profession
function setCraftableItems()
    local professionName = GetTradeSkillLine() -- Get the active profession name
    print("PROFESSION NAME: ", professionName)

    if professionName == "Cooking" then
        setCookingItems()
    elseif professionName == "First Aid" then
        setFirstAidItems()
    else
        print("No craftable items available for this profession.")
        CraftableItems = nil
    end
end

-- Print the craftable item IDs
function printCraftableItemIds(items)
    if items == nil then
        print("No craftable items to display.")
        return
    end

    for key, value in pairs(items) do
        for _, item in ipairs(value) do
            local name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(item.id)
            -- Check if the spell is NOT in the knownSkills table
            local isKnown = false
            for _, knownSpell in ipairs(knownSkills) do
                if knownSpell == name then
                    isKnown = true
                    break
                end
            end

            -- If the spell is not known, add it to professionItemsNotKnown
            if not isKnown then
                table.insert(professionItemsNotKnown, {
                    key = key,
                    name = name
                })
            end
        end
    end

    for _, item in ipairs(professionItemsNotKnown) do
        print("NOT KNOWN:", item.key, item.name)
    end
end

-- Main handler function for the /gotrain slash command
function GoTrainHandler()
    -- Initialize event listener
    initializeEventFrame()

    -- Set craftable items and print the IDs
    setCraftableItems()
    printCraftableItemIds(CraftableItems)

    -- Create the profession UI with unknown items
    CreateProfessionUI(professionItemsNotKnown)
end

-- Register the slash command
SLASH_GOTRAIN1 = "/gotrain"
SlashCmdList["GOTRAIN"] = GoTrainHandler
