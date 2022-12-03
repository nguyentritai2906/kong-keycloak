FROM kong:2.8.1-alpine

LABEL description="Kong Alpine with OIDC plugin for OpenID Connect with Keycloak"
LABEL maintainer="Nguyen Tri Tai <nguyentritai2906@gmail.com>"

USER root
RUN apk update && apk add curl git gcc musl-dev
RUN luarocks install luaossl OPENSSL_DIR=/usr/local/kong CRYPTO_DIR=/usr/local/kong
RUN luarocks install --pin lua-resty-jwt
RUN luarocks install kong-oidc

COPY ./ssl/certs/ /certs

USER kong
