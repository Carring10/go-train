-- Ingame slash command, SLASH_{name}{number} registers it to the function
SLASH_GOTRAIN1 = "/gotrain"

local function GoTrainHandler()
  numSkills = GetNumSkillLines()
  print(numSkills)
  for i = 1, GetNumSkillLines() do
    local skillName, isHeader, _, skillRank, _, _, skillMaxRank, _, _, _, _ = GetSkillLineInfo(i)
    print(skillName)

  end
end

-- Tell WoW about the command
SlashCmdList["GOTRAIN"] = GoTrainHandler
