--coap.lua

if(coapPort == nil) then
    coapPort = 5683
end
cs=coap.Server()
cs:listen(coapPort)
print("CoAP Server started on Port: "..coapPort)

--GET thing description
cs:func(coap.GET, "td")
function td()
    jsonFileName = ""
    if (thingType == "alarm") then
        jsonFileName = "td_alarm.json"
    elseif (thingType == "temp") then
        jsonFileName = "td_temp.json"
    elseif (thingType == "heater") then
        jsonFileName = "td_heater.json"
    else
        print("no valid thing type")
    end

    file.open(jsonFileName, "r")

    json = file.read()
    json = string.gsub(json, "COAP_IP:COAP_PORT", getIP()..":"..coapPort)

    file.close()
    return json
end
