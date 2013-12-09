$as_vagrant = 'sudo -u vagrant -H bash -l -c'
$home = '/home/vagrant'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

#### Preinstall stage ####

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}

class { 'apt_get_update':
  stage => preinstall
}

#### Other packages ####

package { 'curl':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}

package { 'libcurl4-openssl-dev':
  ensure => installed
}

#### RVM ####

exec { 'install_rvm':
  command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
  creates => "${home}/.rvm/bin/rvm",
  require => Package['curl']
}

#### Ruby 1.9.3-p484 with perf patches ####

exec { 'install_ruby':
  command => "${as_vagrant} '${home}/.rvm/bin/rvm install 1.9.3-p484 --autolibs=enabled && ${home}/.rvm/bin/rvm --fuzzy alias create default 1.9.3-p484'",
  creates => "${home}/.rvm/bin/ruby",
  require => Exec['install_rvm'],
  timeout => 3600
}

#### bundler ####

exec { "${as_vagrant} 'gem install bundler --prerelease'":
  creates => "${home}/.rvm/bin/bundle",
  require => Exec['install_ruby']
}
