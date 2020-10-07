remove(list=ls())
library('R.utils')
library(data.table)
library(magrittr)
# Since we have to concatenate labeled sequences, we make a function that takes sequences as inputs
create_protein_dat_from_seq = function(seq_l,seq_u){

  # seq_l = fread(file = path_l,header = F)
  # seq_u = fread(file = path_u,header = F)
  #
  # create an aggregated data with (sequence, number of sequence) for labeled and unlabeld
  g_l = seq_l[,.N,by=names(seq_l)] %>% setnames("V1","sequence") %>% setnames("N","labeled")
  g_u = seq_u[,.N,by=names(seq_u)] %>% setnames("V1","sequence") %>% setnames("N","unlabeled")
  # merge two aggregated datasets
  g_lu = merge(g_l,g_u,by="sequence",all = T)
  g_lu[is.na(g_lu$labeled),"labeled"] = 0
  g_lu[is.na(g_lu$unlabeled),"unlabeled"] =0
  # check an error
  if(!sum(g_lu[,"labeled"])==length(seq_l$V1)){stop("error")}
  if(!sum(g_lu[,"unlabeled"])==length(seq_u$V1)){stop("error")}
  # assign a sequence ID: 1,...,number of unique sequences
  g_lu$seqId = 1:nrow(g_lu)
  g_lu
}


gen_seq_l = function(l_file_list){
  seq_ls = vector("list",length(l_file_list))
  for(i in 1:length(l_file_list)){
    seq_ls[[i]] = fread(l_file_list[[i]],header=F)
  }
  seq_l = rbindlist(seq_ls)

  return(seq_l)
}

# Library1
l1_file_list = vector("list",3)
l1_file_list[[1]]  = "data/Bgl3/Bgl3_Lib1_sel1_sequences_filtered.txt.gz"
l1_file_list[[2]]  = "data/Bgl3/Bgl3_Lib1_sel2_sequences_filtered.txt.gz"
l1_file_list[[3]]  = "data/Bgl3/Bgl3_Lib1_sel3_sequences_filtered.txt.gz"

l1_seq_l = gen_seq_l(l1_file_list)
l1_seq_u = fread("data/Bgl3/Bgl3_Lib1_ref_sequences_filtered.txt.gz",header=F)

Bgl3_LT = create_protein_dat_from_seq(seq_l = l1_seq_l,seq_u = l1_seq_u)

# Library2
l2_file_list = vector("list",2)
l2_file_list[[1]]  = "data/Bgl3/Bgl3_Lib2_sel1_sequences_filtered.txt.gz"
l2_file_list[[2]]  = "data/Bgl3/Bgl3_Lib2_sel2_sequences_filtered.txt.gz"

l2_seq_l = gen_seq_l(l2_file_list)
l2_seq_u = fread("data/Bgl3/Bgl3_Lib2_ref_sequences_filtered.txt.gz", header=F)
Bgl3_HT_1 = create_protein_dat_from_seq(seq_l = l2_seq_l, seq_u = l2_seq_u)

# Library3
l3_file_list = vector("list",3)
l3_file_list[[1]]  = "data/Bgl3/Bgl3_Lib3_sel1_sequences_filtered.txt.gz"
l3_file_list[[2]]  = "data/Bgl3/Bgl3_Lib3_sel2_sequences_filtered.txt.gz"
l3_file_list[[3]]  = "data/Bgl3/Bgl3_Lib3_sel3_sequences_filtered.txt.gz"

l3_seq_l = gen_seq_l(l3_file_list)
l3_seq_u = fread("data/Bgl3/Bgl3_Lib3_ref_sequences_filtered.txt.gz", header=F)
Bgl3_HT_2 = create_protein_dat_from_seq(seq_l = l3_seq_l, seq_u = l3_seq_u)

save(Bgl3_LT,file="data-r/Bgl3_LT.rda")
save(Bgl3_HT_1,file="data-r/Bgl3_HT_1.rda")
save(Bgl3_HT_2,file="data-r/Bgl3_HT_2.rda")

# usethis::use_data(Bgl3_LT, overwrite = TRUE)
# usethis::use_data(Bgl3_HT_1, overwrite = TRUE)
# usethis::use_data(Bgl3_HT_2, overwrite = TRUE)
