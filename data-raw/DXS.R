library(data.table)
library(pudms)

DXS = pudms::create_protein_dat(path_l = "../DMS_data/DXS/DXS_sel_sequences_filtered.txt.gz",
                                path_u = "../DMS_data/DXS/DXS_ref_sequences_filtered.txt.gz")

usethis::use_data(DXS, overwrite = T)
