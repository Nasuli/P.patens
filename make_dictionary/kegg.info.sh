#!/bin/bash

wget http://rest.kegg.jp/list/pathway/ppp
cat ppp | tr ':' '\t' | awk -F- '{print $1}' | awk -F'\t' '{print $2"\t"$3}' > KEGG_names

wget http://rest.kegg.jp//link/ppp/pathway
cat pathway | tr ':' '\t' | awk '{print $2"\t"$4}' > KEGG_pathway

