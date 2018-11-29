
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

Tasks:
*assign_leader*
*assign_node*
*enable_kubernetes_scheduler*
*inspect_scheduler*
*inspect_self*
*list_nodes*
*nfs_restart*
*print_tokens*
*print_manager_token*
*print_worker_token*

## Setup

### Setup Requirements

Add this module to the PRODUCTION environment's `Puppetfile`:

```
mod 'docker_ucp',
    git: 'https://github.com/autostructure/docker_ucp.git',
    branch: 'master'
```

**NOTE:** Puppet Tasks only appear if added to the Production environment!

### Order of Task Execution
1. nfs_restart
1. assign_leader
1. enable_kubernetes_scheduler (on leader)
1. print_tokens
1. assign_node (pass manager token)
1. assign_node (pass worker token)
1. enable_kubernetes_scheduler (for each manager/worker)
1. inspect_scheduler (for each manager/worker)
1. list_nodes

## Usage

TBD
