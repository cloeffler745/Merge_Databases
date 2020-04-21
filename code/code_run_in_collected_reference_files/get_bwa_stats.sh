#!/bin/bash

:> BWA_stats.txt
echo "#read_name	ref_name	NW_Value" >> BWA_stats.txt
 samtools view aln.sam | awk '{print $1, $3, $12}' >> BWA_stats.txt

echo "Done."
