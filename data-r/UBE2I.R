UBE2I = pudms::create_protein_dat(path_l = "data/UBE2I/UBE2I_sel_sequences_filtered.txt.gz",
                                  path_u = "data/UBE2I/UBE2I_ref_sequences_filtered.txt.gz")

save(UBE2I,file="data-r/UBE2I.rda")
# usethis::use_data(UBE2I)
