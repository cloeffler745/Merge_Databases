#!/bin/bash


# THIS IS THE CODE FOR SEARCHING ENTRIES FROM THE SQL DATABASE WE HAVE COMPILED. IT USES OUR OWN PREPARED METADATA


# prep search

search_term_cl="$1" # get the first variable given on the command line

search_term=$(echo "$search_term_cl" | sed "s/^/|/g" | sed "s/$/|/g")

mkdir -p "$search_term_cl" 
cd "$search_term_cl"

#DIR_NAME=$(cd `dirname $0` && pwd)

# Search our metadata file (made from our sql database of references) for the desired values.

# for reference, right now 1 is the filepath

grep -i "$search_term" /u/home/c/cloeffle/scratch/merge/Merge_Databases/code/our_sql_metadata_fungi.txt | awk -F "|" 'BEGIN{OFS=",";} {print $1;}' > first_step.txt

mkdir -p JGI
mkdir -p REFSEQ
mkdir -p ENSEMBL
mkdir -p FUNGIDB

while IFS="" read -r file_path; do
	dbase=$(echo "$file_path" | awk -F '/' '{print $8}')
	if [ "$dbase" == "JGI" ]
	then
		cp $file_path ./JGI/.
	elif [ "$dbase" == "NCBI" ]
	then
		cp $file_path ./REFSEQ/.
	elif [ "$dbase" == "ensembl" ]
	then
		cp $file_path ./ENSEMBL/.
	else
		cp $filepath ./FUNGIDB/.
	fi
done < first_step.txt



