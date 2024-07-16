{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $region := $.observed.composite.resource.spec.properties.region }}
{{- $version := $.observed.composite.resource.spec.properties.version -}}
---
apiVersion: eks.aws.upbound.io/v1beta1
kind: Cluster
metadata:
  name: {{ $ID }}-eks-cluster
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: eks-cluster
spec:
  forProvider:
    region: {{ $region }}
    version: {{ $version | quote }}
    roleArnSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-controlplane
    vpcConfig:
      - endpointPrivateAccess: true
        endpointPublicAccess: true
        subnetIdSelector:
          matchControllerRef: true
          matchLabels:
            nttdata.dach.accelerators/access: private
    accessConfig:
      - authenticationMode: API_AND_CONFIG_MAP
        bootstrapClusterCreatorAdminPermissions: true

### Patches ###
#   status.atProvider.id >>> status.cluster.name
#   status.atProvider.identity[0].oidc[0].issuer >>> status.cluster.oidc
#   status.atProvider.identity[0].oidc[0].issuer >>> status.cluster.oidcUri (transforms: string: trim: https:// type: TrimPrefix) 
#   status.atProvider.roleArn >>> status.cluster.accountId (transforms: string: regexp: group: 1 match: arn:aws:iam::(\d+):.* type: Regexp)
#   status.atProvider.vpcConfig[0].clusterSecurityGroupId >>> status.cluster.clusterSecurityGroupId
#   status.atProvider.certificateAuthority.data >>> status.cluster.caData
#   status.atProvider.endpoint >>> status.cluster.endpoint