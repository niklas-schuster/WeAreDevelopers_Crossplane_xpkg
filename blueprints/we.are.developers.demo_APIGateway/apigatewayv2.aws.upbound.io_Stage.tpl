{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
---
apiVersion: apigatewayv2.aws.upbound.io/v1beta1
kind: Stage
metadata:
  name: {{ $NAME }}-stage
  annotations:
    crossplane.io/external-name: "$default"
    gotemplating.fn.crossplane.io/composition-resource-name: stage
spec:
  forProvider:
    region: {{ $REGION }}
    autoDeploy: true
    apiIdSelector:
      matchControllerRef: true
    