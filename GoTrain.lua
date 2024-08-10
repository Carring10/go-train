-- Ingame slash command, SLASH_{name}{number} registers it to the function
SLASH_GOTRAIN1 = "/gotrain"

function GoTrainHandler()
    setCraftableItems()

    -- All spells in object
    function printCraftableItemIds(items)
        if items == nil then
            print("No craftable items to display.")
            return
        end

        for key, value in pairs(items) do
            for _, item in ipairs(value) do
                print("Craftable Item ID: " .. item.id)
                name, rank, icon, castTime, minRange, maxRange = GetSpellInfo(item.id)
                print("SPELL NAME: " .. name .. " DESCRIPTION: " .. GetSpellDescription(item.id))
            end
        end
    end
    
    printCraftableItemIds(CraftableItems)

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
end

-- Tell WoW about the command
SlashCmdList["GOTRAIN"] = GoTrainHandler
