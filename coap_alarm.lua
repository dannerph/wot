--coap_alarm.lua
speakerPin = 3
gpio.mode(speakerPin,gpio.OUTPUT)

t={}  
t["a"] = 440
alarmIsOn = false

cs:func(coap.PUT, "alarmON")

function alarmON()
    if alarmIsOn then
        
    else
        alarmIsOn = true
        tmr.alarm(4, 1000, 1, function()
           beep("a", 500)
        end)
    end
end

cs:func(coap.PUT, "alarmOFF")

function alarmOFF()
    if alarmIsOn then
        tmr.stop(4)
        alarmIsOn = false
    end
end

function beep(tone, duration)
    local pin = speakerPin
    local freq = t[tone]  
    pwm.setup(pin, freq, 512)
    pwm.start(pin)  
    -- delay in uSeconds  
    tmr.delay(duration * 1000)  
    pwm.stop(pin)  
    --20ms pause  
    tmr.wdclr()  
    tmr.delay(20000)  
end  

function myCondition(con)
    return tostring(alarmIsOn) == con
end