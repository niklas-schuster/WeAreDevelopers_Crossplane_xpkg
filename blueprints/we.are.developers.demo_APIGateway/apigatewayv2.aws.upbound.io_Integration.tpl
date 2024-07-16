{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
{{- $VPC_LINK := $XR.status.vpcLink.ID -}}
{{- $ALB_LISTENER := $XR.status.alb.listenerARN -}}
---
apiVersion: apigatewayv2.aws.upbound.io/v1beta1
kind: Integration
metadata:
  name: {{ $NAME }}-integration
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: integration
spec: 
  forProvider:
    region: {{ $REGION }}
    apiIdSelector:
      matchControllerRef: true
    integrationType: HTTP_PROXY
    connectionType: VPC_LINK
    connectionId: {{ $VPC_LINK }}
    payloadFormatVersion: "1.0"
    integrationMethod: ANY
    integrationUri: {{ $ALB_LISTENER }}
    