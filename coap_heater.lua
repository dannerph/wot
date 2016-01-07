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


function myCondition(cond)
    status = gpio.read(0)
end


function ledIsOn()
    var = false
        if gpio.read(0) == 0 then
         var = false
        else  
           var = true 
           end
        return var
        
end