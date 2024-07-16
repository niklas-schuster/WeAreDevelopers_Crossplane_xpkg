{{ $ID := $.observed.composite.resource.spec.id -}}
{{ $region := $.observed.composite.resource.spec.properties.region -}}
{{ $nodeCount := $.observed.composite.resource.spec.properties.nodes.count}}
{{ $nodeType := $.observed.composite.resource.spec.properties.nodes.type -}}
{{ $nodeSize := $.observed.composite.resource.spec.properties.nodes.size -}}
{{- define "instanceMap" -}}
types:
  general-purpose:
    small:  "m5.large"
    medium: "m5.xlarge"
    large:  "m5.4xlarge"
  compute-optimized:
    small:  "c7g.large"
    medium: "c7g.xlarge"
    large:  "c7g.4xlarge"
  memory-optimized:
    small:  "r5.large"
    medium: "r5.xlarge"
    large:  "r5.4xlarge"
  gpu-accelereted:
    small:  "g3.4xlarge"
    medium: "g3.8xlarge"
    large:  "g3.16xlarge"
{{- end -}}
---
apiVersion: eks.aws.upbound.io/v1beta1
kind: NodeGroup
metadata:
  name: {{ $ID }}-nodegroup
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: eks-nodegroup
spec:
  forProvider:
    region: {{ $region }}
    clusterNameSelector:
      matchControllerRef: true
    instanceTypes:
      - "{{ index (index (fromYaml (include "instanceMap" .)).types $nodeType) $nodeSize }}"
    nodeRoleArnSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-nodegroup
    scalingConfig:
      - desiredSize: {{ $nodeCount }}
        maxSize:  {{ $nodeCount }}
        minSize: {{ $nodeCount }}
    subnetIdSelector:
      matchLabels:
        nttdata.dach.accelerators/access: private
### Patches ###
#   status.atProvider.id >>> status.cluster.nodegroup.name
#   status.atProvider.nodeRoleArn >>> status.cluster.nodegroup.IAMRole
