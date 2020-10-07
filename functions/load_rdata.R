#' import all Rdata files in the directory
#'
#'@import progress
#'@param dir the directory path
#'@param envir an environment for Rdata files to be loaded into
#'@param name load files which include "name" in filenames
#'@export
load_rdata<-function(dir,envir,name = NULL){

  res = list.files(path = dir, pattern = ".Rdata")
  if(!is.null(name)){res = res[grep(x = res,pattern = name)]}
  pb = progress::progress_bar$new(total= length(res))
  if(dir==".") dir=""
  for(i in 1:length(res)) {
    pb$tick()
    load(paste(dir, res[i], sep = ""),envir = envir)}
}
