# creates enr_r_[protein].Rdata
# contains vfit_r_[protein] and venrfit_r_[protein]

library(pudms)
library(doParallel)
remove(list=ls())
load("data-r/py1values.rda")
source("functions/v.enr.R")

## setting
ntest = 10
seed = 19462020
maxit = 1000

##### code (same for all proteins) #####
## r, nCores and protein.name need to be provided as additional arguments at the time of submission
# parse server inputs
args=(commandArgs(TRUE))
if(length(args)==0){
  print("No arguments supplied.")
  r=1
  protein.name = 'DXS'
  nCores = 4
  cat("protein =",protein.name,"\n")

}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
  cat("r=",r,"\n")
  cat("nCores=",nCores,"\n")
  cat("protein =",protein.name,"\n")
}

refstate = NULL
if(protein.name == 'DXS') refstate= 'A'

# fitting

load(paste0('data-r/',protein.name,".rda"))
py1val = py1values[protein.name]
cat("Fitting at py1=",py1val,"\n")
assign(x = "protein_dat", value = eval(parse(text=protein.name)))

venrfit = v.enr(protein_dat = protein_dat,
                py1 = py1val,
                nfolds = ntest,
                refstate = refstate,
                test_idx = 1:ntest,
                seed = seed*r,
                nCores = nCores)

vfit= v.pudms(protein_dat = protein_dat,
              py1 = py1val,
              nfolds = ntest,
              refstate = refstate,
              test_idx = 1:ntest,
              seed = seed*r,
              maxit = maxit,
              nCores = nCores)

# all(vfit$folds$cv_labeled == venrfit$folds$cv_labeled)

# saving results
result.name  = paste("enr",r,protein.name, sep = "_")
result1.name = paste("vfit",r,protein.name,sep = "_")
result2.name = paste("venrfit",r,protein.name,sep = "_")
assign(x =result1.name, value = vfit)
assign(x =result2.name, value = venrfit)

save(list = c(result1.name,result2.name),file = paste('Rdata/',result.name,".Rdata",sep = ""))

