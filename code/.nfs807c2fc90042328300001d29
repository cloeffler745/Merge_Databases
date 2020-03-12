samtools view aln.sam | grep -P "\t4\t\*" | awk -F '\t' '{print $1}' # Will get the first part of the first line of the files that were not aligned.

# See if the contigs that did not match are the same as each other
xargs samtools faidx all_reads.fa < get_these.txt > hold.fa # get headers of seq that were not aligned
/u/home/c/cloeffle/project/anaconda2/bin/ete3_apps/bin/muscle -in hold.fa -clwstrictout aligned.clw  # run multiple sequence alignment on the unaligned seq
/u/home/c/cloeffle/project/anaconda2/bin/ete3_apps/bin/clustalo -i aligned.clw --percent-id --distmat-out=pim.txt --full --force # get the percent identity matrix


# combine the raw files and the extra bits into one file
