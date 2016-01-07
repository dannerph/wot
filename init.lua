--init.lua

--start wifi initiator
dofile("wifi.lua")
tmr.stop(0)
tmr.alarm(0,1000,1,function()
check_wifi(4)
end)

--start coap server with thing description
coapPort = 5683
cs=nil
dofile("coap.lua")

--Load specific thing file
dofile("config.lua")
if (thingType == "alarm") then
    dofile("coap_alarm.lua")
elseif (thingType == "temp") then
    pdofile("coap_temp.lua")
elseif (thingType == "heater") then
   dofile("coap_heater.lua")
else
    print("no valid thing type")
end

--coap_register()
