Arm = Object:extend()

function Arm:new(x, y, r, ox, oy)
    self.image = love.graphics.newImage("assets/arm.png")
    self.x = 485
    self.y = 280
    self.r = 0
    self.speed = 70
    self.scale = .25
    self.width = 10
    self.height = 10
    self.ox = self.width/2
    self.oy = self.height/2
end

function Arm:keyPressed(key)
    if key == "space" then
        self.r = self.r-1
        
    end
end

function Arm:update(dt)
    if dt == dt then 
        self.r= self.r + 3
    end
    if love.keyboard.isDown("right") and arm.x < 900 then
        arm.x = arm.x + 600 * dt
        end
        if love.keyboard.isDown("left") and arm.x > 200 then
            arm.x = arm.x - 600 * dt
            end
            if love.keyboard.isDown("down") and arm.y < 540 then
                arm.y = arm.y + 200 * dt
                end
                if love.keyboard.isDown("up") and arm.y > 0 then
                    arm.y = arm.y - 200 * dt
                    end
    end

function Arm:draw()
    love.graphics.draw(self.image, self.x, self.y, self.r, (self.width * .0025), (self.height* .005), self.ox, self.oy)
end