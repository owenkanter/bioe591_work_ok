cp ~/bioe-591-genomics/course-materials/data/raw_reads/Diglossa_glauca/Diglossa_glauca*.fastq.gz ~/bioe-591-genomics/students/owenkanter/workflow/data/.
Diglossa_glauca_161092_R1_001.fastq.gz
Diglossa_glauca_161092_R2_001.fastq.gz

rule fastp:
    conda:
        "envs/fastp.yaml"
    input:
        r1="data/Diglossa_glauca_161092_R1_001.fastq.gz",
        r2="data/Diglossa_glauca_161092_R2_001.fastq.gz"
    output:
        r1="results/clean/Diglossa_glauca_161092_R1_001.clean.fastq.gz",
        r2="results/clean/Diglossa_glauca_161092_R2_001.clean.fastq.gz"
    shell:
        """
        fastp \
        -i {input.r1} -I {input.r2} \
        -o {output.r1} -O {output.r2}
        """
		

#Fastp trial SBATCH

#!/bin/bash
##
## example-array.slurm.sh: submit an array of jobs with a varying parameter
##
## Lines starting with #SBATCH are read by Slurm. Lines starting with ## are comments.
## All other lines are read by the shell.
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=snakemake_fastp_trial                             
#SBATCH --partition=priority              
#SBATCH --nodes=1                     
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-00:30:00                 
#SBATCH --output=log/snakemake_fastp_trial-%j.out
#SBATCH --error=log/snakemake_fastp_trial-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
snakemake --profile profile/slurm --use-conda

#Downloading SnakeMake SLURM Plugin - Script
#New Yaml

name: snakemake3
channels: 
  - conda-forge 
  - bioconda 
  - nodefaults 
dependencies:
  - snakemake >=9
  - snakemake-executor-plugin-slurm
  - mamba
  - conda>=24.7.1
  
#!/bin/bash
#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=snakemake3                             
#SBATCH --partition=priority              
#SBATCH --nodes=1                       
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-10:00:00                 
#SBATCH --output=snakemake3-%j.out
#SBATCH --error=snakemake3-%j.err


module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
mamba env create -f snakemake3.yaml

#Fastp Trial snakemake

#SBATCH --account=priority-bioe-591-genomics        
#SBATCH --job-name=snakemake_fastp                          
#SBATCH --partition=priority              
#SBATCH --nodes=1                     
#SBATCH --ntasks-per-node=1             
#SBATCH --cpus-per-task=1              
#SBATCH --time=0-00:30:00                 
#SBATCH --output=log/snakemake_fastp-%j.out
#SBATCH --error=log/snakemake_fastp-%j.err

module load Mamba/23.11.0-0;
eval "$(conda shell.bash hook)"
snakemake --profile /home/f85j978/bioe-591-genomics/students/owenkanter/workflow/profiles/slurm --use-conda

#Dry Run
snakemake --profile /home/f85j978/bioe-591-genomics/students/owenkanter/workflow/profiles/slurm --use-conda -n

#Expanding Rules to include two samples
	
SAMPLES = ["Diglossa_glauca_161092","Diglossa_glauca_161139"]

rule all:
    input:
        expand("results/clean/{sample}_R1.clean.fastq.gz", sample=SAMPLES),
        expand("results/clean/{sample}_R2.clean.fastq.gz", sample=SAMPLES)

rule fastp:
    conda:
        "envs/fastp.yaml"
    input:
        r1="data/{sample}_R1_001.fastq.gz",
        r2="data/{sample}_R2_001.fastq.gz"
    output:
        r1="results/clean/{sample}_R1.clean.fastq.gz",
        r2="results/clean/{sample}_R2.clean.fastq.gz"
    shell:
        """
        fastp \
        -i {input.r1} -I {input.r2} \
        -o {output.r1} -O {output.r2}
        """

#Updated Snakefile
		
SAMPLES = ["Diglossa_glauca_161092","Diglossa_glauca_161139"]

rule all:
    input:
	    "genome/hemoglobin_references.fasta"
		"genome/hemoglobin_references.fasta.fai",
        expand("results/clean/{sample}_R1.clean.fastq.gz", sample=SAMPLES),
        expand("results/clean/{sample}_R2.clean.fastq.gz", sample=SAMPLES),
		expand("results/aligned/{sample}.sam", sample=SAMPLES),
		expand("results/aligned/{sample}.sorted.bam", sample=SAMPLES),
		"results/vcf/Diglossa_glauca_multisample.vcf"
		"results/filtered/Diglossa_glauca_multisample_filtered_vcf.gz"

rule fastp:
    conda:
        "envs/fastp.yaml"
    input:
        r1="data/{sample}_R1_001.fastq.gz",
        r2="data/{sample}_R2_001.fastq.gz"
    output:
        r1="results/clean/{sample}_R1.clean.fastq.gz",
        r2="results/clean/{sample}_R2.clean.fastq.gz"
    shell:
        """
        fastp \
        -i {input.r1} -I {input.r2} \
        -o {output.r1} -O {output.r2}
        """
		
rule index:
    input:
        "genome/hemoglobin_references.fasta"
    output:
        "genome/hemoglobin_references.fasta.fai"
    conda:
        "envs/align.yaml"
    shell:
        """
        samtools faidx {input}
        """

rule align:
    input:
        g="genome/hemoglobin_references.fasta",
        r1="results/clean/{sample}_R1.clean.fastq.gz",
        r2="results/clean/{sample}_R2.clean.fastq.gz"
    output:
        "results/aligned/{sample}.sam"
    conda:
        "envs/align.yaml"
    shell:
        bwa mem -t 4 {input.g} {input.r1} {input.r2} > {output}
        """
		
rule sort:
    input:
        "results/aligned/{sample}.sam"
    output:
        "results/aligned/{sample}.sorted.bam"
    conda:
        "envs/align.yaml"
    shell:
        """
        samtools view -b {input} | samtools sort -o {output}
        samtools index {output}
        """
		
rule variantcalling:
    input:
	    g="genome/hemoglobin_references.fasta",
        r1="results/aligned/Diglossa_glauca_161092.sorted.bam",
		r2="results/aligned/Diglossa_glauca_161139.sorted.bam"
    output:
        "results/vcf/Diglossa_glauca_multisample.vcf"
    conda:
        "envs/bcftools.yaml"
    shell:
        """
        bcftools mpileup -f {input.g} {input.r1} {input.r2} | bcftools call -mv -Ov -o {output}
        """
		
rule variantfiltering:
    input:
	    "results/vcf/Diglossa_glauca_multisample.vcf"
    output:
        "results/filtered/Diglossa_glauca_multisample_filtered_vcf.gz"
    conda:
        "envs/vcftools.yaml"
    shell:
        """
        vcftools --gzvcf {input} --remove-indels --minQ 40 --thin 50 --mac 3 --max-missing-count 1 --min-meanDP 6 --recode --out {output}
        """
		
------------------

SAMPLES = ["Diglossa_glauca_161092","Diglossa_glauca_161139"]

rule all:
    input:
        "genome/hemoglobin_references.fasta",
        expand("results/clean/{sample}_R1.clean.fastq.gz", sample=SAMPLES),
        expand("results/clean/{sample}_R2.clean.fastq.gz", sample=SAMPLES),
        expand("results/aligned/{sample}.sam", sample=SAMPLES),
        expand("results/aligned/{sample}.sorted.bam", sample=SAMPLES),
        "results/vcf/Diglossa_glauca_multisample.vcf",
        "results/filtered/Diglossa_glauca_multisample_filtered_vcf.gz"

rule fastp:
    conda:
        "envs/fastp.yaml"
    input:
        r1="data/{sample}_R1_001.fastq.gz",
        r2="data/{sample}_R2_001.fastq.gz"
    output:
        r1="results/clean/{sample}_R1.clean.fastq.gz",
        r2="results/clean/{sample}_R2.clean.fastq.gz"
    shell:
        """
        fastp \
        -i {input.r1} -I {input.r2} \
        -o {output.r1} -O {output.r2}
        """
		
rule index:
    input:
        "genome/hemoglobin_references.fasta"
    output:
        "genome/hemoglobin_references.fasta.fai"
    conda:
        "envs/align.yaml"
    shell:
        """
        samtools faidx {input}
        """

rule align:
    input:
        g="genome/hemoglobin_references.fasta",
        r1="results/clean/{sample}_R1.clean.fastq.gz",
        r2="results/clean/{sample}_R2.clean.fastq.gz"
    output:
        "results/aligned/{sample}.sam"
    conda:
        "envs/align.yaml"
	resources:
	    runtime=120
    shell:
        """
        bwa mem -t 4 {input.g} {input.r1} {input.r2} > {output}
        """

rule sort:
    input:
        "results/aligned/{sample}.sam"
    output:
        "results/aligned/{sample}.sorted.bam"
    conda:
        "envs/align.yaml"
	resources:
	    runtime=120
    shell:
        """
        samtools view -b {input} | samtools sort -o {output}
        samtools index {output}
        """	

rule variantcalling:
    input:
        g="genome/hemoglobin_references.fasta",
        r=expand("results/aligned/{sample}.sorted.bam", sample=SAMPLES)
    output:
        "results/vcf/Diglossa_glauca_multisample.vcf"
    conda:
        "envs/bcftools.yaml"
	resources:
	    runtime=120
    shell:
        """
        bcftools mpileup -f {input.g} {input.r} | bcftools call -mv -Ov -o {output}
        """
		
rule variantsummary:
    input:
        "results/vcf/Diglossa_glauca_multisample.vcf"
    output:
        "results/filtered/Diglossa_glauca_multisample_vcf_stats.txt"
    conda:
        "envs/bcftools.yaml"
	shell:
        """
        bcftools stats {input} 
        """
	    

rule variantfiltering:
    input:
        "results/vcf/Diglossa_glauca_multisample.vcf"
    output:
        "results/filtered/Diglossa_glauca_multisample_filtered_vcf.gz"
    conda:
        "envs/vcftools.yaml"
	resources:
	    runtime=120
    shell:
        """
        vcftools --gzvcf {input} --remove-indels --minQ 40 --thin 50 --mac 3 --max-missing-count 1 --min-meanDP 6 --recode --out {output}
        """