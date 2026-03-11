**VCF Cutoff Justifications**
Owen Kanter

**Variant Filtering**

*Includes Line from VCF Documentation for explaining the command.*
*Followed by Justification Line, explaining chosen value.*

--remove-indels
	VCF Documentation: "Include or exclude sites that contain an indel. For these options "indel" means any variant that alters the length of the REF allele."
	Justification: Retain this command that excludes insertions/deletions. No cutoff necessary.

--minQ 40
	VCF Documentation: "Includes only sites with Quality value above this threshold."
	Justification: Gives us a probability of error of 0.001 (Source: Duke University) which provides very strong evidence read quality is not affecting our conclusions.

--thin 50
	VCF Documentation: "Thin sites so that no two sites are within the specified distance from one another."
	Justification: Retain this step from our processing practice to ensure that two sites are not closer than 50 nucleotides apart.
	
--mac 3
	VCF Documentation: "Include only sites with Minor Allele Count greater than or equal to the "--mac" value."
	Justification: A MAC of 3 controls for at least 2 of the individuals carrying the SNP.
	
--max-missing-count 1
	VCF Documentation: "Exclude sites with more than this number of missing genotypes over all individuals."
	Justification: Allows for 1 genotype to be missing from the six samples (17 %). A threshold of 2 would allow for (33 %) of samples to be missing which seems excessively high for our sample size.
	
--min-meanDP 6
	VCF Documentation: "Includes only sites with mean depth values (over all included individuals) greater than or equal to the "--min-meanDP" value."
	Justification: Utilizing cutoff depth greater than 6 as seen in Linck and Battey 2019.

**Summary** 

--het
	VCF Documentation: "Calculates a measure of heterozygosity on a per-individual basis. Specfically, the inbreeding coefficient, F, is estimated for each individual using a method of moments."
	Justification: Allows for the evaluation of 
	
| Individual | Observed Homozygosity | Expected Homozygosity | N_Sites | F |
|---|---|---|
| 161092 | 29 | 22.1 | 42 | 0.34703 |
| 161139 | 34 | 22.1 | 42 | 0.59817 |
| 161164 | 30 | 22.1 | 42 | 0.39726 |
| 176849 | 35 | 22.1 | 42 | 0.64840 |
| 176863 | 28 | 22.1 | 42 | 0.29680 |
| 218504 | 30 | 22.1 | 42 | 0.39726 |

Interpretation: Given that inbreeding coefficients range from 0 to 1, the values which range from 0.29680 to 0.64840. These values appear excessively high for a wild population that is not isolated.