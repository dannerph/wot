--start wifi initiator
dofile("wifi.lua")
tmr.stop(0)
tmr.alarm(0,1000,1,function()
check_wifi(4)
end)