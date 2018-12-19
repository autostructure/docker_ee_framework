#!/bin/sh

#kubectl create -r namespaces.yaml
#kubectl create -f nfs-server.yaml
#kubectl label node nfs001 node-role.kubernetes.io/nfs-server=nfs-server
#kubectl create -f nfs-storage.yaml
kubectl create -f nfs-volume.yaml
kubectl create -f nfs-claim.yaml
kubectl create -f nginx-deployment.yaml
kubectl create -f nginx-service.yaml
#kubectl create -f ingress-resource.yaml
#kubectl create -f ingress-controller.yaml
#kubectl create -f ingress-default-backend.yaml
