SUMO1 = pudms::create_protein_dat(path_l = "data/SUMO1/SUMO1_sel_sequences_filtered.txt.gz",
                                  path_u = "data/SUMO1/SUMO1_ref_sequences_filtered.txt.gz")
# usethis::use_data(SUMO1,overwrite = T)
save(SUMO1,file="data-r/SUMO1.rda")
