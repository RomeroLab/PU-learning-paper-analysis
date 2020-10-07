library(data.table)
library(pudms)

rocker = pudms::create_protein_dat(path_l = "data/rocker/rocker_sel_sequences_filtered.txt.gz",
                                   path_u = "data/rocker/rocker_ref_sequences_filtered.txt.gz")
save(rocker,file="data-r/rocker.rda")
# usethis::use_data(rocker,overwrite = T)
