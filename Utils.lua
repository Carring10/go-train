-- Table to store profession names
local currentProfessions = {}

function gatherProfessions()
    -- Iterate through each skill line
    for i = 1, GetNumSkillLines() do
        local skillName, isHeader, _, skillRank, _, _, skillMaxRank, _, _, _, _ = GetSkillLineInfo(i)

        -- If it's not a header and matches known professions, add to the list
        if not isHeader and
            (skillName == "Alchemy" or skillName == "Blacksmithing" or skillName == "Enchanting" or skillName ==
                "Engineering" or skillName == "Herbalism" or skillName == "Leatherworking" or skillName == "Mining" or
                skillName == "Skinning" or skillName == "Tailoring" or skillName == "First Aid" or skillName ==
                "Cooking" or skillName == "Fishing") then
            table.insert(currentProfessions, skillName .. " (" .. skillRank .. "/" .. skillMaxRank .. ")")
        end
    end

    -- Print the collected profession names
    -- if #currentProfessions > 0 then
    --     print("Your Professions:")
    --     for _, name in ipairs(currentProfessions) do
    --         print(name)
    --     end
    -- else
    --     print("No professions found.")
    -- end
end
