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
function getNoteLength(index)
    local noteString = n[index]  
    local i = 0
    i = string.find(noteString, ",", i)
    local length = tonumber(string.sub(noteString, i+1))
    return length
end

function getNoteFreq(index)
    local noteString = n[index]  
    local i = 0
    i = string.find(noteString, ",", i)
    local note = tonumber(string.sub(noteString, 0, i-1))
    return note
end

function playNote(index)
    print(index)
    if getNoteFreq(index) > 0 then
        local pin = speakerPin
        pwm.setup(pin, getNoteFreq(index), 512)
        pwm.start(pin)  
        -- delay in uSeconds 
        tmr.alarm(2, getNoteLength(index), 2, function()
            pwm.stop(pin)
        end)
     end
     tmr.alarm(1, getNoteLength(index) + 20, 2, function()
        playNote((index + 1)%#n)
     end)
end

-- condition to check on command execution
function myCondition(con)
    return (con == "On" and alarmIsOn) or (con == "Off" and not (alarmIsOn))
end
