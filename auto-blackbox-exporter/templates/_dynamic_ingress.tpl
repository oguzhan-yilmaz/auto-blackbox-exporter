{{/* 
Call K8s API and get all Ingress objects
Prefix with https:// if no protocol defined
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
Get K8s ingress objects and combine with .Values.additionalHosts
*/}}
{{- define "blackbox.ingress" -}}
{{- $ingressList := (include "blackbox.fetch-ingresses" . | fromYaml) -}}
{{- if  not (or $ingressList.hosts .Values.additionalHosts) }}
hosts: []
{{- else }} 
hosts:
{{- if $ingressList.hosts }} 
{{ toYaml $ingressList.hosts}}  
{{- end }} 
{{- if  .Values.additionalHosts }} {{/* append additionalHosts if exists  */}}
{{- range $host := .Values.additionalHosts }}
- {{ (or (hasPrefix "https://" $host) (hasPrefix "http://" $host)) | ternary $host (printf "https://%s" $host) }}
{{- end }}  {{/* end of range additionalHosts rules */}}
{{- end }} 
{{- end }} {{/* end of if $ingressList */}}
{{- end }} {{/* end of define */}}

