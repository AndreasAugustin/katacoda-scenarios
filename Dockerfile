FROM node:17.0.1-alpine

RUN apk add --update --no-cache bash make git zsh curl
# install oh-my-zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

WORKDIR /app
