local Menu ={}

function Menu:draw()
    love.graphics.print("Every Night the Crab Attacks", 150, 300, 0, 3, 3)
start:draw()
close:draw()
-- love.graphics.rectangle("line", 100, 150, 100, 50)
-- love.graphics.print("Start Game", 125, 175 )
-- love.graphics.rectangle("line", 250, 150, 100, 50)
-- love.graphics.print("Close Game", 275, 175 )
end

return Menu