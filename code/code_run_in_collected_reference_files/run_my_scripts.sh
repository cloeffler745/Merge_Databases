#!/bin/bash

. /u/local/Modules/default/init/modules.sh

../../Merge_Databases/code/collect_reads.sh
../../Merge_Databases/code/run_assembly_tool.sh
module load bwa
bwa index assembly.raw.fa
module load samtools
bwa mem assembly.raw.fa all_reads.fa.gz  > aln.sam

samtools view aln.sam | awk '{print $1,$2,$3}' > important_data_from_aln_file.txt


