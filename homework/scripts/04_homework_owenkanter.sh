#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=fastp_homework4_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=fastp_homework4_owenkanter-%j.out
#SBATCH --error=fastp_homework4_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your fastp environment
conda activate fastp

# run fastp sample 161092
fastp -i ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_161092_R1_001.fastq.gz \
-o ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161092_R1_001_trimmed.fastq.gz \
-I ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_161092_R2_001.fastq.gz \
-O ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161092_R2_001_trimmed.fastq.gz \
-h ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161092_owenkanter.fastp.html \
-j ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161092_owenkanter.fastp.json

# run fastp sample 161139
fastp -i ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_161139_R1_001.fastq.gz \
-o ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161139_R1_001_trimmed.fastq.gz \
-I ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_161139_R2_001.fastq.gz \
-O ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161139_R2_001_trimmed.fastq.gz \
-h ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161139_owenkanter.fastp.html \
-j ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161139_owenkanter.fastp.json

# run fastp sample 161164
fastp -i ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_161164_R1_001.fastq.gz \
-o ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161164_R1_001_trimmed.fastq.gz \
-I ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_161164_R2_001.fastq.gz \
-O ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161164_R2_001_trimmed.fastq.gz \
-h ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161164_owenkanter.fastp.html \
-j ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161164_owenkanter.fastp.json

# run fastp sample 176849
fastp -i ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_176849_R1_001.fastq.gz \
-o ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176849_R1_001_trimmed.fastq.gz \
-I ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_176849_R2_001.fastq.gz \
-O ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176849_R2_001_trimmed.fastq.gz \
-h ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_176849_owenkanter.fastp.html \
-j ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_176849_owenkanter.fastp.json

# run fastp sample 176863
fastp -i ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_176863_R1_001.fastq.gz \
-o ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176863_R1_001_trimmed.fastq.gz \
-I ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_176863_R2_001.fastq.gz \
-O ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176863_R2_001_trimmed.fastq.gz \
-h ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_176863_owenkanter.fastp.html \
-j ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_176863_owenkanter.fastp.json

# run fastp sample 218504
fastp -i ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_218504_R1_001.fastq.gz \
-o ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_218504_R1_001_trimmed.fastq.gz \
-I ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca_218504_R2_001.fastq.gz \
-O ~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_218504_R2_001_trimmed.fastq.gz \
-h ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_218504_owenkanter.fastp.html \
-j ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_218504_owenkanter.fastp.json
