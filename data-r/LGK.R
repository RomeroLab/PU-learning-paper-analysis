library(data.table)
library(pudms)

LGK = pudms::create_protein_dat(path_l = "data/LGK/LGK_sel_sequences_filtered.txt.gz",
                                path_u = "data/LGK/LGK_ref_sequences_filtered.txt.gz")

save(LGK,file="data-r/LGK.rda")
# usethis::use_data(LGK,overwrite = T)
