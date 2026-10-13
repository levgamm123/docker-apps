FROM alpine:latest

RUN apk update

RUN apk add --no-cache luajit 
RUN apk add --no-cache luarocks 
RUN luarocks install lua-websockets 
RUN luarocks install copas 

COPY server.lua /app/server.lua
WORKDIR /app

EXPOSE 8080

CMD ["luajit", "server.lua"]
