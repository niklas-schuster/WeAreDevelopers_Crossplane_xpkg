{{- $ID := $.observed.composite.resource.spec.id -}}
---
apiVersion: helm.crossplane.io/v1beta1
kind: ProviderConfig
metadata:
  name: {{ $ID }}-cluster
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: helm-provider-config
spec:
  credentials:
    secretRef:
      namespace: crossplane-system
      name: {{ $ID }}-cluster-auth
      key: kubeconfig
    source: Secret