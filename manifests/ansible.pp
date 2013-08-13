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

package{'ansible':
    ensure => present
}

package{'ansible-doc':
    ensure => present
}

package{'ansible-fireball':
    ensure => present
}

# Server config hosts file
file {'/etc/ansible/hosts':
    require => Package['ansible'],
    ensure => link,
    target => '/vagrant/deployment/hosts',
    force => true,
}

# No clue how the hell ansible would work without ssh.
#
include ssh
include packages
