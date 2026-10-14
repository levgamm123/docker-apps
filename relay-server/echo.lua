local copas = require("copas")
local socket = require("socket") 
local port = tonumber(os.getenv("PORT")) or 10000 

local function handler(handle) 
handle = copas.wrap(handle) 
handle:send("hello") 
print("bro connected") 
while true do 
local input = handle:receive() 
if type(input) ~= "string" then print("bro disconnected") handle:close() return end 
print("bro wrote: " ..input) 
handle:send(input)
end
end

local server = assert(socket.bind("*", port) 
copas.addserver(server, handler) 

print("echo serber onlin!!! on port " ..tostring(port))  
copas.loop()
