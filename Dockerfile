FROM alpine:3.10 AS katacoda

RUN apk add --update --no-cache bash curl libc6-compat

# install Katacoda cli
RUN curl -s https://cli.katacoda.com | sh

WORKDIR /app

FROM node:12.6-alpine as node

RUN apk add --update --no-cache bash make
RUN npm install markdownlint-cli -g

WORKDIR /app
