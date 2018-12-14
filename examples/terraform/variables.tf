# number of docker nodes (managers)...
variable "cnt_managers" {
  default=3
}

# number of docker nodes (workers)...
variable "cnt_workers" {
  default=4
}

# timeout for 'wait_for_guest_net_timeout' (in minutes)
variable "timeout_minutes" {
  default=20
}

# # timeout for 'wait_for_guest_net_timeout' (in minutes)
# variable "net_timeout_minutes" {
#   default=20
# }
