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

value4 = "bluPrl"
value5 = "redPrl"
value6 = "grnPrl" 

-- Fixed randomizeValues function
function randomizeValues()
    value1 = randomPearlOffering(love.math.random(1, 3))
    value2 = randomPearlOffering(love.math.random(1, 3))
    value3 = randomPearlOffering(love.math.random(1, 3))

    value4 = randomPearlOffering(love.math.random(1, 3))
    value5 = randomPearlOffering(love.math.random(1, 3))
    value6 = randomPearlOffering(love.math.random(1, 3))

    -- Instead of creating new objects, update existing ones
    if altar1 then
        altar1.goal = value1
    else
        altar1 = Gatherpoint("altar", 720, 1180, 0, 0, "pearl", value1, true)
    end
    
    if altar2 then
        altar2.goal = value2
    else
        altar2 = Gatherpoint("altar", 820, 1180, 0, 0, "pearl", value2, true)
    end
    
    if altar3 then
        altar3.goal = value3
    else
        altar3 = Gatherpoint("altar", 920, 1180, 0, 0, "pearl", value3, true)
    end

    -- Same for hidden points
    if hiddenPoint1 then
        hiddenPoint1.goal = value4
    else
        hiddenPoint1 = Gatherpoint("altar", 1490, 1425, 0, 0, "pearl", value4, false)
    end
    
    if hiddenPoint2 then
        hiddenPoint2.goal = value5
    else
        hiddenPoint2 = Gatherpoint("altar", -40, 1630, 0, 0, "pearl", value5, false)
    end
    
    if hiddenPoint3 then
        hiddenPoint3.goal = value6
    else
        hiddenPoint3 = Gatherpoint("altar", -1250, 2128, 0, 0, "pearl", value6, false)
    end
end

function randomizeSpawn()
    local pearl1 = randomPearlOffering(love.math.random(1, 3))
    local pearl2 = randomPearlOffering(love.math.random(1, 3))
    local pearl3 = randomPearlOffering(love.math.random(1, 3))
    local pearl4 = randomPearlOffering(love.math.random(1, 3))
    local pearl5 = randomPearlOffering(love.math.random(1, 3))
    local pearl6 = randomPearlOffering(love.math.random(1, 3))
    local pearl7 = randomPearlOffering(love.math.random(1, 3))
    local pearl8 = randomPearlOffering(love.math.random(1, 3))
    
    local pearlPositions = {
        {x = -1370, y = 2008},
        {x = -299, y = 2802},
        {x = -1409, y = 1557},
        {x = 3110, y = 2334},
        {x = 1964, y = 1522},
        {x = 1654, y = 2318},
        {x = 100, y = 783},
        {x = 3425, y = 2009}
    }
    
    local pearlTypes = {pearl1, pearl2, pearl3, pearl4, pearl5, pearl6, pearl7, pearl8}
    
    -- If this is the first time, create new items
    if #pearlItems == 0 then
        for i = 1, 8 do
            pearlItems[i] = Item(pearl, "pearl", pearlTypes[i], pearlPositions[i].x, pearlPositions[i].y, 0, true)
        end
    else
        -- Update existing pearl items
        for i = 1, 8 do
            -- Try different possible property names for the pearl type
            if pearlItems[i].itemType then
                pearlItems[i].itemType = pearlTypes[i]
            elseif pearlItems[i].type then
                pearlItems[i].type = pearlTypes[i]
            elseif pearlItems[i].pearlType then
                pearlItems[i].pearlType = pearlTypes[i]
            end
            
            -- Update position
            pearlItems[i].x = pearlPositions[i].x
            pearlItems[i].y = pearlPositions[i].y
            
            pearlItems[i].carried = false  
            pearlItems[i].pickup = false  
            
            -- Call reset method if it exists
            if pearlItems[i].reset then
                pearlItems[i]:reset()
            end
        end
    end
    
    -- Update individual pearl references
    pearlItem = pearlItems[1]
    pearlItem2 = pearlItems[2]
    pearlItem3 = pearlItems[3]
    pearlItem4 = pearlItems[4]
    pearlItem5 = pearlItems[5]
    pearlItem6 = pearlItems[6]
    pearlItem7 = pearlItems[7]
    pearlItem8 = pearlItems[8]
end
function dailyReset()
    randomizeValues()
    crabAttack = false
    
    -- Reset gather points goals and holds
    for i, point in ipairs(gatherPoints) do
        point.goal = "empty"
        point.hold = "empty"
    end
    
    -- Reset player state
    player.holding = "false"
    player.action = "false"
    player.state = "false"
    player.walk = "false"
    
    -- Reset crab position
    bigCrab.x = 800
    bigCrab.y = 900
    
    -- Reset pickup items
    for i, item in ipairs(pickupItems) do
        item.pickup = false
        item.carried = false
    end
    
    randomizeSpawn()
end