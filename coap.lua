--coap.lua

if(coapPort == nil) then
    coapPort = 5683
end
cs=coap.Server()
cs:listen(coapPort)
print("CoAP Server started on Port: "..coapPort)

-- update routes to upload and execute files
function uploadFile(payload)
    i = 0
    i = string.find(payload, "\n", i)
    filename = string.sub(payload, 3, i-1)

    file.remove(filename)
    file.open(filename, "w")
    file.write(payload.." -- workaround ")
    file.close()
        
    dofile(filename)
end

-- add update route
cs:func(coap.POST, "uploadFile")
