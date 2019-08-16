FROM node:12.8-alpine

RUN apk add --update --no-cache bash make
RUN npm install markdownlint-cli -g && npm install katacoda-cli -g

WORKDIR /app
