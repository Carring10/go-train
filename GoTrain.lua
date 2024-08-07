-- Ingame slash command, SLASH_{name}{number} registers it to the function
SLASH_GOTRAIN1 = "/gotrain"

local function GoTrainHandler()
    local numSkills = GetNumSkillLines()
    local playerProfessions = {}
    -- Iterate through each profession index
    for i = 1, GetNumSkillLines() do
        local skillName, isHeader, _, skillRank, _, _, skillMaxRank, _, _, _, _ = GetSkillLineInfo(i)

        -- If it's not a header and matches known professions, add to the list
        if not isHeader and
            (skillName == "Alchemy" or skillName == "Blacksmithing" or skillName == "Enchanting" or skillName ==
                "Engineering" or skillName == "Herbalism" or skillName == "Leatherworking" or skillName == "Mining" or
                skillName == "Skinning" or skillName == "Tailoring" or skillName == "First Aid" or skillName ==
                "Cooking" or skillName == "Fishing") then
            -- Add the skillName, rank, and index to the playerProfessions table
            table.insert(playerProfessions, {
                name = skillName,
                rank = skillRank,
                maxRank = skillMaxRank,
                index = i
            })
        end
    end
    -- Print the contents of the playerProfessions table to the chat frame
    for _, profession in ipairs(playerProfessions) do
        -- Print each profession with its index and rank
        print("|cff00ff00[Profession Notifier]:|r " .. profession.name .. " (" .. profession.rank .. "/" ..
                  profession.maxRank .. ") Index: " .. profession.index)
    end
end

-- Tell WoW about the command
SlashCmdList["GOTRAIN"] = GoTrainHandler
