## salt.pp ##

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
  content => "This is the salt server. IP address is ${ipaddress_eth1}. It thinks its
hostname is ${fqdn}, but you might not be able to reach it there
from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
Puppet ${puppetversion}.  ",
}

package{'python-pip':
    ensure => present, # pip
}

include ssh
include saltnode

# needs salt node package to have the PPA for master...
package{'salt-master':
    ensure => present,
}  # Will bind TCP/4505-4506 (firewall)

exec{'accept_my_own_key':
  # Insecure, keys unverified
  command => "/usr/bin/sudo salt-key -A -y",
  require => Package["salt-master"],
}

file{'/srv/salt':
  ensure => "link",
  target => "/vagrant/salt",
  require => Package["salt-master"],
}

# We will recreate our packages with salt.
#   (but not ssh or salt node because bootstrapping by bootstrapping...)
# include packages
#
# cd /srv/salt && sudo su
# salt '*' state.sls packages
