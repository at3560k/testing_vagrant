testing_vagrant
===============

gotta test somewhere.

* vagrant up puppetmaster
* vagrant up dbase
* log into puppetmaster
  * vagrant ssh puppetmaster
  * check for postgres: `ps aux | grep -ir postgres`
  * No PG running


Expected Result:
  * Postgresql 9.1 installed and running


Logs:  (when vagrant up dbase)

---

    [dbase] Running provisioner: puppet_server...
    Running Puppet agent...
    stdin: is not a tty
    debug: Failed to load library 'shadow' for feature 'libshadow'
    debug: Puppet::Type::User::ProviderLdap: true value when expecting false
    debug: Puppet::Type::User::ProviderUser_role_add: file roledel does not exist
    debug: Puppet::Type::User::ProviderPw: file pw does not exist
    debug: Puppet::Type::User::ProviderDirectoryservice: file /usr/bin/dscl does not exist
    debug: Failed to load library 'selinux' for feature 'selinux'
    debug: Failed to load library 'ldap' for feature 'ldap'
    debug: /File[/var/lib/puppet/state/graphs]: Autorequiring File[/var/lib/puppet/state]
    debug: /File[/var/lib/puppet/facts]: Autorequiring File[/var/lib/puppet]
    debug: /File[/var/lib/puppet/state/state.yaml]: Autorequiring File[/var/lib/puppet/state]
    debug: /File[/var/lib/puppet/lib]: Autorequiring File[/var/lib/puppet]
    debug: /File[/var/lib/puppet/state/last_run_summary.yaml]: Autorequiring File[/var/lib/puppet/state]
    debug: /File[/var/lib/puppet/state]: Autorequiring File[/var/lib/puppet]
    debug: /File[/etc/puppet/ssl/certs]: Autorequiring File[/etc/puppet/ssl]
    debug: /File[/var/lib/puppet/run]: Autorequiring File[/var/lib/puppet]
    debug: /File[/etc/puppet/ssl/certificate_requests]: Autorequiring File[/etc/puppet/ssl]
    debug: /File[/var/lib/puppet/state/last_run_report.yaml]: Autorequiring File[/var/lib/puppet/state]
    debug: /File[/etc/puppet/ssl/private]: Autorequiring File[/etc/puppet/ssl]
    debug: /File[/var/lib/puppet/client_data]: Autorequiring File[/var/lib/puppet]
    debug: /File[/var/lib/puppet/clientbucket]: Autorequiring File[/var/lib/puppet]
    debug: /File[/etc/puppet/ssl/private_keys]: Autorequiring File[/etc/puppet/ssl]
    debug: /File[/var/lib/puppet/client_yaml]: Autorequiring File[/var/lib/puppet]
    debug: /File[/etc/puppet/ssl/public_keys]: Autorequiring File[/etc/puppet/ssl]
    debug: /File[/etc/puppet/ssl]: Autorequiring File[/etc/puppet]
    debug: /File[/var/lib/puppet/log]: Autorequiring File[/var/lib/puppet]
    debug: /File[/var/lib/puppet/state/state.yaml]/mode: mode changed '0640' to '0660'
    debug: Finishing transaction 69905115162160

-----

puppetmaster: /var/log/puppet/masterhttp.log


    vagrant@puppet:~$ sudo cat /var/log/puppet/masterhttp.log
    vagrant@puppet:~$ sudo cat /var/log/puppet/masterhttp.log
    [2013-08-09 16:10:25] INFO  WEBrick 1.3.1
    [2013-08-09 16:10:25] INFO  ruby 1.8.7 (2011-06-30) [x86_64-linux]
    [2013-08-09 16:10:25] INFO  
    Certificate:
        Data:
            Version: 3 (0x2)
            Serial Number: 2 (0x2)
        Signature Algorithm: sha1WithRSAEncryption
            Issuer: CN=Puppet CA: puppet.test.edac.unm.edu
            Validity
                Not Before: Aug  8 16:10:25 2013 GMT
                Not After : Aug  8 16:10:25 2018 GMT
            Subject: CN=puppet.test.edac.unm.edu
            Subject Public Key Info:
                Public Key Algorithm: rsaEncryption
                    Public-Key: (1024 bit)
                    Modulus:
                        00:a1:c2:df:3a:97:fb:ab:35:8c:33:01:0d:35:7d:
                        8d:4b:86:c8:e3:37:6e:70:58:4e:26:a8:d6:3c:b6:
                        d6:e5:34:15:73:90:e0:00:d6:99:80:b4:34:9f:af:
                        52:5a:cb:f6:08:7c:ba:49:8e:9a:fb:0e:8e:0b:c4:
                        46:3d:d6:52:31:6e:6a:7f:ac:a1:dc:57:65:9e:65:
                        3a:12:c0:88:2c:8a:0c:6e:bd:50:38:bc:36:47:ba:
                        4a:74:1e:90:f3:81:b6:95:78:97:0a:77:24:2b:81:
                        25:a5:6f:83:4b:b3:94:02:34:03:fd:5b:f3:75:05:
                        37:16:df:61:cf:f4:f8:5b:39
                    Exponent: 65537 (0x10001)
            X509v3 extensions:
                X509v3 Basic Constraints: critical
                    CA:FALSE
                X509v3 Extended Key Usage: critical
                    TLS Web Server Authentication, TLS Web Client Authentication
                X509v3 Key Usage: critical
                    Digital Signature, Key Encipherment
                X509v3 Subject Alternative Name: 
                    DNS:puppet, DNS:puppet.test.edac.unm.edu
                X509v3 Subject Key Identifier: 
                    2F:93:0D:66:03:12:F8:66:DB:47:45:1F:AD:20:61:F5:63:81:C0:FB
                Netscape Comment: 
                    Puppet Ruby/OpenSSL Internal Certificate
        Signature Algorithm: sha1WithRSAEncryption
             78:91:2e:ea:ad:a4:a9:f8:5b:40:72:98:c5:be:e3:1a:a3:f7:
             94:ff:16:44:e0:74:1b:16:d6:71:31:13:4d:70:31:25:4f:04:
             a4:21:0b:50:3b:10:87:64:b5:b0:7d:c6:a3:1e:3a:4b:59:a5:
             89:94:b6:ad:b3:fc:1f:60:03:40:4f:f4:81:5b:be:54:3d:19:
             12:a2:35:e3:6f:cb:7d:a9:a0:2f:3e:d1:3e:74:44:0c:c3:ad:
             b8:e1:16:9c:78:a7:16:5a:d1:80:48:bb:1f:f0:e8:11:52:24:
             05:f5:e7:82:96:91:ca:c7:a5:53:e0:78:01:64:1a:cc:81:da:
             7d:43
    [2013-08-09 16:10:25] INFO  WEBrick::HTTPServer#start: pid=6999 port=8140
    [2013-08-09 16:12:59] dbserver.test.edac.unm.edu - - [09/Aug/2013:16:12:59 UTC] "GET /production/certificate/ca? HTTP/1.1" 200 859
    [2013-08-09 16:12:59] - -> /production/certificate/ca?
    [2013-08-09 16:12:59] dbserver.test.edac.unm.edu - - [09/Aug/2013:16:12:59 UTC] "GET /production/certificate/dbserver.test.edac.unm.edu? HTTP/1.1" 404 53
    [2013-08-09 16:12:59] - -> /production/certificate/dbserver.test.edac.unm.edu?
    [2013-08-09 16:12:59] dbserver.test.edac.unm.edu - - [09/Aug/2013:16:12:59 UTC] "GET /production/certificate_request/dbserver.test.edac.unm.edu? HTTP/1.1" 404 61
    [2013-08-09 16:12:59] - -> /production/certificate_request/dbserver.test.edac.unm.edu?
    [2013-08-09 16:12:59] dbserver.test.edac.unm.edu - - [09/Aug/2013:16:12:59 UTC] "PUT /production/certificate_request/dbserver.test.edac.unm.edu HTTP/1.1" 200 192
    [2013-08-09 16:12:59] - -> /production/certificate_request/dbserver.test.edac.unm.edu
    [2013-08-09 16:12:59] dbserver.test.edac.unm.edu - - [09/Aug/2013:16:12:59 UTC] "GET /production/certificate/dbserver.test.edac.unm.edu? HTTP/1.1" 200 1415
    [2013-08-09 16:12:59] - -> /production/certificate/dbserver.test.edac.unm.edu?
    [2013-08-09 16:13:00] dbserver.test.edac.unm.edu - - [09/Aug/2013:16:13:00 UTC] "GET /production/certificate_revocation_list/ca? HTTP/1.1" 200 410
    [2013-08-09 16:13:00] - -> /production/certificate_revocation_list/ca?
    [2013-08-09 16:13:00] dbserver.test.edac.unm.edu - - [09/Aug/2013:16:13:00 UTC] "POST /production/catalog/dbserver.test.edac.unm.edu HTTP/1.1" 400 126
    [2013-08-09 16:13:00] - -> /production/catalog/dbserver.test.edac.unm.edu
    [2013-08-09 16:13:00] dbserver.test.edac.unm.edu - vagrant@puppet:~$ 
    vagrant@puppet:~$ 

