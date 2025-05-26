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


    if show == "red" then
    if hiddenPoint1.goal == "empty" then
        love.graphics.draw(promptSheet, basicFrames[math.floor(currentFrame1)], 1460, 1313, 0, 2, 2)
    elseif hiddenPoint1.goal == value4 then
        love.graphics.draw(promptSheet, yesFrames[math.floor(currentFrame1)], 1460, 1313, 0, 2, 2)

    else
        love.graphics.draw(promptSheet, noFrames[math.floor(currentFrame1)], 1460, 1313, 0, 2, 2)
    end
end

        if show == "grn" then
    if hiddenPoint2.goal == "empty" then
        love.graphics.draw(promptSheet, basicFrames[math.floor(currentFrame1)], -64, 1510, 0, 2, 2)
    elseif hiddenPoint2.goal == value5 then
        love.graphics.draw(promptSheet, yesFrames[math.floor(currentFrame1)], -64, 1510, 0, 2, 2)
    else
        love.graphics.draw(promptSheet, noFrames[math.floor(currentFrame1)], -64, 1510, 0, 2, 2)
    end
end

    if show == "blu" then
    if hiddenPoint3.goal == "empty" then
        love.graphics.draw(promptSheet, basicFrames[math.floor(currentFrame1)], -1283, 2008, 0, 2, 2)
    elseif hiddenPoint3.goal == value6 then
        love.graphics.draw(promptSheet, yesFrames[math.floor(currentFrame1)], -1283, 2008, 0, 2, 2)
    else
        love.graphics.draw(promptSheet, noFrames[math.floor(currentFrame1)], -1283, 2008, 0, 2, 2)
    end
end

    if day > 1 then
        love.graphics.draw(promptSheet, logFrames[math.floor(currentFrame1)], -600, 2850, 0, 2, 2)
    end
end

return Prompts