--coap_alarm.lua
  
gpio.mode(speakerPin,gpio.OUTPUT)

t={}  
t["a"] = 440

cs:func(coap.PUT, "alarmStart")

function alarmStart()
    tmr.alarm(4, 1000, 1, function()
        beep("a", 500)
    end)
end

cs:func(coap.PUT, "alarmStop")

function alarmStop()
    tmr.stop(4)
end

function beep(tone, duration)
    local pin = 3
    local freq = t[tone]  
    print ("Frequency:" .. freq)  
    pwm.setup(pin, freq, 512)  
    pwm.start(pin)  
    -- delay in uSeconds  
    tmr.delay(duration * 1000)  
    pwm.stop(pin)  
    --20ms pause  
    tmr.wdclr()  
    tmr.delay(20000)  
end  