{{- $ID := $.observed.composite.resource.spec.id -}}
{{- $OIDC_PROVIDER := ($.observed.composite.resource.status.cluster.oidc | toString ) -}}
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: Role
metadata:
  name: {{ $ID }}-iam-role-controlplane
  labels:
    nttdata.dach.accelerators/role: {{ $ID }}-iam-role-controlplane
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-controlplane
spec:
  forProvider:
    assumeRolePolicy: |
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": {
              "Service": "eks.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
          }
        ]
      }
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: Role
metadata:
  name: {{ $ID }}-iam-role-nodegroup
  labels:
    nttdata.dach.accelerators/role: {{ $ID }}-iam-role-nodegroup
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-nodegroup
spec:
  forProvider:
    assumeRolePolicy: |
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": {
                "Service": "ec2.amazonaws.com"
            },
            "Action": "sts:AssumeRole"
          }
        ]
      }
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: Role
metadata:
  name: {{ $ID }}-iam-role-argocd
  labels:
    nttdata.dach.accelerators/role: {{ $ID }}-iam-role-argocd
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: iam-role-argocd
spec:
  forProvider:
    assumeRolePolicy: |
      {
        "Version": "2012-10-17",
        "Statement": [
          {
            "Effect": "Allow",
            "Principal": {
              "AWS": "arn:aws:iam::518283773752:role/universal-control-plane-argocd"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
          }
        ]
      }
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: Role
metadata:
  name: {{ $ID }}-iam-role-alb-controller
  labels:
    nttdata.dach.accelerators/role: {{ $ID }}-iam-role-alb-controller
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: iam-role-alb-controller
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
                "Action": "sts:AssumeRoleWithWebIdentity",
                "Condition": {
                    "StringEquals": {
                        "{{ trimPrefix "https://" $OIDC_PROVIDER }}:sub": "system:serviceaccount:kube-system:aws-load-balancer-controller-sa"
                    }
                }
            }
        ]
      }









      