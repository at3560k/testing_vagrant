testing_vagrant
===============

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
