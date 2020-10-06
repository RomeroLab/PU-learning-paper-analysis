library(data.table)
library(pudms)

PyKS = pudms::create_protein_dat(path_l = "../DMS_data/PyKS/PyKS_sel_sequences_filtered.txt.gz",
                                 path_u = "../DMS_data/PyKS/PyKS_ref_sequences_filtered.txt.gz")

usethis::use_data(PyKS, overwrite = T)
