require ("components/spawnTimer")
require("components/playerAnimations")
 Map =  require "components/map"
 Menu = require "components/menu"
 Intro = require "components/intro"

 Object = require "components/classic"

 shine = {1, 1, 1, 1} 

 show = "none"

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

    stand = "assets/images/props/stand.png"
    altar = "assets/images/props/altar.png"
    
    pearl = "assets/images/props/pearl.png"
    pearlItem = Item(pearl, "pearl", "redPrl", -201, 2808)
    pearlItem2 = Item(pearl, "pearl", "grnPrl", -251, 2808)
    pearlItem3 = Item(pearl, "pearl", "bluPrl", -201, 2608)
    pearlItem4 = Item(pearl, "pearl", "bluPrl", 550, 1300)
    pearlItem5 = Item(pearl, "pearl", "bluPrl", 550, 1300)

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
    altar1 = Gatherpoint("altar", 720, 1180, 0, 0, "pearl")
    altar2 = Gatherpoint("altar", 820, 1180, 0, 0, "pearl")
    altar3 = Gatherpoint("altar", 920, 1180, 0, 0, "pearl")

