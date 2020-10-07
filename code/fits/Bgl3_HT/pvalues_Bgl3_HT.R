remove(list=ls())
load("code/fits/fit_Bgl3_HT_1.Rdata")
load("code/fits/fit_Bgl3_HT_2.Rdata")

load("data-r/Bgl3_HT_2.rda")
load("data-r/Bgl3_HT_1.rda")
load("data-r/py1values.rda")
source("code/fits/Bgl3_HT/fn_fit_aggregate.R")

rep_all = list(Bgl3_HT_1,Bgl3_HT_2)
fits_all = list(fit_Bgl3_HT_1, fit_Bgl3_HT_2)
fit_all<- lapply(1:2, fit_repi, rep_all = rep_all, fits_all = fits_all,py1_rep = 0.2)

# collect coefficients and inv matrices
coef_all <- lapply(1:2, function(i) fit_all[[i]]$coef)
invI_all <- lapply(1:2, function(i) fit_all[[i]]$invI)

# aggreate results from reps
pvalues = aggregate_reps(coef_all = coef_all,invI_all = invI_all,finiteSampleAdj = TRUE)

library(dplyr)
top_K = function(pvalues, K=10){
  dat = with(pvalues, data.frame(zvalue = zvalue, pvalue = pvalue))
  dat[dat$zvalue<0,"pvalue"] = 1
  dat = dat %>% tibble::rownames_to_column() %>% arrange(pvalue)
  dat_K = dat[1:K,]
  dat_K$ranking = 1:K

  pos<-gsub(sapply(1:K, function(i)strsplit(dat_K$rowname,split = "\\.")[[i]][1]),
            pattern = "[^0-9]",
            replacement = "")

  dat_K[order(as.numeric(pos)),]
}
pvalue_Bgl3_HT = pvalues
print(top_K(pvalues = pvalue_Bgl3_HT,K = 10))

write.csv(top_K(pvalues = pvalue_Bgl3_HT,K = 10), file = "code/fits/Bgl3_HT/top_10_muts.csv")
save(list = c("pvalue_Bgl3_HT"),file = "code/fits/Bgl3_HT/pvalues_Bgl3_HT.Rdata")

