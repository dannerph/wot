function coap_init()
    if(coapPort == nil) then
        coapPort = 5683
    end
    cs=coap.Server()
    cs:listen(coapPort)
    print("CoAP Server started on Port: "..coapPort)
end