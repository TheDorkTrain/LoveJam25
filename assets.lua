require ("components/spawnTimer")
require("components/playerAnimations")
 Map =  require "components/map"
 Menu = require "components/menu"
 Intro = require "components/intro"

 Object = require "components/classic"

 shine = {1, 1, 1, 1} 

 function changeShine(e) 
    if e == "redPrl" then
        shine = {1, 0, 0, 1} 
        show = "red"
    end
    if e == "grnPrl" then
        shine = {0, 1, 0, 1} 
        show = "grn"
    end
    if e == "bluPrl" then
        shine = {0, 0, 1, 1} 
        show = "blu"
    end
    if e == "none" then
        shine = {1, 1, 1}
        show = false
    end 
end
    
    require "components/entity"
    require "components/player"
    require "components/tile"
    require "components/button"
    require "components/item"
    stand = "assets/images/props/stand.png"
    altar = "assets/images/props/stand.png"
    
    pearl = "assets/images/props/pearl.png"
    pearlItem = Item(pearl, "redPrl", -201, 2808)
    pearlItem2 = Item(pearl, "grnPrl", -251, 2808)
    pearlItem3 = Item(pearl, "bluPrl", -201, 2608)

    stand = Item(stand, "stand", 100, 2000 , 1)

    altar = Item(altar, "stand", 0, 2250 , 1)
    
    local radiusPadding = 120

    areaRadius = Object:extend()

    function areaRadius:new(e)
        self.x = (e.x - 40)
        self.width = (e.width + radiusPadding)
        self.y = (e.y - 40 )
        self.height = (e.height + radiusPadding)
    end
    standRadius = areaRadius(stand)

