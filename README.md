# VcfFile_filtering
VCF file filtering is a crucial step in order to get better inferences from your data.
VCF files of poor quality will most likely introduce bias in almost all the downstream
analysis you may like to do.

The RealMcCoil (RMCL) software is very sensitive to bias as it relies on a bayesian statistical
approach to infer the complexity of infection (COI), that means, the quality of your vcf files
(depthcoverage) will be used by RMCL to set its priors.
