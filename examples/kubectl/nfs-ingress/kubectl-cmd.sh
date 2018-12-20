#!/bin/sh

# kubectl-cmds.sh

# Designate a node to host nfs by assigning it a role.
# This is used by the Deployment's nodeSelector
# Run this command after replacing worker001 with your nfs node name...
# remove label...
# $ kubectl label node nfs001 node-role.kubernetes.io/nfs-server-
# add label...
# $ kubectl label node nfs001 node-role.kubernetes.io/nfs-server=nfs-server
#
# echo "Open nfs-volume.yaml"
# echo "Assign the nfs-server IP address (found above)"
# echo "to the 'server:' parameter..."
# pause
# vi nfs-volume.yaml
# echo "waiting for nfs server spin up.  Hit any key to continue."
# pause
# echo "Assigning nfs-server IP address to storageClass server parameter."
# # cp nfs-storage.yaml nfs-storage.yaml.template
# export POD_IP=`kubectl describe pod nfs-server | grep IP: | grep -oE '[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}\.[[:digit:]]{1,3}'`
# sed "s/replace-with-nfs-server-pod-ip-address/${POD_IP}/g" nfs-volume-template.yaml > nfs-volume.yaml
# cat nfs-volume.yaml
# pause

kubectl create -r namespaces.yaml
kubectl label node nfs001 node-role.kubernetes.io/nfs-server=nfs-server
kubectl create -f nfs-server.yaml
kubectl create -f nfs-storage.yaml
kubectl create -f nfs-volume.yaml
kubectl create -f nfs-claim.yaml
kubectl create -f nginx-deployment.yaml
kubectl create -f nginx-service.yaml
#kubectl create -f ingress-resource.yaml
#kubectl create -f ingress-controller.yaml
#kubectl create -f ingress-default-backend.yaml

kubectl get po --all-namespaces
kubectl get nodes --show-labels
kubectl get sc
kubectl get pv
kubectl get pvc --all-namespaces
kubectl get pods -l -o wide --all-namespaces #app=nginx
kubectl get deployment --all-namespaces
kubectl get svc --all-namespaces
kubectl get ingress --all-namespaces
echo
echo "ip address and port info for testing nginx deployments..."
kubectl get nodes -o yaml | grep ExternalIP -C 1
kubectl get nodes -o yaml | grep InternalIP -C 1
kubectl get svc test-service -o yaml | grep nodePort -C 5
kubectl get svc nginx-service -o yaml --namespace=autostructure-development | grep nodePort -C 5

echo "Test the nginx install by returning a web page using the curl command."
echo "You must use the InternalIP/ExternalIP and the nodePort"
echo "e.g."
echo "curl http://192.168.5.24:33080 -k"

# ssh nfs001.autostructure.io
# su
# docker ps
# docker container exec -it k8s_nginx_nginx-deployment-54f64d7b56-7wdkz_default_7f59b31a-021d-11e9-b608-0242ac110004_0 ls -pal /usr/share/nginx/html
# docker container exec -it k8s_nfs-server_nfs-server_default_b8027b81-ffe9-11e8-9018-0242ac110004_0 ls -pal /exports
# docker container exec -it k8s_nfs-server_nfs-server_default_b8027b81-ffe9-11e8-9018-0242ac110004_0 /bin/bash
#
# Run command in existing pod (1 container case)
kubectl exec my-pod -- /bin/bash
# Run command in existing pod (multi-container case)
kubectl exec my-pod -c my-container -- /bin/bash
