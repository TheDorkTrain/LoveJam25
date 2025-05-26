local Intro ={}

function Intro:draw()
    -- love.graphics.print("Every Night the Crab Attacks", 150, 300, 0, 3, 3)
    love.graphics.print("Move", 50, 50 )
    love.graphics.draw(moveButt, 50, 100, 0, 2, 2)
    love.graphics.print("Action", 50, 225 )
    love.graphics.draw(actionButt, 50, 275, 0, 2, 2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 250, 75, 500, 350)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(smallF)
    love.graphics.print("\"I come from the island of Shield", 275, 140 )
    love.graphics.print("In battle I never yield", 275, 180 )
    love.graphics.print("My boat crashed in a storm", 275, 220 )
    love.graphics.print("Giant Crab thinks I'm a worm", 275, 260 )
    love.graphics.print("And I have no shield to wield\"", 275, 300 )
    love.graphics.print("- Shield King", 275, 340 )
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(mediumF)
    press:draw()
end

return Intro