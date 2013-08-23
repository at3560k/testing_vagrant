include:
  - packages

# pkg.installed
apache2: # pkg name
  pkg:
     - installed
  service:
     - running
     - watch:
        - pkg: apache
        - user: apache
 
# http://docs.saltstack.com/topics/tutorials/pillar.html
#

extend:
  apache2:
    service:
      - watch:
        -pkg: libaapche2-mod-php5
      - watch:
        -pkg: php5-curl

needed-pkgs:   # any name
  pkg.installed:  # magic
    - names:
      - libapache2-mod-php5
      - php5-curl
      - zip

/var/www:
  file.directory:
    - user: wwwrun
    
# Never runs correctly
builder:
  cmd.script:
    - name: salt://fema/builder.sh
    #- source: salt://fema/builder.sh
    - cwd: /var/www
    - user: root
    - group: wheel
    - shell: /bin/bash
    - stateful: True


