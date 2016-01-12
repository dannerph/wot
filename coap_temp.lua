--coap_temp.lua
cs:var(coap.GET, "temp", 0, 1)
tmr.alarm(0, 1000, 1, function()
    currentTemp = "{\"value\":\""..getTemp(3).."\"}"
    if (temp ~= currentTemp) then
        temp = currentTemp
        cs:changed('temp')
        print("changed")
    end
end)

function myCondition(cond)
    comperator = string.sub(cond, 1, 1)
    value = tonumber(string.sub(cond, 2))
    if (comperator == "<") then
        return getTemp(3) / 10000 < value
    end
    if (comperator == ">") then
        return getTemp(3) / 10000 > value
    end
    return false
end
