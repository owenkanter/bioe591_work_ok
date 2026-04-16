#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_K23456_data_3                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_K23456_data_3-%j.out
#SBATCH --error=log/admixture_K23456_data_3-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

admixture --cv data/species.int.bed 2

admixture --cv data/species.int.bed 3

admixture --cv data/species.int.bed 4

admixture --cv data/species.int.bed 5

admixture --cv data/species.int.bed 6
