# auto-blackbox-exporter

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/auto-blackbox-exporter)](https://artifacthub.io/packages/helm/auto-blackbox-exporter/auto-blackbox-exporter)

Fully automatic `prometheus-blackbox-exporter` configuration with Helm.

Automatically create SSL Certificate Expiration alarms for Prometheus Alert Manager for your existing Ingress endpoints.

## Features

- 🔄 Automatic discovery of Ingress endpoints in your cluster
- 🔒 SSL Certificate Expiration Alert Manager Alerts 
- 🎯 Configurable alert thresholds for certificate expiration
- 🛠️ Auto configured prometheus blackbox-exporter settings

## Dependencies


### [blacbox-exporter](https://artifacthub.io/packages/helm/prometheus-community/prometheus-blackbox-exporter)

`prometheus-blackbox-exporter` chart is included as a Helm Dependency. 

If you have `prometheus-blackbox-exporter` installed, you should set it to `false` to skip installation.

```yaml
# values.yaml
blackboxExporter:
  install: false
```

## Installation

### Using Helm

```bash
# Add the Helm repository
helm repo add auto-blackbox-exporter https://oguzhan-yilmaz.github.io/auto-blackbox-exporter/

# Update the repository
helm repo update auto-blackbox-exporter

# print Helm Manifests that'd apply to K8s
helm template auto-blackbox-exporter/auto-blackbox-exporter --dry-run=server

# Install the chart
helm install -n monitoring \
    auto-blackbox-exporter auto-blackbox-exporter/auto-blackbox-exporter
```

### Using ArgoCD

You can use the `argocd-app.yaml` manifest from the repository:

```bash
kubectl apply -f https://raw.githubusercontent.com/oguzhan-yilmaz/auto-blackbox-exporter/main/argocd-app.yaml
```

## Configuration

### Certificate Expiration Alerts

Configure alert thresholds for SSL certificate expiration:

```yaml
prometheusRules:
  enabled: true
  expiringInfo:
    days: 30
    severity: info
  expiringWarning:
    days: 15
    severity: warning
  expiringCritical:
    days: 7
    severity: critical
```

### Additional Hosts

Monitor additional hosts that are not managed by Kubernetes Ingress:

```yaml
additionalHosts:
  - https://example.com
  - https://api.example.com
```

### Prometheus Scraping

Configure Prometheus scraping settings:

```yaml
prometheus:
  scrape_timeout: 60s
  scrape_interval: 180s
```

## Grafana Dashboards 

Recommended dashboards for monitoring your endpoints:

- [Blackbox Exporter HTTP Prober](https://grafana.com/grafana/dashboards/13659-blackbox-exporter-http-prober/)
- [Prometheus Blackbox Exporter](https://grafana.com/grafana/dashboards/7587-prometheus-blackbox-exporter/)
- [Blackbox Exporter Overview](https://grafana.com/grafana/dashboards/18538-blackbox-exporter/)

## Development

### Local Development

1. Clone the repository:
```bash
git clone https://github.com/oguzhan-yilmaz/auto-blackbox-exporter.git
cd auto-blackbox-exporter/
```

2. Update dependencies:
```bash
helm dependency update
```

3. Generate manifests:
```bash
helm template auto-blackbox-exporter/ --dry-run=server
```

4. Install locally:
```bash
helm upgrade --install \
    -n monitoring \
    auto-blackbox-exporter auto-blackbox-exporter/
```


## License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.