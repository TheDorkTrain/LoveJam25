function animations()

    playerSheet = love.graphics.newImage("assets/images/character/playersheet.png")
    shieldSheet = love.graphics.newImage("assets/images/character/shieldSheet.png")

    activeSheet = playerSheet 

    escapeSheet = love.graphics.newImage("assets/images/character/escape.png")

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

    escapeFrames = {}

    currentFrame = 1
   
    local frame_width = 59
    local frame_height = 62

    local big_width = 1024/4
    local big_height = 1024/4

    for i=0,4 do
    table.insert(escapeFrames, love.graphics.newQuad(i* big_width, 0, big_width, big_height, escapeSheet:getWidth()/4, escapeSheet:getHeight()/4))
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


-- idleShieldFrames = {}
-- walkShieldFrames = {}
-- carryIdleShieldFrames ={}
-- carryWalkShieldFrames ={}

-- upIdleShieldFrames = {}
-- upWalkShieldFrames = {}
-- upCarryIdleShieldFrames = {}
-- upCarryWalkShieldFrames = {}

-- throwShieldFrames = {}
-- waveShieldFrames = {}

-- for i=0,4 do
-- table.insert(idleShieldFrames, love.graphics.newQuad(i* frame_width, 0, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert(waveShieldFrames, love.graphics.newQuad(i* frame_width, 64, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert(walkShieldFrames, love.graphics.newQuad(i* frame_width, 130, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert(throwShieldFrames, love.graphics.newQuad(i* frame_width, 192, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert(carryIdleShieldFrames, love.graphics.newQuad(i* frame_width, 255, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert(carryWalkShieldFrames, love.graphics.newQuad(i* frame_width, 320, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert(upIdleShieldFrames, love.graphics.newQuad(i* frame_width, 385, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert(upWalkShieldFrames, love.graphics.newQuad(i* frame_width, 450, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert( upCarryWalkShieldFrames, love.graphics.newQuad(i* frame_width, 515, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- table.insert( upCarryIdleShieldFrames, love.graphics.newQuad(i* frame_width, 580, frame_width, frame_height, playerSheet:getWidth(), playerSheet:getHeight()))
-- end

end

function runAnimation(dt)

    currentFrame = currentFrame + 10 * dt
    if currentFrame >= 4 then
        currentFrame = 1
    end

end

