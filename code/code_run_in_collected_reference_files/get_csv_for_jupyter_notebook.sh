#!/bin/bash

:> before_after_contig_length.csv

zgrep ">" master_ref.fa.gz | awk '{print $2}' | awk -F '=' '{print $2}' | sed 's/$/,149040,after/g' | sed 's/^/MASTER,/g' >> before_after_contig_length.csv

cat all_reads.fa | awk '$0 ~ ">" {if (NR > 1) {print c;} c=0;printf substr($0,2,100) "\t"; } $0 !~ ">" {c+=length($0);} END { print c; }' | awk -v OFS="," '{n=split($0,A,"\t"); db=split($1,B,","); print B[1],A[n]}' | sed 's/$/,149040,before/g' >> before_after_contig_length.csv
