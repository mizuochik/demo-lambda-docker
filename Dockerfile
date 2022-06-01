
FROM golang:1.18 AS go

WORKDIR /build
COPY go.mod go.sum main.go ./
RUN CGO_ENABLED=0 go build -o demo-lambda-docker .

FROM alpine

WORKDIR /bin
COPY --from=go /build/demo-lambda-docker .
ADD https://github.com/aws/aws-lambda-runtime-interface-emulator/releases/latest/download/aws-lambda-rie ./aws-lambda-rie
RUN chmod +x ./aws-lambda-rie

WORKDIR /
COPY ./main.sh .
ENTRYPOINT [ "/main.sh" ]
