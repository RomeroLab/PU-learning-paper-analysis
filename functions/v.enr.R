#' test an enrichment-score based fit on a test data set
#'
#'@import parallel
#'@import PUlasso
#'@import pbapply
#'@import pudms
#'@param protein_dat input data. A data table containing (sequence, labeled, unlabeled, seqId)
#'@param py1 a numeric value, the prevalence of positives in the unlabeled data
#'@param nfolds the number of subsamples. (nfolds -1)/nfolds splits will be used for training, and the rest will be used for testing.
#'@param test_idx a vector of indices of cross-validation models which will be fitted. Default is to fit the model for each of the cross-validation fold.
#'@param seed a seed number for reproducibility
#'@param order an integer; 1= main effects, 2= main effects + pairwise effects
#'@param refstate a character which will be used for the common reference state; the default is to use the most frequent amino acid as the reference state for each of the position.
#'@param verbose a logical value. The default is TRUE
#'@param nobs_thresh the number of minimum required mutations per position
#'@param nCores the number of threads for computing
#'@export
v.enr = function(protein_dat,
                 py1,
                 nfolds = 5,
                 test_idx =1:nfolds,
                 seed = round(runif(1, min = 1, max = 1000)),
                 order = 1,
                 refstate =NULL,
                 verbose = T,
                 nobs_thresh=10,
                 nCores =1) {

  # if nCores>1, set up a parallel environment
  if(nCores>1){
    if(verbose) cat("creating a parallel environment...\n")
    isParallel = TRUE
    nCores = min(nCores,detectCores())
    clustertype = ifelse(.Platform$OS.type=="windows", 'PSOCK', 'FORK')
    cl <- makeCluster(nCores,type = clustertype)

    # export libPaths to the cluster
    invisible(clusterCall(cl, function(x) .libPaths(x), .libPaths()))
    # export libraries to the cluster
    invisible(clusterEvalQ(cl, c(library(puDMSanalysis),library(pudms),library(pbapply),library(data.table),library(PUlasso))))

  }else{
    cl = NULL
    isParallel = FALSE
  }
  if(verbose){pboptions(type="txt")}

  # train/test data split
  cvfolds = cv_grouped_dat(grouped_dat = protein_dat,test_idx = 1,nfolds = nfolds,seed = seed,return.datasets = F)
  # create training/test datasets for test_idx
  cv.datasets = lapply(X = 1:length(test_idx),FUN = function(i) {cv_grouped_dat(grouped_dat = protein_dat,test_idx = i,folds = cvfolds$folds)})

  gc()

  # ----------------------------------------------------------------------------------------------------
  # for each py1, we fit the model based on the enrichment score and obtain the modified roc curve

  # i: a running index for 1,,,test_idx
  # j: a running index for hyperparam 1,..., nhyperparam

  v.enrfit = list() # list of length length(text_idx); each list contains length(py1) lists
  v1.varlist = list(cv.datasets=  cv.datasets,
                    py1 = py1,
                    order = order,
                    refstate = refstate,
                    verbose= FALSE,
                    nobs_thresh=nobs_thresh)

  v.1round = function(x,i,varlist){

    Xprotein = create_model_frame(grouped_dat = cv.datasets[[i]]$train_grouped_dat,
                                  order = order,
                                  aggregate = T,
                                  refstate = refstate,
                                  verbose = verbose)

    # remove sequences which contain a feature whose number of mutations < nobs_thresh
    filtered_Xprotein = filter_mut_less_than_thresh(Xprotein = Xprotein,
                                                    order = order,
                                                    nobs_thresh = nobs_thresh,
                                                    checkResFullRank = T,
                                                    verbose = verbose)

    logEnr_fold = with(filtered_Xprotein,
                       log_enrichment_score(X = X,z = z,wei = wei,group = blockidx))

    coef_enr= with(logEnr_fold, c(sum(unique(logEnr_WT)),logEnr_v-logEnr_WT))
    rownames.enr = names(coef_enr)
    coef_enr = matrix(coef_enr,ncol = 1); rownames(coef_enr) = rownames.enr

    refstate_ = filtered_Xprotein$refstate

    roc = with(varlist,
               adjusted_roc_curve(coef = coef_enr,
                                  test_grouped_dat = cv.datasets[[i]]$test_grouped_dat,
                                  order = order,
                                  refstate = refstate_,
                                  verbose = FALSE,
                                  py1 = py1[x],
                                  plot = F))

    list(train_fit=coef_enr,test_roc = roc,py1 = py1[x])
  }

  for(i in 1:length(test_idx)){
    if(verbose) cat("fitting with a fold",i,"...\n")
    v.enrfit[[i]] = pblapply(X = 1:length(py1), i=i, varlist = v1.varlist,cl = cl, FUN =v.1round)
  }

  # assign names to v.enrfit
  names(v.enrfit) = paste("fold",1:length(test_idx),sep = "")
  for (x in 1:length(test_idx)){names(v.enrfit[[x]]) = paste("py1_",1:length(py1), sep = "")}

  # if length(test_idx)>1, for each hyperparameter py1, we obtain an averaged ROC curve

  if(length(test_idx)>1){
    if(verbose) {cat("obtaining an average ROC curve for each py1...\n")}
    if(isParallel) clusterExport(cl,varlist = c("v.enrfit"),envir = environment())
    roc_curves = pblapply(1:length(py1),
                          FUN = function(j){
                            roc_curves = lapply(1:length(test_idx), function(i) v.enrfit[[i]][[j]]$test_roc$roc_curve)
                            m_roc_curve = roc.average(roc_curves)
                            m_roc_curve
                          },cl = cl)
  }else{
    roc_curves = lapply(1:length(py1), FUN = function(j) v.enrfit[[1]][[j]]$test_roc$roc_curve)
  }
  names(roc_curves) = paste("roc_",1:length(py1), sep="")

  if(isParallel) on.exit(stopCluster(cl))

  structure(list(v.enrfit = v.enrfit,
                 roc_curves = roc_curves,
                 folds = cvfolds$folds,
                 py1 = py1,
                 call = match.call()),class = "venr.fit")

}

