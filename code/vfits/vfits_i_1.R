# Fitting each fold in parallel
library(pudms)
library(puDMSanalysis)
remove(list=ls())

# setting
seed = 23002020
maxit = 1000
nfolds = 10

## index, nCores and protein.name need to be provided as additional arguments at the time of submission to the server

##### code (same for all proteins) #####

# parse server inputs
args=(commandArgs(TRUE))
if(length(args)==0){
  print("No arguments supplied.")
  protein.name = 'DXS'
  nCores = 4
  index = 5
  cat("protein =",protein.name,"\n")
  cat("index=", index,"\n")

}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
  cat("protein =",protein.name,"\n")
  cat("index=", index,"\n")
}
refstate = NULL
if(protein.name == 'DXS') refstate= 'A'

# fitting
load(paste0('data-r/',protein.name,".rda"))
assign(x = "protein_dat", value = eval(parse(text=protein.name)))
vfit = v.pudms(protein_dat = protein_dat,
               nfolds = nfolds,
               test_idx = index,
               refstate = refstate,
               nCores = nCores,
               pvalue = TRUE,
               full.fit = FALSE,
               full.fit.pvalue = FALSE,
               seed = seed,
               nhyperparam = 20)

# saving results
result.name = paste("vfit",protein.name,index,sep = "_")
assign(x =result.name, value = vfit)
save(list = result.name,file = paste('code/vfits/',result.name,".Rdata",sep = ""))

