#!/bin/bash

# count.bash
# for each file in the working directory, this program will print the
# filename, the # of lines, and the # of words to stdout
# 
# Geoffrey Xiao, gx26
# CS265 Lab 2

# Loop through all the files in the current directory 
# NOTE: this will not recursively search through subdirectories

for filename in * ; do
	
	file="$filename"; # the file name
	
	if [ -f "$filename" ] ; then # if the file is a file

		# use wc to determine number of words and lines in file
		lines=$(wc -l < "$filename")
		words=$(wc -w < "$filename")

		# print the file # lines # words to stdout
		printf "%s %d %d\n" "$file" "$lines" "$words"

	fi # end if

done # end for loop
