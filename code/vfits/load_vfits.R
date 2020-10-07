### load all vfits and check convergence ###

# load libraries
library(puDMSanalysis)
library(foreach)

if(!exists("vfits")){
  # load data
  cat("loading data...\n")
  vfits = load_rdata(dir= "code/vfits/Rdata/", envir = environment())
  vfits = ls(pattern = "vfit_")
  # check convergence
  conv<-sapply(X=1:length(vfits), FUN = function(i){
    tmp=check.vfit.convergence(vfit = eval(parse(text = vfits[i])))
    all(tmp$conv ==0 & tmp$conv.full ==0)
  })

  print(conv)
  rm(conv)
}

# keep only vfits, vfit_proteins
remove(list=ls()[!ls()%in%c(ls(pattern = "vfit_"),"vfits")])

#scp hsong@lunchbox.stat.wisc.edu:/workspace/hsong/inference_protein_functions/puDMSanalysis/vfits/*.Rdata .
