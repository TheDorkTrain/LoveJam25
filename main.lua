require ("assets")
 location = "menu"

function love.load()

    Map:load()
    randomizeValues()
    randomizeSpawn()

    -- player = Player(300, 1873)
    player = Player(-454, 2793)
    -- tile = Tile(200, 100)

    start = Button("start", 300, 350, 100, 50, "Start Game")
    close = Button("close", 450, 350, 100, 50, "Close Game")
    press = Button("press", 350, 450, 125, 50, "Click to Continue")

    gatherPoints = {standRadius, altar1, altar2, altar3}

    score = 0
    gameTime = 31

    tick = require "tick"
    
    spawnTimer = 0

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
            location = "menu"
        end
    end
end

function love.keyreleased(key)
    player:keyreleased(key)
end

animations()
promptAnimations()

function love.update(dt)
    soundtrack()
    Map:update(dt)
    runAnimation(dt)
    DayTimerCount(dt)
    runPromptAnimation(dt)
    player:update(dt)
    player:resolveCollision(stand)
    player:resolveCollision(altar)
    Tile:update(dt)
    pearlItem:update(dt)

    for i, item in ipairs(pearlItems) do
        item:update(dt)
    end

    if location == "dayChange" then
        dayChange(dt)
    end


    
end


function love.draw()

    if location == "gameover" then
        love.graphics.print("Game Over", 150, 300, 0, 3, 3)
        press:draw()
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
        love.graphics.print( "The Crab is pleased with your offering" , 175, 325)
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

if show == "red" then
    altar:draw()
end

if player.direction2 == "up" then
    for i, item in ipairs(pearlItems) do
        item:draw()
    end
    player:draw()
end

if player.direction2 == "down" then
    player:draw()
    for i, item in ipairs(pearlItems) do
        item:draw()
    end
end

for i, point in ipairs(gatherPoints) do
    point:draw()
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

-- love.graphics.setFont(tinyF)
-- love.graphics.rectangle("fill", 25, 150, 200, 400)
-- love.graphics.setColor(1, .5, 0)
-- love.graphics.print( "Player X" , 50, 200)
-- love.graphics.print( player.x , 100, 200)
-- love.graphics.print( "Player Y:" , 50, 250)
-- love.graphics.print( player.y, 125, 250)
-- love.graphics.print( "Altar 1" , 50, 300)
-- love.graphics.print( altar1.goal , 100, 300)
-- love.graphics.print( "Value 1" , 50, 325)
-- love.graphics.print( value1, 100, 325)
-- love.graphics.print( "Value 2" , 50, 350)
-- love.graphics.print( value2, 100, 350)
-- love.graphics.print( "Value 3" , 50, 375)
-- love.graphics.print( value3, 100, 375)
-- love.graphics.print( " Answer 1 " , 50, 400)
-- love.graphics.print( altar1.answer, 100, 400)
-- love.graphics.print( " Answer 2 " , 50, 425)
-- love.graphics.print( altar2.answer, 100, 425)
-- love.graphics.print( " Answer 3 " , 50, 450)
-- love.graphics.print( altar3.answer, 100, 450)


love.graphics.setColor(1, 0, 0, 0.5)
-- love.graphics.circle("line", arm.x, arm.y, (arm.width * arm.scale * 2) + 50)
love.graphics.setColor(1, 1, 1, 1)
end
end