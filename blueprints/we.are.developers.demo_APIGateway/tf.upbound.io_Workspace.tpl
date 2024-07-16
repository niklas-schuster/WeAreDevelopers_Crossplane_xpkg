{{- $XR := $.observed.composite.resource -}}
{{- $NAME := $XR.spec.service.name -}}
{{- $CLUSTER := $XR.spec.service.cluster -}}
apiVersion: tf.upbound.io/v1beta1
kind: Workspace
metadata:
  name: {{ $NAME }}-values
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: fetch-values
spec:
  managementPolicies: ["Create", "Observe", "Update", "LateInitialize"]
  forProvider:
    source: Inline
    module: |
        data "aws_lb" "ingress_alb" {
          name = "{{ $CLUSTER }}-services"
        }
        data "aws_lb_listener" "select80" {
          load_balancer_arn = data.aws_lb.ingress_alb.arn
          port = 80
        }
        output "vpcID" {
          value = data.aws_lb.ingress_alb.vpc_id
        }
        output "subnetIDs" {
          value = data.aws_lb.ingress_alb.subnets
        }
        output "listenerARN" {
          value = data.aws_lb_listener.select80.arn
        }