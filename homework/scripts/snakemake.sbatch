#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=snakemake_complete8                          
#SBATCH --partition=priority              
#SBATCH --nodes=1                     
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-24:00:00                 
#SBATCH --output=log/snakemake_complete8-%j.out
#SBATCH --error=log/snakemake_complete8-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
snakemake --profile /home/f85j978/bioe-591-genomics/students/owenkanter/workflow/profiles/slurm --use-conda
