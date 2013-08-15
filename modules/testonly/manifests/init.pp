class testonly{
    host{'puppet.test.edac.unm.edu':
        ip => '10.11.12.100',
        ensure => 'present'
    }

    host{'ansible.test.edac.unm.edu':
        ip => '10.11.12.101',
        ensure => 'present'
    }

    host{'appserver.test.edac.unm.edu':
        ip => '10.11.12.201',
        ensure => 'present'
    }

    host{'dbserver.test.edac.unm.edu':
        ip => '10.11.12.211',
        ensure => 'present'
    }

    host{'mongo1.mongo.edac.unm.edu':
        ip => '10.11.12.221',
        ensure => 'present'
    }

    host{'mongo2.mongo.edac.unm.edu':
        ip => '10.11.12.222',
        ensure => 'present'
    }

    host{'mongo3.mongo.edac.unm.edu':
        ip => '10.11.12.223',
        ensure => 'present'
    }

    host{'mongo4.mongo.edac.unm.edu':
        ip => '10.11.12.224',
        ensure => 'present'
    }
}
