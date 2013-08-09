## database.pp ##

#  pretty much a copypasta of my default.pp
#
#  We should probably use https://github.com/puppetlabs/puppetlabs-postgresql
#
##    (once we get the puppet server under VC)

class database {

    file {'motd':
      ensure  => file,
      path    => '/etc/motd',
      mode    => 0644,
      content => "This is the DB Server. IP address is ${ipaddress}. It thinks its
    hostname is ${fqdn}, but you might not be able to reach it there
    from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
    Puppet ${puppetversion}.  ",
    }

    package{'postgresql-9.1':
      ensure => present,
      before => File['/etc/postgresql/9.1/main/pg_hba.conf']
    }

    package{'postgresql-client-9.1':
      ensure => present
    }

    service { "postgresql":
         ensure => "running",
         enable => "true",
         require => Package["postgresql-9.1"],
         subscribe => File['/etc/ssh/sshd_config'],
    }

    # TODO: variable/prompt
    exec { "fixPgPassword":
        # In order to connect, you will still have to use 127.0.0.1 in the default hba.conf file.
        user => 'postgres',
        command => "/usr/bin/psql -U postgres -c \"ALTER USER  postgres WITH ENCRYPTED PASSWORD 'ChangeThis1';\" ",
        notify => [Service["postgresql"]],
        require => [Package["postgresql-9.1"], Package["postgresql-client-9.1"]],
    }


    file { '/etc/postgresql/9.1/main/pg_hba.conf':
      ensure => file,
      mode   => 640,
      source => '/vagrant/manifests/cnf/dbase/pg_hba.conf',
      # No, your owner is not vagrant just because the file is touched
      owner => 'postgres',
      group => 'postgres',
    }

    file { '/etc/postgresql/9.1/main/postgresql.conf':
      ensure => file,
      mode   => 644,
      source => '/vagrant/manifests/cnf/dbase/postgresql.conf',
      # No, your owner is not vagrant just because the file is touched
      owner => 'postgres',
      group => 'postgres',
    }

}
