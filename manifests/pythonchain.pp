## pythonchain.pp ##

# TODO: I'm sure there's a puppet pip package with caching, and I figured 
#  out an ugly way to do it with vagrant for oscon.

class pythonchain {

  $python = [
        # Jason packages
        "bicyclerepair",
        "exuberant-ctags",

        # Things we probably need
        "python-dev",
        "python-examples",
        "python-lxml",
        "python-lxml-doc",
        "python-pip",
        "python-virtualenv",

        # Gstore... ?
        'python-pyramid',
        'python-pastescript',

        # Things that are a PITA to install in pip
        "python-numpy",
  ]
    
  package{ $python: ensure => present }

}
