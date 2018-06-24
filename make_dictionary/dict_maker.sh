#!/bin/bash

awk '{print $1}' KEGG_names > KEGG_pp.txt
awk '{print $2}' KEGG_names > KEGG_glyconames.txt
cat KEGG_pp.txt | while read line
do
    sort new_dict.txt | uniq | grep $line | tr 'V' '\t' | awk '{print $2}' | tr '\n' ' ' > $line.txt
done

sed r ppp* > pppkegg.gmt
paste KEGG_glyconames.txt KEGG_pp.txt pppkegg.gmt | tr ' ' '\t' > kegg_p33.gmt

rm ppp* KEGG_pp.txt KEGG_glyconames.txt
