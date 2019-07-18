FROM alpine:3.10

RUN apk add --update --no-cache bash git openssh-keygen

RUN ssh-keygen -t rsa -f /root/.ssh/id_rsa -q -P "" && \
    chmod 700 /root/.ssh && chmod 600 /root/.ssh/id_rsa && chmod 644 /root/.ssh/id_rsa.pub

WORKDIR /app/

CMD ["/bin/bash"]
