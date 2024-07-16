{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
{{- $SUBNETS := $XR.status.alb.subnetIDs -}}
---
apiVersion: apigatewayv2.aws.upbound.io/v1beta1
kind: VPCLink
metadata:
  name: {{ $NAME }}-vpclink
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: vpclink
spec:
  forProvider:
    name:   {{ $NAME }}-vpclink
    region: {{ $REGION }}
    securityGroupIdSelector:
      matchLabels:
        nttdata.dach.accelerators/sg: {{ $NAME }}-vpclink-sg
    subnetIds: 
    {{- range $SUBNETS }}
    - {{ . }}
    {{- end }}
