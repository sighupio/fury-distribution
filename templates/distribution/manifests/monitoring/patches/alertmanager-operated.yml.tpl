---
apiVersion: monitoring.coreos.com/v1
kind: Alertmanager
metadata:
  name: main
  namespace: monitoring
spec:
  externalUrl: https://{{ template "alertmanagerUrl" .spec }}
