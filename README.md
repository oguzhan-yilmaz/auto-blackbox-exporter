# auto-blackbox-exporter

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/auto-blackbox-exporter)](https://artifacthub.io/packages/helm/auto-blackbox-exporter/auto-blackbox-exporter)

<!-- 

- https://promlabs.com/blog/2024/02/06/monitoring-tls-endpoint-certificate-expiration-with-prometheus/
- https://www.infracloud.io/blogs/monitoring-endpoints-kubernetes-blackbox-exporter/

- https://github.com/prometheus-operator/prometheus-operator/blob/main/Documentation/additional-scrape-config.md !!!!! -->


<!-- additionalScrapeConfigsSecret
    - prometheus.prometheusSpec.additionalScrapeConfigsSecret -->
## Features

- automatically finds with Helm `lookup` function:
    - Ingress hosts in your Cluster
    - Prometheus Service Monitor Labels
    - Blackbox Service Endpoint
    - 

## Dependencies


### Install [blacbox-exporter](https://artifacthub.io/packages/helm/prometheus-community/prometheus-blackbox-exporter)

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update prometheus-community

helm upgrade --install -n monitoring \
    -f blackbox-exporter.values.yaml \
    blackbox-exporter prometheus-community/prometheus-blackbox-exporter 
```
## Install auto-blacbox-exporter

```bash
helm repo add auto-blackbox-exporter https://oguzhan-yilmaz.github.io/auto-blackbox-exporter/

helm install -n monitoring \
    auto-blackbox-exporter auto-blackbox-exporter/auto-blackbox-exporter

helm install --version 0.1.1 -n monitoring \
    auto-blackbox-exporter auto-blackbox-exporter/auto-blackbox-exporter
```


## [optional] Generating blackbox-exporter configuration locally


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

      https://medium.com/@parikshitaksande/monitoring-apis-using-blackbox-exporter-18f916e421b4
      valid_status_codes: [200, 201, 202, 203, 204, 205, 206, 207, 208, 226, 401, 405]


```bash
helm uninstall auto-blackbox-exporter
```

## Prometheus


### Check days left for Certificate Expiry  

```promql
(probe_ssl_earliest_cert_expiry - time()) / 24 / 3600
```

<!-- ---------

fetaures:
- auto find prometheus config for correct labels
- 
probe_ssl_earliest_cert_expiry

---------
 -->

## Grafana Dashboards 

- https://grafana.com/grafana/dashboards/13659-blackbox-exporter-http-prober/
- https://grafana.com/grafana/dashboards/7587-prometheus-blackbox-exporter/
- https://grafana.com/grafana/dashboards/18538-blackbox-exporter/
