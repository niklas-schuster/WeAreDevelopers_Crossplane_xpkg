{{- $region := $.observed.composite.resource.spec.properties.region -}}
{{- $cidr := $.observed.composite.resource.spec.properties.networkCIDR -}}
{{- $name := printf "%s-vpc" $.observed.composite.resource.spec.id -}}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: VPC
metadata:
  name: {{ $name }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: vpc
spec:
  forProvider:
    cidrBlock: {{ $cidr }}
    enableDnsHostnames: true
    enableDnsSupport: true
    region: {{ $region }}
    tags:
      Name: {{ $name }}