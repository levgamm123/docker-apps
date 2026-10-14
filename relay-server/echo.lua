local copas = require("copas")
local websocket = require("websocket")
local ssl = require("ssl") 
local bit = require("bit") 

local function handler(ws)
ws:send("hi") 
print("client connected") 
local headers = ws.handshake_request or {} 
print(headers) 
print("dropped client") ws:close() 
end

local server = websocket.server.copas.listen({
        port = tonumber(os.getenv("PORT")) or 443, 
        interface = "0.0.0.0", 
        protocols = {default = handler}
})

print("echo serber onlin!!! on port " ..os.getenv("PORT") or "443") 
copas.loop()
