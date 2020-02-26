#!/bin/bash

# note: the shopt -s nullglob command is so that when there is no file in the directory, code does not stop and throw an error.

:> all_reads.fa.gz

shopt -s nullglob
for i in ENSEMBL/*; do
	do_this='s/^>/>ENSEMBL,'"$i"',/g'
	do_this=$(echo "$do_this" | sed 's/,ENSEMBL\//,/g')
	zcat $i | sed $do_this >> all_reads.fa.gz
done

shopt -s nullglob
for i in REFSEQ/*; do
        do_this='s/^>/>REFSEQ,'"$i"',/g'
        do_this=$(echo "$do_this" | sed 's/,REFSEQ\//,/g')
        zcat $i | sed $do_this >> all_reads.fa.gz
done

shopt -s nullglob
for i in JGI/*; do
        do_this='s/^>/>JGI,'"$i"',/g'
        do_this=$(echo "$do_this" | sed 's/,JGI\//,/g')
        zcat $i | sed $do_this >> all_reads.fa.gz
done

shopt -s nullglob
for i in FUNGIDB/*; do
        do_this='s/^>/FUNGIDB,'"$i"',/g'
        do_this=$(echo "$do_this" | sed 's/,FUNGIDB\//,/g')
        zcat $i | sed $do_this >> all_reads.fa.gz
done 

