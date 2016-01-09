--coap_alarm.lua
gpio.mode(speakerPin,gpio.OUTPUT)

t={}  
t["a"] = 440
alarmIsOn = false

-- POST alarm on route
cs:func(coap.POST, "alarmON")
function alarmON()
    if alarmIsOn then
        
    else
        alarmIsOn = true
        tmr.alarm(4, 1000, 1, function()
           beep("a", 500)
        end)
    end
end

-- POST alarm off route
cs:func(coap.POST, "alarmOFF")
function alarmOFF()
    if alarmIsOn then
        tmr.stop(4)
        alarmIsOn = false
    end
end

-- GET status route
cs:func(coap.GET, "status")
function status()
    if alarmIsOn then
        return "On"
    else
        return "Off"
    end
end

--GET thing description
cs:var(coap.GET, "td")
td = "{\n"..
"  \"@context\": \"http://w3c.github.io/wot/w3c-wot-td-context.jsonld\",\n"..
"  \"metadata\": {\n"..
"    \"name\": \"AlarmThingy\",\n"..
"    \"protocols\" : {\n"..
"      \"CoAP\" : {\n"..
"        \"uri\" : \"coap://"..getIP()..":"..coapPort.."\",\n"..
"        \"priority\" : 1\n"..
"          }\n"..
"      },\n"..
"    \"encodings\": \[\n"..
"      \"JSON\"\n"..
"    \]\n"..
"  },\n"..
"  \"interactions\": \[\n"..
"    {\n"..
"      \"@type\": \"Property\",\n"..
"      \"name\": \"status\",\n"..
"      \"outputData\": \"xsd:string\",\n"..
"      \"writable\": false\n"..
"    },{\n"..
"      \"@type\": \"Action\",\n"..
"      \"name\": \"alarmON\",\n"..
"      \"inputData\": \"\",\n"..
"      \"outputData\": \"\"\n"..
"    },{\n"..
"      \"@type\": \"Action\",\n"..
"      \"name\": \"alarmOFF\",\n"..
"      \"inputData\": \"\",\n"..
"      \"outputData\": \"\"\n"..
"    },{\n"..
"      \"@type\": \"Property\",\n"..
"      \"name\": \"myCommands\",\n"..
"      \"outputData\": \"xsd:string\",\n"..
"      \"writable\": false\n"..
"    },{\n"..
"      \"@type\": \"Action\",\n"..
"      \"name\": \"clearCommands\",\n"..
"      \"inputData\": \"\",\n"..
"      \"outputData\": \"\"\n"..
"    },{\n"..
"      \"@type\": \"Action\",\n"..
"      \"name\": \"addCommand\",\n"..
"      \"inputData\": \"xsd:string\",\n"..
"      \"outputData\": \"\"\n"..
"    }\n"..
"  \]\n"..
"}"

--################--
-- help functions --
--################--
function beep(tone, duration)
    local pin = speakerPin
    local freq = t[tone]  
    pwm.setup(pin, freq, 512)
    pwm.start(pin)  
    -- delay in uSeconds  
    tmr.delay(duration * 1000)  
    pwm.stop(pin)  
    --20ms pause  
    tmr.wdclr()  
    tmr.delay(20000)  
end  

-- condition to check on command execution
function myCondition(con)
    return (con == "On" and alarmIsOn) or (con == "Off" and not (alarmIsOn))
end
