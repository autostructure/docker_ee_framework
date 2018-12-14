# First, designate a node to host nfs by assigning it a role.
# This is used by the Deployment's nodeSelector
# Run this command after replacing worker001 with your nfs node name...
# kubectl label node worker001 node-role.kubernetes.io/nfs-server=nfs-server

kubectl create -f nfs-server.yaml

# echo "Open nfs-storage.yaml"
# echo "Assign the nfs-server IP address (found above)"
# echo "to the 'server:' parameter..."
# pause
# vi nfs-storage.yaml

echo "Assigning nfs-server IP address to storageClass server parameter."
# cp nfs-storage.yaml nfs-storage.yaml.template
export POD_IP=`kubectl describe pod nfs-server | grep IP: | grep -oE '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}'`
sed "s/replace-with-nfs-server-pod-ip-address/${POD_IP}/g" nfs-storage.yaml.template > nfs-storage.yaml
cat nfs-storage.yaml
pause
kubectl create -f nfs-storage.yaml
# reset nfs-storage.yaml
cp nfs-storage.yaml.template nfs-storage.yaml
# rm nfs-storage.yaml.template

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
echo "You must use the InternalIP/ExternalIP and the nodePort"
echo "e.g."
echo "curl http://192.168.5.39:32781 -k"

# ssh worker004.autostructure.io
# su
# docker ps
# docker container exec -it k8s_nginx_nginx-deployment-7fc7d55995-9zfsg_default_f120b2a0-ffee-11e8-9018-0242ac110004_0 ls -pal /mnt/nfs/nginx
