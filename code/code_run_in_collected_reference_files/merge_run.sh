#!/bin/bash

. /u/local/Modules/default/init/modules.sh

#../../Merge_Databases/code/collect_reads.sh
../../Merge_Databases/code/run_assembly_tool.sh
module load bwa
bwa index assembly.raw.fa
module load samtools
bwa mem assembly.raw.fa all_reads.fa  > aln.sam

samtools view aln.sam | awk '{print $1,$2,$3}' > important_data_from_aln_file.txt

samtools view aln.sam | grep -P "\t4\t\*" | awk -F '\t' '{print $1}' > get_these.txt # Will get the first part of the first line of the files that were not aligned.


# See if the contigs that did not match are the same as each other
# xargs samtools faidx all_reads.fa.gz < get_these.txt > hold.fa # get headers of seq that were not aligned

number=0


:> hold.fa

xargs samtools faidx all_reads.fa < get_these.txt | while read -r line; do 
        if $(echo $line | grep -q ">")
        then
                printf '%s%i\n' ">Read" "$(( ++number ))" >> hold.fa
        else
                echo $line >> hold.fa
        fi
done


/u/home/c/cloeffle/project/anaconda2/bin/ete3_apps/bin/muscle -in hold.fa -clwstrictout aligned.clw  # run multiple sequence alignment on the unaligned seq
/u/home/c/cloeffle/project/anaconda2/bin/ete3_apps/bin/clustalo -i aligned.clw --percent-id --distmat-out=pim.txt --full --force # get the percent identity matrix

../find_uniq_of_unaln.py # find unique reads that were not alinged , puts terms in "unaln_uniq.txt"

xargs samtools faidx hold.fa < unaln_uniq.txt > hold1.fa # change unalinged reads so that it only holds unique references (remove duplicates)


awk '/^>/ { if (name) {printf("%s len=%d\n%s", name, len, seq)} name=$0; seq=""; len = 0; next}
    NF > 0 {seq = seq $0 "\n"; len += length()}
    END { if (name) {printf("%s len=%d\n%s", name, len, seq)} }' hold1.fa > unassembled_reads.fa


# combine the raw files and the extra bits into one file

cat assembly.raw.fa unassembled_reads.fa > master_ref.fa

gzip master_ref.fa

#rm hold.fa
#rm hold1.fa

:> master_stats.txt 
echo "#contig_count, avg_length_contigs" >> master_stats.txt
/u/home/c/cloeffle/scratch/merge/Merge_Databases/code/get_consensus_stats.py >> master_stats.txt

echo "Done!"
