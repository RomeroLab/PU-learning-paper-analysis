remove(list=ls())
library(ggplot2)
library(magrittr)
library(dplyr)
source("code/vfits/load_vfits.R")

r = t(sapply(1:length(vfits), function(i){
  c(vfits[i],auc(vfit = eval(parse(text=vfits[i]))))
}))
r = data.frame(r)
colnames(r) = c("protein","auc")
r$protein = gsub(r$protein,pattern = "vfit_",replacement = "")
r$protein[r$protein=="Bgl3_LT"] = "Bgl3"


protein_order = r[order(r$auc,decreasing = T),"protein"]
save(protein_order,file = "code/roc/protein_order_by_auc_magnitude.Rdata")

write.csv(r[order(r$auc,decreasing = T),], file = "code/roc/aucs.csv")
