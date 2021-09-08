FROM alpine:3.14

RUN apk add --no-cache bash

ADD .docker/install-pwsh.alpine.sh .
RUN chmod +x /install-pwsh.alpine.sh
RUN /install-pwsh.alpine.sh && rm /install-pwsh.alpine.sh

RUN apk add --no-cache make
RUN apk add --no-cache p7zip

WORKDIR /workspace
