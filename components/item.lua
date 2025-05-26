Item = Object:extend()

function Item:new(imagepath, name, type, x, y, z, spawn)
    if z ==nil then
        z = 0
    end
    zy = z * 2
    self.x = x
    self.y = y
    self.image = love.graphics.newImage(imagepath)
    self.type = type
    self.width = (self.image:getWidth() * .01 + z )
    self.height = (self.image:getHeight() * .01 + z)
    self.pickup = false
    self.carried = false
    self.name = name
    self.destroy = false
    self.spawn = spawn

end

function Item:update(dt)
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


function Item:draw()
    -- love.graphics.rectangle("fill",  self.x, self.y, self.width*60 , self.height*60) 

    if show == "red" or "blu" or "grn"  then
        if self.type == "redPrl" then
            love.graphics.draw(self.image, self.x, self.y, self.scale, self.width, self.height)
            end
            if self.type == "grnPrl" then
            love.graphics.draw(self.image, self.x, self.y, self.scale, self.width, self.height)
            end
            if self.type == "bluPrl" then
            love.graphics.draw(self.image, self.x, self.y, self.scale, self.width, self.height)
            end
        end

if show == "none" then 
if self.type == "redPrl" then
    love.graphics.setColor(1, 0.639, 0.329, 1) 
love.graphics.draw(self.image, self.x, self.y, self.scale, self.width, self.height)
love.graphics.setColor(shine)  
end
if self.type == "grnPrl" then
    love.graphics.setColor(0.329, 1, 0.557, 1) 
love.graphics.draw(self.image, self.x, self.y, self.scale, self.width, self.height)
love.graphics.setColor(shine)  
end
if self.type == "bluPrl" then
    love.graphics.setColor(0.329, 0.847, 1, 1) 
love.graphics.draw(self.image, self.x, self.y, self.scale, self.width, self.height)
love.graphics.setColor(shine)  
end
end



if self.type == "stand" or self.type == "tree" then
    love.graphics.draw(self.image, self.x, self.y, self.scale, self.width, self.height)
end

if self.type == "log" then
    love.graphics.draw(self.image, self.x, self.y, self.scale, self.width/2, self.height/2)
end

if self.type == "altar" then
    love.graphics.draw(self.image, self.x, self.y, self.scale, self.width/2, self.height)
end

end