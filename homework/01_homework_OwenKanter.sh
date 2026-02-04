#!/usr/bin/env bash

# Downloading the data
	# cd /c/Users/owenk/OneDrive/Desktop/GradCourses/Genomics591/Coding/week_1/ # enter the data directory
	# curl --ssl-no-revoke https://raw.githubusercontent.com/elinck/genomics_eco_con/main/data/week_1.tar.gz -o week_1.tar.gz # download a resource at a url
	# tar -xzf week_1.tar.gz # this command unzips a "tarball"
		
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
	

