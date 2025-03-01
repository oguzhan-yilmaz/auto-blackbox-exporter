{{/* 


*/}}
{{- define "blackbox.fetch-ingresses" -}}
hosts:
{{- range $ingressobj := (lookup "networking.k8s.io/v1" "Ingress" "" "").items }}
{{- range $rule := $ingressobj.spec.rules }}
- {{ (or (hasPrefix "https://" $rule.host) (hasPrefix "http://" $rule.host)) | ternary $rule.host (printf "https://%s" $rule.host) }}
{{- end }}  {{/* end of range ingress rules */}}
{{- end }}  {{/* end of range ingress */}}
{{- end }} {{/* end of define */}}

{{/* 


*/}}
{{- define "blackbox.ingress" -}}
{{- $ingressList := (include "blackbox.fetch-ingresses" . | fromYaml) -}}
{{- if  not (or $ingressList.hosts .Values.additinalHosts) }}
hosts: []
{{- else }} 
hosts:
{{- if $ingressList.hosts }} 
{{ toYaml $ingressList.hosts}}  
{{- end }} 
{{- if  .Values.additinalHosts }} {{/* append additionalHosts if exists  */}}
{{- range $host := .Values.additinalHosts }}
- {{ (or (hasPrefix "https://" $host) (hasPrefix "http://" $host)) | ternary $host (printf "https://%s" $host) }}
{{- end }}  {{/* end of range additinalHosts rules */}}
{{- end }} 
{{- end }} {{/* end of if $ingressList */}}
{{- end }} {{/* end of define */}}

