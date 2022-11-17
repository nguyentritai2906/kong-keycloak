FROM kong:2.8.1-alpine

LABEL description="Alpine + Kong + OIDC"

USER root
RUN apk update && apk add curl git gcc musl-dev
RUN luarocks install luaossl OPENSSL_DIR=/usr/local/kong CRYPTO_DIR=/usr/local/kong
RUN luarocks install --pin lua-resty-jwt
RUN luarocks install kong-oidc

COPY kong.conf.default /etc/kong/kong.conf

USER kong
