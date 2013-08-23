#!/bin/sh

cd /var/www
wget -m 'http://edacweb.unm.edu/~fema/'
mv edacweb.unm.edu/~fema ./fema
rmdir edacweb.unm.edu

mkdir proxy
cd proxy
/usr/bin/wget 'https://developers.arcgis.com/en/javascript/jshelp/proxypage_php.zip'
/usr/bin/unzip proxypage_php.zip  # extracts proxy.php
rm proxypage_php.zip  

# #array( 'url' => 'http://sampleserver1.arcgisonline.com/ArcGIS/rest/services/', 'matchAll' => true, 'token' => '' )

/bin/sed -i 's/sampleserver1.arcgisonline.com\/ArcGIS/nmbbmapping.org\/arcgis\//' proxy.php
# punch allowed service into shape
#   most right way to do this is checkout or install our own version...

# writing the state line
echo  # an empty line here so the next line will be the last.
echo "changed=yes comment='something has changed' whatever=123"
