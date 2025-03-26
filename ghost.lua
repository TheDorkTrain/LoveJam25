Ghost = Object:extend()


function Ghost:new( image, x, y, rotation, scale, speed, yspeed, ghostType)
    self.image = image
    self.x = x
    self.y = y
    self.radius = 1
    self.scale = scale  
    self.speed = speed
    self.yspeed = yspeed
    self.type = ghostType
    self.width = 10
    self.height = 10
end

function Ghost:update(dt)
    self.x = self.x + self.speed * dt
    self.y = self.y + self.yspeed * dt
end

function Ghost:draw()
    if self.type == "fast" then
        love.graphics.setColor(0, 255/255, 0, 1)
    elseif self.type == "bomb" then
        love.graphics.setColor(255/255, 0, 0, 0.8)
    elseif self.type == "time" then
        love.graphics.setColor(0, 0, 255/255, 0.8)
    elseif self.type == "gold" then
        love.graphics.setColor(255/255, 249/255, 0, 1)
    end
    love.graphics.draw(self.image, self.x, self.y, self.rotation, self.scale, self.scale)
    love.graphics.setColor(255, 255, 255)
end