class puppetfactory::dockerenv {
  include docker

  file { '/etc/docker/centosagent/':
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/puppetfactory/centos/',
    notify => Docker::Image['centosagent'],
    require => Class['docker'],
  }

  docker::image { 'centosagent':
    docker_dir => '/etc/docker/centosagent/',
    require     => File['/etc/docker/centosagent/'],
  }

  file { '/var/run/docker.sock':
    group   => 'docker',
    require => [Class['docker'],Group['docker']],
  }

  group { 'docker':
    ensure => present,
  }
}
