# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"

  # cache buckets auto detection for vagrant-cachier
  #   verified working with vagrant-cachier (0.1.0)
  config.cache.auto_detect = true 

  # Note: host only networks mean no ports are blocked at all.
  #  10.11.12/24 is vbox hostonlyif vboxnet0  on dev host
   
  # We need to run our updater in apt first or packages fail
  config.vm.provision :shell, :path => "shell/bootstrap.sh"

  # Okay, this is a bit weird.  We add a provisioner for all VMs That points to
  # a submodule locally.  Which basically forces some writes to the hostfile so
  # puppet and newly created systems can talk to each other without
  # me building a custom nameserver...
  #
  # This will go away once we actually have hostnames or internal NS
  config.vm.provision :puppet do |puppet|
      # looks in manifests/default.pp automagically
      puppet.module_path = "modules"
      puppet.manifest_file = "patchhosts.pp"
  end
 

  #####################################
  # Puppet server - local
  #####################################
  config.vm.define :puppetmaster do |pp_config|
    pp_config.vm.hostname = "puppet.test.edac.unm.edu"
    pp_config.vm.network :private_network, ip: "10.11.12.100"

    # Hey dog, I heard you like puppet so I provisioned puppet with your puppet
    pp_config.vm.provision :puppet do |puppet|
      # Local manifest, puppet apply
      puppet.manifests_path = "manifests"
      puppet.manifest_file = "puppet.pp"
      # Module path for remote module we'll add in
      puppet.module_path = "modules"
    end
  end

  #####################################
  # dbase - via puppet master
  #####################################
  config.vm.define :dbase do |db_config|
    db_config.vm.hostname = 'dbserver.test.edac.unm.edu'
    db_config.vm.network :private_network, ip: "10.11.12.211"
    # Relay PG to localhost.  This may not work nicely if you have a mismatched client version
    db_config.vm.network :forwarded_port, guest: 5432, host: 5432

    # Remote server
    db_config.vm.provision :puppet_server do |puppet|
      puppet.options = ["--verbose", "--debug"]
      puppet.puppet_server = "puppet.test.edac.unm.edu"
    end
  end

end