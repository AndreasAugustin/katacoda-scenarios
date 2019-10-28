FROM node:13.0.1-alpine

RUN apk add --update --no-cache bash make
RUN npm install markdownlint-cli -g && npm install katacoda-cli -g

WORKDIR /app
