{{- $ID := $.observed.composite.resource.spec.id -}}
---
apiVersion: kubernetes.crossplane.io/v1alpha1
kind: Object
metadata:
  name: {{ $ID }}-aws-auth-cm
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: aws-auth-cm
spec:
  deletionPolicy: Orphan
  forProvider:
    manifest:
      {{ include "v1_ConfigMap" . | nindent 6 }}
  providerConfigRef:
    name: {{ $ID }}-cluster
---
apiVersion: kubernetes.crossplane.io/v1alpha1
kind: Object
metadata:
  name: {{ $ID }}-argocd-cluster-secret
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: argocd-cluster-secret
spec:
  deletionPolicy: Orphan
  forProvider:
    manifest:
      {{ include "v1_Secret" . | nindent 6 }}
---
apiVersion: kubernetes.crossplane.io/v1alpha1
kind: Object
metadata:
  name: {{ $ID }}-alb-controller-sa
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: alb-controller-sa
spec:
  deletionPolicy: Orphan
  forProvider:
    manifest:
      {{ include "v1_ServiceAccount" . | nindent 6 }}
  providerConfigRef:
    name: {{ $ID }}-cluster