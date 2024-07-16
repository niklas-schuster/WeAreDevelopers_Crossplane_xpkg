{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $NAMESPACE := $XR.spec.service.namespace -}}
{{- $SERVICE_ACCOUNT := $XR.spec.service.serviceAccount -}}
{{- $OIDC_PROVIDER := ($XR.status.cluster.oidc | toString ) -}}
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: Role
metadata:
  name: {{ $NAME }}-iam-role-nosql-database
  labels:
    nttdata.dach.accelerators/role: {{ $NAME }}-iam-role-nosql-database
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: role
spec:
  forProvider:
    assumeRolePolicy: |
      {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Principal": {
                    "Federated": "arn:aws:iam::518283773752:oidc-provider/{{ trimPrefix "https://" $OIDC_PROVIDER }}"
                },
                {{ if eq $OIDC_PROVIDER nil }}
                "Action": "sts:AssumeRoleWithWebIdentity"
                {{ else }}
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Condition": {
                    "StringEquals": {
                        "{{ trimPrefix "https://" $OIDC_PROVIDER }}:sub": "system:serviceaccount:{{ $NAMESPACE }}:{{ $SERVICE_ACCOUNT }}"
                    }
                {{ end }} 
                }
            }
        ]
      }