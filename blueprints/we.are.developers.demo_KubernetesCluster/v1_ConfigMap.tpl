{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $nodeGroupRole := $.observed.composite.resource.status.cluster.nodegroup.IAMRole -}}
{{- $accessRole := $.observed.composite.resource.spec.properties.auth.role -}}
{{- $ARGOCD_ROLE := $.observed.composite.resource.status.cluster.argocdRole -}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: {{ $nodeGroupRole }}
      username: system:node:{{ printf "{{EC2PrivateDNSName}}" }}
    - groups:
      - system:masters
      rolearn: {{ $accessRole }}
      username: administrator
    - groups:
      - system:masters
      rolearn: {{ $ARGOCD_ROLE }}
      username: argocd
  # mapUsers: |
  #   - groups:
  #     - system:masters
  #     userarn: %s
  #     username: adminuser
