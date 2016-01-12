--coap_alarm.lua
gpio.mode(speakerPin,gpio.OUTPUT)

dofile("notes.lua")
alarmIsOn = false

-- POST alarm on route
cs:func(coap.POST, "alarmON")
function alarmON()
    if not alarmIsOn then
        alarmIsOn = true
        playNote(0)
    end
end

-- POST alarm off route
cs:func(coap.POST, "alarmOFF")
function alarmOFF()
    if alarmIsOn then
        tmr.stop(1)
        alarmIsOn = false
    end
end

-- GET status route
cs:func(coap.GET, "status")
function status()
    if alarmIsOn then
        return "{\"value\":\"On\"}"
    else
        return "{\"value\":\"Off\"}"
    end
end

--################--
-- help functions --
--################--
function playNote(index)
    local freq = bit.rshift(n[index],16)
    local duration = bit.clear(n[index],16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31) 
    
    if freq > 0 then
        pwm.setup(speakerPin, freq, 512)
        pwm.start(speakerPin)  
        tmr.alarm(2, duration, 2, function()
            pwm.stop(speakerPin)
        end)
     end
     tmr.alarm(1, duration + 20, 2, function()
        playNote((index + 1)%#n)
     end)
end

-- condition to check on command execution
function myCondition(con)
    return (con == "On" and alarmIsOn) or (con == "Off" and not (alarmIsOn))
end
