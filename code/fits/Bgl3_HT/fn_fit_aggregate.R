## function to aggregate results from reps
fit_repi <- function(i, rep_all, py1_rep, fits_all = NULL){
  
  # create a design matrix for rep i
  Xprotein_i = create_model_frame(grouped_dat = rep_all[[i]])
  filtered_Xprotein_i = filter_mut_less_than_thresh(Xprotein = Xprotein_i,
                                                    nobs_thresh = 10)
  # fit for rep i
  if(is.null(fits_all)){
    fit_i = pudms(protein_dat = rep_all[[i]],py1 = py1_rep,pvalue = FALSE)}
  else{
    fit_i = fits_all[[i]]
  }
  
  # calculate fisher information for rep i
  pvalue_i <-
    pval_pu(
      X = filtered_Xprotein_i$X,
      z = filtered_Xprotein_i$z,
      theta = as.numeric(fit_i$fit$coef),
      py1 = py1_rep,
      weights = filtered_Xprotein_i$wei,
      effective_n_prop = 1
    )
  list(Xprotein = Xprotein_i,
       coef = fit_i$fit$coef[,1],
       invI = pvalue_i$invI)
}


aggregate_reps <- function(coef_all, invI_all, finiteSampleAdj = TRUE){
  
  if(length(coef_all) != length(invI_all)) stop("invalid input")
  nreps = length(coef_all)
  stopifnot(all(sapply(1:nreps,function(i) is.null(dim(coef_all[[i]])))))
  
  # obtain mutations that exist in all reps
  muts <- lapply(coef_all,names)
  mutual_muts <- muts[[1]]
  for(i in 2:nreps){
    mutual_muts <- intersect(mutual_muts, muts[[i]])
  }
  
  m_coef_all = vector("list",nreps)
  m_invI_all = vector("list",nreps)
  
  for(i in 1:nreps){
    fidx_i = which(muts[[i]] %in% mutual_muts)
    m_coef_all[[i]] = coef_all[[i]][fidx_i]
    m_invI_all[[i]] = invI_all[[i]][fidx_i,fidx_i]
  }
  
  names(m_coef_all) = paste("rep",1:nreps,sep = "")
  m_coef_all = data.frame(m_coef_all)
  
  # average over nreps coefficients
  coef_p = apply(m_coef_all,1,mean)
  # average invI matrix (variation within reps)
  W = Reduce("+", m_invI_all)/nreps
  # variation between reps
  B = vector("list",nreps)
  for(i in 1:nreps){
    B[[i]] = (m_coef_all[[i]]- coef_p)%*%t(m_coef_all[[i]]- coef_p)
  }
  B = Reduce("+",B)/(nreps-1)
  
  
  if(finiteSampleAdj){
    invI_p=W+(1+1/nreps)*B
  }else{
    invI_p=W+B
  }
  
  se = sqrt(diag(invI_p))
  zvalue = coef_p/se
  pvalue = pnorm(abs(zvalue),lower.tail = F)*2
  
  return(invisible(list(coef = coef_p, invI = invI_p, se = se, zvalue = zvalue, pvalue = pvalue)))
  
}


return_table_for_aggregated_dat <- function(pvalues,blockidx,p.adjust.method="BH"){
  
  # individual effects
  
  dat.i = data.frame(coef= as.numeric(pvalues$coef),
                     se = pvalues$se,
                     zvalue = pvalues$zvalue,
                     p = pvalues$pvalue,
                     p.adj = p.adjust(pvalues$pvalue, method = p.adjust.method))
  
  block  = c(-1, blockidx) # to include intercept
  
  i=1;
  dat.g = foreach(i=1:length(unique(block)),
                  .combine = "rbind",
                  .packages = c("Matrix"))%dopar%{
                    
                    ridx = which(block == unique(block)[i]) # indices coef to each block
                    coef_sub = matrix(pvalues$coef[ridx],ncol = 1)
                    invI_sub = chol2inv(chol(pvalues$invI[ridx,ridx,drop=F]))
                    chi2value = as.numeric(t(coef_sub)%*%invI_sub%*%coef_sub)
                    
                    p.grp = pchisq(q = chi2value,df = length(ridx),lower.tail = F)
                    # nobs.grp = sum(nobs[ridx])
                    c(chi2value,p.grp)
                  }
  dat.g= data.frame(dat.g)
  colnames(dat.g) = c("chi2value","p.grp")
  rownames(dat.g) = unique(block)
  
  p.grp.adj = p.adjust(p = dat.g[,"p.grp"],method = p.adjust.method)
  
  dat_grp = data.frame(dat.g[,-3], p.grp.adj)
  
  # obtain group size
  block = as.factor(block)
  block = factor(block, levels = rownames(dat_grp))
  ntimes = table(block)
  
  dat_grp = data.frame(lapply(dat_grp, rep, ntimes))
  sep = rep("*",nrow(dat.i))
  dat = data.frame(dat.i,sep,group=block,dat_grp)
  rownames(dat) = names(pvalues$coef)
  
  
  return(dat)
}
