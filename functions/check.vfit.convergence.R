#' check convergence of all training fits in a vpudms.fit object
#' 
#' @param vfit vpudms.fit object
#' @import foreach
#' @importFrom stats runif
#' @export
check.vfit.convergence<-function(vfit){
  i=1; j=1;
  conv<-
    foreach(i=1:length(vfit$v.dmsfit),.combine = "cbind")%:%
    foreach(j=1:length(vfit$v.dmsfit[[1]]),.combine = "c")%do%{
      vfit$v.dmsfit[[i]][[j]]$train_fit$fit$optResult$convergence
    }

  conv2<- vfit$dmsfit$fit$optResult$convergence
  #print(all(conv==0)& conv2==0)
  invisible(list(conv=conv, conv.full=conv2))
}

