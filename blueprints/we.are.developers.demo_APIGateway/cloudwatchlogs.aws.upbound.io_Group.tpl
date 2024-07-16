{{- $xr := $.observed.composite.resource -}}
{{- $name := printf "/apigw/%s-%s" $xr.spec.service.name $xr.spec.service.stage -}}
{{- $region := $xr.spec.properties.region -}}
---
apiVersion: cloudwatchlogs.aws.upbound.io/v1beta1
kind: Group
metadata:
  name: {{ $name }}
spec:
  forProvider:
    region: {{ $region }}
    retentionInDays: 30
