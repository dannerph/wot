function getNoteLength(index)
    local noteString = n[index]  
    local i = 0
    i = string.find(noteString, ",", i)
    local length = tonumber(string.sub(noteString, i+1))
    return length
end

function getNoteFreq(index)
    local noteString = n[index]  
    local i = 0
    i = string.find(noteString, ",", i)
    local note = tonumber(string.sub(noteString, 0, i-1))
    return note
end

function test()
file.open("notes_new.lua", "w")
    for i=0,#n do
        --encode
        b = bit.lshift(getNoteFreq(i),16)
        b = bit.bor(b,getNoteLength(i))
        --print("n["..i.."] = "..b)
        
        file.writeline("n["..i.."] = "..b)

        --decode
        --print("Freq: "..getNoteFreq(i).." vs "..bit.rshift(b,16))
        --freq = bit.rshift(b,16)
        --print("Length: "..getNoteLength(i).." vs "..bit.clear(b,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32))        
        
    end
    file.close()

end

function decode()
file.open("notes_new_decode.lua", "w")
    for i=0,#n do

        b = n[i]  
        --encode
        --b = bit.lshift(getNoteFreq(i),16)
        --b = bit.bor(b,getNoteLength(i))
        --print("n["..i.."] = "..b)
        
        

        --decode
        freq = bit.rshift(b,16)
        length = bit.clear(b,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32) 

        --file.writeline("n["..i.."] = \""..freq..","..length.."\"")
        print("n["..i.."]"..freq..","..length)
        
    end
    file.close()


end