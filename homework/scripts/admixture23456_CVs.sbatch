#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_23456_extractCVs_13                           
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_23456_extractCVs_13-%j.out
#SBATCH --error=log/admixture_23456_extractCVs_13-%j.err

module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"
conda activate admixture

set -e

for K in 2 3 4 5 6; do
  for rep in {1..5}; do
    seed=$RANDOM
    echo "Running K=$K rep=$rep seed=$seed"

    admixture --cv -s $seed data/species.int.bed $K \
      2>&1 | tee log_K${K}_rep${rep}.out
  done
done
