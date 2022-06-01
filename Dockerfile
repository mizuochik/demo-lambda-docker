
FROM golang:1.18 AS go

WORKDIR /build

COPY go.mod main.go ./

RUN CGO_ENABLED=0 go build -o demo-lambda-docker .

FROM gcr.io/distroless/static

WORKDIR /bin

COPY --from=go /build/demo-lambda-docker .

ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie /bin/aws-lambda-rie
