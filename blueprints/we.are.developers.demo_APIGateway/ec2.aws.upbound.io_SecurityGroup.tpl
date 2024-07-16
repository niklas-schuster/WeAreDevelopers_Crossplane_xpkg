{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $REGION := $XR.spec.service.region -}}
{{- $VPC_ID := $XR.status.alb.vpcID -}}
---
apiVersion: ec2.aws.upbound.io/v1beta1
kind: SecurityGroup
metadata:
  name:  {{ $NAME }}-vpclink-sg
  labels:
    nttdata.dach.accelerators/sg: {{ $NAME }}-vpclink-sg
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: vpclink-sg
spec:
  forProvider:
    region: {{ $REGION }}
    vpcId:  {{ $VPC_ID }}
    
