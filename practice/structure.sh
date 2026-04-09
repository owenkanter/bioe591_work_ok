#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=bedfileconversion3                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/bedfileconversion_3-%j.out
#SBATCH --error=log/bedfileconversion_3-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

plink2 \
  --vcf /home/f85j978/bioe-591-genomics/students/owenkanter/structure/data/sparrows.vcf \
  --allow-extra-chr \
  --make-bed \
  --out species

awk 'BEGIN{OFS="\t"} {if(!($1 in a)) a[$1]=++i; $1=a[$1]; print}' species.bim > species.int.bim
cp species.bed species.int.bed
cp species.fam species.int.fam

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture1                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture1-%j.out
#SBATCH --error=log/admixture1-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

admixture --cv data/species.int.bed 2

R Chunk

# read sample names and extract
fam <- read_table("data/species.int.fam", 
  col_names = FALSE,
  show_col_types = FALSE
)
samples <- fam$X2   # individual IDs are usually column 2

# choose your K value (will be 2 for this demo)
K <- 2

# read Q matrix
q <- read_table("data/species.int.2.Q",
  col_names = FALSE,
  show_col_types = FALSE
)

# name the ancestry columns
colnames(q) <- paste0("Cluster", 1:K)

# combine with sample names
q_df <- q %>%
  mutate(sample = samples) %>%
  relocate(sample)

# convert to long format for ggplot
q_long <- q_df %>%
  pivot_longer(
    cols = starts_with("Cluster"),
    names_to = "cluster",
    values_to = "ancestry"
  ) %>%
  mutate(sample = factor(sample, levels = samples))
  
#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_k2_reps                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_k2_reps-%j.out
#SBATCH --error=log/admixture_k2_reps-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

for rep in {1..5}; do
  admixture --cv species.int.bed 2 | tee log_K2_rep${rep}.out
done

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_2-6                           
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_2-6-%j.out
#SBATCH --error=log/admixture_2-6-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

for K in 2 3 4 5 6; do
  admixture --cv data.bed $K | tee log_rep1${K}.out
done

for K in 2 3 4 5 6; do
  admixture --cv data.bed $K | tee log_rep2${K}.out
done

for K in 2 3 4 5 6; do
  admixture --cv data.bed $K | tee log_rep3${K}.out
done

for K in 2 3 4 5 6; do
  admixture --cv data.bed $K | tee log_rep4${K}.out
done

for K in 2 3 4 5 6; do
  admixture --cv data.bed $K | tee log_rep5${K}.out
done

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_extractCVs                           
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_extractCVs-%j.out
#SBATCH --error=log/admixture_extractCVs-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

grep -h "CV error" log_*2.out

grep -h "CV error" admixlogs/log_*3.out > admixlogs/CVError_K3.txt

grep -h "CV error" admixlogs/log_*4.out > admixlogs/CVError_K4.txt

grep -h "CV error" admixlogs/log_*5.out > admixlogs/CVError_K5.txt

grep -h "CV error" admixlogs/log_*6.out > admixlogs/CVError_K6.txt

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_K4_K6                            
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_K4_K6_2-%j.out
#SBATCH --error=log/admixture_K4_K6-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

admixture --cv data/k4/species.int.bed 4

admixture --cv data/k6/species.int.bed 6

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_K4_K6_CVs                           
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_K4_K6_CVs-%j.out
#SBATCH --error=log/admixture_K4_K6_CVs-%j.err

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

#Command for extracting CVs

grep -h "CV error" log_K2_rep*.out > k2_CVerror.txt

#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=admixture_K4246                           
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=log/admixture_K246-%j.out
#SBATCH --error=log/admixture_K246-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
conda activate admixture

for K in 2 4 6; do
  admixture --cv data/data.bed $K | tee log${K}.out
done
