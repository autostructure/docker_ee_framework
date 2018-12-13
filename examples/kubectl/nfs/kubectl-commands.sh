kubectl create -f nfs-server.yaml

kubectl describe pod nfs-server | grep IP:

echo "Open nfs-storage.yaml"
echo "Assign the nfs-server IP address (found above)"
echo "to the 'server:' parameter..."

pause

vi nfs-storage.yaml

kubectl create -f nfs-storage.yaml

kubectl create -f nfs-volume.yaml

kubectl create -f nfs-claim.yaml

kubectl create -f nginx-deployment.yaml

kubectl create -f nginx-service.yaml

kubectl get storageclass
kubectl get pv
kubectl get pvc
kubectl get deployment
kubectl get svc

kubectl get pods -l app=nginx -o wide
kubectl get nodes -o yaml | grep ExternalIP -C 1
kubectl get nodes -o yaml | grep InternalIP -C 1

kubectl get svc nginx-service -o yaml | grep nodePort -C 5

echo "Test the nginx install by returning a web page using the curl command."
echo  "You must use the InternalIP/ExternalIP and the nodePort"
echo "e.g."
echo "curl http://192.168.5.39:32781 -k"

# ssh worker001.autostructure.io
# su
# docker ps
# docker container exec -it k8s_nfs-server_nfs-server_default_38ce311f-fefd-11e8-9018-0242ac110004_0 cat /etc/exports
