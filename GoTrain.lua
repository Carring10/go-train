-- Ingame slash command, SLASH_{name}{number} registers it to the function
SLASH_GOTRAIN1 = "/gotrain"

local function GoTrainHandler()
    function printCraftableItemIds(items)
        for key, value in pairs(items) do
            for _, item in ipairs(value) do
                print("Craftable Item ID: " .. item.id)
                name, rank, icon, castTime, minRange, maxRange 
                = GetSpellInfo(item.id)
                print("SPELL NAME: " .. name .. " DESCRIPTION: " .. GetSpellDescription(item.id))
            end
        end
    end
    printCraftableItemIds(CraftableItems)
end

-- Tell WoW about the command
SlashCmdList["GOTRAIN"] = GoTrainHandler
