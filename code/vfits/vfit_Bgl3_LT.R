library(pudms)
remove(list=ls())

# setting
seed = 23002020
maxit = 1000
nfolds = 10

## nCores and protein.name need to be provided as additional arguments at the time of submission

##### code (same for all proteins) #####

# parse server inputs
args=(commandArgs(TRUE))
if(length(args)==0){
  print("No arguments supplied.")
  protein.name = 'rocker'
  nCores = 4
  cat("protein =",protein.name,"\n")

}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
  cat("protein =",protein.name,"\n")
}

# fitting
load(paste0('data-r/',protein.name,".rda"))
assign(x = "protein_dat", value = eval(parse(text=protein.name)))
vfit = v.pudms(protein_dat = protein_dat,
               py1 = 0.35,
               nfolds = nfolds,
               nCores = nCores,
               pvalue = TRUE,
               full.fit = TRUE,
               full.fit.pvalue = TRUE,
               seed = seed,
               nhyperparam = 1)
vfit$py1.opt = 0.35

# saving results
result.name = paste("vfit",protein.name,sep = "_")
assign(x =result.name, value = vfit)
save(list = result.name,file = paste(result.name,".Rdata",sep = ""))


######
# after obtaining vfit_Bgl3_LT.Rdata and fit_Bgl3_LT.Rdata
load("code/vfits/vfit_Bgl3_LT.Rdata")
load("code/fits/fit_Bgl3_LT.Rdata")

vfit_Bgl3_LT$dmsfit = fit_Bgl3_LT
save(vfit_Bgl3_LT,file =  "code/vfits/vfit_Bgl3_LT.Rdata")
