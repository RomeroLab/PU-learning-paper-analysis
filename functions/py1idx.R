#' obtain an index for the selected py1
#'
#'@param vfit vpudms.fit object
#'@export
py1idx <- function(vfit){which(with(vfit, py1 == py1.opt))}
