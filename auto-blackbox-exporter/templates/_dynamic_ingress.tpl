{{- define "blackbox.ingress" -}}
{{- $ingressList := (include "blackbox.fetch-ingresses" . | fromYaml) -}}
{{- if  $ingressList }}
{{ toYaml $ingressList}}  
{{- else }} 
hosts: false
{{- end }} {{/* end of if */}}
{{- end }} {{/* end of define */}}



{{- define "blackbox.fetch-ingresses" -}}
hosts:
{{- range $ingressobj := (lookup "networking.k8s.io/v1" "Ingress" "" "").items }}
{{- range $rule := $ingressobj.spec.rules }}
- {{ hasPrefix "https://" $rule.host | ternary $rule.host (printf "https://%s" $rule.host) }}
{{- end }}  {{/* end of range ingress rules */}}
{{- end }}  {{/* end of range ingress */}}
{{- end }} {{/* end of define */}}
