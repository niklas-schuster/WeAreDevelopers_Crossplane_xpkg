{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
{{- $INTEGRATION := $XR.status.integration.ID -}}
---
apiVersion: apigatewayv2.aws.upbound.io/v1beta1
kind: Route
metadata:
  name: {{ $NAME }}-route
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: route
spec:
  forProvider:
    apiIdSelector:
      matchControllerRef: true
    region: {{ $REGION }}
    routeKey: ANY /{proxy+}
    target: integrations/{{ $INTEGRATION }}
