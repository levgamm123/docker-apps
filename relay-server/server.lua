local copas = require("copas")
local websocket = require("websocket")

--go go gadget stolen code
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
local id = generate_id()
connected[id] = ws
print("bro connected: " .. id)

local input 

while true do 
::beans::
copas.sleep(0.1) 
input = ws:receive()
if type(input) ~= "string" then 
connected[id] = nil 
print("bro disconnected: " ..id)
if loggedin["sender"] == ws then loggedin["sender"] = nil end 
if loggedin["receiver"] == ws then loggedin["receiver"] = nil end 
return end 
local parsed = split(input, " ")

if parsed[1] == "LOGIN" then 
if parsed[2] == "sender" and parsed[3] == "beans6969" then ws:send("success") print("bro logged in: " ..id.. ", sender") loggedin["sender"] = ws 
elseif parsed[2] == "receiver" and parsed[3] == "meHiThreadOpener" then ws:send("success") print("bro logged in: " ..id.. ", receiver") loggedin["receiver"] = ws 
else ws:send("wrong login or password bitch") end 
end

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


local ws_server = websocket.server.copas.listen({
    host = "0.0.0.0",
    port = tonumber(os.getenv("PORT")) or 443,
    protocols = {default = handler}
})

print("serber onlin!!! on port " ..os.getenv("PORT") or "443")
copas.loop()
