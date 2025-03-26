Wall = Entity:extend()

function Wall:new(x, y)
    Wall.super.new(self, x, y, "assets/images/background/tile.png")
    self.width = 10
    self.height = 10
end