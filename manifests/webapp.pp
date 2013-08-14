## webapp.pp ##

class webapp {

  include ssh
  include packages
  include pythonchain

  file {'motd':
    ensure  => file,
    path    => '/etc/motd',
    mode    => 0644,
    content => "This is the Webserver. IP address is ${ipaddress_eth1}. It thinks its
  hostname is ${fqdn}, but you might not be able to reach it there
  from your host machine. It is running ${operatingsystem} ${operatingsystemrelease} and
  Puppet ${puppetversion}.  ",
  }




  Package{ ensure => "installed" } 

  package{ "gunicorn":}
  package{ "apache2": }

  #exec { 'apt-get update':
  #  command => '/usr/bin/apt-get update'
  #}

  service { "apache2":
    ensure => running,
    enable => "true",
    require => Package["apache2"],
  }

  file { "/etc/apache2/sites-available/gstore_v3":
      notify => Service["apache2"],
      ensure => "present",
      owner => "root",
      group => "root",
      mode => 644,
      require => [Package["apache2"]],
      content => "
WSGIApplicationGroup gstore_v3
WSGIPassAuthorization On
WSGIDaemonProcess gstore_v3 user=www-data group=staff processes=2 threads=2 deadlock-timeout=60 maximum-requests=50 display-name=gstore \
   python-path=/opt/modwsgi/gstore_v3_env/lib/python2.7/site-packages
WSGIScriptAlias /gstore_v3 /opt/modwsgi/gstore_v3_env/pyramid.wsgi
AllowEncodedSlashes On

<Directory /opt/modwsgi/gstore_v3_env>
  WSGIProcessGroup gstore_v3
  Order allow,deny
  Allow from all
</Directory>
"
  }

  file { '/etc/apache2/sites-enabled/gstore_v3':
    ensure => link,
    target => "/etc/apache2/sites-available/gstore_v3",
    notify => Service['apache2'],
    force  => true,
    require => Package["apache2"],
  }

  file{'/opt/modwsgi/gstore_v3_env':
    ensure => link,
    target => "/vagrant/gstore_v3",
    notify => Service['apache2'],
    force  => true,
    require => Package["apache2"],
  }

}
