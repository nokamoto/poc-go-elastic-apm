FROM golang:1.11.0-alpine3.8 AS build

RUN apk update && apk add git

WORKDIR /go/src/github.com/nokamoto/poc-go-elastic-apm

ENV GO111MODULE=on
ENV CGO_ENABLED=0

COPY go.mod go.mod
COPY go.sum go.cum
COPY protobuf ./protobuf
COPY *.go ./

RUN go build

FROM alpine:3.8

RUN apk update && apk add --no-cache ca-certificates

COPY --from=build /go/src/github.com/nokamoto/poc-go-elastic-apm/poc-go-elastic-apm /usr/local/bin/poc-go-elastic-apm

ENTRYPOINT [ "poc-go-elastic-apm" ]
