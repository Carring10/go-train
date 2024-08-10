function setCraftableItems()
    local professionName = GetTradeSkillLine()
    if professionName ~= "First Aid" then
        return
    end

    CraftableItems = {
        [1] = {{
            id = 3275
        }},
        [40] = {{
            id = 3276
        }},
        [80] = {{
            id = 7934
        }, {
            id = 3277
        }}
    }
end
