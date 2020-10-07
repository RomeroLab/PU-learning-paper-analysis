### parameter Coefficient of Variation ###
remove(list=ls())
library(pudms)
library(magrittr)
library(doParallel)

# load data
source("code/vfits/load_vfits.R")

# collect coefficients from 1...Kth fold at jth py1
coef_j <- function(j, vfit, nCores = 10, only.sig = T, alpha = 0.05){
  cl = makeCluster(nCores,type = 'FORK')
  res = foreach(i=1:length(vfit$v.dmsfit),.combine = "list",.multicombine = T)%dopar%{
    x=vfit$v.dmsfit[[i]][[j]];
    tibble::rownames_to_column(data.frame(coef(x$train_fit$fit)))
  }

  # check whether all varialbes are the same
  vars = sapply(res, `[[`, 1)
  check = sapply(2:10, function(i) all(vars[,i]==vars[,1]))
  if(!all(check)) stop("not all variables are the same")
  if(!all(vars[-1,1] == rownames(vfit$dmsfit$result_table))) stop("variables from k fold cv are different from variables from full fit")
  res = sapply(res,`[[`,2)[-1,]
  on.exit(stopCluster(cl))
  colnames(res) = paste("cv",1:length(vfit$v.dmsfit),sep="")
  rownames(res) = rownames(vfit$dmsfit$result_table)

  if(only.sig){
    res = res[vfit$dmsfit$result_table$p.adj<alpha,]
  }
  return(res)
}


# calculate CV from the estimated coefficients using each subsample
# export results
coef_cv = function(i,export=TRUE){
  vfit = eval(parse(text = vfits[i] ))
  protein=gsub(x = vfits[i],pattern = "vfit_",replacement = "")
  coef_table= data.frame(coef_j(py1idx(vfit),vfit))

  coef_table =
    coef_table %>% tibble::rownames_to_column(var = "mut") %>%
    dplyr::mutate(coef.mean = apply(coef_table,1,mean),
                  coef.sd = apply(coef_table,1,sd),
                  coef.CV = coef.sd/coef.mean)
  if(export) fwrite(x = coef_table,
                    file = paste("code/coefficient_of_variation/",protein,".csv",sep = ""))
  return(coef_table)
}

# Write Coefficient of Variations for each protein
list_coef_cv = vector("list",length(vfits))
for(i in 1:length(vfits)){
  print(i)
  list_coef_cv[[i]] = coef_cv(i)
}

# Gather cvs
cvs = sapply(1:length(vfits),FUN = function(i) list_coef_cv[[i]]$coef.CV)
list_proteins = sapply(1:length(vfits), function(i) gsub(x = vfits[i],pattern = "vfit_",replacement = ""))
names(cvs) = list_proteins

# plot
# absolute cv means
abscvmeans = sapply(1:length(list_proteins), function(i) mean(abs(cvs[[i]])))


ggplot(data = data.frame(cv=abs(cvs[[1]])), aes(x = cv))+
  geom_density(aes(color = list_proteins[1], fill=list_proteins[1]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[2]])), aes(x = cv, color =list_proteins[2], fill=list_proteins[2]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[3]])), aes(x = cv, color =list_proteins[3], fill=list_proteins[3]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[4]])), aes(x = cv, color =list_proteins[4], fill=list_proteins[4]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[5]])), aes(x = cv, color =list_proteins[5], fill=list_proteins[5]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[6]])), aes(x = cv, color =list_proteins[6], fill=list_proteins[6]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[7]])), aes(x = cv, color =list_proteins[7], fill=list_proteins[7]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[8]])), aes(x = cv, color =list_proteins[8], fill=list_proteins[8]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[9]])), aes(x = cv, color =list_proteins[9], fill=list_proteins[9]), alpha=0.25)+
  geom_density(data = data.frame(cv=abs(cvs[[10]])), aes(x = cv, color =list_proteins[10], fill=list_proteins[10]), alpha=0.25)+
  theme_classic(base_size=15)+
  scale_x_continuous(trans = "sqrt",breaks = c(0.01,0.1,0.2,0.35))+
  coord_cartesian(expand = 0)+
  xlab("Absolute Coefficient of Variations")+
  scale_color_manual(name = c("protein"),values =RColorBrewer::brewer.pal(10,"Spectral"))+
  scale_fill_manual (name = c("protein"),values =RColorBrewer::brewer.pal(10,"Spectral"))+
  annotate("text",x = .25, y=12, label = paste(paste(list_proteins[order(abscvmeans)], round(abscvmeans,3)[order(abscvmeans)], sep=": "),collapse = "\n"))


ggsave("code/coefficient_of_variation/cv_density.png",dpi=300)
ggsave("code/coefficient_of_variation/cv_density.eps",dpi=300)

