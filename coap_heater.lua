--coap_heater.lua

gpio.mode(0,gpio.OUTPUT)

cs:func(coap.PUT, "heaterStart")
cs:func(coap.PUT, "heaterStop")

function heaterStart()
        gpio.write(0, gpio.HIGH)
    end

function heaterStop()
    gpio.write(0,gpio.LOW)
    end