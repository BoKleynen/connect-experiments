FROM debian:bookworm-slim AS dev
RUN apt-get update && \
    apt-get install --no-install-recommends -y protobuf-compiler curl nodejs npm

RUN npm install -g corepack nodemon && \
    corepack enable

# Install go
ARG GO_VERSION=1.20
RUN curl -sSL "https://golang.org/dl/go${GO_VERSION}.linux-arm64.tar.gz" -o "go${GO_VERSION}.tar.gz" && \
    tar -C "/usr/local" -xzf "go${GO_VERSION}.tar.gz" && \
    mkdir -m 777 /go
ENV GOPATH="/go"
ENV PATH="/usr/local/go/bin:${GOPATH}/bin:${PATH}"

# install buf
RUN BIN="/usr/local/bin" && \
    VERSION="1.14.0" && \
      curl -sSL \
        "https://github.com/bufbuild/buf/releases/download/v${VERSION}/buf-$(uname -s)-$(uname -m)" \
        -o "${BIN}/buf" && \
      chmod +x "${BIN}/buf"
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.1 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0 && \
    go install github.com/bufbuild/connect-go/cmd/protoc-gen-connect-go@latest

WORKDIR /workspace

FROM dev AS backend-builder

WORKDIR /workspace/backend
COPY ./backend/go.mod ./backend/go.sum ./
RUN --mount=type=cache,mode=0777,target=/go/pkg/mod go mod download

COPY backend backend

RUN --mount=type=cache,mode=0777,target=/go/pkg/mod \
    --mount=type=cache,mode=0777,target=/.cache/go-build \
    CGO_ENABLED=0 GOOS=linux go build -o connect-experiments cmd/main.go

FROM scratch AS backend

WORKDIR /
COPY --from=backend-builder /workspace/backend/greeter greeter

ENTRYPOINT ["/connect-experiments", "serve"]
