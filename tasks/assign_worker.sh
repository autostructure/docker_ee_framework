#!/bin/sh

# Puppet Task Name: assign_worker
#
docker swarm join --token $PT_join_token $PT_ucp_addr:2377
