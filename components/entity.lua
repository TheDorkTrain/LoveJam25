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
    return self.x + self.width +30 > e.x
    and self.x + 20< e.x + (e.width*60)
    and self.y + self.height+40 > e.y
    and self.y +20 < e.y + (e.height*60)
end


function Entity:update(dt)
    if not self.last then
        self.last = {
            x = self.x,
            y = self.y
        }
    end
    
    self.last.x = self.x
    self.last.y = self.y
end

function Entity:resolveCollision(e)
    if e and self:checkCollision(e) then
        self.x = self.last.x
        self.y = self.last.y
    end
end


function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y)
end