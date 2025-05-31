local Debug ={}

-- put in main.update
    -- if love.keyboard.isDown("p") then
    --     debugMode = true
    --  else
    --     debugMode = false
    --  end

-- put in main.draw
--  if debugMode == true then
-- Debug:draw()
--  end

debugMode = false
debugMenu = 1

  consolelog = "test"

function Debug:draw()
love.graphics.setFont(smallF)
love.graphics.setColor(1, 1, 1)
love.graphics.rectangle("fill", 10, 10, 750, 550)
love.graphics.setColor(0, 0, 0)

if debugMenu == 1 then
love.graphics.print( "Page 1" , 20, 50)
love.graphics.print( "Player and Crab", 150, 50)
love.graphics.print( "Player X:", 20, 75)
love.graphics.print( player.x, 150, 75)
love.graphics.print( "Player Y:" , 20, 100)
love.graphics.print( player.y , 150, 100)
love.graphics.print( "Unlock" , 20, 125)
love.graphics.print( player.unlock, 150, 125)
love.graphics.print( "Holding", 20, 150)
love.graphics.print( player.holding, 150, 150)
love.graphics.print( "State" , 20, 175)
love.graphics.print( player.state, 150, 175)
love.graphics.print( "Unlock" , 20, 200)
love.graphics.print( player.unlock, 150, 200)
love.graphics.print( "Day " , 20, 225)
love.graphics.print( day, 150, 225)
love.graphics.print( " Answer 3 " , 20, 250)
love.graphics.print( altar3.answer, 150, 250)

elseif debugMenu == 2 then
love.graphics.print( "Page 2" , 20, 50)
love.graphics.print( "Pearls", 150, 50)
love.graphics.setFont(tinyF)
for i, item in ipairs(pickupItems) do
 if item.carried then
    carryDebug = "true"
 else carryDebug = "false"
 end

    if item.pickup then
        pickupDebug = "true"
    else pickupDebug = "false"
    end
    if i > 4 and i < 9 then
    love.graphics.print( pickupNames[i], 20, (i*100)-400)
    love.graphics.print( "Holding", 20, 25+(i*100)-400)
    love.graphics.print( carryDebug, 150, 25+(i*100)-400)
    love.graphics.print( "Pickup:", 20, 50+(i*100)-400)
    love.graphics.print( pickupDebug, 150, 50+(i*100)-400)
    love.graphics.print( "Type:", 20, 75+(i*100)-400)
    love.graphics.print( item.type, 150, 75+(i*100)-400)
    elseif i > 8 then
    love.graphics.print( pickupNames[i], 320, (i*100)-800)
    love.graphics.print( "Holding", 320, 25+(i*100)-800)
    love.graphics.print( carryDebug, 450, 25+(i*100)-800)
    love.graphics.print( "Pickup:", 320, 50+(i*100)-800)
    love.graphics.print( pickupDebug, 450, 50+(i*100)-800)
     love.graphics.print( "Type:", 320, 75+(i*100)-800)
    love.graphics.print( item.type, 450, 75+(i*100)-800)
end
end


elseif debugMenu == 3 then
love.graphics.print( "Page 3" , 20, 50)
love.graphics.print( "Altar" , 150, 50)
love.graphics.print( "Altar1 Goal:", 20, 75)
love.graphics.print( altar1.goal, 150, 75)
love.graphics.print( "Value 1:" , 20, 100)
love.graphics.print( value1 , 150, 100)
love.graphics.print( "Altar2 Goal:" , 20, 125)
love.graphics.print( altar2.goal, 150, 125)
love.graphics.print( "Value 2:", 20, 150)
love.graphics.print( value2, 150, 150)
love.graphics.print( "Altar3 Goal:" , 20, 175)
love.graphics.print( altar3.goal, 150, 175)
love.graphics.print( "Value 3:" , 20, 200)
love.graphics.print( value3, 150, 200)
love.graphics.print( "Day " , 20, 225)
love.graphics.print( day, 150, 225)
love.graphics.print( " Answer 3 " , 20, 250)
love.graphics.print( altar3.answer, 150, 250)
love.graphics.print( "Hidden 1:", 320, 75)
love.graphics.print( value4, 450, 75)
love.graphics.print( "Hidden 2:" , 320, 100)
love.graphics.print( value5 , 450, 100)
love.graphics.print( "Hidden 3:" , 320, 125)
love.graphics.print( value6, 450, 125)

else
love.graphics.print( "Page 3" , 20, 50)
love.graphics.print( "Console:" , 20, 25)
love.graphics.print( consolelog , 150, 25)


end
nextButt:draw()
prevButt:draw()

end

return Debug
