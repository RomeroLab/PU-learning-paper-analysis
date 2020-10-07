library(data.table)
library(pudms)

PyKS = pudms::create_protein_dat(path_l = "data/PyKS/PyKS_sel_sequences_filtered.txt.gz",
                                 path_u = "data/PyKS/PyKS_ref_sequences_filtered.txt.gz")
save(PyKS,file="data-r/PyKS.rda")
# usethis::use_data(PyKS, overwrite = T)
