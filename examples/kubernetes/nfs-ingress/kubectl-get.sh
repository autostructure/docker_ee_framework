#!/bin/sh

# troubleshooting...
# 
# kubectl get pods --all-namespaces --show-all
# kubectl get pod nginx-ingress-controller --namespace=ci-cd -o yaml --export
#
# kubectl get pod cdpe-cdpe-0 --namespace=ci-cd -o yaml --export
# kubectl get pod cdpe-mysql-5fd94f5855-8swv2 --namespace=ci-cd -o yaml --export
# kubectl get pod cdpe-mysql-5fd94f5855-j4qtd --namespace=ci-cd -o yaml --export
#
# kubectl describe pod cdpe-cdpe-0 --namespace=ci-cd
# kubectl describe pod cdpe-mysql-5fd94f5855-8swv2 --namespace=ci-cd
# kubectl describe pod cdpe-mysql-5fd94f5855-j4qtd --namespace=ci-cd

clear
echo "Processes..."
kubectl get po -o wide --all-namespaces
echo
echo "Nodes..."
kubectl get nodes --show-labels
echo
echo "PersistentVolumes..."
kubectl get pv
echo
echo "StorageClasses..."
kubectl get sc
echo
echo "PersistentVolumeClaims..."
kubectl get pvc --all-namespaces
echo
echo "Pods..."
kubectl get pods -o wide --all-namespaces --show-all
echo
echo "Deployments..."
kubectl get deployment --all-namespaces
echo
echo "Services..."
kubectl get svc --all-namespaces
echo
echo "Ingress..."
kubectl get ingress --all-namespaces
echo
