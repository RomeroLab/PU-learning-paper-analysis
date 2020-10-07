remove(list=ls())
library(magrittr)
library(data.table)
GB1 = fread(input = "data-r/GB1_PU_dataset.txt") %>%
  setnames("V1","sequence") %>%
  setnames("V2","unlabeled") %>%
  setnames("V3","labeled")

GB1$seqId = 1:nrow(GB1)
save(GB1,file="data-r/GB1.rda")
# usethis::use_data(GB1, overwrite = TRUE)
