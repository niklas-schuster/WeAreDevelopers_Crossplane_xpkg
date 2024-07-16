{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $cluster := $.observed.composite.resource.status.cluster.name -}}
{{- $region := $.observed.composite.resource.spec.properties.region }}
---
apiVersion: eks.aws.upbound.io/v1beta1
kind: Addon
metadata:
  name: {{ $ID }}-aws-ebs-csi-driver
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: aws-ebs-csi-driver
    crossplane.io/external-name: {{ $cluster }}:aws-ebs-csi-driver
spec:
  forProvider:
    region: {{ $region }}
    addonName: aws-ebs-csi-driver
    clusterNameSelector:
      matchControllerRef: true
---
apiVersion: eks.aws.upbound.io/v1beta1
kind: Addon
metadata:
  name: {{ $ID }}-vpc-cni
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: vpc-cni
    crossplane.io/external-name: {{ $cluster }}:vpc-cni
spec:
  forProvider:
    region: {{ $region }}
    addonName: vpc-cni
    clusterNameSelector:
      matchControllerRef: true
    preserve: false