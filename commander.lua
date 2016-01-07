--commander.lua
commands = {}
cc = coap.Client()
function clearCommands()
commands = {}
end
function addCommand(command)
    table.insert(commands, command)
end

function printCommands()
    result = ""
    for i=1,#commands,1 do
        result = result .. commands[i] .. "\n"
    end
    return result
end

function doCommands()
    for i=1,#commands,1 do
        executeCommand(commands[i])
    end
end

function executeCommand(command)
    cmd = {}
    i = 1
    for str in string.gmatch(command, "([^,]+)") do
                cmd[i] = str
                if i == 1 then
                cond = str
                end
                if i == 2 then
                method = str
                end
                if i == 3 then
                address = str
                end
                i = i + 1
    end
    if (myCondition(cond)) then
        print("CALL: "..address)
        address = "coap://" .. address
        if (method == "GET") then
           cc:get(coap.CON, address)
        elseif (method == "POST") then
           cc:post(coap.CON, address)
        elseif (method == "PUT") then
           cc:put(coap.CON, address)
        elseif (method == "DELETE") then
           cc:delete(coap.CON, address)
        end
    end
end

tmr.alarm(5,1000,1,function()
  doCommands()
end)

cs:func(coap.PUT, "clearCommands", 0)
cs:func(coap.PUT, "addCommand", 0)
cs:func(coap.GET, "printCommands", 0)
