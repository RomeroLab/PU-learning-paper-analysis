#' obtain log enrichment scores
#'
#'@import Matrix
#'@param X design matrix
#'@param z response
#'@param group group (protein position)
#'@param wei observation weights
#'@export
log_enrichment_score <- function(X,z,group,wei = rep(1,nrow(X))){

  p = ncol(X)
  nl=  sum(wei[z==1])
  N = sum(wei)
  nu = N - nl
  P_variants = Matrix::colSums(Matrix::Diagonal(x=wei[z==1])%*%(X[z==1,]==1)) # P_variants
  U_variants = Matrix::colSums(Matrix::Diagonal(x=wei[z==0])%*%(X[z==0,]==1)) # U_variants

  idx = unique(c(which(P_variants==0),which(U_variants==0)))

  enr_variants = log((P_variants/nl)/(U_variants/nu))

  if(length(idx)>0){
    cat("P_variants == 0 or U_variants == 0 \n")
    enr_variants[idx] = 0}

  d = length(unique(group))
  group_size = table(group)
  groupname = unique(group)

  i=1;
  enr_WT = foreach(i=1:d, .combine = "c")%do%{
    M = group_size[i]
    P_WT = (nl - sum(P_variants[group==groupname[i]]))/nl
    U_WT = (nu - sum(U_variants[group==groupname[i]]))/nu
    log(rep(P_WT,M)/rep(U_WT,M))
  }

  return(list(logEnr_v = enr_variants, logEnr_WT = enr_WT))
}
