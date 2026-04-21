# Create env

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=bcftools                             
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=bcftools-%j.out
#SBATCH --error=bcftools-%j.err


module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
mamba env create -f bcftools.yaml

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=htslib                             
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=htslib-%j.out
#SBATCH --error=htslib-%j.err


module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda install -y -c bioconda htslib
conda create -n hts_env -c bioconda htslib
conda activate hts_env

#Create Relatedness vcf

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=ngsrelate_inca10_8                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/ngsrelate_inca10_8-%j.out
#SBATCH --error=log/ngsrelate_inca10_8-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"

# gzip the vcf
conda activate bcftools
bcftools view -Oz -o data/Inca_MaxMissing10.vcf.gz data/Inca_MaxMissing10.recode.vcf

# index the vcf
conda activate hts_env
tabix -p vcf data/Inca_MaxMissing10.vcf.gz

# generate a sample ID file 
conda activate bcftools
bcftools query -l data/Inca_MaxMissing10.vcf.gz > data/Inca_MaxMissing10_ids.txt

# call ngsRelate
conda activate ngsrelate
ngsRelate -h data/Inca_MaxMissing10.vcf.gz -T GT -c 1 -O data/Inca_MaxMissing10.out -z data/Inca_MaxMissing10_ids.txt
