{{ $ID := $.observed.composite.resource.spec.id -}}
{{ $region := $.observed.composite.resource.spec.properties.region -}}
---
apiVersion: eks.aws.upbound.io/v1beta1
kind: ClusterAuth
metadata:
  name: {{ $ID }}-cluster-auth
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: cluster-auth
spec:
  forProvider:
    clusterNameSelector:
      matchControllerRef: true
    region: {{ $region }}
  writeConnectionSecretToRef:
    namespace: crossplane-system
    name:  {{ $ID }}-cluster-auth