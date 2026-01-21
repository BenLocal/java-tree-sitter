FROM alpine:3.19 AS build
LABEL maintainer="Ozren Dabić (dabico@usi.ch)"

ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk"

RUN apk update && \
    apk add --no-cache \
    openjdk11 \
    python3 \
    make \
    g++

WORKDIR /java-tree-sitter
COPY . ./

RUN python build.py

FROM scratch AS export

WORKDIR /

COPY --from=build /java-tree-sitter/libjava-tree-sitter.so .
