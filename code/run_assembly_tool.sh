#!/bin/bash

. /u/local/Modules/default/init/modules.sh

module load samtools
module load bwa
#module load minimap2

/u/home/c/cloeffle/scratch/merge/wtdbg2/wtdbg2 -x rs -g 33459860 -i all_reads.fa.gz -t 16 -fo assembly

/u/home/c/cloeffle/scratch/merge/wtdbg2/wtpoa-cns -t 16 -i assembly.ctg.lay.gz -fo assembly.raw.fa 

