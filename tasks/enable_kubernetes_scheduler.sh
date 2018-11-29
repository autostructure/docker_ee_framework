#!/bin/sh

# Puppet Task Name: enable_kubernetes_scheduler
#
# @Usage
# You MUST run this task on a UCP manager node,
# but the target is set to the node you wish to set.

# add kubernetes scheduler
#docker node update --label-add com.docker.ucp.orchestrator.kubernetes=true $PT_target_node
docker node update --label-rm com.docker.ucp.orchestrator.swarm --label-add com.docker.ucp.orchestrator.kubernetes=true $PT_target_node

# remove swarm scheduler
#docker node update --label-rm com.docker.ucp.orchestrator.swarm $PT_target_node

puts `docker node inspect self | grep -i orchestrator`
