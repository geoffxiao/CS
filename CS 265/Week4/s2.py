#!/usr/bin/env python
#
# Lab 4 -- Python, Q2
# Geoffrey Xiao, gx26
#
# 
# For each student in the input file, computes the average of all the scores
# for the student, prints 2 columns: name and average
#
# To call:
# python s2.py INPUT_FILE
#	INPUT_FILE contains the student data in csv format
# Output:
# Two columns: student name and student's average grade

import sys

filename = sys.argv[1] # The file name
f = open(filename, 'r') # Open file for reading

tokenized = [] # Store the lines in the file

# Read each line in file and store it in list
for line in f :
	split = line.split(",") # Split each line into a list, use "," because csv file
	tokenized.append(split)

# Print table headers
print '%10s %10s' % ('Student', 'Average Grade')

# Iterate through the items for each student
for student in tokenized:
	print '%10s ' % (student[0]), # Print student name
	
	total = 0 # Sum of the student
	number = 0 # Number of grades

	# calculate total sum of and number of grades for each student
	for grade in student[1:] :
		total = total + float(grade)
		number = number + 1
	
	# Print average
	print '%12.3f' % (total / number)


