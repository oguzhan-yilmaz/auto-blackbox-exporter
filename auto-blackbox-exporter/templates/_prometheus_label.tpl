{{/* 
Actually call K8s API and get Prometheus objects
*/}}
{{- define "blackbox.fetch-prometheus-objects" -}}
prometheusObjects:
{{ range $promObj := (lookup "monitoring.coreos.com/v1" "Prometheus" "" "").items }}
- {{ toYaml $promObj | nindent 2}}
{{ end }}  {{/* end of range promObj */}}
{{- end }} {{/* end of define */}}

{{/* 
We only deal with one Prometheus obj, get the first one.
*/}}
{{- define "blackbox.prometheus" -}}
{{ $firstPromObj := first (include "blackbox.fetch-prometheus-objects" . | fromYaml).prometheusObjects -}}
{{ toYaml $firstPromObj }}
{{- end }} {{/* end of define */}}

{{/* 
Prometheus scrapeConfigSelector labels
*/}}
{{- define "blackbox.prometheus-additional-scrape-config-labels" -}}
{{ $promObj :=  include "blackbox.prometheus" . | fromYaml -}}
{{ toYaml $promObj.spec.scrapeConfigSelector.matchLabels }}
{{- end }} {{/* end of define */}}


{{/* 
Prometheus namespace
*/}}
{{- define "blackbox.prometheus-namespace" -}}
{{ $promObj :=  include "blackbox.prometheus" . | fromYaml -}}
{{ $promObj.metadata.namespace }}
{{- end }} {{/* end of define */}}

{{/* 
Prometheus name
*/}}
{{- define "blackbox.prometheus-name" -}}
{{ $promObj :=  include "blackbox.prometheus" . | fromYaml -}}
{{ $promObj.metadata.name }}
{{- end }} {{/* end of define */}}

{{/* 
Prometheus Service Monitor Labels
*/}}
{{- define "blackbox.prometheus-service-monitor-labels" -}}
{{ $promObj :=  include "blackbox.prometheus" . | fromYaml -}}
{{ toYaml $promObj.spec.serviceMonitorSelector.matchLabels }}
{{- end }} {{/* end of define */}}
