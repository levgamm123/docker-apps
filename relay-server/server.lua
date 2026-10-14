-- Source - https://stackoverflow.com/q/80009846
-- Posted by NoikOnesjor
-- Retrieved 2026-10-14, License - CC BY-SA 4.0

local copas = require("copas")
local websocket = require("websocket")
local ssl = require("ssl") 
local bit = require("bit") 

--thanks, cc.strings :3 
local function split(str, deliminator, plain, limit)

    local out, out_n, pos = {}, 0, 1
    while not limit or out_n < limit - 1 do
        local start, finish = str:find(deliminator, pos, plain)
        if not start then break end

        out_n = out_n + 1
        out[out_n] = str:sub(pos, start - 1)

        -- Require us to advance by at least one character.
        if finish < start then error("separator is empty", 2) end

        pos = finish + 1
    end

    if pos == 1 then return { str } end

    out[out_n + 1] = str:sub(pos)
    return out
end

local connected = {}
local loggedin = {} 

local function generate_id()
return tostring(math.random(100000, 999999))
end

local function handler(ws)
copas.sleep(0.1) 
local id = generate_id()
connected[id] = ws
print("bro connected: " .. id) --connection log 

local input 
ws:send("hi twin") --test response immediately after connection 

while true do 
::beans::
copas.sleep(0.1) 
input = ws:receive()
if type(input) ~= "string" then 
connected[id] = nil 
print("bro disconnected: " ..id) 
if loggedin["sender"] == ws then loggedin["sender"] = nil end 
if loggedin["receiver"] == ws then loggedin["receiver"] = nil end 
ws:close() 
return end 
local parsed = split(input, " ")

--login handling 
if parsed[1] == "LOGIN" then 
if parsed[2] == "sender" and parsed[3] == "beans6969" then ws:send("success") print("bro logged in: " ..id.. ", sender") loggedin["sender"] = ws 
elseif parsed[2] == "receiver" and parsed[3] == "meHiThreadOpener" then ws:send("success") print("bro logged in: " ..id.. ", receiver") loggedin["receiver"] = ws 
else ws:send("wrong login or password bitch") end 
end

--message relay handling 
if parsed[1] == "SEND" then 
if ws == loggedin["sender"] then 
if not loggedin["receiver"] then ws:send("nbopdoy CARES abt ur commanbd") goto beans end 
loggedin["receiver"]:send(table.concat(parsed, " ", 2)) ws:send("success") print("bro executed command: " ..table.concat(parsed, " ", 2))
else ws:send("dude you are a receiver (or not logged in at all)")
end
end

copas.sleep(0.1) 
end
end

--start server 
local server = websocket.server.copas.listen({
        port = tonumber(os.getenv("PORT")) or 443, 
        interface = "0.0.0.0", 
        protocols = {default = handler}
})

--log if server was initiated 
print("serber onlin!!! on port " ..os.getenv("PORT") or "443") --this is strange because this still logs on startup 
copas.loop()
