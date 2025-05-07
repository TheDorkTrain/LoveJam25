pearlItems = {}

function randomPearlOffering(xValue)
    if xValue == 1 then
        xValue = "bluPrl"
    elseif xValue == 2 then
        xValue = "redPrl"
    else
        xValue = "grnPrl"
    end
    return xValue
end

value1 = "bluPrl"
value2 = "redPrl"
value3 = "grnPrl"

function randomizeValues()
    value1 = randomPearlOffering(love.math.random(1, 3))
    value2 = randomPearlOffering(love.math.random(1, 3))
    value3 = randomPearlOffering(love.math.random(1, 3))

    altar1 = Gatherpoint("altar", 720, 1180, 0, 0, "pearl", value1)
    altar2 = Gatherpoint("altar", 820, 1180, 0, 0, "pearl", value2)
    altar3 = Gatherpoint("altar", 920, 1180, 0, 0, "pearl", value3)
end

function dailyReset()
    randomizeValues()
    altar1.goal = "empty"
    altar2.goal = "empty"
    altar3.goal = "empty"
    altar1.hold = "empty"
    altar2.hold = "empty"
    altar3.hold = "empty"
    stand.goal = "empty"
    player.holding = "false"
    player.action = "false"
     player.state= "false"
     player.walk= "false"
    randomizeSpawn()

end

function randomizeSpawn()
    local pearl1 = randomPearlOffering(love.math.random(1, 3))
    local pearl2 = randomPearlOffering(love.math.random(1, 3))
    local pearl3 = randomPearlOffering(love.math.random(1, 3))
    local pearl4 = randomPearlOffering(love.math.random(1, 3))
    local pearl5 = randomPearlOffering(love.math.random(1, 3))
    local pearl6 = randomPearlOffering(love.math.random(1, 3))
    
    local pearlPositions = {
        {x = -1370, y = 2008},
        {x = -299, y = 2802},
        {x = -720, y = 1688},
        {x = 1395, y = 1747},
        {x = 1964, y = 1522},
        {x = 1654, y = 2318}
    }
    
    local pearlTypes = {pearl1, pearl2, pearl3, pearl4, pearl5, pearl6}
    
    -- If this is the first time, create new items
    if #pearlItems == 0 then
        -- Create new pearl items
        for i = 1, 6 do
            pearlItems[i] = Item(pearl, "pearl", pearlTypes[i], pearlPositions[i].x, pearlPositions[i].y)
        end
    else
        -- Update existing pearl items with new types and positions
        for i = 1, 6 do
            -- Update the pearl type
            pearlItems[i].itemType = pearlTypes[i]
            
            -- Update position
            pearlItems[i].x = pearlPositions[i].x
            pearlItems[i].y = pearlPositions[i].y
            
            pearlItems[i].carried = false  
            pearlItems[i].pickup = false  
            
            if pearlItems[i].reset then
                pearlItems[i]:reset()
            end
        end
    end
    
    -- If you need to access these specific pearls individually elsewhere
    pearlItem = pearlItems[1]
    pearlItem2 = pearlItems[2]
    pearlItem3 = pearlItems[3]
    pearlItem4 = pearlItems[4]
    pearlItem5 = pearlItems[5]
    pearlItem6 = pearlItems[6]
    
    -- Print debug information
    -- print("Pearls randomized for new day!")
    -- for i, item in ipairs(pearlItems) do
    --     print("Pearl " .. i .. ": " .. item.itemType .. " at " .. item.x .. ", " .. item.y)
    -- end
end



