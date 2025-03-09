# auto-blackbox-exporter

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/auto-blackbox-exporter)](https://artifacthub.io/packages/helm/auto-blackbox-exporter/auto-blackbox-exporter)

Fully automatic `prometheus-blackbox-exporter` configuration with Helm.

Automatically create SSL Certificate Expiration alarms for Prometheus Alert Manager for your existing Ingress endpoints.

Utilizes Helm `lookup` function to:

- Find Ingress hosts in your Cluster
- Prometheus Service Monitor labels
- Blackbox Service Endpoint (for scraping)


## Dependencies


### [blacbox-exporter](https://artifacthub.io/packages/helm/prometheus-community/prometheus-blackbox-exporter)

`prometheus-blackbox-exporter` chart is included as a Helm Dependency. 

If you have `prometheus-blackbox-exporter` installed, you should set it to `false` to skip installation.

```yaml
blackboxExporter:
  install: false
```

## Install auto-blacbox-exporter

```bash
helm repo add auto-blackbox-exporter https://oguzhan-yilmaz.github.io/auto-blackbox-exporter/

helm repo update auto-blackbox-exporter

helm install -n monitoring \
    auto-blackbox-exporter auto-blackbox-exporter/auto-blackbox-exporter
```


## [optional] Generating blackbox-exporter configuration locally


### Generate Manifests with Helm


**Generate .yaml manifests**

```bash
git clone https://github.com/oguzhan-yilmaz/auto-blackbox-exporter.git
cd auto-blackbox-exporter/

# vim values.yaml

helm template auto-blackbox-exporter/ --dry-run=server
```

**Install w/ helm locally**

```bash
helm upgrade --install \
    -n monitoring \
    auto-blackbox-exporter auto-blackbox-exporter/

# uninstallation
helm uninstall auto-blackbox-exporter
```

## Grafana Dashboards 

Recommended dashboards for Prometheus Blackbox Exporer 

- https://grafana.com/grafana/dashboards/13659-blackbox-exporter-http-prober/
- https://grafana.com/grafana/dashboards/7587-prometheus-blackbox-exporter/
- https://grafana.com/grafana/dashboards/18538-blackbox-exporter/


## Misc

### Check days left for Certificate Expiry  

```promql
(probe_ssl_earliest_cert_expiry - time()) / 24 / 3600
```