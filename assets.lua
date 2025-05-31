-- require ("components/spawnTimer")
tinyF = love.graphics.newFont("assets/Bestime.ttf", 10)
debugF = love.graphics.newFont("assets/Bestime.ttf", 15)
smallF = love.graphics.newFont("assets/Bestime.ttf", 20)
mediumF = love.graphics.newFont("assets/Bestime.ttf", 36)
largeF = love.graphics.newFont("assets/Bestime.ttf", 50)
crabIcon = love.graphics.newImage("assets/images/character/crab.png")
moveButt = love.graphics.newImage("assets/images/props/moveButt.png")
actionButt = love.graphics.newImage("assets/images/props/actionButt.png")

scream = love.audio.newSource("assets/audio/scream.wav", "static")
spook = love.audio.newSource("assets/audio/spook.wav", "static")

teleportfx = love.audio.newSource("assets/audio/teleport.wav", "static")
teleportPlay = true

powerfx = love.audio.newSource("assets/audio/powerup.wav", "static")
powerPlay = true

function playPower()
 if powerPlay then
    powerfx:play()
    powerPlay = false
 end
end

function playTeleport()
    if teleportPlay then
        teleportfx:play()
        teleportPlay = false
    end
   end

menuSong = love.audio.newSource("assets/audio/menu.mp3", "static")
daySong = love.audio.newSource("assets/audio/day.mp3", "static")
nightSong = love.audio.newSource("assets/audio/night.mp3", "static")
menuSong:setVolume(.10)
daySong:setVolume(.10)
nightSong:setVolume(.10)
scream:setVolume(.10)

titleScreen = love.graphics.newImage("assets/images/background/title.png")

require("components/playerAnimations")
require("components/promptAnimations")
 Map =  require "components/map"
 Prompts = require "components/prompts"
 Menu = require "components/menu"
 Intro = require "components/intro"
 Debug = require "components/debug"

 Object = require "components/classic"

 shine = {1, 1, 1, 1} 

 show = "none"
 teleportFirst = true

 function soundtrack()
    if location == "game" and phase == "Day" then
        spook:stop()
        scream:stop()
        nightSong:stop()
        menuSong:stop()  
        daySong:play()       
    elseif location == "game" and phase == "Night" then
        spook:stop()
        scream:stop()
        daySong:stop()
        menuSong:stop()      
        nightSong:play()     
    elseif location == "dayChange" and phase == "Night"  then
        daySong:stop()
        menuSong:stop()      
        nightSong:stop()
        spook:play()
        scream:play()       
    else
        spook:stop()
        scream:stop()
        daySong:stop()
        nightSong:stop()  
            menuSong:play()
    end
 end


 function changeShine(e) 
    if e == "redPrl" then
        shine = {1, 0.639, 0.329, 1} 
        show = "red"
        hiddenPoint1.spawn = true
    end
    if e == "grnPrl" then
        shine = {0.329, 1, 0.557, 1} 
        show = "grn"
        hiddenPoint2.spawn = true
    end
    if e == "bluPrl" then
        shine = {0.329, 0.847, 1, 1} 
        show = "blu"
        hiddenPoint3.spawn = true
    end
    if e == "none" then 
        shine = {1, 1, 1}
        show = "none"
        hiddenPoint1.spawn = false
        hiddenPoint2.spawn = false
        hiddenPoint3.spawn = false
    end 
end
    
    require "components/entity"
    require "components/messages"
    require "components/player"
    require "components/tile"
    require "components/button"
    require "components/item"
    require "components/gatherPoints"
    require "components/pearlSpawn"
    require "components/dayTimer"
    require "components/dailyGoal"
    require "components/boss"
    require "components/collect"

    ocean = love.graphics.newImage("assets/images/background/ocean.png")

    standImage = "assets/images/props/stand.png"
    altarImage = "assets/images/props/altar.png"
    pearl = "assets/images/props/pearl.png"
    tree = "assets/images/props/tree.png"
    log = "assets/images/props/logs.png"
    sunImage = love.graphics.newImage("assets/images/props/sun.png")
    asteroid = "assets/images/props/asteroid.png"
    bottleImage = "assets/images/props/bottle.png"

    stand = Item(standImage, "stand", "stand", 100, 2000 , 1)

    altar = Item(altarImage, "stand", "altar", 689, 1138 , 1)

    hiddenstand1 = Item(standImage, "stand", "stand", 1460, 1383 , 1)
    hiddenstand2 = Item(standImage, "stand", "stand", -74, 1593 , 1)
    hiddenstand3 = Item(standImage, "stand", "stand", -1289, 2078 , 1)

    tree1 = Item(tree, "tree", "tree", -400, 2300, 2, true)
    tree2 = Item(tree, "tree", "tree", 676, 2678, 2, true)
    tree3 = Item(tree, "tree", "tree", 2280, 1803, 2, true)
    tree4 = Item(tree, "tree", "tree", -264, 1612, 2, true)

    log1 = Item(log, "log", "log", -400, 2300, 1, false)
    log2 = Item(log, "log", "log", 676, 2678, 1,  false)
    log3 = Item(log, "log", "log", 2280, 1803, 1,  false)
    log4 = Item(log, "log", "log", -264, 1612, 1,  false)

    asteroidCrash = Collect(asteroid, 3186, 2132, 1, shieldText, "shield", false)
    bottle1 = Collect(bottleImage, 350, 2842, .5, bottleText1, "none", true)
    bottle2 = Collect(bottleImage, 1136, 1107, .5, bottleText2, "none", true)
    bottle3 = Collect(bottleImage, 3136, 1932, .5, bottleText3, "none", true)
    bottle4 = Collect(bottleImage, -528, 2555, .5, bottleText4, "none", false)
    bottle5 = Collect(bottleImage, 111, 2358, .5, bottleText5, "none", false)

    bigCrab = Boss(800,900)
    
    local radiusPadding = 120

    -- areaRadius = Object:extend()

    -- function areaRadius:new(e)
    --     self.x = (e.x - 40)
    --     self.width = (e.width + radiusPadding)
    --     self.y = (e.y - 40 )
    --     self.height = (e.height + radiusPadding)
    -- end
    standRadius = Gatherpoint("stand", 130, 2040, 0, 0, "pearl", nil, true)

    dock = Gatherpoint("dock", -500, 2793, 175, 175, "log", nil, true)

