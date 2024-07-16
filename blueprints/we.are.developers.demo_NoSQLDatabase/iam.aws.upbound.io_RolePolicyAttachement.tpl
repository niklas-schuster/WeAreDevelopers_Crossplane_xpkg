{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $NAME }}-iam-role-attachment-nosql-database
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: role-attachment
spec:
  forProvider:
    roleSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $NAME }}-iam-role-nosql-database
    policyArnSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/policy: {{ $NAME }}-nosql-database-policy