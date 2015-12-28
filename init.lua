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
coap_init()

--TODO: change to right file
--dofile("td_alarm.lua")
coap_register()
