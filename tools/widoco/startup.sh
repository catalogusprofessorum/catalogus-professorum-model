#!/bin/bash

if [ ! -f widoco-1.4.3-jar-with-dependencies.jar ]; then
    wget https://github.com/dgarijo/Widoco/releases/download/v1.4.3/widoco-1.4.3-jar-with-dependencies.jar
fi
 
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2.ttl -O cpm-2.ttl

java -jar widoco-1.4.3-jar-with-dependencies.jar -ontFile cpm-2.ttl -lang en-de -webVowl -rewriteAll -includeAnnotationProperties -outFolder /var/www/html/cpm-2/

echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm-2/index-en.html"); ?>' > /var/www/html/index.php
echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm-2/index-en.html"); ?>' > /var/www/html/cpm-2/index.php

