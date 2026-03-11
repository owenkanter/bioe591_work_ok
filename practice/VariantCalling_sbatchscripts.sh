#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=variantcallingpractice_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=variantcallingpractice_owenkanter-%j.out
#SBATCH --error=variantcallingpractice_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate bcftools

#mpileup command
bcftools mpileup -f ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sorted.bam | head -n 50 > mpileup_output.txt

---------------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=variantcallingpractice_step2_try2_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=variantcallingpractice_step2_try2_owenkanter-%j.out
#SBATCH --error=variantcallingpractice_step2_try2_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate bcftools

#mpileup command
bcftools mpileup -f ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta ~/bioe-591-genomics/students/owenkanter/sequence_alignments/Diglossa_glauca_161092.sorted.bam | bcftools call -mv -Ov -o ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_161092.vcf

--------------

#Moving Err/Out Reports
mv ~/bioe-591-genomics/students/owenkanter/scripts/variantcalling/*.err \
~/bioe-591-genomics/students/owenkanter/reports/variant_calling/.

-----------

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
##
#SBATCH --account=priority-bioe-591-genomics        #specify the account to use
#SBATCH --job-name=multisamplevcf_owenkanter                             # job name
#SBATCH --partition=priority              # queue partition to run the job in
#SBATCH --nodes=1                       # number of nodes to allocate
#SBATCH --ntasks-per-node=1             # number of descrete tasks - keep at one except for MPI
#SBATCH --cpus-per-task=1              # number of cores to allocate
#SBATCH --time=0-00:30:00                 # Maximum job run time
#SBATCH --output=multisamplevcf_owenkanter-%j.out
#SBATCH --error=multisamplevcf_owenkanter-%j.err

# load module and activate mamba
module load Mamba/23.11.0-0
eval "$(conda shell.bash hook)"

# activate your bcftools environment
conda activate bcftools

#Multisample VCF
bcftools mpileup -f ~/bioe-591-genomics/students/owenkanter/references/hemoglobin_references.fasta \
~/bioe-591-genomics/students/owenkanter/sequence_alignments/*.sorted.bam \
| bcftools call -mv -Ov -o ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.vcf

-----------------

bcftools stats Diglossa_glauca_multisample.vcf | grep ^SN > ~/bioe-591-genomics/students/owenkanter/variant_calling/Diglossa_glauca_multisample.txt