##
## Begin shankarz code 
##

## The original consturct is not shankarz's 
## Shankarz only made incremental changes

.onAttach <- function(libname, pkgname) {
  # For debugging purpose
  # packageStartupMessage("shankarz.TexST package from Natarajan Shankar attached")
}

# .onLoad borrowed as-is from documentation
# This routine is NOT code written by shankarz
.onLoad <- function(libname, pkgname) {
  
    op <- options()
    op.devtools <- list(
      devtools.path = "~/R-dev",
      devtools.install.args = "",
      devtools.desc.suggests = NULL,
      devtools.desc = list()
  )
  toset <- !(names(op.devtools) %in% names(op))
  if(any(toset)) options(op.devtools[toset])
  
  invisible()
}

.onUnload <- function(libpath) {
  # For debugging purpose
  #packageStartupMessage("shankarz.TexST package from Natarajan Shankar unloaded")
}

##
## End shankarz code
##