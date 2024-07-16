{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region -}}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: MainRouteTableAssociation
metadata:
  name: {{ $ID }}-mrta
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: mrta
spec:
  forProvider:
    region: {{ $region }}
    routeTableIdSelector:
      matchControllerRef: true
    vpcIdSelector:
      matchControllerRef: true