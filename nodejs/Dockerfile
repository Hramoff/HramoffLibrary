ARG BASE_TAG=lts-slim

FROM harbor.ru/proxy.docker.io/library/node:${BASE_TAG}

RUN npm install -g bower \
 && npm install -g bower-installer \
 && npm install -g grunt-cli
