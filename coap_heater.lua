--coap_heater.lua

gpio.mode(0,gpio.OUTPUT)
cs:func(coap.PUT, "heaterON")
cs:func(coap.PUT, "heaterOFF")

heaterIsOn = false

function heaterON()
        gpio.write(0, gpio.LOW)
        heaterIsOn = true
    end

function heaterOFF()
    gpio.write(0,gpio.HIGH)
    heaterIsOn = false
    end


function myCondition(con)
  return (con == "On" and heaterIsOn) or (con == "Off" and not (heaterIsOn))
   -- return heaterIsOn
end
        