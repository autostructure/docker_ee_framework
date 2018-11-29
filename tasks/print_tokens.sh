#!/opt/puppetlabs/puppet/lib/ruby

# Puppet Task Name: print_tokens
#
# @Usage
# You MUST run this task on a UCP manager node.
# Outputs the token need to join the UCP as a manager.
#
puts `docker swarm join-token -q manager`
puts `docker swarm join-token -q worker`
