-- Ingame slash command, SLASH_{name}{number} registers it to the function
SLASH_GOTRAIN1 = "/gotrain"

function GoTrainHandler()
    -- Gather player's already learned profession skills
    local knownSkills = {}

    local tradeskillName, currentLevel, maxLevel, skillLineModifier = GetTradeSkillLine()

    for i = 1, GetNumTradeSkills() do
        name, type, _, _, _, _ = GetTradeSkillInfo(i);
        if (name and type ~= "header") then
            table.insert(knownSkills, name)
        end
    end
    print("KNOWN SKILLS: ")
    for _, name in ipairs(knownSkills) do
        print(name)
    end

    gatherProfessions()

    -- Function to set CraftableItems based on the profession
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

    -- All spells in object
    function printCraftableItemIds(items)
        local professionItemsNotKnown = {}

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

    -- Call the function to set and print craftable items
    setCraftableItems()
    printCraftableItemIds(CraftableItems)

end

-- Tell WoW about the command
SlashCmdList["GOTRAIN"] = GoTrainHandler
