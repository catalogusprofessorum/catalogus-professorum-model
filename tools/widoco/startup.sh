#!/bin/bash

# provide the web path for the URIs
mkdir html/cpm/
mkdir html/cpm/1
mkdir html/cpm/2

# download WIDOC tool if not exists
if [ ! -f widoco-1.4.3-jar-with-dependencies.jar ]; then
    wget https://github.com/dgarijo/Widoco/releases/download/v1.4.3/widoco-1.4.3-jar-with-dependencies.jar
fi

#update generate.sh
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-model/master/tools/widoco/generate.sh -O generate.sh
chmod a+rx generate.sh

./generate.sh 1
./generate.sh 2

# Content Negoiation /cpm/
echo "<?php header('HTTP/1.1 303 See Other');"  	> html/cpm/index.php
echo "header('Location: /cpm/2/');" >> html/cpm/index.php
echo "?>" >> html/cpm/index.php

# chmod to enable rebuild script
chmod a+rw -R *

# rebuild.php skript
echo "<?php echo exec('/var/www/generate.sh 1'); echo exec('/var/www/generate.sh 2'); echo 'Rebuild finished!'; ?><a href='index.php'>index</a>" > html/cpm/rebuild.php

