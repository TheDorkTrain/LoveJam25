require ("assets")
 location = "menu"

function love.load()

    Map:load()
    randomizeValues()
    randomizeSpawn()

 
    player = Player(-454, 2793)
    -- tile = Tile(200, 100)

    start = Button("start", 100, 450, 275, 50, "Start Game")
    close = Button("close", 100, 525, 275, 50, "Close Game")
    press = Button("press", 300, 475, 350, 50, "Click to Continue")
    winPress = Button("press", 125, 450, 250, 50, "Play Again")
    nextButt = Button("debug1", 575, 500, 125, 50, "Next")
    prevButt = Button("debug2", 25, 500, 125, 50, "Prev")

    gatherPoints = {standRadius, altar1, altar2, altar3, hiddenPoint1, hiddenPoint2, hiddenPoint3, dock}

    pickupItems = {log1, log2, log3, log4, pearlItem, pearlItem2, pearlItem3, pearlItem4, pearlItem5, pearlItem6, pearlItem7, pearlItem8}
pickupNames = {"log1", "log2", "log3", "log4", "pearlItem", "pearlItem2", "pearlItem3", "pearlItem4", "pearlItem5", "pearlItem6", "pearlItem7", "pearlItem8"}

    collectionItems = {asteroidCrash, bottle1, bottle2, bottle3, bottle4, bottle5}

    trees = {tree1, tree2, tree3, tree4} 

    score = 0
    gameTime = 31
    crabAttack = false

    tick = require "tick"
    
    spawnTimer = 0

    oceanOffset = 0
oceanSpeed = 50 
creditsOffset = love.graphics.getHeight() 
creditsSpeed = 20
end


function love.mousepressed(x, y, button)
    if location == "menu" then
        if start:mousepressed(x, y, button) then
            location = "intro"
        end
        if close:mousepressed(x, y, button) then
            love.event.quit()
        end
    end
    if location == "intro" then
        if press:mousepressed(x, y, button) then
            location = "game"
        end
    end
    if location == "gameover" then
        if press:mousepressed(x, y, button) then
            dayTimer = 5
            phase = "Day"
            dailyReset()
            location = "menu"
        end
    end
    if location == "ending" then
        if winPress:mousepressed(x, y, button) then
            location = "menu"
        end
    end
    if debugMode == true then
        if nextButt:mousepressed(x, y, button) and debugMenu < 4 then
            debugMenu = debugMenu + 1
        elseif prevButt:mousepressed(x,y, button) and debugMenu > 1 then
            debugMenu = debugMenu - 1
        end
    end

end

function love.keyreleased(key)
    player:keyreleased(key)
end

animations()
promptAnimations()

function love.update(dt)
     if love.keyboard.isDown("p") then
        debugMode = true
     else
        debugMode = false
     end

    soundtrack()
    Map:update(dt)
    runAnimation(dt)
    if location == "game" then
    DayTimerCount(dt)
    end
    runPromptAnimation(dt)
    player:update(dt)
    player:resolveCollision(stand)
    player:resolveCollision(altar)


    for i, tree in ipairs(trees) do
        if tree.destroy == false then
            player:resolveCollision(tree)
        elseif tree.destroy == true and pickupItems[i] then
            pickupItems[i].spawn = true  
        end
    end

    
    for i, item in ipairs(collectionItems) do
        if item.spawn == true then
            player:collectCheck(item)
        end
    end


    Tile:update(dt)
    pearlItem:update(dt)

    if crabAttack == true then
    bigCrab:update(dt)
    end

    for i, item in ipairs(pickupItems) do
        item:update(dt)
    end

    if location == "dayChange" then
        dayChange(dt)
    end

    if location == "gameover" then
        crabAttack = false
        dailyReset()
    end

    if dock.total == 3 then
        location = "ending"
    end

    if location == "ending" then
        oceanOffset = oceanOffset - oceanSpeed * dt
        local oceanWidth = ocean:getWidth() * 0.5
        if oceanOffset <= -oceanWidth then
            oceanOffset = 0
        end
        
        creditsOffset = creditsOffset - creditsSpeed * dt
        
        local totalCreditsHeight = #credits * 40 
        if creditsOffset < -totalCreditsHeight then
            creditsOffset = love.graphics.getHeight()
        end
    end

    local teleportTimer = 0

    if value4 == hiddenPoint1.goal and value5 == hiddenPoint2.goal and value6 == hiddenPoint3.goal and player.unlock == "no" then
            playTeleport()
            asteroidCrash.spawn = true
            
    end

    if love.keyboard.isDown("space") then
        activeText = false
    end


end


function love.draw()

    if location == "gameover" then
        love.graphics.setFont(largeF)
        love.graphics.print("Game Over", 100, 300, 0, 2, 2)
        love.graphics.setFont(mediumF)
        press:draw()
    end

    if location == "ending" then
        -- Draw scrolling ocean background
        local oceanWidth = ocean:getWidth() * 0.5
        love.graphics.draw(ocean, oceanOffset, 0, 0, .5, .5)
        love.graphics.draw(ocean, oceanOffset + oceanWidth, 0, 0, .5, .5)
        
        -- Draw character animation
        love.graphics.draw(escapeSheet, escapeFrames[math.floor(currentFrame)], 100, 150, 0)
        
        -- Draw scrolling credits
        love.graphics.setColor(1, 1, 1, 1) -- White text
        local font = mediumF
        local screenWidth = love.graphics.getWidth()
        
        for i, line in ipairs(credits) do
            local y = creditsOffset + (i - 1) * 40 -- 40 pixels between lines
            
            -- Only draw if the line is visible on screen
            if y > -30 and y < love.graphics.getHeight() + 30 then
                local textWidth = font:getWidth(line)
                local x = 375 -- Center the text
                love.graphics.setFont(debugF)
                
                -- Make title lines bigger
                if line == "GAME TITLE" or (line ~= "" and i <= 3) then
                    love.graphics.print(line, x, y, 0, 2, 2) -- Bigger scale for title
                else
                    love.graphics.print(line, x, y)
                end
            end
        end
    end

    if location == "menu" then
	Menu:draw()
end
if location == "intro" then
    Intro:draw()
end

if location == "dayChange" then
    if phase == "Night" and value1 == altar1.goal and value2 == altar2.goal and value3 == altar3.goal then
        love.graphics.setFont(largeF)
        love.graphics.print( "Day " .. day , 325, 300)
        love.graphics.print( phase , 325, 250)
        love.graphics.setFont(smallF)
        love.graphics.print( "The Crab is pleased with your offering" , 175, 350)
    elseif phase =="Day" then
        love.graphics.setFont(largeF)
    love.graphics.print( "Day " .. day , 325, 300)
    love.graphics.print( phase , 325, 300)
    else
        love.graphics.setFont(largeF)
        love.graphics.print( "Day " .. day , 325, 200)
        love.graphics.print( phase , 325, 250)
        love.graphics.setFont(smallF)
        love.graphics.print( "The Crab is unhappy with your offering" , 175, 325)
    end
end

 if location == "game" then
-- love.graphics.setColor(0.3, 0.2, 0.5)


love.graphics.setColor(shine)  -- Semi-transparent red


    
love.graphics.translate(-player.x + 400, -player.y + 300)

Map:draw()
Prompts:draw()

stand:draw()
altar:draw()

for i, item in ipairs(collectionItems) do
if item.spawn == true then
    item:draw()
end
end

if show == "red" then
 hiddenstand1:draw()
 hiddenPoint1:draw()
end

if show == "grn" then
    hiddenstand2:draw()
    hiddenPoint2:draw()
   end

   if show == "blu" then
    hiddenstand3:draw()
    hiddenPoint3:draw()
   end

for i, tree in ipairs(trees) do
    if tree.destroy == false then
    tree:draw()
    end
end

if crabAttack == true then
bigCrab:draw()
end

if player.direction2 == "up" then
    for i, item in ipairs(pickupItems) do
        if item.spawn == true then
        item:draw()
    end
    end
    player:draw()
end

if player.direction2 == "down" then
    player:draw()
    for i, item in ipairs(pickupItems) do
        if item.spawn == true then
        item:draw()
        end
    end
end

for i, point in ipairs(gatherPoints) do
    point:draw()
end

if day > 1 then
    love.graphics.print( dock.total.."/3" , -575, 2825)
    bottle4.spawn = true
end

if day > 10 then
    bottle5.spawn = true
end
-- love.graphics.setColor(1, 0, 0, 1)
-- love.graphics.rectangle("fill", standRadius.x, standRadius.y, standRadius.width+60, standRadius.height+60)
-- love.graphics.setColor(1, 1, 1)


love.graphics.translate(player.x - 400, player.y - 300)

-- Print Scoreboard
if phase == "Day" then
love.graphics.setColor(0, 0, 0)
love.graphics.circle("fill", 0, 0, 210, 210)
love.graphics.setColor(1, 1, 1)
love.graphics.circle("fill", 0, 0, 200, 200)
love.graphics.setColor(0, 0, 0)
love.graphics.setFont(mediumF)
love.graphics.print( "Day " , 50, 10)
love.graphics.print( day , 75, 60)
love.graphics.line(5,5, 5, 175)
love.graphics.setColor(1, .984, 0)
love.graphics.circle("fill", 5, dayTimer, 10, 10)
end

if phase == "Night" then
love.graphics.setColor(0, 0, 0, .5)
love.graphics.circle("fill", 0, 0, 210, 210)
love.graphics.setColor(1, 1, 1)
love.graphics.circle("fill", 0, 0, 200, 200)
love.graphics.setColor(0, 0, 0)
love.graphics.setFont(mediumF)
love.graphics.print( "Night ", 50, 10)
love.graphics.print( day , 75, 60)
love.graphics.line(5,5, 5, 175)
love.graphics.setColor(1, 1, 1)
love.graphics.draw(crabIcon, 0, dayTimer, 0, .05, .05)

end

if activeText then
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", 190, 140, 525, 325)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 200, 150, 500, 300)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(smallF)
    love.graphics.print(loadedText, 210, 160)
    love.graphics.print("Press Action to Close", 250, 400)
end

 if debugMode == true then
Debug:draw()
 end

love.graphics.setColor(1, 0, 0, 0.5)
-- love.graphics.circle("line", arm.x, arm.y, (arm.width * arm.scale * 2) + 50)
love.graphics.setColor(1, 1, 1, 1)
end
end