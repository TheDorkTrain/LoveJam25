require ("example")
require ("spawnTimer")

function love.load()
    Object = require "classic"
    require "player"
    require "ghost"
    require "arm"
    require "button"

    player = Player()
    arm = Arm()
    button = Button()
    listOfArms = {}
    ghosts = {}
    score = 0
    gameTime = 31

    tick = require "tick"
    
    spawnTimer = 0

    tick.delay(function () drawGhost = true end , 2)


end

function love.mousepressed()
    button:mousepressed(1)
end

function gameTimerCount(dt)

    if gameTime > 0 then
        gameTime = gameTime - dt
       timeleft = math.floor(gameTime - dt)
    end
    if gameTime <= 0 then
       timeleft = "GAME OVER"
    end
   
   end

-- function checkCollision(a, b)
--     local a_left = a.x
--     local a_right = a.x + a.width
--     local a_top = a.y
--     local a_bottom = a.y + a.height

--     local b_left = (b.x)/2
--     local b_right = (b.x + b.width+20)/2
--     local b_top = (b.y)/2
--     local b_bottom = (b.y + b.height+20)/2

--     return  a_right > b_left
--     and a_left < b_right
--     and a_bottom > b_top
--     and a_top < b_bottom
-- end
function armCollision(ghost, arm)
    -- Use a circular hitbox for the arm
    local armCenterX = arm.x
    local armCenterY = arm.y
    
    -- Calculate the center of the ghost
    local ghostCenterX = ghost.x + ghost.width/2
    local ghostCenterY = ghost.y + ghost.height/2
    
    -- Calculate distance between centers
    local dx = ghostCenterX - armCenterX
    local dy = ghostCenterY - armCenterY
    local distance = math.sqrt(dx*dx + dy*dy)
    
    -- Define the arm's reach (radius)
    local armRadius = (arm.width * arm.scale * 2) + 50  -- Adjust this based on your arm size
    
    -- Check if ghost is within arm's reach
    return distance < armRadius
end

function love.update(dt)
    gameTimerCount(dt)
    player:update(dt)
    arm:update(dt)
    
    
    if gameTime > 0 then
        SpawnTimerCount(dt)
        for i, ghost in ipairs(ghosts) do
            if armCollision(ghost, arm) then
                if ghost.type == "easy" then
                table.remove(ghosts, i)
                score = score + 1
                elseif ghost.type == "fast" then
                    table.remove(ghosts, i)
                    score = score + 3
                elseif ghost.type == "bomb" then
                    table.remove(ghosts, i)
                    score = score - 5
                elseif ghost.type == "time" then
                    table.remove(ghosts, i)
                    gameTime = gameTime + 10
                elseif ghost.type == "gold" then
                    table.remove(ghosts, i)
                    score = score + 10
            end
        end
            ghost:update(dt)
            if ghost.x < 215 or ghost.x > 800 or ghost.y > 600 or ghost.y <0 then
                table.remove(ghosts, i)
            end
        end
    end
end



function love.draw()
    love.graphics.rectangle("line", 200, 0, 600, 600, 75)
    love.graphics.print( "Ball = 1 Point", 50 , 350)
    love.graphics.print( "Green = 3 Point", 50 , 375)
    love.graphics.print( "Yellow = 10 Points", 50 , 400)
    love.graphics.print( "Red = -5 Points", 50 , 425)
    love.graphics.print( "Blue = Extra Time", 50 , 450)

    love.graphics.print( "Score" , 50, 200)
    love.graphics.print( math.floor(score) , 100, 200)
    love.graphics.print( "Time Left:" , 50, 250)
    love.graphics.print( timeleft , 125, 250)

    button:draw()
    love.graphics.print( "Reset" , 70, 300)

    for i=1, #ghosts do
        ghosts[i]:draw()
    end

    arm:draw()
    player:draw()

    love.graphics.setColor(1, 0, 0, 0.5)
    -- love.graphics.circle("line", arm.x, arm.y, (arm.width * arm.scale * 2) + 50)
    love.graphics.setColor(1, 1, 1, 1)

    for i,v in ipairs(listOfArms) do
        v:draw()
    end

end