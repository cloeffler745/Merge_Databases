#!/bin/bash

source /u/local/Modules/default/init/modules.csh

module load samtools
module load bwa
module load minimap2

/u/home/c/cloeffle/scratch/merge/wtdbg2/wtdbg2 -x rs -g 17755462 -i /u/home/c/cloeffle/scratch/fungi/ensembl/single_files/release_44/Kockovaella_imperatae_gca_002102565.Kocim1.dna.toplevel.fa.gz -i /u/home/c/cloeffle/scratch/fungi/NCBI/GCF_002102565.1_Kocim1_genomic.fna.gz -i /u/home/c/cloeffle/scratch/fungi/JGI/4_4_2019/single_files_genomes/Kocim1_AssemblyScaffolds_Repeatmasked.fasta.gz -t 16 -fo four_triple_nine

/u/home/c/cloeffle/scratch/merge/wtdbg2/wtpoa-cns -t 16 -i four_triple_nine.ctg.lay.gz -fo four_triple_nine.raw.fa 

minimap2 -t 16 -ax map-pb -r2k four_triple_nine.raw.fa cat_reads.fa.gz | samtools sort -@4 > out.bam
samtools view -F0x900 out.bam | ./wtpoa-cns -t 16 -d four_triple_nine.raw.fa -i - -fo out.cns.fa

bwa index out.cns.fa
bwa mem -t 16 out.cns.fa /u/home/c/cloeffle/scratch/fungi/ensembl/single_files/release_44/Kockovaella_imperatae_gca_002102565.Kocim1.dna.toplevel.fa.gz /u/home/c/cloeffle/scratch/fungi/NCBI/GCF_002102565.1_Kocim1_genomic.fna.gz /u/home/c/cloeffle/scratch/fungi/JGI/4_4_2019/single_files_genomes/Kocim1_AssemblyScaffolds_Repeatmasked.fasta.gz | samtools sort -O SAM | /u/home/c/cloeffle/scratch/merge/wtdbg2/wtpoa-cns -t 16 -x sam-sr -d out.cns.fa -i - -fo out.srp.fa
