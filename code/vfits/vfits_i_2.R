# vfits_i_2.R

# 1. collect all 'vfit_protein_index.Rdata' (from vfits_i_1.R)
# 2. obtain mean roc_curves at each py1
# 3. search for optimal py1
# 4. fit a model with a full dataset at py1.opt

remove(list=ls())
library(pudms)
args=(commandArgs(TRUE))
if(length(args)==0){
  print("No arguments supplied.")
  protein.name = 'DXS'
  refstate = 'A'

}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }

}

cat("protein =",protein.name,"\n")
refstate = NULL
if(protein.name == 'DXS') refstate= 'A'


### load protein data
load(paste0('data-r/',protein.name,".rda"))
assign(x = "protein_dat", value = eval(parse(text=protein.name)))

## load all vfit_protein_index
vfits_protein = load_rdata(dir = "code/vfits/",envir = environment())
vfits_protein_all = ls(pattern = paste0("vfit_",protein.name,"_"))
vfits_protein_idx = as.numeric(gsub(vfits_protein_all, pattern = paste0("vfit_",protein.name,"_"), replacement = ""))

# sort based on idx
vfits_protein_all = vfits_protein_all[order(vfits_protein_idx)]
vfits_protein_idx = vfits_protein_idx[order(vfits_protein_idx)]

## collect v.dmsfit
v.dmsfit= list()

for(i in 1:length(vfits_protein_all)){
  x = vfits_protein_all[i]
  vfit_i = eval(parse(text = x))
  ind = vfits_protein_idx[i]
  v.dmsfit[[paste0('fold',ind)]] =vfit_i$v.dmsfit[[paste0('fold',ind)]]
  # vfit_protein$v.dmsfit[[i]] = vfit_i$v.dmsfit[[1]]
}
# names(vfit_protein$v.dmsfit) = paste("fold",1:10,sep="")


### average roc_curves
roc_curves = list()
for (j in 1:length(vfit_i$py1)) {
  cat("py_idx at j:", j, "\n")
  roc_curves_at_j = lapply(1:length(v.dmsfit),
                           function(i)
                             v.dmsfit[[i]][[j]]$test_roc$roc_curve)
  roc_curves[[j]] = roc.average(roc_curves_at_j)
}
names(roc_curves) = paste("roc_",1:length(vfit_i$py1), sep="")

### search for optimal py1
py1.opt = optimal_py1(roc_curves = roc_curves,py1 = vfit_i$py1,verbose = TRUE,tol = 1e-5)

### fit full dataset
dmsfit = pudms(protein_dat = protein_dat,py1 = py1.opt, refstate = refstate)

vfit_protein = structure(list(v.dmsfit = v.dmsfit,
                              roc_curves = roc_curves,
                              dmsfit = dmsfit,
                              folds = vfit_i$folds,
                              py1 = vfit_i$py1,
                              py1.opt = py1.opt,
                              call = NULL),class = "vpudms.fit")
result.name = paste("vfit",protein.name,sep = "_")
assign(x =result.name, value = vfit_protein)
save(list = result.name,file = paste(result.name,".Rdata",sep = ""))



