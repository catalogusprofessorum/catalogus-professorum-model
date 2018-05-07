#!/bin/bash

# ONTO contains version (First Argument)
ONTO="$1"
echo "Generating Documentation for cpm/$ONTO"
cd /var/www

#update ontology
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/ontology.ttl -O ontology-cpm-$ONTO.ttl

#remove old files
rm -R html/cpm/$ONTO

#generate documentation for Version 1.9
java -jar widoco-1.4.3-jar-with-dependencies.jar -ontFile ontology-cpm-$ONTO.ttl -lang en-de -webVowl -rewriteAll -includeAnnotationProperties -outFolder html/cpm/$ONTO/

#warte 5 Sekunden
echo "Documentation generated. Wait now 5s to copy additional files."  
sleep 5

#start post processing

#extend the generated documentation
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/description-en.html -O html/cpm/$ONTO/sections/description-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/description-de.html -O html/cpm/$ONTO/sections/description-de.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/abstract-en.html -O html/cpm/$ONTO/sections/abstract-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/abstract-de.html -O html/cpm/$ONTO/sections/abstract-de.html

#add references
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/references.html -O html/cpm/$ONTO/sections/references-en.html
cp html/cpm/$ONTO/sections/references-en.html html/cpm/$ONTO/sections/references-de.html
sed s/References/Referenzen/g -i html/cpm/$ONTO/sections/references-de.html

#add introduction
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/intro-en.html -O html/cpm/$ONTO/sections/intro-en.html
more +6 ./html/cpm/$ONTO/sections/introduction-en.html >> html/cpm/$ONTO/sections/intro-en.html
mv html/cpm/$ONTO/sections/intro-en.html html/cpm/$ONTO/sections/introduction-en.html
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/intro-de.html -O html/cpm/$ONTO/sections/intro-de.html
more +6 ./html/cpm/$ONTO/sections/introduction-de.html >> html/cpm/$ONTO/sections/intro-de.html
mv html/cpm/$ONTO/sections/intro-de.html html/cpm/$ONTO/sections/introduction-de.html

#German translations
sed s/Cross\ reference\ for/Übersicht\ über/g -i html/cpm/$ONTO/sections/crossref-de.html
sed s/This\ section\ provides\ details\ for\ each\ class\ and\ property\ defined\ by/Dieser\ Abschnitt\ beschreibt\ detailliert\ die\ Klassen\ und\ Rollen\,\ die\ definiert\ sind\ durch/g -i html/cpm/$ONTO/sections/crossref-de.html
sed s/Table\ of\ contents/Inhaltsverzeichnis/g -i html/cpm/$ONTO/index-de.html
sed s/Download\ serialization/Download\ in\ verschiedenen\ Datenformaten/g -i html/cpm/$ONTO/index-de.html
sed s/License\:/Datenlizenz\:/g -i html/cpm/$ONTO/index-de.html
sed s/Visualization/Darstellung\ als\ Graph/g -i html/cpm/$ONTO/index-de.html
sed s/Acknowledgements/Danksagung/g -i html/cpm/$ONTO/index-de.html

#Authors, Maintainer and other Version Section
wget https://raw.githubusercontent.com/pcp-on-web/catalogus-professorum-lipsiensium/master/model/cpm-$ONTO/authors.html -O html/cpm/$ONTO/sections/authors-en.html
cp html/cpm/$ONTO/sections/authors-en.html html/cpm/$ONTO/sections/authors-de.html
sed s/Authors/Autoren/g -i html/cpm/$ONTO/sections/authors-de.html
sed s/Other\ Versions/Weitere\ Versionen/g -i html/cpm/$ONTO/sections/authors-de.html
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i html/cpm/$ONTO/index-en.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-en.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i html/cpm/$ONTO/index-en.html 
sed s/\<\\/dl\>/\<\\/dl\>\<dl\ id\=\"authors\"\>\<\\/dl\>\<p\\/\>/g -i html/cpm/$ONTO/index-de.html 
sed s/\$\(\"\#abstract\"\)\.load/\$\(\"\#authors\"\)\.load\(\"sections\\/authors\-de.html\"\)\;\$\(\"\#abstract\"\)\.load/g -i html/cpm/$ONTO/index-de.html 


# Content Negoiation for rdf formats
echo "<?php header('HTTP/1.1 303 See Other');"  	> html/cpm/$ONTO/index.php
echo "\$accept = explode(',', \$_SERVER['HTTP_ACCEPT']);"	>> html/cpm/$ONTO/index.php
echo "if (in_array('text/turtle ', \$accept))  header('Location: ontology.ttl');" >> html/cpm/$ONTO/index.php
echo "else if (in_array('application/n-triples', \$accept)) header('Location: ontology.nt');" >> html/cpm/$ONTO/index.php
echo "elseif (in_array('application/ld+json', \$accept)) header('Location: ontology.json');" >> html/cpm/$ONTO/index.php
echo "elseif (in_array('application/rdf+xml', \$accept)) header('Location: ontology.xml');" >> html/cpm/$ONTO/index.php
echo "else header('Location: index-en.html');" >> html/cpm/$ONTO/index.php
echo "?>" >> html/cpm/$ONTO/index.php

