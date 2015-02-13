class puppetfactory {
  include puppetfactory::service
  include puppetfactory::shellinabox
  include puppetfactory::dockerenv
  include epel

  file { '/etc/puppetlabs/puppet/environments/production/environment.conf':
    ensure  => file,
    content => "environment_timeout = 0\n",
    replace => false,
  }

  file_line { 'remove tty requirement':
    path  => '/etc/sudoers',
    line  => '#Defaults    requiretty',
    match => '^\s*Defaults    requiretty',
  }

  # sloppy, get this gone
  user { 'vagrant':
    ensure     => absent,
    managehome => true,
  }

  # ensure the packages used by userprefs are available so that the simulated
  # installation labs appear to work properly.
  package { ['zsh', 'emacs', 'nano', 'vim-enhanced', 'rubygems', 'tree', 'git' ]:
    ensure  => present,
    require => Class['epel'],
    before  => Class['puppetfactory::service'],
  }
  augeas{'sshd-clientalive':
    context => '/files/etc/ssh/sshd_config',
    changes => [
      'set ClientAliveInterval 300',
      'set ClientAliveCountMax 2'
    ],
  }
}
