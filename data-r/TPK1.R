TPK1 = pudms::create_protein_dat(path_l = "data/TPK1/TPK1_sel_sequences_filtered.txt.gz",
                                 path_u = "data/TPK1/TPK1_ref_sequences_filtered.txt.gz")

# usethis::use_data(TPK1)
save(TPK1,file="data-r/TPK1.rda")
