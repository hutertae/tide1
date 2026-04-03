FROM ubuntu:22.04

WORKDIR /app

COPY . .

RUN apt update && apt install -y curl ca-certificates

# install cloudflared
RUN curl -L https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64 \
-o /usr/local/bin/cloudflared && chmod +x /usr/local/bin/cloudflared

RUN chmod +x start.sh

CMD ["bash","start.sh"]
