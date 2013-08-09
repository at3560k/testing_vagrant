## ssh.pp ##

class ssh {

  package { 'openssh-server':
    ensure => present,
  #  before => File['/etc/ssh/sshd_config'],
  }

  file { '/etc/ssh/sshd_config':
    ensure => file,
    mode   => 600,
    source => '/vagrant/manifests/cnf/sshd_config',
    # And yes, that's the first time we've used the "source" attribute. It accepts
    # absolute local paths and puppet:/// URLs, which we'll say more about later.
  }

  # ubuntu is ssh, not sshd
  service {'ssh':
    ensure    => running,
    enable    => true,
    subscribe => File['/etc/ssh/sshd_config'],
  }

}
