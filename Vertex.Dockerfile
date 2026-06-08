# ========================================================
# Stage: Frontend (Vite)
# ========================================================

FROM node:22-trixie AS frontend
WORKDIR /src/frontend
COPY frontend/package.json frontend/package-lock.json ./
RUN npm ci
COPY frontend/ ./
COPY web/translation /src/web/translation
RUN npm run build


# ========================================================
# Stage: Builder
# ========================================================

FROM golang:1.26-trixie AS builder

WORKDIR /app

ARG TARGETARCH

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y \
      bash \
      build-essential \
      unzip \
      curl

COPY . .

COPY --from=frontend /src/web/dist ./web/dist

ENV CGO_ENABLED=1
ENV CGO_CFLAGS="-D_LARGEFILE64_SOURCE"

RUN go build -ldflags "-w -s" -o build/main main.go

RUN ./DockerInit.sh "$TARGETARCH" \
  && mv build/bin/xray-linux-amd64 build/bin/vertex-linux-amd64 \
  && dd if=/dev/zero bs=1M count=1 of=build/bin/vertex-linux-amd64 oflag=append conv=notrunc \
  && chmod +x build/bin/vertex-linux-amd64


# ========================================================
# Stage: Final Image of 3x-ui
# ========================================================

FROM debian:trixie-slim

ENV TZ=Europe/Moscow

WORKDIR /app

ENV DEBIAN_FRONTEND=noninteractive

COPY --from=builder /app/build/ /app/

RUN apt-get update \
    && apt-get dist-upgrade -y \
    && apt-get install -y --no-install-recommends \
      bash \
      ca-certificates \
      tzdata \
      curl \
      openssl \
    && apt-get autoremove -y \
    && apt-get autoclean -y \
    && rm -rf /var/lib/apt/lists/* /var/cache/apt/archives \
    && chmod +x /app/main

ENV XUI_IN_DOCKER="true"
ENV XUI_MAIN_FOLDER="/app"
# ENV XUI_ENABLE_FAIL2BAN="true"
ENV XUI_DB_TYPE=""
ENV XUI_DB_DSN=""

VOLUME [ "/etc/x-ui", "/root/cert" ]
ENTRYPOINT [ "/app/main" ]
