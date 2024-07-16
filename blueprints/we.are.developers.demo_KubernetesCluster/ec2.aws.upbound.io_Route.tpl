{{- range $index, $subnet := ($.observed.composite.resource.spec.properties.subnets) }}
{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region -}}
{{ if $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: Route
metadata:
  name: {{ $ID }}-route-igw-{{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: route-igw-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    destinationCidrBlock: 0.0.0.0/0
    gatewayIdSelector:
      matchControllerRef: true
    routeTableIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/access: public
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
{{ end }}
{{ if not $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: Route
metadata:
  name: {{ $ID }}-route-natgw-{{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: route-natgw-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    destinationCidrBlock: 0.0.0.0/0
    natGatewayIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
    routeTableIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/access: private
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
{{- end }}
{{- end }}