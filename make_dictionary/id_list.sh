#!/bin/bash
#At first you need to download and unpack transcriptome assembly (Ppatens_318_v3.fa) and annotanion (Ppatens_318_v3.3.gene.gff3) of P. patens v3.3 from Phytozome v12

makeblastdb -in Ppatens_318_v3.3.transcript.fa -dbtype nucl

wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/002/425/GCF_000002425.3_V1.1/GCF_000002425.3_V1.1_rna.fna.gz
gunzip GCF_000002425.3_V1.1_rna.fna.gz 

blastn -task megablast -db Ppatens_318_v3.3.transcript.fa -query GCF_000002425.3_V1.1_rna.fna -outfmt 6 > blastn_res.txt
sort -k 3 blastn_res.txt | awk '($3) > 95.00' | tr '.' '\t' | awk '{print $1"\t"$3}' | sort | uniq > 95.txt

grep transcript Ppatens_318_v3.3.gene.gff3 | cut -f 9 | tr 'V' ';' | tr '=' ';' | awk -F';' '{print $2"\t"$4}' | sort | uniq > PACtoPp3.txt
grep ">XM_" GCF_000002425.3_V1.1_rna.fna | tr '.' '\t' | awk '{print $1"\t"$(NF-3)}' | sort -k 2 | uniq > XMtoPHYPA.txt

