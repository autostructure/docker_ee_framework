kubectl delete svc nginx-service --namespace autostructure-development
kubectl delete deployment nginx-deployment --namespace autostructure-development
kubectl delete pvc nfs-claim-3g --namespace autostructure-development
kubectl delete pv nfs-vol-autostructure-development
kubectl delete storageclass nfs-storage
#kubectl delete pod nfs-server-development
#kubectl delete namespace autostructure-development
