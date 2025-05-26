Collect = Object:extend()

function Collect:new(imagepath, x, y, z, text, unlock, spawn )
    if z ==nil then
        z = 0
    end
    zy = z * 2
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(imagepath)
    self.width = (self.image:getWidth() * .01 + z )
    self.height = (self.image:getHeight() * .01 + z)
    self.unlock = unlock
    self.spawn = spawn
    self.text = text

end

function Collect:update(dt)
    if self.carried then
        if player.direction2 == "up" then
        self.x = player.x
        self.y = player.y + 5
        end
        if player.direction2 == "down" then
            self.x = player.x +5
        self.y = player.y + 5
        end
    end
end

function Collect:draw()
if self.spawn == true then
    love.graphics.draw(self.image, self.x, self.y, self.width, self.height)
end
-- love.graphics.setColor(0.329, 0.847, 1, 1) 
--     love.graphics.rectangle("fill", self.x-75, self.y+15, self.image:getWidth(), self.image:getHeight())

end