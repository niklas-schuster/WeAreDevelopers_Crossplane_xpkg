{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: SecurityGroupEgressRule
metadata:
  name: {{ $NAME }}-vpclink-sg-egress-rule
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: vpclink-sg-egress
spec:
  forProvider:
    cidrIpv4: 0.0.0.0/0
    ipProtocol: "-1"
    region: {{ $REGION }}
    securityGroupIdSelector:
      matchControllerRef: true
