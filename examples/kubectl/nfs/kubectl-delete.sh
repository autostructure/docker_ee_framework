#!/bin/sh

kubectl delete nginx-ingress-default-backend --namespace autostructure-development
kubectl delete nginx-ingress-controller --namespace autostructure-development
kubectl delete nginx-ingress-resource --namespace autostructure-development
kubectl delete svc nginx-service --namespace autostructure-development
kubectl delete deployment nginx-deployment --namespace autostructure-development
kubectl delete pvc nfs-claim-3g --namespace autostructure-development

#kubectl delete nginx-ingress-default-backend --all-namespaces
#kubectl delete nginx-ingress-default-backend --all-namespaces
#kubectl delete nginx-ingress-controller --all-namespaces
#kubectl delete nginx-ingress-resource --all-namespaces
#kubectl delete svc nginx-service --all-namespaces
#kubectl delete deployment nginx-deployment --all-namespaces
#kubectl delete pvc nfs-claim-3g --namespace autostructure-development
#kubectl delete pvc nfs-claim-1g --namespace default

kubectl delete pv nfs-vol-autostructure-development
kubectl delete pv nfs-vol-default
#kubectl delete storageclass nfs-storage
#kubectl delete pod nfs-server --namespace autostructure-development
#kubectl delete pod nfs-server --namespace default
#kubectl delete namespace autostructure-development
