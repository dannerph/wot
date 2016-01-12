--coap_heater.lua

gpio.mode(0,gpio.OUTPUT)
cs:func(coap.POST, "heaterON")
cs:func(coap.POST, "heaterOFF")
cs:func(coap.GET, "status")

heaterIsOn = true

function heaterON()
        gpio.write(0, gpio.LOW)
        heaterIsOn = true
    end

function heaterOFF()
    gpio.write(0,gpio.HIGH)
    heaterIsOn = false
    end

function status()
    if heaterIsOn then
        return "{\"value\":\"On\"}"
    else 
        return "{\"value\":\"Off\"}"
    end
end

function myCondition(con)
  return (con == "On" and heaterIsOn) or (con == "Off" and not (heaterIsOn))
   -- return heaterIsOn
end
        
