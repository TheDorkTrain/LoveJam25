function animations()

    idle = love.graphics.newImage("assets/images/character/idle.png")
    walk = love.graphics.newImage("assets/images/character/walk.png")

    idleFrames = {}
    walkFrames = {}
    currentFrame = 1
   
    local frame_width = 62
    local frame_height = 62

    for i=0,4 do
    table.insert(idleFrames, love.graphics.newQuad(i* frame_width,0, frame_width, frame_height, idle:getWidth(), idle:getHeight()))
    table.insert(walkFrames, love.graphics.newQuad(i* frame_width,0, frame_width, frame_height, walk:getWidth(), walk:getHeight()))
    end

end

function runAnimation(dt)

    currentFrame = currentFrame + 10 * dt
    if currentFrame >= 4 then
        currentFrame = 1
    end

end

