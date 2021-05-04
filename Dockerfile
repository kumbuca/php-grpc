FROM golang:1.16 AS build
WORKDIR /src

COPY go.mod go.mod
COPY go.sum go.sum
RUN go mod download -x

COPY . .
RUN ./build.sh Linux

FROM scratch
COPY --from=build /src/rr-grpc /rr-grpc
ENTRYPOINT ["/rr-grpc"]
