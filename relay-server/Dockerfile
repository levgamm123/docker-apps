FROM alpine:latest

RUN echo "https://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk update

RUN apk add --no-cache \
    luajit \
    luarocks \
    lua5.1-dev \
    gcc \
    musl-dev \
    make \
    git

RUN ln -s /usr/bin/luarocks-5.1 /usr/bin/luarocks

RUN luarocks init --lua-versions "5.1" 
RUN luarocks install lua-websockets 
RUN luarocks install copas 

COPY server.lua /app/server.lua
WORKDIR /app

EXPOSE 8080

CMD ["luajit", "server.lua"]
