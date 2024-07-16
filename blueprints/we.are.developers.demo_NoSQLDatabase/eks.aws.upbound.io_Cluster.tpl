{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $CLUSTER := $XR.spec.service.cluster -}}
{{- $REGION := $XR.spec.service.region -}}
---
apiVersion: eks.aws.upbound.io/v1beta1
kind: Cluster
metadata:
  name: {{ $NAME }}-{{ $CLUSTER }}-fetch
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: eks-cluster
    crossplane.io/external-name: {{ $CLUSTER }}
spec:
  forProvider:
    region: {{ $REGION }}
  managementPolicies: ["Observe"]
