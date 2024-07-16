{{- $ID := $.observed.composite.resource.spec.id -}}
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $ID }}-iam-role-attachment-controlplane-1
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-attachment-controlplane-1
spec:
  forProvider:
    policyArn: arn:aws:iam::aws:policy/AmazonEKSClusterPolicy
    roleSelector:
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-controlplane
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $ID }}-iam-role-attachment-controlplane-2
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-attachment-controlplane-2
spec:
  forProvider:
    policyArn: arn:aws:iam::aws:policy/AmazonEKSServicePolicy
    roleSelector:
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-controlplane
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $ID }}-iam-role-attachment-nodegroup-1
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-attachment-nodegroup-1
spec:
  forProvider:
    policyArn: arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy
    roleSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-nodegroup
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $ID }}-iam-role-attachment-nodegroup-2
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-attachment-nodegroup-2
spec:
  forProvider:
    policyArn: arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy
    roleSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-nodegroup
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $ID }}-iam-role-attachment-nodegroup-3
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-attachment-nodegroup-3
spec:
  forProvider:
    policyArn: arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly
    roleSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-nodegroup
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $ID }}-iam-role-attachment-nodegroup-4
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-attachment-nodegroup-4
spec:
  forProvider:
    policyArn: arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore
    roleSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-nodegroup
---
apiVersion: iam.aws.upbound.io/v1beta1
kind: RolePolicyAttachment
metadata:
  name: {{ $ID }}-iam-role-attachment-alb-controller-1
  annotations:
    gotemplating.fn.crossplane.io/composition-resource-name: {{ $ID }}-iam-role-attachment-alb-controller-1
spec:
  forProvider:
    policyArn: arn:aws:iam::518283773752:policy/AWSLoadBalancerControllerIAMPolicy
    roleSelector:
      matchControllerRef: true
      matchLabels:
        nttdata.dach.accelerators/role: {{ $ID }}-iam-role-alb-controller