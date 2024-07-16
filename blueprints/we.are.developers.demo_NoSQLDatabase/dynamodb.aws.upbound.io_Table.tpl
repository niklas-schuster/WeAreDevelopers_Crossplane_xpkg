{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $TABLE_NAME := $XR.spec.table.name -}}
{{- $REGION := $XR.spec.service.region -}}
{{- $ATTRIBUTES := $XR.spec.table.attributes -}}
{{- $PRIMARY_KEY := $XR.spec.table.key -}}
---
apiVersion: dynamodb.aws.upbound.io/v1beta1
kind: Table
metadata:
  name: {{ $NAME }}-dynamodb-table
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: table
    crossplane.io/external-name: {{ $TABLE_NAME }}
spec:
  forProvider:
    attribute: 
    {{- range $ATTRIBUTES }}
    - name: {{ .name }}
      type: {{ .type }}
    {{- end }}
    billingMode: PAY_PER_REQUEST
    hashKey: {{ $PRIMARY_KEY }}
    region: {{ $REGION }}
