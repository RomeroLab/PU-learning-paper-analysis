library(data.table)
library(pudms)

rocker = pudms::create_protein_dat(path_l = "../DMS_data/rocker/rocker_sel_sequences_filtered.txt.gz",
                                   path_u = "../DMS_data/rocker/rocker_ref_sequences_filtered.txt.gz")

usethis::use_data(rocker,overwrite = T)
