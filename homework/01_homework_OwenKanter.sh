#!/usr/bin/env bash

# Downloaded the data
		
# 1. Change into week_1 directory
	cd week_1/;
	pwd ;
	
# 2. Make 3 subdirectories
	mkdir fastq/;
	mkdir fasta/;
	mkdir metadata/;
	
# 3. Move files into directories
	mv *.fastq.gz fastq/;
	mv *.fasta fasta/;
	mv *.csv metadata/;
	
# 4. Count files in each directory
	echo "fastq";
	ls fastq/ | wc -l;
	echo "fasta";
	ls fasta/ | wc -l;
	echo "metadata";
	ls metadata/ | wc -l
	

