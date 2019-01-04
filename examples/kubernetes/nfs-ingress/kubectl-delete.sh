#!/bin/sh

# drain a node before deleting (if other nodes remain to pick up pods)
# kubectl drain $NODE --force=true --ignore-daemonsets=true

# autostructure-development namespace...
kubectl delete service nginx-ingress-controller --namespace autostructure-development
kubectl delete deployment nginx-ingress-controller --namespace autostructure-development
kubectl delete service nginx-ingress-default-backend --namespace autostructure-development
kubectl delete deployment nginx-ingress-default-backend --namespace autostructure-development
kubectl delete ingress nginx-ingress-resource --namespace autostructure-development
kubectl delete svc test-web-service --namespace autostructure-development
kubectl delete deployment test-nginx-ingress --namespace autostructure-development

# default namespace...
kubectl delete service nginx-ingress-controller
kubectl delete deployment nginx-ingress-controller
kubectl delete service nginx-ingress-default-backend
kubectl delete deployment nginx-ingress-default-backend
kubectl delete ingress nginx-ingress-resource

# volume claims
kubectl delete pvc nfs-claim-1g --namespace autostructure-development

# low-level resources with no namespaces...
kubectl delete pv nfs-vol-default
#kubectl delete storageclass nfs-storage

# nfs-servers...
# kubectl delete service nfs-server
# kubectl delete pod nfs-server
# kubectl delete pod nfs-server --namespace autostructure-development


# namespaces...
# kubectl delete namespace autostructure-development
