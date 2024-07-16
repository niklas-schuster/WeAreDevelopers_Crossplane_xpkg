{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region }}
apiVersion: ec2.aws.upbound.io/v1beta1
kind: SecurityGroup
metadata:
  name: {{ $ID }}-nodegroup-sg
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-nodegroup-sg
spec:
  forProvider:
    description: Allow TLS inbound traffic
    name: {{ $ID }}-nodegroup-sg
    region: {{ $region }}
    vpcIdSelector:
      matchControllerRef: true
    tags:
      Name: {{ $ID }}-nodegroup-sg
      nttdata.dach.accelerators/selector: {{ $ID }}
