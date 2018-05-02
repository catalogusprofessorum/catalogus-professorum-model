#!/bin/bash

cp ../model/cpd.ttl cpd.ttl
rapper -g cpd.ttl -o rdfxml  > cpd.owl
git add *
git commit -m "rdf formats generated"
git push


