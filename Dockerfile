FROM alpine:3.5

ENV prometheus_version 2.1.0

RUN apk update \
    && apk add --no-cache curl tar \
    && curl -LO https://github.com/prometheus/prometheus/releases/download/v${prometheus_version}/prometheus-${prometheus_version}.linux-amd64.tar.gz \
    && tar -xvzf prometheus-${prometheus_version}.linux-amd64.tar.gz \
    && mv prometheus-${prometheus_version}.linux-amd64/prometheus* /bin/ \
    && apk del --purge curl tar

VOLUME /etc/prometheus

VOLUME /var/prometheus

ENTRYPOINT ["/bin/prometheus", \ 
            "--config.file", "/var/prometheus/config/prometheus.yml" \ 
            "--storage.tsdb.path", "/var/prometheus/data"]

EXPOSE 9090
