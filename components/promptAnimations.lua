function promptAnimations()

    promptSheet = love.graphics.newImage("assets/images/props/prompts.png")

    basicFrames = {}
    noFrames = {}
    yesFrames ={}
    logFrames ={}

    currentFrame1 = 1
   
    local frame_width = 59
    local frame_height = 62

    for i=0,4 do
    table.insert(basicFrames, love.graphics.newQuad(i* frame_width, 0, frame_width, frame_height, promptSheet:getWidth(), promptSheet:getHeight()))
    table.insert(noFrames, love.graphics.newQuad(i* frame_width, 64, frame_width, frame_height, promptSheet:getWidth(), promptSheet:getHeight()))
    table.insert(yesFrames, love.graphics.newQuad(i* frame_width, 128, frame_width, frame_height, promptSheet:getWidth(), promptSheet:getHeight()))
    table.insert(logFrames, love.graphics.newQuad(i* frame_width, 192, frame_width, frame_height, promptSheet:getWidth(), promptSheet:getHeight()))

end

end

function runPromptAnimation(dt)

    currentFrame1 = currentFrame1 + 10 + dt
    if currentFrame1 >= 4 then
        currentFrame1 = 1
    end

end

