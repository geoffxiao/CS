#!/usr/bin/env python
#
# Lab 4 -- Python, Q4
# Geoffrey Xiao, gx26
# 
# Reads ids and names from stdin  and creates dictionary to store the IDs are the names
# 
# To call:
#  ./id2.py INPUT_FILE
# 		If INPUT_FILE not provided, read from stdin
#
# Output:
# Two columns: ID and name

import fileinput
import sys

ids = dict() # dictionary to store IDs and names

# Read from stdin
if len(sys.argv) == 1:
	f = fileinput.input()

# Read from file
else:
	filename = sys.argv[1]
	f = open(filename, 'r')



# Read lines from stdin
for line in f :
	split = line.split(' ', 1) # Split each line, 1 indicates max times to split
	ids[int(split[0])] = split[1].rstrip() # convert str to int, also strip newline character

# Print the dictionary sorted by ID number
print "%10s %40s" % ('ID', 'Name')
for key in sorted(ids):
	print "%10s %40s" % (key, ids[key])
