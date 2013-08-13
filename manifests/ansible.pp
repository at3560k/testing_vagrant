## ansible.pp ##

## Active Configurations ##

# PRIMARY FILEBUCKET
# This configures puppet agent and puppet inspect to back up file contents when
# they run. The Puppet Enterprise console needs this to display file contents
# and differences.

# Define filebucket 'main':
filebucket { 'main':
  path   => '/root/puppet_backup',
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

file {'motd':
  ensure  => file,
  path    => '/etc/motd',
  mode    => 0644,
  content => "This is the ansible server. IP address is ${ipaddress}. It thinks its
hostname is ${fqdn}, but you might not be able to reach it there
from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
Puppet ${puppetversion}.  ",
}

package{'python-dev':
    # Needed for pip to build ansible
    ensure => present,
}

package{'python-pip':
    ensure => present,
    # not a python server, but we need pip to get ansible instead of system packages
}

exec{'get_pip_mongo':
    # Note -- our default cwd for this happens to be in our manifsts folder,
    #  making a build cache
    command => '/usr/bin/sudo /usr/bin/pip install ansible',
    require => [Package['python-pip'], Package['python-dev']],
}

# turn me back on
# Server config hosts file
file {'/etc/ansible':
    ensure => directory,
    owner => 'root',
    force => true 
}

file {'/etc/ansible/hosts':
    #require => Package['ansible'],
    require => Exec['get_pip_mongo'],
    ensure => link,
    target => '/vagrant/deployment/hosts',
    force => true,
    owner => 'root',
}

# No clue how the hell ansible would work without ssh.
#
include ssh
include packages

#  Because these packages are ansible 1.1 in ubu 12.04 and aren't 1.2
#  which is what we need to work with the examples.

#package{'ansible':
#    ensure => present
#}
#
#package{'ansible-doc':
#    ensure => present
#}
#
#package{'ansible-fireball':
#    ensure => present
#}
