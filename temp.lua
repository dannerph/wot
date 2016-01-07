--temp.lua
function getTemp(pin)

    local addr      = nil
    local count     = 0
    local data      = nil
    local s         = ''

    -- setup gpio pin for oneWire access
    ow.setup(pin)

    -- do search until addr is returned
    repeat
        count   = count + 1
        addr    = ow.reset_search(pin)
        addr    = ow.search(pin)
        tmr.wdclr()
        until((addr ~= nil) or (count > 100))

    -- if addr was never returned, abort
    if (addr == nil) then
        print('DS18B20 not found')
        return -999999
        end
  
    s=string.format("Addr:%02X-%02X-%02X-%02X-%02X-%02X-%02X-%02X", 
        addr:byte(1),addr:byte(2),addr:byte(3),addr:byte(4), 
        addr:byte(5),addr:byte(6),addr:byte(7),addr:byte(8))
    --print(s)

    -- validate addr checksum
    --crc = ow.crc8(string.sub(addr,1,7))
    --if (crc ~= addr:byte(8)) then
    --    print('DS18B20 Addr CRC failed');
    --    return -999999
    --    end

    if not((addr:byte(1) == 0x10) or (addr:byte(1) == 0x28)) then
        print('DS18B20 not found')
        return -999999
        end
        
    ow.reset(pin)               -- reset onewire interface
    --ow.select(pin, addr)        -- select DS18B20
    ow.write(pin,0x55, 1) -- 0x55==search aka select command
    for i=1,8 do
        ow.write(pin,addr:byte(i), 1)
    end
    ow.write(pin, 0x44, 1)      -- store temp in scratchpad
    -- tmr.delay(1000000)          -- wait 1 sec
    
    present = ow.reset(pin)     -- returns 1 if dev present
    if present ~= 1 then
        print('DS18B20 not present')
        return -999999
        end
    
    --ow.select(pin, addr)        -- select DS18B20 again
    ow.write(pin,0x55, 1) -- 0x55==search aka select command
    for i=1,8 do
        ow.write(pin,addr:byte(i), 1)
    end
    ow.write(pin,0xBE,1)        -- read scratchpad

    -- rx data from DS18B20
    data = nil
    data = string.char(ow.read(pin))
    for i = 1, 8 do
        data = data .. string.char(ow.read(pin))
        end
    
    s=string.format("Data:%02X-%02X-%02X-%02X-%02X-%02X-%02X-%02X", 
        data:byte(1),data:byte(2),data:byte(3), data:byte(4),
        data:byte(5),data:byte(6), data:byte(7),data:byte(8))
    --print(s)

    -- validate data checksum
    --crc = ow.crc8(string.sub(data,1,8))
    --if (crc ~= data:byte(9)) then
    --    print('DS18B20 data CRC failed')
    --    return -9999
    --    end

    -- compute and return temp as 99V9999 (V is implied decimal-a little COBOL there)
    return (data:byte(1) + data:byte(2) * 256) * 625
    
end -- getTemp


