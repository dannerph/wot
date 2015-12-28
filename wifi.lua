function wifi_connect(pin)
    if check_jumper(pin) then
        print("Starting as client")
        wifi.setmode(wifi.STATION)
        wifi.sta.config("TermoThingy","termothingy1234")
        ip = wifi.sta.getip()
        retry = 0
        while ip == nil and retry < 10 do
            tmr.delay(500000)
            ip = wifi.sta.getip()
            print("...")
            retry = retry + 1
        end
        print(ip)
    else
        print("Starting as station")
        wifi.setmode(wifi.SOFTAP)
        cfg={}
        cfg.ssid="TermoThingy"
        cfg.pwd="termothingy1234"
        wifi.ap.config(cfg)
        ip = wifi.ap.getip()
            while ip == nil do
                tmr.delay(50000)
                ip = wifi.ap.getip()
            end
        print(ip)
    end
end

function check_wifi(pin)
    if wifi.getmode() == wifi.SOFTAP then
        if check_jumper(pin) then
            print("Lost jumper")
            wifi_connect(pin)
        end
    else
        if not check_jumper(pin) then
            print("Jumper added")
            wifi_connect(pin)
        elseif wifi.sta.getip() == nil then
            print("Lost connection...reconnect")
            wifi_connect(pin)
        end
    end
end

function check_jumper(pin)
    gpio.mode(pin, gpio.OUTPUT)
    gpio.write(pin,gpio.LOW)
    gpio.mode(pin, gpio.INPUT)
    v = gpio.read(pin)
    return v == gpio.HIGH
end