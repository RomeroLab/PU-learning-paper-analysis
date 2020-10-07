### obtain average feature selection stability based on p-values ###
remove(list=ls())
library(pbapply)
library(magrittr)

# load data
source("code/vfits/load_vfits.R")

# SSk = average % of common features where selection size = k
# return % of common features where selection size = k for k = 1,..,nfeat
coef_stability = function(vfit){
  nmax.BH = sum(vfit$dmsfit$result_table$p.adj<0.05)
  nfeat = nrow(vfit$dmsfit$result_table)
  result_tables = lapply(1:length(vfit$v.dmsfit), function(i){
    result_table_i = vfit$v.dmsfit[[i]][[py1idx(vfit)]]$train_fit$result_table
    result_table_i =
      result_table_i %>% tibble::rownames_to_column("muts") %>% dplyr::arrange(desc(abs(zvalue)))
    result_table_i
  })

  # for k =1,...,ncoef
  pb=progress::progress_bar$new(total= nfeat* choose(length(vfit$v.dmsfit),2))
  SS = foreach(k=1:nfeat,.combine = "cbind")%:%
    foreach(i=1:(length(vfit$v.dmsfit)-1),.combine = "c")%:%
    foreach(j=(i+1):length(vfit$v.dmsfit),.combine = "c")%do%{
      pb$tick()
      SSk = length(intersect(result_tables[[i]][1:k,"muts"], result_tables[[j]][1:k,"muts"]))/k
    }
  colnames(SS) = 1:nfeat
  return(list(SS=SS, nmax.BH = nmax.BH))
}

### This part generates featsel_stability.Rdata ###
# obtain stability for each protein
cat("obtaining stability metrics for each protein...")
sdats<-
  pblapply(X = 1:length(vfits), function(i){
    vfit = eval(parse(text=vfits[i]));
    sdat = coef_stability(vfit)
  })
save(sdats, file = "code/coefficient_selection_stability/featsel_stability.Rdata")
###

load("code/coefficient_selection_stability/featsel_stability.Rdata")
## average feature selection stability
v = data.frame(v.mean= sapply(sdats, function(sdat) mean(with(sdat,SS[,1:nmax.BH]))),
           v.sd = sapply(sdats, function(sdat) sd(with(sdat,SS[,1:nmax.BH]))))
rownames(v) = gsub(vfits,pattern = "vfit_",replacement = "")

dat = v %>% tibble::rownames_to_column("protein") 
dat$protein[1] = "Bgl3"

load("code/roc/protein_order_by_auc_magnitude.Rdata") # order of protein for plotting
dat$protein = factor(dat$protein, levels = protein_order)
(plot_avg_SS =
ggplot(dat,aes(protein,v.mean,color=protein))+
  geom_errorbar(aes(ymin = v.mean-v.sd, ymax = pmin(v.mean+v.sd,1)))+
  geom_point(size=2)+
  theme_classic(base_size = 15)+
  scale_y_continuous(breaks = c(0.85,0.9,0.95,1),limits = c(0.85,1.01))+
  ylab(expression(Average~feature~selection~stability~(bar(SS))))+
  scale_color_brewer(palette = "Spectral"))

ggsave(plot_avg_SS,filename = "code/coefficient_selection_stability/avg_featsel_stability.eps",dpi = 300)
cat("average feature selection stability\n")
print(dat)


