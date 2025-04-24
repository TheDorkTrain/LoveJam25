function animations()

    playerSheet = love.graphics.newImage("assets/images/character/playersheet.png")

    idle = love.graphics.newImage("assets/images/character/idle.png")
    walk = love.graphics.newImage("assets/images/character/walk.png")

    idleFrames = {}
    walkFrames = {}
    carryIdleFrames ={}
    carryWalkFrames ={}

    upIdleFrames = {}
    upWalkFrames = {}
    upCarryIdleFrames = {}
    upCarryWalkFrames = {}

    throwFrames = {}
    waveFrames = {}

    currentFrame = 1
   
    local frame_width = 59
    local frame_height = 62

    for i=0,4 do
    table.insert(idleFrames, love.graphics.newQuad(i* frame_width, 0, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert(waveFrames, love.graphics.newQuad(i* frame_width, 64, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert(walkFrames, love.graphics.newQuad(i* frame_width, 130, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert(throwFrames, love.graphics.newQuad(i* frame_width, 192, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert(carryIdleFrames, love.graphics.newQuad(i* frame_width, 255, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert(carryWalkFrames, love.graphics.newQuad(i* frame_width, 320, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert(upIdleFrames, love.graphics.newQuad(i* frame_width, 385, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert(upWalkFrames, love.graphics.newQuad(i* frame_width, 450, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert( upCarryWalkFrames, love.graphics.newQuad(i* frame_width, 515, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
    table.insert( upCarryIdleFrames, love.graphics.newQuad(i* frame_width, 580, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
end

end

function runAnimation(dt)

    currentFrame = currentFrame + 10 * dt
    if currentFrame >= 4 then
        currentFrame = 1
    end

end

