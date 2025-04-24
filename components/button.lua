Button = Object:extend()

function Button:new(name, x, y, width, height, text)
    self.name = name
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.text = text
end

function Button:mousepressed(x, y, button)
    if button == 1 then -- 1 is left mouse button in LÖVE2D
        if x > self.x and x < self.x + self.width and 
           y > self.y and y < self.y + self.height then 
            print("Button " .. self.name .. " was clicked!") -- debug print
            return true -- Return true to indicate the button was clicked
        end
    end
    return false -- Button was not clicked
end

function Button:draw()
    love.graphics.setColor(1, 1, 1)
        love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
        love.graphics.print(self.text, self.x+15, self.y+15)
end