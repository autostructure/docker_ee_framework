#!/bin/sh

# Puppet Task Name: ucp_set_kubernetes_scheduling
#
# @Usage
# You MUST run this task on a UCP manager node,
# but the target is set to the node you wish to set.

# add kubernetes scheduler
docker node update --label-add com.docker.ucp.orchestrator.kubernetes=true $PT_target_node

# remove swarm scheduler
docker node update --label-rm com.docker.ucp.orchestrator.swarm $PT_target_node
