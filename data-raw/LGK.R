library(data.table)
library(pudms)

LGK = pudms::create_protein_dat(path_l = "../DMS_data/LGK/LGK_sel_sequences_filtered.txt.gz",
                                path_u = "../DMS_data/LGK/LGK_ref_sequences_filtered.txt.gz")

usethis::use_data(LGK,overwrite = T)
