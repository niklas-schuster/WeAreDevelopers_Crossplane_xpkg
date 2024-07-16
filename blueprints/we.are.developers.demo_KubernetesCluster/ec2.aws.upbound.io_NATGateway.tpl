{{- range $index, $subnet := ($.observed.composite.resource.spec.properties.subnets) }}
{{- $ID := $.observed.composite.resource.spec.id }}
{{- $region := $.observed.composite.resource.spec.properties.region }}
{{ if $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: NATGateway
metadata:
  name: {{ $ID }}-natgw-{{ $subnet.availabilityZone }}
  labels:
    nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-natgw-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    connectivityType: public
    allocationIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
    subnetIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/access: public
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
    tags:
      Name: {{ $ID }}-natgw-{{ $subnet.availabilityZone }}
{{ end }}
{{- end }}