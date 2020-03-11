#!/bin/env python

import re
import gzip

with gzip.open("master_ref.fa.gz") as f:
	contig_lengths = []
	num_contigs = 0
	min_length = 0
	max_length = 0
	avg_length = 0
	sum_contig_lengths = 0
	for line in f:
		if re.findall(r">", line):
			num_contigs +=1
			contig_lengths.append(re.findall(r"\d+", line)[1])
	print(num_contigs, contig_lengths)
	if len(contig_lengths) >= 1:
		contig_lengths.sort()
		min_length = contig_lengths[0]
		max_length = contig_lengths[-1]
		for lengths in contig_lengths:
			sum_contig_lengths += int(lengths)
		avg_length = sum_contig_lengths / num_contigs
	print(avg_length, min_length, max_length)
