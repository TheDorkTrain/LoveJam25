Tile = Entity:extend()

function Tile:new(x, y, image_path, walk, transform)
    Tile.super.new(self, x, y, image_path)
    -- self.width = 10
    -- self.height = 10
    self.scale =  2
    if show == transform then
        self.walk = true
    else
    self.walk = walk
    end
end

function Tile:drawRotatedRectangle(x, y, width, height, angle)
    local cosa, sina = math.cos(angle), math.sin(angle)
    
    -- Calculate the four corner points
    local px1 = x
    local py1 = y
    
    local px2 = x + width * cosa
    local py2 = y + width * sina
    
    local px3 = x + width * cosa - height * sina
    local py3 = y + width * sina + height * cosa
    
    local px4 = x - height * sina
    local py4 = y + height * cosa
    
    -- Draw the rectangle
    love.graphics.polygon("fill", px1, py1, px2, py2, px3, py3, px4, py4)
end


function Tile:draw()
    -- Optional: rotate the tile to look more isometric
    if show == transform then
    love.graphics.draw("assets/images/background/plank.png", self.x, self.y, 0, self.scale, self.scale)
end

    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
    
    -- if not self.walk then 
    --     love.graphics.setColor(1, 0, 0, 0.5) -- Red with transparency
        
    --     -- Draw a diamond shape that matches the isometric tile
    --     local tileWidth = self.width * self.scale
    --     local tileHeight = self.height * self.scale
        
    --     -- Define the four corners of the diamond
    --     local centerX = self.x + tileWidth / 2
    --     local centerY = self.y + tileHeight / 2
        
    --     -- Diamond points - adjusted to match the isometric tile shape
    --     local points = {
    --         centerX, centerY - tileHeight / 2 + 35, -- top
    --         centerX + tileWidth / 2, centerY,  -- right
    --         centerX, centerY + tileHeight / 2, -- bottom
    --         centerX - tileWidth / 2, centerY   -- left
    --     }
        
    --     love.graphics.polygon("fill", points)
    --     love.graphics.setColor(1, 1, 1, 1)  -- Reset color
    -- end
end