local copas = require("copas")
local socket = require("socket") 

local function handler(handle) 
handle:send("hello") 
print("connected to guy") 
while true do 
local input = handle:receive() 
if not input then print("guy disconnected") handle:close() end 
handle:send(input)
end
end

copas.addserver(socket.bind("0.0.0.0", tonumber(os.getenv("PORT")) or 10000), function(handle) copas.addthread(handler, handle) end)

print("echo serber onlin!!! on port " ..os.getenv("PORT") or "10000") 
copas.loop()
