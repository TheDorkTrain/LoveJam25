dayTimer = 5
phase = "Day"
day = 1

dayChangeTimer = 0

function DayTimerCount(dt)

if phase == "Day" then
   if value1 == altar1.goal and value2 == altar2.goal and value3 == altar3.goal then
 if dayTimer <= 175 then
    dayTimer = dayTimer + dt*3
 end
else
   if dayTimer <= 175 then
      dayTimer = dayTimer + dt
   end
end

 if dayTimer >= 175 then
    dayTimer = 5
    phase = "Night"
    location = "dayChange"
 end
end

if phase == "Night" then
    if dayTimer <= 175 then
        dayTimer = dayTimer + dt
     end
     if dayTimer >= 175 then
        dayTimer = 5
        phase = "Day"
        day = day + 1
        location = "dayChange"
        dailyReset()
     end
    end

end


function dayChange(dt)
   if dayChangeTimer <= 5 then
      dayChangeTimer = dayChangeTimer + dt
   end
   if dayChangeTimer >= 5 then
      if phase == "Night" and value1 == altar1.goal and value2 == altar2.goal and value3 == altar3.goal then
      phase = "Day"
      day = day + 1
      location = "game"
      dailyReset()
      dayChangeTimer = 0
      elseif phase == "Day" then 
      location = "game"
      dayChangeTimer = 0
      else
         location = "gameover"
      end
   end
end
   

