### This R script will filter vcf by allele depth 'AD' based on some conditions
### and give back a list of loci that satisfy the condition.

# upload the necessary functions and packages for the analysis
deps <- c("tidyverse", "vcfR")
deps <- !sapply(deps, function(x){x %in% installed.packages()[,1]} )
if(any(deps)) {
  install.packages(names(deps)[deps])
}

# upload the source code to run RMCL
source("R/utils.R")
library(tidyverse)
library(vcfR)

# load the vcf file
full.vcf <- vcfR::read.vcfR("file.vcf.gz")
# extract allele depth 'AD' 
ad_full <- vcfR::extract.gt(full.vcf, element = "AD", as.numeric = T)
# create a dataframe object from the AD matrix where 0 is replaced by NA
library(naniar)
ad_full.NAs <- ad_full |> t() |> as.data.frame() |> 
  replace_with_na_all(condition = ~.x == 0)
### optionally, once you transform your AD matrix to a df, you can delete the
### matrix for the sake of memory.
rm(ad_full)
# create a dataframe with missing percentatge of each locus (columns)
ad_ALL.missings <- as.data.frame(colSums(is.na(ad_full.NAs)) / nrow(ad_full.NAs))
ad_ALL.missings <- `colnames<-`(ad_ALL.missings, 'missing_percentage')
# retrieve name of locus with missing <= 10%
ad_ALL.missings |>  filter(missing_percentage <= 0.10) |> 
  rownames() |> write.table(
    "/Users/ronky/Projects/WGS_SANRUHRP/locus_to_keep.txt",
    sep = "\t",row.names = FALSE
    )
