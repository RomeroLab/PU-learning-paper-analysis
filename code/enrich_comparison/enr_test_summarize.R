remove(list=ls())
source('functions/load_rdata.R')
enr_test<- function(protein,dir="code/enrich_comparison/Rdata/" ){
  cat("protein",protein,"\n")
  load_rdata(dir = dir,envir = environment(),name = protein)

  venrfits = intersect(ls(pattern = "venrfit_"),ls(pattern=protein))
  vfits = intersect(ls(pattern = "vfit_"),ls(pattern=protein))

  if(length(venrfits)!=10) {
    idx= sapply(1:length(venrfits), function(i) strsplit(venrfits,"_")[[i]][2])
    missingidx= (1:10)[!1:10%in%as.numeric(idx)]
    cat("missing idx:", missingidx,"\n")
    warning("not all model fits are collected")
    }
  enr.aucs = foreach(i=1:length(venrfits),.combine = "c")%do%{
    venrfit = eval(parse(text=venrfits[i]))
    venrfit_auc = sapply(1:length(venrfit$v.enrfit),
                         function(i) venrfit$v.enrfit[[i]][[1]]$test_roc$roc_curve$auc)

  }

  vpudms.aucs <- foreach(i=1:length(venrfits),.combine = "c")%do%{
    vfit = eval(parse(text=vfits[i]))
    vfit_auc = sapply(1:length(vfit$v.dmsfit),
                      function(i) vfit$v.dmsfit[[i]][[1]]$test_roc$roc_curve$auc)
  }


  data.frame(protein = protein, vpudms.aucs =vpudms.aucs , enr.aucs=enr.aucs)
}


### This generates res_comp.Rdata ###
res_comp <-rbind(
  enr_test('LGK'),
  enr_test('PyKS'),
  enr_test('DXS'),
  enr_test('rocker'),
  enr_test('SUMO1'),
  enr_test('HA'),
  enr_test('UBE2I'),
  enr_test('TPK1'),
  enr_test('Bgl3'),
  enr_test('GB1')
)
save(res_comp,file = "code/enrich_comparison/res_comp.Rdata")
### 

### Load saved res_comp.Rdata file ###
load(file = "code/enrich_comparison/res_comp.Rdata")
load(file = "code/roc/protein_order_by_auc_magnitude.Rdata")

library(reshape2)
dt = melt(res_comp)
levels(dt$variable) = c("pu","enr")

library(magrittr)
library(dplyr)
library(ggplot2)

# bar-diff plot
dt3<-
  data.frame(
    protein = res_comp$protein,
    diff = with(res_comp, vpudms.aucs - enr.aucs))

dt4<- dt3 %>%
  droplevels() %>%
  group_by(protein) %>% summarise(len=mean(diff),sd = sd(diff))
dt4$protein = factor(dt4$protein, levels= protein_order)
# levels(dt4$protein) = protein_order

pl2=ggplot(dt4,aes(protein,len,fill=protein))+
  geom_col(width = .85)+
  theme_classic(base_size = 18)+
  geom_errorbar(aes(ymin=len-sd, ymax=len+sd), width=.3,
                position=position_dodge(.9)) +
  ylab("adjusted AUC(PU) - AUC(enr)")+
  xlab("")+
  theme(legend.position ="none")
pl2

ggsave("code/enrich_comparison/comp_enr_diff.eps",dpi=300,width = 10,height = 8)
dev.off()


## Table (t,p,mean_diff)

protein = as.character(unique(dt3$protein))
res=function(i){
  dat = res_comp[res_comp$protein==protein[i],];
  d = dat[,"vpudms.aucs"]-dat[,"enr.aucs"]
  dbar = mean(d)
  dsd  = sd(d)
  dse = sqrt(1/length(d)+1/9)*sd(d)
  t = dbar/dse
  p = pt(q = t,df = length(d)-1, lower.tail = F)*2
  c(t,p,dbar)
  # tt=t.test(dat[,"vpudms.aucs"]-dat[,"enr.aucs"]);
  # c(tt$statistic,tt$p.value,tt$estimate)
  }

test_Res = sapply(1:length(protein),res)
colnames(test_Res) = protein
rownames(test_Res) = c("t","p","mean_diff")

write.csv(x = test_Res,file = "code/enrich_comparison/PU_enr_pvalue_diff.csv")
print(round(test_Res,8))
test_Res[2,]
