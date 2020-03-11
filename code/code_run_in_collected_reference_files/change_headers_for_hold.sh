#!/bin/bash 

. /u/local/Modules/default/init/modules.sh

module load samtools

number=0

:> hold1.fa

xargs samtools faidx all_reads.fa < get_these.txt | while read -r line; do 
	if $(echo $line | grep -q ">")
	then
		printf '%s%i\n' ">Read" "$(( ++number ))" >> hold1.fa
	else
		echo $line >> hold1.fa
	fi
done 


awk '/^>/ { if (name) {printf("%s len=%d\n%s", name, len, seq)} name=$0; seq=""; len = 0; next}
    NF > 0 {seq = seq $0 "\n"; len += length()}
    END { if (name) {printf("%s len=%d\n%s", name, len, seq)} }' hold1.fa > hold.fa
