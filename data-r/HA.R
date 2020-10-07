library(data.table)
library(pudms)
HA = pudms::create_protein_dat(path_l = "data/HA/HA_sel_sequences_filtered.txt.gz",
                               path_u = "data/HA/HA_ref_sequences_filtered.txt.gz")


save(HA,file="data-r/HA.rda")
# usethis::use_data(HA, overwrite = T)
