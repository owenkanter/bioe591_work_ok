#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=ngsrelate_inca10_6                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=ngsrelate_inca10_6-%j.out
#SBATCH --error=ngsrelate_inca10_6-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"

# gzip the vcf
conda activate bcftools
bcftools view -Oz -o Inca_MaxMissing10.vcf.gz /home/f85j978/bioe-591-genomics/students/owenkanter/kinship/data/Inca_MaxMissing10.recode.vcf

# index the vcf
conda activate hts_env
tabix -p vcf Inca_MaxMissing10.vcf.gz

# generate a Inca_MaxMissing10 ID file 
conda activate bcftools
bcftools query -l Inca_MaxMissing10.vcf.gz > Inca_MaxMissing10_ids.txt

# call ngsrelate
conda activate ngsrelate
ngsrelate -h Inca_MaxMissing10.vcf.gz -T GT -c 1 -O Inca_MaxMissing10.ngsrelate.out -z Inca_MaxMissing10_ids.txt
