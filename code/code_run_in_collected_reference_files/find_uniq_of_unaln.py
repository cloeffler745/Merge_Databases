#!/bin/env python

# BOILER PLATE ------------------------------------------------------------------------------------

per_id_matrix = open("pim.txt")

# FUNCTIONS ---------------------------------------------------------------------------------------



# MAIN FUNCTION -----------------------------------------------------------------------------------

lines = per_id_matrix.readlines()
count = int(lines[0].strip()) # because first line does not count, actual matrix starts on line 1, therefore, use 0-based indexing for rows.
matches = list(range(1,count+1))

#print(matches)

i = 1
while i < count: # not equal to because will never use last line of matrix
	row = lines[i].strip().split(" ")
	e = i + 1 # only want top triangle of values.
	if i in matches:# if the read has not yet been found identical with another read
		while e <= count: # we have a [count x count] matrix, and since 0 value is held by read name, matrix is 1-based indexing
			identity = int(float(row[e])) # float must be used to remove most excessive 0 after decimal
			if identity == 100:
				matches.remove(e)
			e += 1
		
	i += 1


#print(matches)

unique_read_names = open("unaln_uniq.txt","w")

for p in matches: 
	unique_read_names.write(lines[p].split(" ")[0])



# CLOSE -------------------------------------------------------------------------------------------

per_id_matrix.close()
unique_read_names.close()
