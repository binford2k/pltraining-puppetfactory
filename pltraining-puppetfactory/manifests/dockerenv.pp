class puppetfactory::dockerenv {
  include docker

  file { '/etc/docker/centosagent/':
    ensure  => directory,
    source  => 'puppet:///modules/puppetfactory/centos/',
    require => Class['docker'],
  }

  docker::image { 'centosagent':
    docker_dir => '/etc/docker/centosagent/',
    require     => File['/etc/docker/centosagent/'],
  }
  yumrepo { 'base':
    enabled => 1,
    before  => Class['docker'],
  }
}
