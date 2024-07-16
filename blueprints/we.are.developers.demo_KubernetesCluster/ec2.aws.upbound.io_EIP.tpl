{{- range $index, $subnet := ($.observed.composite.resource.spec.properties.subnets) }}
{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region -}}
{{ if $subnet.public }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: EIP
metadata:
  name: {{ $ID }}-eip-{{ $subnet.availabilityZone }}
  labels:
    nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: eip-{{ $subnet.availabilityZone }}
spec:
  forProvider:
    region: {{ $region }}
    vpc: true
{{- end }}
{{- end }}
