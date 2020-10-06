library(data.table)
library(pudms)
HA = pudms::create_protein_dat(path_l = "../DMS_data/HA/HA_sel_sequences_filtered.txt.gz",
                               path_u = "../DMS_data/HA/HA_ref_sequences_filtered.txt.gz")



usethis::use_data(HA, overwrite = T)
