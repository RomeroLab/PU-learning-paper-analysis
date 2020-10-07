library(data.table)
library(pudms)

DXS = pudms::create_protein_dat(path_l = "data/DXS/DXS_sel_sequences_filtered.txt",
                                path_u = "data/DXS/DXS_ref_sequences_filtered.txt")

# usethis::use_data(DXS, overwrite = T)
save(DXS,file="data-r/DXS.rda")