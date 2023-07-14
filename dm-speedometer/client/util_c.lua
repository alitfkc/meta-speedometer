-------------------------
--Render func
-------------------------
local sx,sy = guiGetScreenSize()
local veh = false
function math.lerp(a, b, k)
	local result = a * (1-k) + b * k
	if result >= b then
		result = b
	elseif result <= a then
		result = a
	end
	return result
end

local font1 = dxCreateFont("imgs/font.ttf", 35 * ( sy / 1080 ))
function renderFunc()

    local time = getTime()
    if time >= 21 and time <= 23 then 
        if not gui.night_background.state  then 
            guiSetVisible(gui.night_background.elm,true)
            gui.night_background.state = true
            guiSetAlpha(gui.night_background.elm,0)
            guiAlphaTo(gui.night_background.elm,1,"Linear",3000)
        end
    elseif time >=0 and time <=5 then 
        if not gui.night_background.state then 
            guiSetVisible(gui.night_background.elm,true)
            gui.night_background.state = true
            guiSetAlpha(gui.night_background.elm,0)
            guiAlphaTo(gui.night_background.elm,1,"Linear",3000)
        end
    else
        if  gui.night_background.state then 
            guiSetVisible(gui.night_background.elm,false)
            gui.night_background.state = false
            guiSetAlpha(gui.night_background.elm,1)
            guiAlphaTo(gui.night_background.elm,0,"Linear",3000)
        end
    end

    local speedx, speedy, speedz = getElementVelocity ( veh )
    local actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
    local kmh = math.floor(actualspeed * 250)
    local rotation = math.lerp(-117,90,kmh/300)
    if rotation >= 90 then rotation = math.random(88,92) end


    -----
    --Draw line
    -----------------
    if (time >=0 and time <=5) or (time >= 21 and time <= 23) then
        dxDrawImage(sx*0.81,sy*0.685,sx*0.18,sy*0.33,"imgs/night_line.png",rotation,0,0,tocolor(255,255,255,255),true)
    else
        dxDrawImage(sx*0.81,sy*0.685,sx*0.18,sy*0.33,"imgs/day_line.png",rotation,0,0,tocolor(255,255,255,255),true)
    end
    ----draw kmh

    dxDrawText(tostring(kmh),sx*0.89,sy*0.925,0,0,tocolor(12,12,12,255),1,font1,"left","top",false,false,true)


    --draw gear
    
    local gear = getVehicleCurrentGear( veh )
    if gear == 0 then
        if kmh <= 1 then
            gear = "N"
        else
            gear = "R"
        end 
    elseif gear == 1 then
        if kmh <= 2 then
            gear = "N"
        end
    end
    dxDrawText(tostring(gear),sx*0.892,sy*0.865,0,0,tocolor(255,0,0,255),1,font1,"left","top",false,false,true)
end






-------------------------------------------
--Vehicle Enter Exit
--------------------------------------------
local render_state = false
addEventHandler("onClientVehicleEnter", getRootElement(),function(p,seat)
    if p == localPlayer and seat == 0 then
        if  render_state then return end
        guiSetVisible(gui.day_background.elm,true)
        gui.day_background.state = true
        guiSetAlpha(gui.day_background.elm,0)
        guiAlphaTo(gui.day_background.elm,1,"Linear",500)
        addEventHandler("onClientRender",root,renderFunc)
        render_state = true
        veh = getPedOccupiedVehicle(localPlayer)
    end
end)

addEventHandler("onClientVehicleExit", getRootElement(),function(p,seat)
    if p == localPlayer and seat == 0 then
        if not render_state then return end
        guiSetVisible(gui.day_background.elm,false)
        gui.day_background.state = false
        guiSetVisible(gui.night_background.elm,false)
        gui.night_background.state = false
        removeEventHandler("onClientRender",root,renderFunc)
        render_state = false
    end
end)
addEventHandler("onClientResourceStart",resourceRoot,function()
    local seat = getPedOccupiedVehicleSeat(localPlayer)
    if seat == 0 then
        if  render_state then return end
        guiSetVisible(gui.day_background.elm,true)
        gui.day_background.state = true
        guiSetAlpha(gui.day_background.elm,0)
        guiAlphaTo(gui.day_background.elm,1,"Linear",500)
        addEventHandler("onClientRender",root,renderFunc)
        render_state = true
        veh = getPedOccupiedVehicle(localPlayer)
    end
end)