## saltnode.pp ##

class saltnode {

  package{'python-software-properties':
      ensure => present, # pip
      before => Exec["add_salt_repo"]
  } # for apt-add-repository
  
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
