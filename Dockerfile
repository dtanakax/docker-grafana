# Set the base image
FROM tanaka0323/debianjp:wheezy

# File Author / Maintainer
MAINTAINER Daisuke Tanaka, tanaka@infocorpus.com

ENV DEBIAN_FRONTEND noninteractive
ENV GRAFANA_VERSION 2.0.1

RUN apt-get update && \
    apt-get install -y curl && \
    rm -rf /var/lib/apt/lists/*
RUN apt-get clean all

RUN curl -k http://grafanarel.s3.amazonaws.com/builds/grafana-$GRAFANA_VERSION.x86_64.tar.gz >> grafana.tar.gz && \
    tar zxvf grafana.tar.gz && \
    mv -f /grafana-$GRAFANA_VERSION /opt/grafana && \
    rm -f grafana.tar.gz

# Define mountable directories.
VOLUME ["/data", "/opt/grafana/conf"]

# Adding the configuration file
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Environment variables
ENV ADMIN_USER              admin
ENV ADMIN_PASSWORD          admin
ENV ALLOW_SIGN_UP           False

# Expose ports.
EXPOSE 3000

# Executing sh
ENTRYPOINT ./start.sh
