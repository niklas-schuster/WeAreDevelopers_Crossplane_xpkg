{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
{{- $TABLE_NAME := $XR.spec.table.name -}}
apiVersion: iam.aws.upbound.io/v1beta1
kind: Policy
metadata:
  name: {{ $NAME }}-nosql-database-policy
  labels:
    nttdata.dach.accelerators/policy: {{ $NAME }}-nosql-database-policy
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: policy
spec:
  forProvider:
    policy: |
      {
          "Version": "2012-10-17",
          "Statement": [
              {
                  "Effect": "Allow",
                  "Action": [
                      "dynamodb:PutItem",
                      "dynamodb:DeleteItem",
                      "dynamodb:UpdateItem",
                      "dynamodb:GetItem",
                      "dynamodb:Scan"
                  ],
                  "Resource": "arn:aws:dynamodb:{{ $REGION }}:518283773752:table/{{ $TABLE_NAME }}"
              }
          ]
      }
