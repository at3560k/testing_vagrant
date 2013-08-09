class testonly{
    host{'puppet.test.edac.unm.edu':
        ip => '10.11.12.100',
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

    host{'mongoserver.test.edac.unm.edu':
        ip => '10.11.12.221',
        ensure => 'present'
    }

}
