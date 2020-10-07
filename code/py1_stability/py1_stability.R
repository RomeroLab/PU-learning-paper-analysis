remove(list=ls())
library(ggplot2)
library(magrittr)
library(dplyr)
source("code/vfits/load_vfits.R")

#i: ith fold, j: jth py1 val
f.coef_trs = function(vfit){
  # return all fitted coefficients when py1idx == j
  coefs_at_j = function(j, vfit) {
    r= sapply(1:length(vfit$v.dmsfit), function(i)
      vfit$v.dmsfit[[i]][[j]]$train_fit$fit$coef)
    rownames(r) = rownames(vfit$dmsfit$fit$coef)

    r
  }
  coef_trs =sapply(1:length(vfit$py1), function(j) apply(coefs_at_j(j,vfit), 1, mean))
  colnames(coef_trs)= paste0("pi",round(vfit$py1,3))
  return(coef_trs) # p by nhyperparam
}

cors = function(vfit,refidx = NULL){
  coef_trs = f.coef_trs(vfit)
  if(is.null(refidx)) refidx = py1idx(vfit)
  foreach(i=1:ncol(coef_trs),.combine = "c")%do%{
    cor(coef_trs[-1,i],coef_trs[-1,refidx])}
}


cors_mat = foreach(i=1:length(vfits),.combine = "cbind")%do%{
  vfit = eval(parse(text=vfits[i]))
  cors(vfit)
}


cors_mat = data.frame(cors_mat)
colnames(cors_mat) = gsub(vfits,pattern = "vfit_",replacement = "")
cors_mat$py1 = vfit_DXS$py1
colnames(cors_mat)[which(colnames(cors_mat)=="Bgl3_LT")]= "Bgl3" # change name Bgl3_LT -> Bgl3
library(reshape2)
dat=reshape2::melt(cors_mat,id.vars = "py1")

dat = dat %>% rename(protein= variable, correlation = value)

load("code/roc/protein_order_by_auc_magnitude.Rdata") # order of protein for plotting
dat$protein = factor(dat$protein, levels = protein_order)

py1_stability = ggplot(dat,aes(py1,correlation))+
  geom_line(aes(color=protein))+
  theme_classic(base_size = 18)+
  xlab(expression(pi))+
  ylab("Pearson correlations between coefficients")+
  ylim(c(0.87,1))+
  scale_x_continuous(trans = "log",breaks = c(1e-3,1e-2,1e-1,1e-0),expand = c(0,0))+
  scale_color_brewer(palette = "Spectral")

py1_stability
ggsave(py1_stability,device = "eps",filename = "code/py1_stability/py1_stability.eps")
