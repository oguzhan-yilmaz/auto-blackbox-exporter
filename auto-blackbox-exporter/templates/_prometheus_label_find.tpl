{{- define "blackbox.fetch-prometheus-objects" -}}
prometheusObjects:
{{ range $promObj := (lookup "monitoring.coreos.com/v1" "Prometheus" "" "").items }}
- {{ toYaml $promObj | nindent 2}}
{{ end }}  {{/* end of range promObj */}}
{{- end }} {{/* end of define */}}


{{- define "blackbox.prometheus" -}}
{{ $firstPromObj := first (include "blackbox.fetch-prometheus-objects" . | fromYaml).prometheusObjects -}}
{{ toYaml $firstPromObj }}
{{- end }} {{/* end of define */}}


{{- define "blackbox.prometheus-additional-scrape-config-labels" -}}
{{ $promObj :=  include "blackbox.prometheus" . | fromYaml -}}
{{ toYaml $promObj.spec.scrapeConfigSelector.matchLabels }}
{{- end }} {{/* end of define */}}


{{- define "blackbox.prometheus-namespace" -}}
{{ $promObj :=  include "blackbox.prometheus" . | fromYaml -}}
namespace: {{ $promObj.metadata.namespace }}
{{- end }} {{/* end of define */}}

{{- define "blackbox.prometheus-name" -}}
{{ $promObj :=  include "blackbox.prometheus" . | fromYaml -}}
name: {{ $promObj.metadata.name }}
{{- end }} {{/* end of define */}}