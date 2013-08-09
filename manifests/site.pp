# manifests/site.pp

# Define filebucket 'main':
filebucket { 'main':
  path   => '/root/puppet_backup',
}

# Make filebucket 'main' the default backup location for all File resources:
File { backup => 'main' }

node default { 
    include ssh
    include packages
}

node 'dbserver.test.edac.unm.edu' inherits default {
    include database
}
