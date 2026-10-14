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
    openssl-dev \
    git

RUN ln -s /usr/bin/luarocks-5.1 /usr/bin/luarocks

RUN luarocks install lua-websockets --lua-version=5.1
RUN luarocks install luasec --lua-version=5.1
RUN luarocks install copas --lua-version=5.1
RUN luarocks install luasocket --lua-version=5.1

COPY echo.lua /app/echo.lua
WORKDIR /app

EXPOSE 10000 
EXPOSE 443

CMD ["luajit", "echo.lua"]
