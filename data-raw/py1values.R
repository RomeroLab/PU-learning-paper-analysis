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
py1values[c("Bgl3_LT","Bgl3_HT_1","Bgl3_HT_2")] = c(0.35,0.2,0.2)
usethis::use_data(py1values,overwrite = T)
