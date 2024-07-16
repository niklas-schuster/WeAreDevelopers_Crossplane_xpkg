{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $CA_DATA := $.observed.composite.resource.status.cluster.caData -}}
{{- $SERVER := $.observed.composite.resource.status.cluster.endpoint -}}
{{- $ARN := $.observed.composite.resource.status.cluster.arn -}}
{{- $ROLE := $.observed.composite.resource.status.cluster.argocdRole -}}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $ID }}-eks-cluster
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: cluster
type: Opaque
stringData:
  name: {{ $ARN }}
  server: {{ $SERVER }}
  config: |
    {
      "awsAuthConfig": {
          "clusterName": "{{ $ID }}-eks-cluster",
          "roleARN": "{{ $ROLE }}"
      },
      "tlsClientConfig": {
        "insecure": false,
        "caData": "{{ $CA_DATA }}"
      }
    }