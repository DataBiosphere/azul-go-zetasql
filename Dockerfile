ARG azul_docker_go_zetasql_base_image_tag

FROM golang:${azul_docker_go_zetasql_base_image_tag}

ARG azul_docker_go_zetasql_internal_version

RUN apt-get update && apt-get install -y --no-install-recommends clang

ENV CGO_ENABLED 1
ENV CXX clang++
ENV CGO_CFLAGS="-fno-PIC"
ENV CGO_CPPFLAGS="-fno-PIC"
ENV CGO_CXXFLAGS="-fno-PIC"

WORKDIR /go-zetasql

COPY ./go.* ./
RUN go mod download

COPY . ./

RUN go install -buildmode=archive .
