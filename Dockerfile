FROM alpine:3.10

RUN apk add --update --no-cache bash make tmux curl

# install Katacoda cli
RUN curl -s https://cli.katacoda.com | sh

WORKDIR /app
