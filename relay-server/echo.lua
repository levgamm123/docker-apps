local copas = require("copas")
local socket = require("socket") 

local function handler(handle) 
handle:send("hello") 
print("bro connected") 
while true do 
local input = handle:receive() 
if type(input) ~= "string" then print("bro disconnected") handle:close() return end 
print("bro wrote: " ..input) 
handle:send(input)
end
end

copas.addserver(socket.bind("0.0.0.0", tonumber(os.getenv("PORT")) or 10000), function(handle) copas.addthread(handler, handle) end)

print("echo serber onlin!!! on port " ..os.getenv("PORT") or "10000") 
copas.loop()
