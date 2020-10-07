## code to prepare `py1values` dataset goes here
remove(list=ls())
source("code/vfits/load_vfits.R")

py1values<-
  sapply(X =1:length(vfits), FUN = function(i){
    vfit = eval(parse(text=vfits[i]))
    protein = gsub(vfits[i],pattern = "vfit_",replacement = "")
    py1val = vfit$py1.opt
    names(py1val) = protein
    return(py1val)
  } )

save(py1values,file="data-r/py1values.rda")
