{{- $ID := $.observed.composite.resource.spec.id -}}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $ID }}-initial-ingress
  namespace: default
  annotations:
    kubernetes.io/ingress.class: alb
    alb.ingress.kubernetes.io/group.name: services
    alb.ingress.kubernetes.io/load-balancer-name: {{ $ID }}-eks-cluster-services
    alb.ingress.kubernetes.io/target-type: instance
    alb.ingress.kubernetes.io/scheme: internal 
    argocd.argoproj.io/sync-wave: "2"
spec:
  rules:
    - http:
        paths:
          - path: "/initial"
            pathType: Prefix
            backend:
              service:
                name: {{ $ID }}-initial-ingress
                port:
                  number: 80