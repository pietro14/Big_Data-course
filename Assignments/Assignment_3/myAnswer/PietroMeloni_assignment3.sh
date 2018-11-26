#!/bin/bash

## -------  Assignment 3  ------- ##
## ------- Pietro  Meloni ------- ##

## This script must be executed from the CODE directory ##

function add_chr {

	num_chr=${1}

	echo "Adding chromosome number to SWB_Full_chr${num_chr}.txt" 

		awk -v x=${num_chr} -F'\t' 'NR==1{print $1, "CHR", $2, $3, $4, $5, $6, $7, $8}\
		NR>1{print $1, x, $2, $3, $4, $5, $6, $7, $8}' \
		OFS='\t'  ../INPUT/SWB_Full_chr${num_chr}.txt >\
		../OUTPUT/SWB_Full_chr${num_chr}.txt
}

for n in {1..22}    
do
add_chr ${n} &
done

wait

echo "Chromosome numbers added."
echo "Catenating per chromosome files."

# catenating all the 22 files
cat ../OUTPUT/SWB_Full_chr{1..22}.txt > ../OUTPUT/SWB_Full_chradded.txt

# saving the first header in the final file
head -n1 ../OUTPUT/SWB_Full_chradded.txt > ../OUTPUT/SWB_Full_Final.txt 

# removing all the other headers, and appending the output to the final file  
sed  '/MarkerName/d'  ../OUTPUT/SWB_Full_chradded.txt >>  ../OUTPUT/SWB_Full_Final.txt

echo "Script over." 

