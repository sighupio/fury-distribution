{{- $loadBalancerArgs := dict "module" "aws" "package" "loadBalancerController" "spec" .spec -}}
{{- $clusterAutoscalerArgs := dict "module" "aws" "package" "clusterAutoscaler" "spec" .spec -}}
{{- $ebsCsiDriverArgs := dict "module" "aws" "package" "ebsCsiDriver" "spec" .spec -}}
{{- $ebsSnapshotControllerArgs := dict "module" "aws" "package" "ebsSnapshotController" "spec" .spec -}}

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
        {{ template "nodeSelector" $loadBalancerArgs }}
      tolerations:
        {{ template "tolerations" $loadBalancerArgs }}
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
        {{ template "nodeSelector" $clusterAutoscalerArgs }}
      tolerations:
        {{ template "tolerations" $clusterAutoscalerArgs }}
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
        {{ template "nodeSelector" merge $ebsCsiDriverArgs }}
      tolerations:
        {{ template "tolerations" merge $ebsCsiDriverArgs }}
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
        {{ template "nodeSelector" merge $ebsSnapshotControllerArgs }}
      tolerations:
        {{ template "tolerations" merge $ebsSnapshotControllerArgs }}
