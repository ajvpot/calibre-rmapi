FROM golang:alpine AS build
RUN apk add --no-cache git
ENV GO111MODULE=on
RUN go install github.com/juruen/rmapi@latest

FROM alpine
RUN apk update && apk add inotify-tools bash

ADD /run.sh /
COPY --from=build /go/bin/rmapi /

WORKDIR /
ENTRYPOINT ["/run.sh", "/data"]