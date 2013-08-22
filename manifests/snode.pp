## snode.pp ##

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

include ssh
include packages
include saltnode
