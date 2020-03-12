# Merge_Databases

We download the current genome references from PATRIC, RefSeq, and Ensembl for Bacteria and JGI 1K, RefSeq, Ensembl, and FungiDB for Fungus. Taxid lineage for each downloaded reference is found and used to pair up references associated with the same lineages. 

Djoin then takes paired reference files and uses wtdbg to assemble the references into larger contigs. Contigs from the original reference databases that did not get assembled are found (using BWA aligner). These unassembled sequences are put through MUSCLE and the resulting percent identity matrix is used to remove duplicate sequences. 

Unique sequences and the assemblies are compiled into a single master reference file for that given lineage. All master reference files are collected into one directory. Filepath, taxid lineage, taxon name lineage, average length of sequences and sequence count are collected into a metadata file.
