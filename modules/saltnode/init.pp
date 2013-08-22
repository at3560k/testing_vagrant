## saltnode.pp ##

class saltnode {

# Okay, the pypy salt /does not work/
#   and there's no ubu package...
# Their shortcut... scary.
#exec{ "install_salt":
#    command => "/bin/sh -c '/usr/bin/wget -O - http://bootstrap.saltstack.org | sudo sh'",
#    path => ["/usr/bin", "/usr/bin"],
#    creates => "/usr/bin/salt-call",
#}

  package{'python-software-properties':
      ensure => present, # pip
      before => Exec["add_salt_repo"]
  } # for add-apt-repository
  
  exec{'add_salt_repo':
    command => "/usr/bin/sudo add-apt-repository -y ppa:saltstack/salt",
    creates => "/etc/apt/sources.list.d/saltstack-salt-precise.list",
    before => Exec["update_for_salt"],
  }

  exec{'update_for_salt':
    command => "/usr/bin/sudo apt-get update",
    before => [Package["salt-minion"]],
  }

  package{'salt-minion':
      ensure => present,
  }

}
