% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scriptloc.R
\name{script_dir_get}
\alias{script_dir_get}
\title{Return directory where the script exists}
\usage{
script_dir_get()
}
\value{
Returns either a single string with path to the file being executed, or NULL
}
\description{
This is a convenient wrapper to dirname(scriptloc())
}
\examples{
writeLines("library(scriptloc); script_dir <- script_dir_get(); print(script_dir)", "dir-example.R")
source("dir-example.R")
file.remove("dir-example.R")
}
