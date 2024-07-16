{{- define "v1_ConfigMap-template" }}
{{- printf "{{- define \"v1_ConfigMap\" }}" }}
{{ (.Files.Get "blueprints/we.are.developers.demo_KubernetesCluster/v1_ConfigMap.tpl") }}
{{ printf "{{ end }}" }}
{{- end }}
{{- define "v1_Secret-template" }}
{{- printf "{{- define \"v1_Secret\" }}" }}
{{ (.Files.Get "blueprints/we.are.developers.demo_KubernetesCluster/v1_Secret.tpl") }}
{{ printf "{{ end }}" }}
{{- end }}
{{- define "v1_ServiceAccount-template" }}
{{- printf "{{- define \"v1_ServiceAccount\" }}" }}
{{ (.Files.Get "blueprints/we.are.developers.demo_KubernetesCluster/v1_ServiceAccount.tpl") }}
{{ printf "{{ end }}" }}
{{- end }}