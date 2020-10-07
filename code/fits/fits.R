library(pudms)

remove(list=ls())

# setting
maxit = 1000

## protein.names need to be provided as additional arguments at the time of submission

##### code (same for all proteins) #####

# parse server inputs
args=(commandArgs(TRUE))
if(length(args)==0){
  print("No arguments supplied.")
  protein.name = 'rocker'
  cat("protein =",protein.name,"\n")

}else{
  for(i in 1:length(args)){
    eval(parse(text=args[[i]]))
  }
  cat("protein =",protein.name,"\n")
}

# fitting
load(paste0('data-r/',protein.name,".rda"))
load(file = 'data-r/py1values.rda')
py1val = py1values[protein.name]
cat("Fitting at py1=",py1val,"\n")
assign(x = "protein_dat", value = eval(parse(text=protein.name)))

fit = pudms(protein_dat = protein_dat,py1 = py1val,maxit = maxit)

# saving results
result.name = paste("fit",protein.name,sep = "_")
assign(x =result.name, value = fit)
save(list = result.name,file = paste(result.name,".Rdata",sep = ""))

