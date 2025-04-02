FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y ocproxy curl lsof procps ssh iputils-ping dnsutils&& \
    apt-get clean && \
    rm -rf /var/cache/apt/* && \
    rm -rf /var/lib/apt/lists/* \
    echo 'deb http://download.opensuse.org/repositories/home:/bluca:/openconnect/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/home:bluca:openconnect.list \
    curl -fsSL https://download.opensuse.org/repositories/home:bluca:openconnect/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home_bluca_openconnect.gpg > /dev/null \
    apt update \
    apt install openconnect 

COPY vpn-open vpn-close /usr/bin/
RUN chmod +x /usr/bin/vpn-open & chmod +x /usr/bin/vpn-close

LABEL org.label-schema.schema-version="1.0" \
    org.label-schema.name="yoep/openconnect" \
    org.label-schema.description="Create a VPN tunnel to your on premise services" \
    org.label-schema.vcs-url="https://github.com/yoep/docker-openconnect"
