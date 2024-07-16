{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $oidc := $.observed.composite.resource.status.cluster.oidc -}}
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: OpenIDConnectProvider
metadata:
  name: {{ $ID }}-openid-connect-provider
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: openid-connect-provider
spec:
  forProvider:
    url: {{ $oidc }}
    clientIdList:
      - sts.amazonaws.com
    thumbprintList:
      - 9e99a48a9960b14926bb7f3b02e22da2b0ab7280