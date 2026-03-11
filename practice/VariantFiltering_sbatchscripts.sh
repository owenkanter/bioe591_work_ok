#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=variantfiltering1_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=variantfiltering1_owenkanter-%j.out
#SBATCH --error=variantfiltering1_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

# remove indels
vcftools --gzvcf ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.vcf.gz \
--remove-indels --recode --out step1

---------------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=variantfiltering2_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=variantfiltering2_owenkanter-%j.out
#SBATCH --error=variantfiltering2_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

# step 2
vcftools --vcf ~/bioe-591-genomics/students/owenkanter/scripts/variant_filtering/step1.recode.vcf \
--minQ 40 --recode --out step2 

---------------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=variantfiltering3_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=variantfiltering3_owenkanter-%j.out
#SBATCH --error=variantfiltering3_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

# step 3

vcftools --vcf ~/bioe-591-genomics/students/owenkanter/scripts/variant_filtering/step2.recode.vcf \
--thin 50 --recode --out step3 

-----------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=variantfilteringsummary_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=variantfilteringsummary_owenkanter-%j.out
#SBATCH --error=variantfilteringsummary_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#summary files for each vcf step
echo -e "file\tsnp_count" > snp_counts.tsv
for f in ~/bioe-591-genomics/students/owenkanter/scripts/variant_filtering/*.vcf; do
    count=$(bcftools view -H -v snps "$f" | wc -l)
    echo -e "${f}\t${count}" >> snp_counts.tsv
done

--------------------------------------

##THIS IS THE FINAL ONE

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_final_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_final_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_final_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#variant filtering homework 7
vcftools --gzvcf ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.vcf.gz \
--remove-indels \
--minQ 40 \
--thin 50 \
--mac 2 \
--max-missing-count 1 \
--min-meanDP 0 \
--recode --out Diglossa_glauca_variant_filtering_final

---------------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_HW7_summary_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_HW7_summary_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_HW7_summary_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#Calculate heterozygosity for each individual. Estimate F_(is)
vcftools --vcf ~/bioe-591-genomics/students/owenkanter/variant_filtering/Diglossa_glauca_variant_filtering_finalscriptHW7.recode.vcf --het

------------
#Max Missing test

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_maxmissingtest_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_maxmissingtest_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_maxmissingtest_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#variant filtering homework 7
vcftools --gzvcf ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.vcf.gz --max-missing-count 1 --recode --out Diglossa_glauca_maxmissing

REASONABLE Kept 383 

---------

#MAC test

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_mactest_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_mactest_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_mactest_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#variant filtering homework 7
vcftools --gzvcf ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.vcf.gz --mac 5 --recode --out Diglossa_glauca_MAC

LEFT ONLY 29 sites @ 5
Left only 63 at 3
Left only 89 at 2

-----------

#Mn depth test

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_mndepthtest_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_mndepthtest_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_mndepthtest_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#variant filtering homework 7
vcftools --gzvcf ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.vcf.gz --min-meanDP 5 --recode --out Diglossa_glauca_mndepth

Left 0 sites @ 5,2,1

--------------

bcftools mpileup \
-f ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
-a FORMAT/DP,FORMAT/AD \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/*.sorted.bam \
| bcftools call -mv -Ov -o ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.vcf

bcftools mpileup \
-f /home/g27n141/bioe-591-genomics/students/Helmstetter/hw_output/05/index/hemoglobin_references.fasta \
-a FORMAT/DP,FORMAT/AD \
/home/g27n141/bioe-591-genomics/students/Helmstetter/hw_output/05/sort_hw/*_sorted.bam \
| bcftools call -mv -Ov -o /home/g27n141/bioe-591-genomics/students/Helmstetter/hw_output/06/hw_06/multi_sample.vcf

----------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_mndepthtest5_depthadded_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_mndepthtest5_depthadded_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_mndepthtest5_depthadded_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#variant filtering homework 7
vcftools --gzvcf ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample_depthadded.vcf.gz \
--min-meanDP 5 --recode --out Diglossa_glauca_mndepth5_depthadded

---------------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_finalscriptHW7_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_finalscriptHW7_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_finalscriptHW7_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

#variant filtering homework 7
vcftools --gzvcf ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample_depthadded.vcf.gz \
--remove-indels \
--minQ 40 \
--thin 50 \
--mac 3 \
--max-missing-count 1 \
--min-meanDP 6 \
--recode --out Diglossa_glauca_variant_filtering_finalscriptHW7

------------------------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=Diglossa_glauca_variant_filtering_finalscriptHW7_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=Diglossa_glauca_variant_filtering_finalscriptHW7_owenkanter-%j.out
#SBATCH --error=Diglossa_glauca_variant_filtering_finalscriptHW7_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate vcftools

