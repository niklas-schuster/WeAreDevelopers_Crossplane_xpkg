{{- $ID := $.observed.composite.resource.spec.id -}}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ $ID }}-initial-ingress
  namespace: default
spec:
  ports:
    - port: 80
      targetPort: 80
  clusterIP: None