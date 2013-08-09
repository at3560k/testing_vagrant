## puppet.pp ##

# This file (/etc/puppetlabs/puppet/manifests/site.pp) is the main entry point
# used when an agent connects to a master and asks for an updated configuration.
#
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
  content => "This is the puppet server. IP address is ${ipaddress}. It thinks its
hostname is ${fqdn}, but you might not be able to reach it there
from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
Puppet ${puppetversion}.  ",
}

package{'vim-puppet':
    ensure => present
}

package{'puppetmaster':
    ensure => present
}

exec{'mk_puppet_user':
    command => '/usr/bin/puppet master --mkusers',
    require => Package['puppetmaster']
}

# Lulzerplex, link our puppet out to the outer boxes vagrant conf
#  (gaping security hole here...)
file { '/etc/puppet/manifests':
  ensure => link,
  target => "/vagrant/manifests",
  force  => true,
  require => Package['puppetmaster']
}

#  Okay, this is dangerous in production...
#    but since we spin up and destroy VMs, we need
#    the puppet master to sign the requests immediately
file {'/etc/puppet/autosign.conf':
    ensure => file,
    mode => 0644,
    require => Package['puppetmaster'],
    owner => 'root',
    group => 'root',
    content => "
*.test.edac.unm.edu
",
    force => true,
}




# Our host files... and other test only stuffs
#  Note -- to work this way, my local desktop with puppet 
#  installed requires this module installed (I symlinked...)
#  ln -s /data/jbrown/compare_provision/modules/testonly/ /etc/puppet/modules/
#  
#   Note -- you probably can't install this module over the network...
file{ '/etc/puppet/modules/testonly':
  ensure => link,
  target => "/vagrant/modules/testonly",
  force  => true,
  require => Package['puppetmaster']
}

# Okay, irritating.  Ubu ships with 2.7.11, 2.7.14 has the module
#  command built in, which will make managing things easier...
#  For now, rather than get a source build of uppet, we use 
#  the distros
package { 'puppet-module':
    ensure => 'installed',
    provider => 'gem',
    require => Package['puppetmaster']
}

include ssh
include packages

#  Now, install the test only module we just used!
