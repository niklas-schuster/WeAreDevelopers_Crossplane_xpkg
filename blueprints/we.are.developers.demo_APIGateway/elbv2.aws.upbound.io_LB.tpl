{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.cluster -}}
{{- $REGION := $XR.spec.service.region -}}
---
apiVersion: elbv2.aws.upbound.io/v1beta1
kind: LB
metadata:
  name: {{ $NAME }}-services-lb
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: lb
spec:
  forProvider:
    loadBalancerType: application
    name: dev-cluster-services
    region: {{ $REGION }}
  managementPolicies: ["Observe"]