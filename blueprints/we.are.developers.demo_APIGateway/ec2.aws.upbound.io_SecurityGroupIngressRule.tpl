{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: SecurityGroupIngressRule
metadata:
  name: {{ $NAME }}-vpclink-sg-ingress-rule-80
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: vpclink-sg-ingress-80
spec:
  forProvider:
    cidrIpv4: 0.0.0.0/0
    fromPort: 80
    toPort: 80
    ipProtocol: tcp
    region: {{ $REGION }}
    securityGroupIdSelector:
      matchControllerRef: true
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: SecurityGroupIngressRule
metadata:
  name: {{ $NAME }}-vpclink-sg-ingress-rule-443
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: vpclink-sg-ingress-443
spec:
  forProvider:
    cidrIpv4: 0.0.0.0/0
    fromPort: 443
    toPort: 443
    ipProtocol: tcp
    region: {{ $REGION }}
    securityGroupIdSelector:
      matchControllerRef: true

