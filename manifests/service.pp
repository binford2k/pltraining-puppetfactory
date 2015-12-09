class puppetfactory::service {
  class{ 'staging':
    path => '/var/staging/'
  }

  staging::file { 'puppetfactory-0.2.0.gem':
    source  => 'puppet:///modules/puppetfactory/puppetfactory-0.2.0.gem'
  }

  package { 'puppetclassify':
    ensure   => present,
    provider => gem,
    before   => Package['puppetfactory'],
  }

  package { 'puppetfactory':
    ensure   => present,
    provider => gem,
    source   => "${staging::path}/puppetfactory/puppetfactory-0.2.0.gem",
    require  => Staging::File['puppetfactory-0.2.0.gem'],
    before   => Service['puppetfactory'],
  }

  file { '/etc/init.d/puppetfactory':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('puppetfactory/puppetfactory.init.erb'),
    before  => Service['puppetfactory'],
  }

  service { 'puppetfactory':
    ensure    => running,
    enable    => true,
    subscribe => Package['puppetfactory'],
  }
}
