# auto-blackbox-exporter

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/auto-blackbox-exporter)](https://artifacthub.io/packages/search?repo=auto-blackbox-exporter)

<!-- 

- https://promlabs.com/blog/2024/02/06/monitoring-tls-endpoint-certificate-expiration-with-prometheus/
- https://www.infracloud.io/blogs/monitoring-endpoints-kubernetes-blackbox-exporter/

- https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/additional-scrape-config.md !!!!! -->


<!-- additionalScrapeConfigsSecret
    - prometheus.prometheusSpec.additionalScrapeConfigsSecret -->


## Installation


### Install blacbox-exporter

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update prometheus-community

helm install -n monitoring \
    blackbox-exporter prometheus-community/prometheus-blackbox-exporter 
```

### Install auto-blacbox-exporter

```bash
helm repo add auto-blackbox-exporter https://oguzhan-yilmaz.github.io/auto-blackbox-exporter/

helm install auto-blackbox-exporter auto-blackbox-exporter/auto-blackbox-exporter

helm install --version 0.1.1 auto-blackbox-exporter auto-blackbox-exporter/auto-blackbox-exporter
```


## Generating blackbox-exporter configuration locally


### Generate Manifests with Helm

```bash
git clone https://github.com/oguzhan-yilmaz/auto-blackbox-exporter.git
cd auto-blackbox-exporter/

# vim values.yaml

helm template auto-blackbox-exporter/ --dry-run=server

helm template auto-blackbox-exporter/ --dry-run=server > additional-config.yaml
```

### Install with helm locally

```bash
helm upgrade --install \
    -n monitoring \
    auto-blackbox-exporter auto-blackbox-exporter/
```


```bash
helm uninstall auto-blackbox-exporter
```


<!-- ---------

fetaures:
- auto find prometheus config for correct labels
- 
probe_ssl_earliest_cert_expiry

---------
 -->

