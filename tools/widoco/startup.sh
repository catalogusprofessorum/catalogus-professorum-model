#!/bin/bash

cd /var/www

if [ ! -f widoco-1.4.3-jar-with-dependencies.jar ]; then
    wget https://github.com/dgarijo/Widoco/releases/download/v1.4.3/widoco-1.4.3-jar-with-dependencies.jar
fi
 
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2.ttl -O cpm-2.ttl
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/description-en.html -O description-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/description-de.html -O description-de.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/introduction-en.html -O introduction-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/introduction-de.html -O introduction-de.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/references.html -O references.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/authors.html -O authors.html

java -jar widoco-1.4.3-jar-with-dependencies.jar -ontFile cpm-2.ttl -lang en-de -webVowl -rewriteAll -includeAnnotationProperties -outFolder html/cpm-2/

#Post Processing

#German Translations
sed s/Cross\ reference\ for/Übersicht\ über/g -i ./html/cpm-2/sections/crossref-de.html
sed s/This\ section\ provides\ details\ for\ each\ class\ and\ property\ defined\ by/Dieser\ Abschnitt\ beschreibt\ detailliert\ die\ Klassen\ und\ Rollen\,\ die\ definiert\ sind\ durch/g -i ./html/cpm-2/sections/crossref-de.html
sed s/Table\ of\ contents/Inhaltsverzeichnis/g -i ./html/cpm-2/index-de.html
sed s/Download\ serialization/Download\ in\ verschiedenen\ Datenformaten/g -i ./html/cpm-2/index-de.html
sed s/License\:/Datenlizenz\:/g -i ./html/cpm-2/index-de.html
sed s/Visualization/Darstellung\ als\ Graph/g -i ./html/cpm-2/index-de.html
sed s/Acknowledgements/Danksagung/g -i ./html/cpm-2/index-de.html

#Description and Introduction Sections
cp description-en.html ./html/cpm-2/sections/description-en.html
cp description-de.html ./html/cpm-2/sections/description-de.html
cp introduction-en.html ./html/cpm-2/sections/introduction-en.html
cp introduction-de.html ./html/cpm-2/sections/introduction-de.html

#References Section
cp references.html ./html/cpm-2/sections/references-en.html
cp references.html ./html/cpm-2/sections/references-de.html
sed s/References/Referenzen/g -i ./html/cpm-2/sections/references-de.html

#Authors and Maintainer Section
cp authors.html ./html/cpm-2/sections/authors-en.html
cp authors.html ./html/cpm-2/sections/authors-de.html
sed s/Authors/Autoren/g -i ./html/cpm-2/sections/authors-de.html
sed s/Cross\ reference\ for/Übersicht\ über/g -i ./html/cpm-2/sections/crossref-de.html
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i ./html/cpm-2/index-en.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-en.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i ./html/cpm-2/index-en.html 
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i ./html/cpm-2/index-de.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-de.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i ./html/cpm-2/index-de.html 

# Content Negoiation
echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm-2/index-en.html"); ?>' > ./html/index.php
echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm-2/index-en.html"); ?>' > ./html/cpm-2/index.php

#Provide Generating link
echo "<?php exec(\"cd /var/www && startup.sh\"); ?><a href=\"index-en.html\">index</a>" > ./html/cpm-2/generate.php

#Provide Access rights
chmod a+rw -R *
chown www-data:www-data -R *
