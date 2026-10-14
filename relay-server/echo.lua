local copas = require("copas")
local socket = require("socket") 
local port = tonumber(os.getenv("PORT")) or 10000 

local connected = {} 
local function newid() 
return tostring(math.random(100000, 999999)) 
end 

local function handler(handle) 
local id = newid() 
connected[id] = handle 
handle = copas.wrap(handle) 
handle:send("hello") 
print("bro connected") 
while true do 
local input = handle:receive() 
if type(input) ~= "string" then print("bro disconnected") connected[id] = nil handle:close() return end 
print("bro wrote: " ..input) 
handle:send(input)
end
end

local server = assert(socket.bind("*", port)) 
copas.addserver(server, handler) 

print("echo serber onlin!!! on port " ..tostring(port))  
copas.loop()
