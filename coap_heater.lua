--coap_heater.lua

gpio.mode(0,gpio.OUTPUT)

cs:func(coap.PUT, "heaterON")
cs:func(coap.PUT, "heaterOFF")

function heaterON()
        gpio.write(0, gpio.HIGH)
    end

function heaterOFF()
    gpio.write(0,gpio.LOW)
    end