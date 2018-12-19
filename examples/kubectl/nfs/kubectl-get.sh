#!/bin/sh

clear
echo "Processes..."
kubectl get po -o wide --all-namespaces
echo
echo "Nodes..."
kubectl get nodes
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
kubectl get pods -o wide --all-namespaces
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
