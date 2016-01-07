--td_alarm.lua
-- register thing description
function coap_register()

    --thing description
    cs:func(coap.GET, "td")

    --register actions

    --register events

    --register properties

end

function td()
    ip = "error"
    if(wifi.getmode() == wifi.SOFTAP) then
        --ip = wifi.ap.getip()
    else
        --ip = wifi.sta.getip()
    end
    td = [[{
  "@context": "http://w3c.github.io/wot/w3c-wot-td-context.jsonld",
  "metadata": {
    "name": "AlarmThingy",
    "protocols" : {
      "CoAP" : {
        "uri" : "coap://]]..ip..[[:]]..coapPort..[[",
        "priority" : 1
          }
      },
    "encodings": [
      "JSON"
    ]
  },
  "interactions": [
    {
      "@type": "Property",
      "name": "colorTemperature",
      "outputData": "xsd:unsignedShort",
      "writable": true
    }
  ]
}]]
    return td
end
