{{- range $index, $subnet := ($.observed.composite.resource.spec.properties.subnets) }}
{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region -}}
{{ if $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: RouteTable
metadata:
  name: {{ $ID }}-rtb-public-{{ $subnet.availabilityZone }}
  labels:
    nttdata.dach.accelerators/access: public
    nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: rtb-public-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    vpcIdSelector:
      matchControllerRef: true
{{ end }}
{{ if not $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: RouteTable
metadata:
  name: {{ $ID }}-rtb-private-{{ $subnet.availabilityZone }}
  labels:
    nttdata.dach.accelerators/access: private
    nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: rtb-private-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    vpcIdSelector:
      matchControllerRef: true
{{- end }}
{{- end }}
