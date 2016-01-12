--init.lua
-- load configrations
dofile("config.lua")

--start wifi initiator
dofile("wifi.lua")
tmr.stop(0)
tmr.alarm(0,1000,1,function()
    check_wifi(wifiJumperPin)
    end)

--start coap server with thing description
cs=nil
dofile("coap.lua")

--Load specific thing file
if (thingType == "alarm") then
    dofile("coap_alarm.lua")
elseif (thingType == "temp") then
    dofile("coap_temp.lua")
elseif (thingType == "heater") then
    dofile("coap_heater.lua")
else
    print("no valid thing type")
end

--load commander
dofile("commander.lua")
