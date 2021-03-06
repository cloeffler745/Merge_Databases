#!/bin/env python

# BOILER PLATE -----------------------------------------------------------------------
import sqlite3
import pandas as pd

# load sql database

datab_bact = sqlite3.connect('/u/home/c/cloeffle/scratch/sql/new_bacteria_stats.db')
datab_fungi = sqlite3.connect('/u/home/c/cloeffle/scratch/sql/fungi.db')

# get data

meta_data_bact = pd.read_sql_query("SELECT FILEPATH, GIVENTAXID, GENUSTAXID, SPECIESTAXID, STRAINTAXID, chromosome_count, avg_length_chromosomes, contig_count, avg_length_contig FROM SPECIESDB WHERE SPECIESTAXID IS NOT NULL;", datab_bact)

meta_data_fungi = pd.read_sql_query("SELECT FILEPATH, GIVENTAXID, GENUSTAXID, SPECIESTAXID, STRAINTAXID,chromosome_count, avg_length_chromosomes, contig_count, avg_length_contig FROM FUNGI_DB WHERE SPECIESTAXID IS NOT NULL;", datab_fungi)

# FUNCTIONS --------------------------------------------------------------------------

# MAIN FUNCTION ----------------------------------------------------------------------

# Make the metadata files

output_metadata_bact = open("our_sql_metadata_bact.txt", "w")
output_metadata_fungi = open("our_sql_metadata_fungi.txt", "w")

# spaces here are to distinguish taxids from statistics since search is done loking for numbers wedged between two |
output_metadata_bact.write("# Filepath|Given_taxid|Genus_taxid|Species_taxid|Strain_taxid| chr_count | chr_avg_length | contig_count | contig_avg_length\n")
output_metadata_bact.write("# Filepath|Given_taxid|Genus_taxid|Species_taxid|Strain_taxid|  chr_count | chr_avg_length | contig_count | contig_avg_length\n")

# write to the files

for index, row in meta_data_bact.iterrows():
	line = "|".join([str(row["FILEPATH"]),str(row["GIVENTAXID"]),str(row["GENUSTAXID"]),str(row["SPECIESTAXID"]),str(row["STRAINTAXID"])])
	line = line + "|"
	line = line + " | ".join([str(row["chromosome_count"]), str(row["avg_length_chromosomes"]), str(row["contig_count"]), str(row["avg_length_contig"])])
	line = line + "\n"
	output_metadata_bact.write(line)

for index, row in meta_data_fungi.iterrows():
        line = "|".join([str(row["FILEPATH"]),str(row["GIVENTAXID"]),str(row["GENUSTAXID"]),str(row["SPECIESTAXID"]),str(row["STRAINTAXID"])])
        line = line + "|"
	line = line + " | ".join([str(row["chromosome_count"]), str(row["avg_length_chromosomes"]), str(row["contig_count"]), str(row["avg_length_contig"])])
	line = line + "\n"
        output_metadata_fungi.write(line)


# CLOSE ------------------------------------------------------------------------------

datab_bact.close()
datab_fungi.close()
output_metadata_bact.close()
output_metadata_fungi.close()
