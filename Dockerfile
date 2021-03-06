# Build image
FROM golang:1.14 AS build-env
WORKDIR /root/
COPY . ./
RUN CGO_ENABLED=0 GOOS=linux go build -a

# Runtime image
FROM alpine:3.11 AS runtime-env
WORKDIR /root/
COPY --from=build-env /root/ddns-digital-ocean ./
COPY records.yaml ./records.yaml
RUN apk update && apk add ca-certificates curl bash
CMD ["./ddns-digital-ocean"]
