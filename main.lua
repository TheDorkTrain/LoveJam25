require ("assets")
 location = "menu"

function love.load()

    map = Map
    map:load()

    items = {pearlItem, pearlItem2, pearlItem3 }
    player = Player(-71, 2673)
    -- tile = Tile(200, 100)

    start = Button("start", 300, 350, 100, 50, "Start Game")
    close = Button("close", 450, 350, 100, 50, "Close Game")
    press = Button("press", 350, 450, 125, 50, "Click to Continue")

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
end

function love.keyreleased(key)
    player:keyreleased(key)
end

animations()

function gameTimerCount(dt)

    if gameTime > 0 then
        gameTime = gameTime - dt
       timeleft = math.floor(gameTime - dt)
    end
    if gameTime <= 0 then
       timeleft = "GAME OVER"
    end
   
   end

function love.update(dt)
    Map:update(dt)
    gameTimerCount(dt)
    runAnimation(dt)
    player:update(dt)
    player:resolveCollision(stand)
    Tile:update(dt)
    pearlItem:update(dt)

    for i, item in ipairs(items) do
        item:update(dt)
    end

    
end


function love.draw()

    if location == "menu" then
	Menu:draw()
end
if location == "intro" then
    Intro:draw()
end
 if location == "game" then
-- love.graphics.setColor(0.3, 0.2, 0.5)


    love.graphics.setColor(shine)  -- Semi-transparent red

love.graphics.translate(-player.x + 400, -player.y + 300)

Map:draw()

if show == "red" then
    altar:draw()
end

if player.direction2 == "up" then
    for i, item in ipairs(items) do
        item:draw()
    end
    player:draw()
end

if player.direction2 == "down" then
    player:draw()
    for i, item in ipairs(items) do
        item:draw()
    end
end


-- love.graphics.setColor(1, 0, 0, 1)
-- love.graphics.rectangle("fill", standRadius.x, standRadius.y, standRadius.width+60, standRadius.height+60)
-- love.graphics.setColor(1, 1, 1)

stand:draw()


love.graphics.translate(player.x - 400, player.y - 300)

-- Print Scoreboard
-- love.graphics.setColor(1, 1, 1)
-- love.graphics.rectangle("fill", 25, 150, 200, 400)
-- love.graphics.setColor(1, .5, 0)
-- love.graphics.print( "Player X" , 50, 200)
-- love.graphics.print( player.x , 100, 200)
-- love.graphics.print( "Player Y:" , 50, 250)
-- love.graphics.print( player.y, 125, 250)
-- love.graphics.print( "Stand Width" , 50, 400)
-- love.graphics.print( standRadius.width , 100, 450)
-- love.graphics.print( "Stand Height:" , 50, 500)
-- love.graphics.print( standRadius.height, 125, 550)








-- love.graphics.print( "Check1 ", 50 , 350)
-- love.graphics.print( check1(), 125 , 350)
-- love.graphics.print( "Check 2 ", 50 , 400)
-- love.graphics.print( check2() , 125 , 400)
-- love.graphics.print( "Check 3 ", 50 , 450)
-- love.graphics.print( check3() , 125 , 450)
-- love.graphics.print( "ICheck 4: ", 50 , 500)
-- love.graphics.print( check4() , 125 , 500)


love.graphics.setColor(1, 0, 0, 0.5)
-- love.graphics.circle("line", arm.x, arm.y, (arm.width * arm.scale * 2) + 50)
love.graphics.setColor(1, 1, 1, 1)
end
end