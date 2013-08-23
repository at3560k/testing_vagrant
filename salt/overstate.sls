
webservers:
  match: fema.* 
  sls: 
    - mike

# Later...
#mysql:
#  match: db*
#  sls:
#    - mysql.server

all:
  match: '*'
  require:
    #- mysql
    - webservers

