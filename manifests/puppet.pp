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
  content => "This is the puppet server. IP address is ${ipaddress_eth1}. It thinks its
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
    notify => Service['puppetmaster'],
    owner => 'root',
    group => 'root',
    content => "
*.test.edac.unm.edu
",
    force => true,
}

#  Contents are slightly modified one liner from Ubu puppetmasterd
# v 2.7.11.  We've changed modulepath so that we can install stuff
#  programatically without bungling up symlinks.
file{'/etc/puppet/puppet.conf':
    ensure => file,
    mode => 0644,
    require => Package['puppetmaster'],
    notify => Service['puppetmaster'],
    owner => 'root',
    group => 'root',
    content => "
[main]
logdir=/var/log/puppet
vardir=/var/lib/puppet
ssldir=/var/lib/puppet/ssl
rundir=/var/run/puppet
factpath=$vardir/lib/facter
templatedir=$confdir/templates
prerun_command=/etc/puppet/etckeeper-commit-pre
postrun_command=/etc/puppet/etckeeper-commit-post
modulepath=/etc/puppet/modules:/usr/share/puppet/modules:/etc/puppet/mymodules

[master]
# These are needed when the puppetmaster is run by passenger
# # and can safely be removed if webrick is used.
ssl_client_header = SSL_CLIENT_S_DN 
ssl_client_verify_header = SSL_CLIENT_VERIFY

",
    force => true,
}

# Our host files... and other test only stuffs
#  Note -- to work this way, my local desktop with puppet 
#  installed requires this module installed (I symlinked...)
#  ln -s /data/jbrown/compare_provision/modules/testonly/ /etc/puppet/modules/
#  
#   Note -- you probably can't install this module over the network...
file{ '/etc/puppet/mymodules/':
  ensure => link,
  target => "/vagrant/modules/",
  force  => true,
  require => Package['puppetmaster'],
  notify => Service['puppetmaster'],
}
#  Keep modules free in case we use puppet module
#

# Need a notifier for when we move the files around, otherwise things get spun
# up and the puppetmaster never detects what's happening
service { "puppetmaster":
   ensure => running,
   require => Package["puppetmaster"],
}


include ssh
include packages

# Okay, irritating.  Ubu ships with 2.7.11, 2.7.14 has the module
#  command built in, which will make managing things easier...
#  For now, rather than get a source build of uppet, we use 
#  the distros
#package { 'puppet-module':
#    ensure => 'installed',
#    provider => 'gem',
#    require => Package['puppetmaster']
#}

#  Now... the puppet stuff we use.
#  puppet librarian requires 2.7.13 ... we're at .7.11
#
#package { 'librarian-puppet':
#    ensure => 'installed',
#    provider => 'gem',
#    require => Package['puppetmaster']
#}
#
#exec{'get_puppet_postgres':
#    command => '/usr/bin/puppet module install puppetlabs/postgresql',
#    cwd => '/etc/puppet/modules',
#    require => Package['puppet-module'],
#    creates => '/etc/puppet/modules/postgresql',
#}
#
#puppet module install puppetlabs/postgresql

# This is too ridiculous to manage.  Their web documentation references
# s/w requirements and versions that don't even exist in their apt package yet
# Writing our own modules is easy if inconvenient.
