Button = Object:extend()

function Button:new()
end

function Button:mousepressed(button)
    if button == 1 then
        score = 0
        gameTime = 31
        player.x = 450
        player.y = 250
        arm.x= 485
        arm.y = 280
    end
end

function Button:draw()
love.graphics.rectangle("line", 50, 300, 75, 20 )
end