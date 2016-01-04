class puppetfactory::wetty {
  package { 'npm':
    ensure => present,
  }
  exec { 'npm -g install npm':
    path    => '/bin',
    onlyif  => 'npm -v | grep "1\.3\.6"',
    require => Package['npm'],
  }
  exec { 'npm -g install wetty':
    path    => '/bin',
    unless  => 'npm -g list wetty',
    require => Exec['npm -g install npm'],
  }

  file { '/etc/init.d/wetty':
    ensure => 'present',
    mode   => '0755',
    source => 'puppet:///modules/puppetfactory/wetty.conf',
  }
  service { 'wetty':
    ensure    => 'running',
    enable    => true,
    require   => Exec['npm -g install wetty'],
    subscribe => File['/etc/init.d/wetty'],
  }
}
