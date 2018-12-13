
# docker_ucp

This modules hosts Puppet Tasks used to setup a Docker Universal Control Plane (UCP).

#### Table of Contents

1. [Description](#description)
2. [Setup](#setup)
    * [Setup requirements](#setup-requirements)
    * [Order of Task Execution](#order-of-task-execution)
3. [Usage - Configuration options and additional functionality](#usage)


## Description

This modules leverages Puppet Enterprise Task Management to setup a
Docker Universal Control Plane (UCP).

**NOTE:** Puppet Tasks only appear if added to the Production environment!

Tasks:
* *assign_leader*
* *assign_node*
* *enable_kubernetes_scheduler*
* *inspect_scheduler*
* *inspect_self*
* *list_nodes*
* *nfs_restart*
* *print_tokens*
* *print_manager_token*
* *print_worker_token*

## Setup

### Setup Requirements

####Puppetfile

Add this module to the PRODUCTION environment's `Puppetfile`:

```
mod 'autostructure-harden_docker', '1.0.6'
mod 'docker_ucp',
    git: 'https://github.com/autostructure/docker_ucp.git',
    branch: 'master'
mod 'puppetlabs-docker', '3.1.0'
```

####Hiera

For details about the file names and associated parameters, see:
`./examples/hieradata/role/*`

hiera.yaml hierarchy entry:

  - "role/%{::trusted.extensions.pp_role}"

####Roles

The `pp_role` trusted extension is used during the Puppet Agent install to assign a node its docker role.  The two roles below are used and map to associated classes.  Setup a node group for each role that identifies nodes by the trusted extension and assign it the docker_ucp_manager or docker_ucp_worker class.

* trusted.extensions.pp_role=docker_ucp_manager
* trusted.extensions.pp_role=docker_ucp_worker

e.g.
`/bin/curl -k https://master.autostructure.io:8140/packages/current/install.bash | sudo bash -s extension_requests:pp_role=docker_ucp_worker`

### Order of Task Execution

1.  run "terraform apply" to create VM nodes
2.  run Puppet on the nameserver (to pick up new DNS entries)
3.  run Puppet on nfs (after all worker nodes have reported to the master)
4.  run Puppet Task "docker_ucp::nfs_restart"
5.  run Puppet on all the worker nodes
6.  run Puppet Task "docker_ucp::assign_leader" on one manager node making it the ucp leader
7.  run Puppet Task "docker_ucp::print_tokens" on the leader
8.  run Puppet Task "docker_ucp::assign_node" on remaining managers using manager join-token
9.  run Puppet Task "docker_ucp::assign_node" on workers using worker join-token
10. run Puppet Task "docker_ucp::enable_kubernetes_scheduler" on all manager & worker nodes
11. run Puppet Task "docker_ucp::list_nodes"
12. open a browser and point it to the leader's https url
    e.g. https://manager001.autostructure.io/
13. enter the certificate and private key for https
    • in LEFT NAV, select <User>(root) > Admin Settings > Certificates
    • paste private key in "Private Key" field
    • paste certificate in "Server Certificate" field
    • paste certificate in "CA Certificate" field (assume server cert holds server, intermediate, and ca certs)
14. add manager nodes to "reverse-proxy.eyaml" hiera file IN PRODUCTION BRANCH!
    • redirect ucp.autostructure.io to manager001, manager002, etc.

ucp.autostructure.io:
    ensure: present
    server_name:
      - ucp.autostructure.io
      - ucp
    listen_port: 443
    ssl_port: 443
    ssl:      true
    proxy:    https://manager001.autostructure.io/
    ssl_cert: /etc/ssl/certs/ssl-bundle.crt
    ssl_key:  /etc/ssl/private/autostructure.io.key
    ssl_cache: shared:SSL:1m

15. add ucp to "nameserver.yaml" IN PRODUCTION BRANCH!

profile::nameserver::a_records:
  ucp:
    zone: autostructure.io
    data:
      - 192.168.5.61

16. Test the cluster...

#### kubectl Commands

kubectl create -f nfs-server.yaml

# enter nfs-server ip-addr into "server:" in "nfs-storage.yaml"...
kubectl describe pod nfs-server | grep IP:
vi nfs-storage.yaml
kubectl create -f nfs-storage.yaml

kubectl create -f nfs-volume.yaml

kubectl create -f nfs-claim.yaml

kubectl create -f nginx-deployment.yaml

kubectl create -f nginx-service.yaml

kubectl get pods -l app=nginx -o wide

kubectl get svc nginx-service -o yaml | grep nodePort -C 5

kubectl get nodes -o yaml | grep InternalIP -C 1

kubectl get nodes -o yaml | grep ExternalIP -C 1

curl http://192.168.5.39:32781 -k

.
.
.

kubectl delete svc nginx-service
kubectl delete deployment nginx-deployment
kubectl delete pvc nfs-claim-3g
kubectl delete pv nfs-vol-001
kubectl delete storageclass nfs-storage
kubectl delete pod nfs-server

## Usage

TBD
