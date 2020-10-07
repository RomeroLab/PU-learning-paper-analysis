### save ROC curves ###
source("code/vfits/load_vfits.R")
library(pbapply)
library(pudms)

pb = progress::progress_bar$new(total=length(vfits))
for(i in 1:length(vfits)){
  pb$tick()
  protein=gsub(x = vfits[i],pattern = "vfit_",replacement = "")
  outroc = paste("code/roc/",protein,".eps",sep = "")
  vfit = eval(parse(text=vfits[i]))
  rocplot = with(vfit,
                 rocplot(roc_curve = roc_curves[[which(py1 == py1.opt)]], py1 = py1.opt))
  ggsave(filename = outroc, plot = rocplot,dpi = 300)

}





