#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_sequencealignment_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_sequencealignment_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_sequencealignment_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your align environment
conda activate align

# align reads 161092
bwa mem -t 4 ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161092_R1_001_trimmed.fastq.gz \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161092_R2_001_trimmed.fastq.gz > \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sam

# create sorted bam 161092
samtools view -b ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sam | samtools sort -o ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sorted.bam
samtools index ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sorted.bam

# mapping statistics 161092
samtools flagstat ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sorted.bam > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_161092_alignment_stats.txt
samtools depth ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sorted.bam | awk '{sum+=$3} END {print sum/NR}' > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_161092_alignment_depth.txt

# align reads 161139
bwa mem -t 4 ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161139_R1_001_trimmed.fastq.gz \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161139_R2_001_trimmed.fastq.gz > \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161139.sam

# create sorted bam 161139
samtools view -b ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161139.sam | samtools sort -o ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161139.sorted.bam
samtools index ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161139.sorted.bam

# mapping statistics 161139
samtools flagstat ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161139.sorted.bam > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_161139_alignment_stats.txt
samtools depth ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161139.sorted.bam | awk '{sum+=$3} END {print sum/NR}' > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_161139_alignment_depth.txt

# align reads 161164
bwa mem -t 4 ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161164_R1_001_trimmed.fastq.gz \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161164_R2_001_trimmed.fastq.gz > \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161164.sam

# create sorted bam 161164
samtools view -b ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161164.sam | samtools sort -o ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161164.sorted.bam
samtools index ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161164.sorted.bam

# mapping statistics 161164
samtools flagstat ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161164.sorted.bam > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_161164_alignment_stats.txt
samtools depth ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161164.sorted.bam | awk '{sum+=$3} END {print sum/NR}' > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_161164_alignment_depth.txt

# align reads 176849
bwa mem -t 4 ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176849_R1_001_trimmed.fastq.gz \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176849_R2_001_trimmed.fastq.gz > \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176849.sam

# create sorted bam 176849
samtools view -b ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176849.sam | samtools sort -o ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176849.sorted.bam
samtools index ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176849.sorted.bam

# mapping statistics 176849
samtools flagstat ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176849.sorted.bam > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_176849_alignment_stats.txt
samtools depth ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176849.sorted.bam | awk '{sum+=$3} END {print sum/NR}' > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_176849_alignment_depth.txt

# align reads 176863
bwa mem -t 4 ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176863_R1_001_trimmed.fastq.gz \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_176863_R2_001_trimmed.fastq.gz > \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176863.sam

# create sorted bam 176863
samtools view -b ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176863.sam | samtools sort -o ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176863.sorted.bam
samtools index ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176863.sorted.bam

# mapping statistics 176863
samtools flagstat ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176863.sorted.bam > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_176863_alignment_stats.txt
samtools depth ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_176863.sorted.bam | awk '{sum+=$3} END {print sum/NR}' > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_176863_alignment_depth.txt

# align reads 218504
bwa mem -t 4 ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_218504_R1_001_trimmed.fastq.gz \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_218504_R2_001_trimmed.fastq.gz > \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_218504.sam

# create sorted bam 218504
samtools view -b ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_218504.sam | samtools sort -o ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_218504.sorted.bam
samtools index ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_218504.sorted.bam

# mapping statistics 218504
samtools flagstat ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_218504.sorted.bam > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_218504_alignment_stats.txt
samtools depth ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_218504.sorted.bam | awk '{sum+=$3} END {print sum/NR}' > ~/bioe-591-genomics/students/owenkanter/reports/alignment/Diglossa_glauca_218504_alignment_depth.txt
