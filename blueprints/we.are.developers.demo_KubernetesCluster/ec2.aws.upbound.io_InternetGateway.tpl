{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: InternetGateway
metadata:
  name: {{ $ID }}-igw
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-igw
spec:
  forProvider:
    region: {{ $region }}
    tags:
      Name: {{ $ID }}-igw
      kubernetes.io/role/elb: "1"
    vpcIdSelector:
      matchControllerRef: true