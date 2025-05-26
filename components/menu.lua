local Menu ={}


function Menu:draw()
    love.graphics.draw(titleScreen, 0, 0, 0, .29, .29)
    love.graphics.setFont(mediumF)
    love.graphics.setColor(1, .5, 0)
    love.graphics.print("Every Night the Crab Attacks", 10, 400)
    love.graphics.setColor(1, 1, 1)
start:draw()
close:draw()
-- love.graphics.rectangle("line", 100, 150, 100, 50)
-- love.graphics.print("Start Game", 125, 175 )
-- love.graphics.rectangle("line", 250, 150, 100, 50)
-- love.graphics.print("Close Game", 275, 175 )
end

return Menu