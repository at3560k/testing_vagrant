## packages.pp ##
#
# Things I insist on having present for basic security or usability

class packages {

  $security = [
      "openssh-blacklist",
      "openssl-blacklist",
      "nmap",
  ]
  package{ $security: ensure => present }
  
  $versionControl = [
      "git",
      "subversion",
  ]
  package{ $versionControl: ensure => present }
  
  # Things that make jason not hate a system
  $experience = [
      "keychain",
      "screen",
      "sshfs",
      "vim-nox",
  ]
  package{ $experience: ensure => present }

}
