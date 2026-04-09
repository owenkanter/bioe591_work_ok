#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_K4246_CVs                           
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_K246_CVs-%j.out
#SBATCH --error=log/admixture_K246_CVs-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

for rep in {1..5}; do
  admixture --cv data/species.int.bed 2 | tee log_K2_rep${rep}.out
done

for rep in {1..5}; do
  admixture --cv data/species.int.bed 4 | tee log_K4_rep${rep}.out
done

for rep in {1..5}; do
  admixture --cv data/species.int.bed 6 | tee log_K6_rep${rep}.out
done
