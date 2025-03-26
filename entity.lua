Entity = Object:extend()

function Entity:new(x, y, image_path)
    self.x = x 
    self.y = y 
    self.image = love.graphics.newImage(image_path)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    self.last = {}
    self.last.x = self.x
    self.last.y = self.y
end

function Entity:checkCollision(e)
    return self.x + self.width +50 > e.x
    and self.x < e.x + e.width +50
    and self.y + self.height+60 > e.y
    and self.y < e.y + e.height +50
end


function Entity:update(dt)
    self.last.x = self.x
    self.last.y = self.y
end

function Entity:resolveCollision(e)
    if self:checkCollision(e) then
        self.x = self.last.x
        self.y = self.last.y
    end
end


function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y)
end