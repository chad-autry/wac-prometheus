FROM alpine:3.5

ENV prometheus_version 2.1.0

RUN apk update \
    && apk add --no-cache curl tar \
    && curl -LO https://github.com/prometheus/prometheus/releases/download/v${prometheus_version}/prometheus-${prometheus_version}.linux-amd64.tar.gz \
    && tar -xvzf prometheus-${prometheus_version}.linux-amd64.tar.gz \
    && mkdir -p /etc/prometheus /var/lib/prometheus \
    && cp prometheus-${prometheus_version}.linux-amd64/promtool /usr/local/bin/ \
    && cp prometheus-${prometheus_version}.linux-amd64/prometheus /usr/local/bin/ \
    && cp -R prometheus-${prometheus_version}.linux-amd64/console_libraries/ /etc/prometheus/ \
    && cp -R prometheus-${prometheus_version}.linux-amd64/consoles/ /etc/prometheus/ \
    && rm -rf prometheus-${prometheus_version}.linux-amd64* \
    && apk del --purge curl tar

VOLUME /etc/prometheus

VOLUME /var/prometheus

ENTRYPOINT /usr/local/bin/prometheus \ 
            --config.file /etc/prometheus/prometheus.yml \ 
            --storage.tsdb.path /var/prometheus/ \
            --web.console.libraries=/usr/share/prometheus/console_libraries \
            --web.console.templates=/usr/share/prometheus/consoles

EXPOSE 9090
