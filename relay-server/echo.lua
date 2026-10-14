local copas = require("copas")
local websocket = require("websocket")
local ssl = require("ssl") 
local bit = require("bit") 

local function handler(ws)
print("client connected") 
while true do 
local input = ws.receive() 
if not input then print("client disconnected") ws:close() return end 
ws:send(input) 
end
end

local server = websocket.server.copas.listen({
        port = tonumber(os.getenv("PORT")) or 443, 
        interface = "0.0.0.0", 
        protocols = {default = handler}
})

--log if server was initiated 
print("serber onlin!!! on port " ..os.getenv("PORT") or "443") --this is strange because this still logs on startup 
copas.loop()
