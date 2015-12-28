function wifi_connect(pin)
    if check_jumper(pin) then
        print("Starting as client")
        wifi.setmode(wifi.STATION)
        wifi.sta.config("TermoThingy","termothingy1234")
        ip = wifi.sta.getip()
        print(ip)
    else
        print("Starting as station")
        wifi.setmode(wifi.SOFTAP)
        cfg={}
        cfg.ssid="TermoThingy"
        cfg.pwd="termothingy1234"
        wifi.ap.config(cfg)
        ip = wifi.ap.getip()
        print(ip)
    end
end

function check_wifi(pin)
    if wifi.getmode() == wifi.SOFTAP then
        if check_jumper(pin) then
            print("Lost jumper")
            wifi_connect(pin)
        end
        ip = wifi.ap.getip()
    else
        if not check_jumper(pin) then
            print("Jumper added")
            wifi_connect(pin)
        end
        ip = wifi.sta.getip()
    end
    if not ip == oldip then
        print(ip)
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