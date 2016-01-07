--coap_temp.lua
cs:var(coap.GET, "temp", 0, 1)
tmr.alarm(0, 1000, 1, function()
    currentTemp = getTemp(3)
    if (temp ~= currentTemp) then
        temp = currentTemp
        cs:changed('temp')
        print("changed")
    end
end)