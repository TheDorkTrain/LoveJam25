-- require ("components/spawnTimer")
tinyF = love.graphics.newFont("assets/Bestime.ttf", 10)
smallF = love.graphics.newFont("assets/Bestime.ttf", 20)
mediumF = love.graphics.newFont("assets/Bestime.ttf", 36)
largeF = love.graphics.newFont("assets/Bestime.ttf", 50)
crabIcon = love.graphics.newImage("assets/images/character/crab.png")

menuSong = love.audio.newSource("assets/audio/menu.mp3", "static")
daySong = love.audio.newSource("assets/audio/day.mp3", "static")
nightSong = love.audio.newSource("assets/audio/night.mp3", "static")

require("components/playerAnimations")
require("components/promptAnimations")
 Map =  require "components/map"
 Prompts = require "components/prompts"
 Menu = require "components/menu"
 Intro = require "components/intro"

 Object = require "components/classic"

 shine = {1, 1, 1, 1} 

 show = "none"

 function soundtrack()
    if location == "game" and phase == "Day" then
        nightSong:stop()
        menuSong:stop()  
        daySong:play()       
    elseif location == "game" and phase == "Night" then
        daySong:stop()
        menuSong:stop()      
        nightSong:play()       
    else
        daySong:stop()
        nightSong:stop()  
            menuSong:play()
    end
 end

 function changeShine(e) 
    if e == "redPrl" then
        shine = {1, 0.639, 0.329, 1} 
        show = "red"
    end
    if e == "grnPrl" then
        shine = {0.329, 1, 0.557, 1} 
        show = "grn"
    end
    if e == "bluPrl" then
        shine = {0.329, 0.847, 1, 1} 
        show = "blu"
    end
    if e == "none" then
        shine = {1, 1, 1}
        show = "none"
    end 
end
    
    require "components/entity"
    require "components/player"
    require "components/tile"
    require "components/button"
    require "components/item"
    require "components/gatherPoints"
    require "components/pearlSpawn"
    require "components/dayTimer"
    require "components/dailyGoal"

    stand = "assets/images/props/stand.png"
    altar = "assets/images/props/altar.png"
    pearl = "assets/images/props/pearl.png"
    sunImage = love.graphics.newImage("assets/images/props/sun.png")

    stand = Item(stand, "stand", "stand", 100, 2000 , 1)

    altar = Item(altar, "stand", "altar", 689, 1138 , 1)
    
    local radiusPadding = 120

    -- areaRadius = Object:extend()

    -- function areaRadius:new(e)
    --     self.x = (e.x - 40)
    --     self.width = (e.width + radiusPadding)
    --     self.y = (e.y - 40 )
    --     self.height = (e.height + radiusPadding)
    -- end
    standRadius = Gatherpoint("stand", 130, 2040, 0, 0, "pearl")

    

