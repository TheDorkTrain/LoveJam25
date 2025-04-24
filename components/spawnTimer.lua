spawnTimer = 0

ball = love.graphics.newImage( "assets/images/props/ball.png")

function SpawnTimerCount(dt)

 if spawnTimer <= 5 then
    spawnTimer = spawnTimer + dt
 end
 if spawnTimer >= .5 then
    newGhost(dt)
    spawnTimer = 0
 end

end

function newGhost(dt)
    regularSpeed = {40, -40}
    fastSpeed = {80, -80}

    slow = regularSpeed[love.math.random( 1,2 )]
    slow2 = regularSpeed[love.math.random( 1,2 )]
    fast = fastSpeed[love.math.random( 1,2 )]
    fast2 = fastSpeed[love.math.random( 1,2 )]

    xRanger = math.random(214, 2504)
    yRanger = math.random(195, 2480)
    ghostType = math.random(1, 125)
    local newGhost = nil
    
    if ghostType <= 80 then
        newGhost = Ghost(ball, xRanger, yRanger, 1, 0.05, slow, slow2, "easy")
    elseif ghostType <= 100 and ghostType >= 81 then
        newGhost = Ghost(ball, xRanger, yRanger, 1, 0.05, fast, fast2, "fast")
    elseif ghostType <= 120 and ghostType >= 101 then
        newGhost = Ghost(ball, xRanger, yRanger, 1, 0.05, fast, fast2, "bomb")
    elseif ghostType <= 125 and ghostType >= 121 then
        newGhost = Ghost(ball, xRanger, yRanger, 1, 0.05, fast, fast2, "time")
        
    end
    
    table.insert(ghosts, newGhost)
end
