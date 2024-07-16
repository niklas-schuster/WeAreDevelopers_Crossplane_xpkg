{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $REGION := $.observed.composite.resource.spec.properties.region -}}
{{- $VPC_ID := $.observed.composite.resource.status.cluster.vpcID -}}
---
apiVersion: helm.crossplane.io/v1beta1
kind: Release
metadata:
  name: aws-alb-controller
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: release-alb-controller
spec:
  rollbackLimit:  3
  deletionPolicy: Orphan
  forProvider:
    chart:
      name: aws-load-balancer-controller
      repository: https://aws.github.io/eks-charts
      version: 1.8.1
    namespace: kube-system
    values:
      fullnameOverride: aws-load-balancer-controller
      clusterName: {{ $ID }}-eks-cluster
      serviceAccount:
        create: false
        name: aws-load-balancer-controller-sa
      region: {{ $REGION }}
      vpcId: {{ $VPC_ID }}
  providerConfigRef:
    name: {{ $ID }}-cluster
---
apiVersion: helm.crossplane.io/v1beta1
kind: Release
metadata:
  name: crossplane
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: release-crossplane
spec:
  rollbackLimit: 3
  deletionPolicy: Orphan
  forProvider:
    namespace: crossplane-system
    chart:
      name:       crossplane
      repository: https://charts.crossplane.io/stable
      version:    1.16.0
  providerConfigRef:
    name: {{ $ID }}-cluster