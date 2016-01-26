class puppetfactory::profile::pdf_stack {
  yumrepo { 'robert-gcj':
    ensure              => 'present',
    baseurl             => 'https://copr-be.cloud.fedoraproject.org/results/robert/gcj/epel-7-$basearch/',
    descr               => 'Copr repo for gcj owned by robert',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'https://copr-be.cloud.fedoraproject.org/results/robert/gcj/pubkey.gpg',
    skip_if_unavailable => 'True',
  }

  yumrepo { 'robert-pdftk':
    ensure              => 'present',
    baseurl             => 'https://copr-be.cloud.fedoraproject.org/results/robert/pdftk/epel-7-$basearch/',
    descr               => 'Copr repo for pdftk owned by robert',
    enabled             => '1',
    gpgcheck            => '1',
    gpgkey              => 'https://copr-be.cloud.fedoraproject.org/results/robert/pdftk/pubkey.gpg',
    skip_if_unavailable => 'True',
    require             => Yumrepo['robert-gcj'],
  }

  package { ['wkhtmltopdf', 'pdftk']:
    ensure  => present,
    require => Yumrepo['robert-pdftk'],
  }

  $fonts = [
    'ucs-miscfixed-fonts.noarch',
    'xorg-x11-fonts-75dpi.noarch',
    'xorg-x11-fonts-Type1.noarch',
    'open-sans-fonts.noarch',
  ]

  package { $fonts:
    ensure => present,
  }

}
