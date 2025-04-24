Tile = Entity:extend()

function Tile:new(x, y, image_path)
    Tile.super.new(self, x, y, image_path)
    self.width = 10
    self.height = 10
    self.scale =  2
end


function Tile:draw()
    -- Optional: rotate the tile to look more isometric
    love.graphics.draw(self.image, self.x, self.y, 0, self.scale, self.scale)
end