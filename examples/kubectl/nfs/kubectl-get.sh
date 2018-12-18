clear
echo "Nodes..."
kubectl get nodes
echo
echo "PersistentVolumes..."
kubectl get pv
echo
echo "StorageClasses..."
kubectl get sc --namespace autostructure-development
echo
echo "PersistentVolumeClaims..."
kubectl get pvc --namespace autostructure-development
echo
echo "Pods..."
kubectl get pods -o wide --namespace autostructure-development
echo
echo "Deployments..."
kubectl get deployment --namespace autostructure-development
echo
echo "Services..."
kubectl get svc --namespace autostructure-development
echo
echo "Ingress..."
kubectl get ingress --namespace autostructure-development
echo
echo "Processes..."
kubectl get po --namespace autostructure-development
echo
