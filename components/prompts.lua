local Prompts = {}


function Prompts:draw()
    if altar1.goal == "empty" then
        love.graphics.draw(promptSheet, basicFrames[math.floor(currentFrame1)], 700, 900, 0, 2, 2)
    elseif altar1.goal == value1 then
        love.graphics.draw(promptSheet, yesFrames[math.floor(currentFrame1)], 700, 900, 0, 2, 2)

    else
        love.graphics.draw(promptSheet, noFrames[math.floor(currentFrame1)], 700, 900, 0, 2, 2)
    end

    if altar2.goal == "empty" then
        love.graphics.draw(promptSheet, basicFrames[math.floor(currentFrame1)], 800, 900, 0, 2, 2)
    elseif altar2.goal == value2 then
        love.graphics.draw(promptSheet, yesFrames[math.floor(currentFrame1)], 800, 900, 0, 2, 2)
    else
        love.graphics.draw(promptSheet, noFrames[math.floor(currentFrame1)], 800, 900, 0, 2, 2)
    end

    if altar3.goal == "empty" then
        love.graphics.draw(promptSheet, basicFrames[math.floor(currentFrame1)], 900, 900, 0, 2, 2)
    elseif altar3.goal == value3 then
        love.graphics.draw(promptSheet, yesFrames[math.floor(currentFrame1)], 900, 900, 0, 2, 2)
    else
        love.graphics.draw(promptSheet, noFrames[math.floor(currentFrame1)], 900, 900, 0, 2, 2)
    end
end

return Prompts