## snode.pp ##

include ssh
include saltnode

filebucket { 'main':
  path   => '/root/puppet_backup',
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

file {'motd':
  ensure  => file,
  path    => '/etc/motd',
  mode    => "0644",
  content => "This is the salt server. IP address is ${ipaddress_eth1}. It
  thinks its hostname is ${fqdn}, but you might not be able to reach it there
  from your host machine. It is running ${operatingsystem}
  ${operatingsystemrelease} and Puppet ${puppetversion}.  ",
}

# Punch out the defaults
exec {'patch_salt_minion_conf':
    command => "/usr/bin/sudo /bin/sed -i 's/^#master: salt$/master: salt.test.edac.unm.edu/' /etc/salt/minion",
    require => [Class['saltnode']],
    notify => Service['salt-minion'],
} 

file{ "/etc/salt/minion":
    notify => Service['salt-minion'],
    mode => "644",
    owner => "root",
    group => "root",
    require => [Class['saltnode']]
}

service{'salt-minion':
    ensure => "running",
    require => [Class['saltnode']]
}

#include packages 
