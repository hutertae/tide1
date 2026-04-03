FROM ubuntu:22.04

RUN apt update && apt install -y \
    ca-certificates \
    bash \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY . .

# install cloudflared (WAJIB karena dipakai di start.sh)
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
    -o /usr/local/bin/cloudflared \
    && chmod +x /usr/local/bin/cloudflared

# permission
RUN chmod +x docker start.sh

# healthcheck (cek binary jalan)
HEALTHCHECK CMD pgrep docker || exit 1

CMD ["./start.sh"]
