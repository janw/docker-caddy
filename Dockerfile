FROM golang:1.14-alpine as build

ENV GO111MODULE=on

WORKDIR /src
COPY . .
RUN go build -mod=vendor -o caddy

FROM alpine

RUN apk add --update tini
COPY --from=build /src/caddy /

ENTRYPOINT [ "tini", "--", "/caddy" ]
