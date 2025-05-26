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
    if e.type == "altar" then 
    return self.x + self.width +30 > e.x
    and self.x + 20< e.x + (e.width*60)+100
    and self.y + self.height+40 > e.y
    and self.y +20 < e.y + (e.height*60)
else
    return self.x + self.width +30 > e.x
    and self.x + 20< e.x + (e.width*60)
    and self.y + self.height+40 > e.y
    and self.y +20 < e.y + (e.height*60)
end
end

function Entity:checkbarrier(e)
    -- Get the dimensions
    local tileWidth = e.width * e.scale
    local tileHeight = e.height * e.scale
    
    -- Calculate the center points of both entities
    local centerX1 = self.x + 25
    local centerY1 = self.y + 40
    
    local centerX2 = e.x + tileWidth / 2
    local centerY2 = e.y + tileHeight / 2
    
    -- Calculate the four corners of the diamond for the tile
    local tileTop = {x = centerX2, y = centerY2 - tileHeight / 2 + 35}
    local tileRight = {x = centerX2 + tileWidth / 2, y = centerY2}
    local tileBottom = {x = centerX2, y = centerY2 + tileHeight / 2}
    local tileLeft = {x = centerX2 - tileWidth / 2, y = centerY2}
    
    -- For the player, we'll use a simpler circular collision detection
    -- Calculate distance between centers
    local dx = centerX1 - centerX2
    local dy = centerY1 - centerY2
    local distance = math.sqrt(dx * dx + dy * dy)
    
    -- Calculate the "radius" of the diamond (average of half-width and half-height)
    local diamondRadius = (tileWidth / 2 + tileHeight / 2) / 3
    
    -- Check if the player's center is close enough to the diamond's center
    -- You can adjust the collision radius as needed
    local playerRadius = (self.width + self.height - 10) / 4
    
    return distance < (diamondRadius + playerRadius)
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

function Entity:collectCheck(e)
    if e and self:checkCollision(e) then
        if e.unlock == "shield" then
            playPower()
            self.unlock = "shield"
        end
    activeText = true
    loadedText = table.concat(e.text, "\n")
     e.spawn = false
    end
end

function Entity:resolveBarrier(e)
    if e and self:checkbarrier(e) then
        self.x = self.last.x
        self.y = self.last.y
    end
end



function Entity:draw()
    love.graphics.draw(self.image, self.x, self.y)
end