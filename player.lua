Player = Entity:extend()
local angle = 0
require("playerAnimations")

shield = love.graphics.newImage("assets/images/character/shield.png")

stepsfx = love.audio.newSource("assets/audio/footstep.wav", "static")
shieldsfx = love.audio.newSource("assets/audio/shield.wav", "static")
stepsfx:setVolume(0.25)

function Player:new(x, y)
    Player.super.new(self, x, y, "assets/images/character/hero.png")
    self.direction = "idle"
    self.width = 1
    self.height = 1
    self.speed = 0
end


function Player:update(dt)
    angle = angle + .5*math.pi * dt

    Player.super.update(self, dt)

    if not love.keyboard.isDown("space") then

if love.keyboard.isDown("right")  then
    self.x = self.x + 300 * dt + self.speed
    stepsfx:play()
       self.direction = "right"
    elseif love.keyboard.isDown("left")  then
        self.x = self.x - 300 * dt - self.speed
        stepsfx:play()
        self.direction = "left"
    end

  if love.keyboard.isDown("up")  then
        self.y = self.y - 300 * dt - self.speed
        stepsfx:play()
           self.direction = "right"
  elseif love.keyboard.isDown("down")  then
            self.y = self.y + 300 * dt + self.speed
            stepsfx:play()
               self.direction = "right"
            end
        end
        if love.keyboard.isDown("space") then
            self.direction = "shield"
            shieldsfx:play()
        end
end

function Player:keyreleased(key)
    if not love.keyboard.isDown("space") then
        if key == "right" or key == "up" or key == "down" then
            self.direction = "idle"
        end
        if key == "left" then
            self.direction = "idleleft"
        end
    end
    if key == "space" then
          self.direction = "idle"
    end
    end
        

function Player:draw()
    if self.direction == "idle" then
    love.graphics.draw(idle, idleFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
    end
    if self.direction == "right" then
        love.graphics.draw(walk, walkFrames[math.floor(currentFrame)], self.x, self.y, self.scale, self.width, self.height)
    end
    if self.direction == "left" then
        love.graphics.draw(walk, walkFrames[math.floor(currentFrame)], (self.x+50), self.y, self.scale, (self.width*-1), self.height)
    end
    if self.direction == "idleleft" then
        love.graphics.draw(idle, idleFrames[math.floor(currentFrame)], (self.x+50), self.y, self.scale, (self.width*-1), self.height)
    end
    if self.direction == "shield" then
        love.graphics.draw(shield, self.x, self.y, self.scale, self.width, self.height)
        love.graphics.setColor(0, 0, 1)
        love.graphics.circle("line", self.x+25, self.y+25, 50, 5)
        love.graphics.rotate(angle)
        love.graphics.setColor(0, 0, 0)
    end

end