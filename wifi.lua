--wifi.lua

function wifi_connect(pin)
    if check_jumper(pin) then
        print("Starting as client")
        wifi.setmode(wifi.STATION)
        wifi.sta.config("TermoThingy","termothingy1234")
        ip = wifi.sta.getip()
    else
        print("Starting as station")
        wifi.setmode(wifi.SOFTAP)
        cfg={}
        cfg.ssid="TermoThingy"
        cfg.pwd="termothingy1234"
        cfg.channel=11
        wifi.ap.config(cfg)
        ip = wifi.ap.getip()
    end
end

function check_wifi(pin)
    if wifi.getmode() == wifi.SOFTAP then
        if check_jumper(pin) then
            print("Lost jumper")
            wifi_connect(pin)
        else
            ip = wifi.ap.getip()
        end
    else
        if not check_jumper(pin) then
            print("Jumper added")
            wifi_connect(pin)
        else
            ip = wifi.sta.getip()
        end
    end
    if not (ip == oldip) then
        if ip == nil then
            print("No connection")
        else
            print ("IP: ".. ip)
        end
        oldip = ip
    end
end

function check_jumper(pin)
    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin,gpio.LOW)
    gpio.mode(pin, gpio.INPUT)
    v = gpio.read(pin)
    return v == gpio.HIGH
end
