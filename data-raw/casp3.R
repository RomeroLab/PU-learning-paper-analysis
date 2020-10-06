library(data.table)
library(pudms)

Casp3 = pudms::create_protein_dat(path_l = "../DMS_data/Casp3/C3_sel_sequences_filtered.txt.gz",
                                  path_u = "../DMS_data/Casp3/C3_ref_sequences_filtered.txt.gz")

usethis::use_data(Casp3,overwrite = T)
