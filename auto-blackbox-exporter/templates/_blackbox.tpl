
{{- define "blackbox.blackbox-service-obj" -}}
{{- $blackboxService := dict "found" nil -}}
{{- $serviceName := "prometheus-blackbox-exporter" -}}
{{- $serviceSelectorLabel := "app.kubernetes.io/name" -}}
{{- range $svc := (lookup "v1" "Service" "" "").items -}}
{{- if eq (get ($svc.metadata.labels | default dict) $serviceSelectorLabel | default "") $serviceName }}
{{- $_ := set $blackboxService "found" $svc -}}
{{ end -}}
{{- end -}}
{{- if $blackboxService.found -}}
port: {{  ($blackboxService.found.spec.ports | first).port | quote }}
name: {{  $blackboxService.found.metadata.name  }}
namespace: {{  $blackboxService.found.metadata.namespace  }}
{{- else -}}
error: "No service with label app.kubernetes.io/name=prometheus-blackbox-exporter found"
{{- end -}}
{{- end }} {{/* end of define */}}


{{- define "blackbox.blackbox-service-endpoint" -}}
{{- $blackboxSvcObj := (include "blackbox.blackbox-service-obj" . | fromYaml) -}}
{{- if ($blackboxSvcObj).name }}
uri: "{{  $blackboxSvcObj.name  }}.{{  $blackboxSvcObj.namespace  }}:{{ $blackboxSvcObj.port }}"
{{- else -}} 
uri: "blackbox-service-endpoint-not-found.auto-blackbox-exporter.io:9115"
{{- end }} {{/* end of if */}}
{{- end }} {{/* end of define */}}
