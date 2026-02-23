#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=alignment1stats_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=alignment1stats_owenkanter-%j.out
#SBATCH --error=alignment1stats_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your align environment
conda activate align

# align reads
bwa mem -t 4 ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161092_R1_001_trimmed.fastq.gz \
~/bioe-591-genomics/students/owenkanter/trimmed_reads/Diglossa_glauca_161092_R2_001_trimmed.fastq.gz > \
~/bioe-591-genomics/students/owenkanter/alignedreads/Diglossa_glauca_161092.sam

#view in samtools
samtools view -b ~/bioe-591-genomics/students/owenkanter/alignedreads/Diglossa_glauca_161092.sam | samtools sort -o ~/bioe-591-genomics/students/owenkanter/alignedreads/Diglossa_glauca_161092.sorted.bam
samtools index ~/bioe-591-genomics/students/owenkanter/alignedreads/Diglossa_glauca_161092.sorted.bam

#view samtools
samtools tview ~/bioe-591-genomics/students/owenkanter/alignedreads/Diglossa_glauca_161092.sorted.bam ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta

#mapping statistics
samtools flagstat ~/bioe-591-genomics/students/owenkanter/alignedreads/Diglossa_glauca_161092.sorted.bam > ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161092_alignment_stats.txt
samtools depth ~/bioe-591-genomics/students/owenkanter/alignedreads/Diglossa_glauca_161092.sorted.bam | awk '{sum+=$3} END {print sum/NR}' > ~/bioe-591-genomics/students/owenkanter/reports/Diglossa_glauca_161092_alignment_depth.txt