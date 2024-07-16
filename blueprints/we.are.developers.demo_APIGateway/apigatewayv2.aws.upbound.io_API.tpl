{{- $xr := $.observed.composite.resource -}}
{{- $name := $xr.spec.service.name -}}
{{- $desc := printf "%s API for %s" $xr.spec.properties.protocol $xr.spec.service.name -}}
{{- $region := $xr.spec.service.region -}}
{{- $protocal := $xr.spec.properties.protocol -}}
---
apiVersion: apigatewayv2.aws.upbound.io/v1beta1
kind: API
metadata:
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: api-gateway
spec:
  forProvider:
    name: {{ $name }}-api
    region: {{ $region }}
    protocolType: {{ $protocal }}
    description: {{ $desc }}
### Patches ###
#   status.atProvider.apiID >>> status.apiID
#   metadata.annotations[javaland.cloud.platform.api/stage] >>> status.account (transforms: map: dev: 518283773752, qa: 518283773752)
