#!/bin/bash

##USAGE: sh hisat2.sh  <threads>  <reference_genome_index> <pair1> <pair2>

base=$(basename $3 _1.fq.gz)
hisat2 --dta-cufflinks -q -p $1 --rg-id $base -x $2 -1 $3 -2 $4 --summary-file ${base}.txt -S ${base}.sam &&
samtools sort -@ $1 -o ${base}.bam ${base}.sam &&
samtools index ${base}.bam