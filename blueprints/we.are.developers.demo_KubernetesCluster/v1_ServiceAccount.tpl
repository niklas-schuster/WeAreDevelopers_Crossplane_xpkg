{{- $ROLE := $.observed.composite.resource.status.cluster.albControllerRole -}}
apiVersion: v1
kind: ServiceAccount
metadata:
  name: aws-load-balancer-controller-sa
  namespace: kube-system
  annotations:
    eks.amazonaws.com/role-arn: {{ $ROLE }}