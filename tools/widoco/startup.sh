#!/bin/bash

cd /var/www
mkdir /var/www/html/cpm/
mkdir /var/www/html/cpm/1
mkdir /var/www/html/cpm/2

if [ ! -f widoco-1.4.3-jar-with-dependencies.jar ]; then
    wget https://github.com/dgarijo/Widoco/releases/download/v1.4.3/widoco-1.4.3-jar-with-dependencies.jar
fi

### Version 1.9

mkdir cpm-1
cd cpm-1
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-1/ontology.ttl -O ontology.ttl
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-1/description-en.html -O description-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-1/description-de.html -O description-de.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-1/introduction-en.html -O introduction-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-1/introduction-de.html -O introduction-de.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-1/references.html -O references.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-1/authors.html -O authors.html

cd /var/www
java -jar widoco-1.4.3-jar-with-dependencies.jar -ontFile cpm-1/ontology.ttl -lang en-de -webVowl -rewriteAll -includeAnnotationProperties -outFolder html/cpm/1/

sleep 30

#Post Processing

#German Translations
sed s/Cross\ reference\ for/Übersicht\ über/g -i ./html/cpm/1/sections/crossref-de.html
sed s/This\ section\ provides\ details\ for\ each\ class\ and\ property\ defined\ by/Dieser\ Abschnitt\ beschreibt\ detailliert\ die\ Klassen\ und\ Rollen\,\ die\ definiert\ sind\ durch/g -i ./html/cpm/1/sections/crossref-de.html
sed s/Table\ of\ contents/Inhaltsverzeichnis/g -i ./html/cpm/1/index-de.html
sed s/Download\ serialization/Download\ in\ verschiedenen\ Datenformaten/g -i ./html/cpm/1/index-de.html
sed s/License\:/Datenlizenz\:/g -i ./html/cpm/1/index-de.html
sed s/Visualization/Darstellung\ als\ Graph/g -i ./html/cpm/1/index-de.html
sed s/Acknowledgements/Danksagung/g -i ./html/cpm/1/index-de.html

#Add latest version
sed s/\<dd\>Version/\<dd\>\<a\ href\=\"http\:\\/\\/catalogus-professorum.org\\/cpm\\/2\\/\"\>Version\ 2\.1\ \-\ 2018\-04\-26\ \-\ Thomas\ Riechert\ \(Latest\)\<\\/a\>\<\\/dd\>\<dd\>Version/g -i ./html/cpm/1/index-en.html
sed s/\<dd\>Version/\<dd\>\<a\ href\=\"http\:\\/\\/catalogus-professorum.org\\/cpm\\/2\\/\"\>Version\ 2\.1\ \-\ 2018\-04\-26\ \-\ Thomas\ Riechert\ \(Aktuelle Version\)\<\\/a\>\<\\/dd\>\<dd\>Version/g -i ./html/cpm/1/index-de.html


#Description and Introduction Sections
cp cpm-1/description-en.html ./html/cpm/1/sections/description-en.html
cp cpm-1/description-de.html ./html/cpm/1/sections/description-de.html
cp cpm-1/introduction-en.html ./html/cpm/1/sections/introduction-en.html
cp cpm-1/introduction-de.html ./html/cpm/1/sections/introduction-de.html

#References Section
cp cpm-1/references.html ./html/cpm/1/sections/references-en.html
cp cpm-1/references.html ./html/cpm/1/sections/references-de.html
sed s/References/Referenzen/g -i ./html/cpm/1/sections/references-de.html

#Authors and Maintainer Section
cp cpm-1/authors.html ./html/cpm/1/sections/authors-en.html
cp cpm-1/authors.html ./html/cpm/1/sections/authors-de.html
sed s/Authors/Autoren/g -i ./html/cpm/1/sections/authors-de.html
sed s/Cross\ reference\ for/Übersicht\ über/g -i ./html/cpm/1/sections/crossref-de.html
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i ./html/cpm/1/index-en.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-en.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i ./html/cpm/1/index-en.html 
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i ./html/cpm/1/index-de.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-de.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i ./html/cpm/1/index-de.html 

# Content Negoiation
echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm/1/index-en.html"); ?>' > ./html/cpm/1/index.php


### Version 2.1
mkdir cpm-2
cd cpm-2
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2/ontology.ttl -O ontology.ttl
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2/description-en.html -O description-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2/description-de.html -O description-de.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2/introduction-en.html -O introduction-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2/introduction-de.html -O introduction-de.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2/references.html -O references.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-2/authors.html -O authors.html

cd /var/www
java -jar widoco-1.4.3-jar-with-dependencies.jar -ontFile cpm-2/ontology.ttl -lang en-de -webVowl -rewriteAll -includeAnnotationProperties -outFolder html/cpm/2/
sleep 30

#Post Processing

#German Translations
sed s/Cross\ reference\ for/Übersicht\ über/g -i ./html/cpm/2/sections/crossref-de.html
sed s/This\ section\ provides\ details\ for\ each\ class\ and\ property\ defined\ by/Dieser\ Abschnitt\ beschreibt\ detailliert\ die\ Klassen\ und\ Rollen\,\ die\ definiert\ sind\ durch/g -i ./html/cpm/2/sections/crossref-de.html
sed s/Table\ of\ contents/Inhaltsverzeichnis/g -i ./html/cpm/2/index-de.html
sed s/Download\ serialization/Download\ in\ verschiedenen\ Datenformaten/g -i ./html/cpm/2/index-de.html
sed s/License\:/Datenlizenz\:/g -i ./html/cpm/2/index-de.html
sed s/Visualization/Darstellung\ als\ Graph/g -i ./html/cpm/2/index-de.html
sed s/Acknowledgements/Danksagung/g -i ./html/cpm/2/index-de.html

#Description and Introduction Sections
cp cpm-2/description-en.html ./html/cpm/2/sections/description-en.html
cp cpm-2/description-de.html ./html/cpm/2/sections/description-de.html
cp cpm-2/introduction-en.html ./html/cpm/2/sections/introduction-en.html
cp cpm-2/introduction-de.html ./html/cpm/2/sections/introduction-de.html

#References Section
cp cpm-2/references.html ./html/cpm/2/sections/references-en.html
cp cpm-2/references.html ./html/cpm/2/sections/references-de.html
sed s/References/Referenzen/g -i ./html/cpm/2/sections/references-de.html

#Authors and Maintainer Section
cp cpm-2/authors.html ./html/cpm/2/sections/authors-en.html
cp cpm-2/authors.html ./html/cpm/2/sections/authors-de.html
sed s/Authors/Autoren/g -i ./html/cpm/2/sections/authors-de.html
sed s/Cross\ reference\ for/Übersicht\ über/g -i ./html/cpm/2/sections/crossref-de.html
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i ./html/cpm/2/index-en.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-en.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i ./html/cpm/2/index-en.html 
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i ./html/cpm/2/index-de.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-de.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i ./html/cpm/2/index-de.html 

# Content Negoiation
echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm/2/index-en.html"); ?>' > ./html/index.php
echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm/2/index-en.html"); ?>' > ./html/cpm/index.php
echo '<?php header("HTTP/1.1 303 See Other");header("Location: http://$_SERVER['HTTP_HOST']/cpm/2/index-en.html"); ?>' > ./html/cpm/2/index.php

