{{- range $index, $subnet := ($.observed.composite.resource.spec.properties.subnets) }}
{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region -}}
{{ if $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: RouteTableAssociation
metadata:
  name: {{ $ID }}-route-table-assoc-public-{{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: route-table-assoc-public-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    routeTableIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/access: public
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
    subnetIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/access: public
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
{{ end }}
{{ if not $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: RouteTableAssociation
metadata:
  name: {{ $ID }}-route-table-assoc-private-{{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: route-table-assoc-private-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    routeTableIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/access: private
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
    subnetIdSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/access: private
        nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
{{ end }}
{{- end }}