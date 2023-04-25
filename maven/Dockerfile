ARG BASE_TAG=17


FROM harbor.ru/proxy.docker.io/bellsoft/liberica-openjdk-alpine:${BASE_TAG}

COPY mvnw /usr/local/bin
COPY .mvn /usr/local/bin/.mvn

RUN chmod +x /usr/local/bin/mvnw