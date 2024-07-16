{{- $ID := $.observed.composite.resource.spec.id -}}
---
apiVersion: kubernetes.crossplane.io/v1alpha1
kind: ProviderConfig
metadata:
  name: {{ $ID }}-cluster
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: kubernetes-provider-config
spec:
  credentials:
    secretRef:
      namespace: crossplane-system
      name: {{ $ID }}-cluster-auth
      key: kubeconfig
    source: Secret