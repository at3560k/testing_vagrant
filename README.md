testing_vagrant
===============

Question: So, I don't know if I'm having a puppet issue, or a vagrant issue...
I had a fully functioning set of puppet scripts being applied to a couple of
russian-doll-style nested VM's via vagrant's :puppet and working good... I
changed to :puppet_server,  locally forced some host files onto things to
handle key signing... enabled autosign.... the machines are in communication, I
can see the client in /var/log/puppet/masterhttp.log, have my first hostname
in /etc/puppet/manifests/site.pp (symlinked out to /vagrant/manifests, but
still readable)... but there's no provisioning going on over the network
anymore even though the node is connecting... I've got no clue where to start
troubleshooting here.

* vagrant up puppetmaster
* vagrant up dbase
* log into puppetmaster
  * vagrant ssh puppetmaster
  * check for postgres: `ps aux | grep -ir postgres`
  * No PG running


Expected Result:
  * Postgresql 9.1 installed and running

Weird fix:
  * had to:
    * edit manifests/site.pp
      * change to use local includes
      * I should fix this to use the module structure they expect
  * vagrant ssh dbase
  * sudo puppet agent --no-daemonize --detailed-exitcodes --server puppet.test.edac.unm.edu --verbose -t

Logs:  (when vagrant up dbase)

    pruned ...
