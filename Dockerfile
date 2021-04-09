FROM golang:alpine AS build
RUN apk add --no-cache git
RUN go get -u github.com/juruen/rmapi
RUN go install github.com/juruen/rmapi

FROM alpine
RUN apk update && apk add inotify-tools bash

ADD /run.sh /
COPY --from=build /go/bin/rmapi /

WORKDIR /
ENTRYPOINT ["/run.sh", "/data"]