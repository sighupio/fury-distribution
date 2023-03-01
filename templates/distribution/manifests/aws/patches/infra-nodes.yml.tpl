{{- $lbcArgs := dict "module" "aws" "spec" .spec "component" "loadBalancerController" -}}
{{- $caArgs := dict "module" "aws" "spec" .spec "component" "clusterAutoscaler" -}}
{{- $ecdArgs := dict "module" "aws" "spec" .spec "component" "ebsCsiDriver" -}}
{{- $scArgs := dict "module" "aws" "spec" .spec "component" "snapshotController" -}}

---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: aws-load-balancer-controller
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $lbcArgs }}
      tolerations:
        {{ template "tolerations" $lbcArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cluster-autoscaler
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" $caArgs }}
      tolerations:
        {{ template "tolerations" $caArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ebs-csi-controller
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" merge $ecdArgs }}
      tolerations:
        {{ template "tolerations" merge $ecdArgs }}
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: snapshot-controller
  namespace: kube-system
spec:
  template:
    spec:
      nodeSelector:
        {{ template "nodeSelector" merge $scArgs }}
      tolerations:
        {{ template "tolerations" merge $scArgs }}
