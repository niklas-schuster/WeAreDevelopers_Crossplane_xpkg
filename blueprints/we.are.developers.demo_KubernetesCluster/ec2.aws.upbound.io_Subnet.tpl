{{- range $index, $subnet := ($.observed.composite.resource.spec.properties.subnets) }}
{{- $ID := $.observed.composite.resource.spec.id }}
{{- $suffix := printf "%s-%s" (ternary "public" "private" $subnet.public) $subnet.availabilityZone }}
# {{- $cidr := $subnet.cidrBlock | replace "." "-" | replace "/" "-"}}
# {{- $name := printf "%s-subnet-%s" ($.observed.composite.resource.spec.id) $cidr }}
{{- $region := $.observed.composite.resource.spec.properties.region }}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: Subnet
metadata:
  name: {{ $ID }}-subnet-{{ $suffix }}
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: subnet-{{ ternary "public" "private" $subnet.public }}-{{ $index }}
  labels:
    {{- range $key, $value := $subnet.selectors }}
    xuniversalcontrolplanes.nttdata.dach.accelerators/{{ $key }}: {{ $value | quote }}
    {{- end }}
    {{ if $subnet.public }}
    nttdata.dach.accelerators/access: public
    {{ else }}
    nttdata.dach.accelerators/access: private
    {{ end }}
    nttdata.dach.accelerators/zone: {{ $subnet.availabilityZone }}
spec:
  forProvider:
    cidrBlock: {{ $subnet.cidrBlock }}
    mapPublicIpOnLaunch: {{ $subnet.public }}
    region: {{ $region }}
    availabilityZone: {{ $subnet.availabilityZone }}
    tags:
      Name: {{ $ID }}-subnet-{{ $suffix }}
      Accelerator: Universal Control Plane
      kubernetes.io/role/internal-elb: "1"
      nttdata.dach.accelerators/selector: {{ $ID }}
      {{ if $subnet.public }}
      nttdata.dach.accelerators/access: public
      {{ else }}
      nttdata.dach.accelerators/access: private
      kubernetes.io/role/internal-elb: "1"
      {{ end }}
    vpcIdSelector:
      matchControllerRef: true
{{- end }}
