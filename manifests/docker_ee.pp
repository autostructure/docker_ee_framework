# docker_ee.pp
# Installs the Docker EE on a virtual machine.
#
class docker_ee(
  Stdlib::Httpurl $docker_ee_source_location,
  Stdlib::Httpurl $docker_ee_key_source,
) {

  class { '::docker':
    docker_ee                 => true,
    docker_ee_source_location => $docker_ee_source_location,
    docker_ee_key_source      => $docker_ee_key_source,
  }

  # Bryan's code, keeping in case its handy?
  #
  # class { '::docker':
  #   docker_ee                 => true,
  #   docker_ee_source_location => $docker_ee_source_location,
  #   docker_ee_key_source      => $docker_ee_key_source,
  #   dns => '8.8.8.8',
  #   docker_users => ['user1', 'user2'],
  #   labels => ['docker=ee','environment=development'],
  # }
  #
  # file { '/var/lib/docker':
  #   ensure => directory,
  # }
  #
  # mount { '/var/lib/docker':
  #   ensure  => 'mounted',
  #   device  => '/dev/appVG/appLV',
  #   fstype  => 'xfs',
  #   options => 'defaults',
  #   target  => '/etc/fstab',
  # }

}
