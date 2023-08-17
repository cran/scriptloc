## ----eval=FALSE---------------------------------------------------------------
#  script_path <- scriptloc()

## ----script01, eval=FALSE, attr.source='.numberLines'-------------------------
#  #' script.R
#  #' Parse our dataset and write out results
#  library(AwesomeRLib)
#  f    <- 'data.tsv'
#  x    <- read.table(f, sep = '\t', header = T, stringsAsFactors = F)
#  y    <- some_cool_function(x)
#  outf <- 'output.tsv'
#  write.table(y, outf, sep = '\t', row.names = F, quote = F)

## ----script02, eval=FALSE, attr.source='.numberLines'-------------------------
#  #' script.R
#  #' Parse our dataset and write out results
#  setwd('/home/user/project')
#  library(AwesomeRLib)
#  f    <- 'data.tsv'
#  x    <- read.table(f, sep = '\t', header = T, stringsAsFactors = F)
#  y    <- some_cool_function(x)
#  outf <- 'output.tsv'
#  write.table(y, outf, sep = '\t', row.names = F, quote = F)

## ----script03, eval=FALSE, attr.source='.numberLines'-------------------------
#  #' script.R
#  #' Parse our dataset and write out results
#  library(AwesomeRLib)
#  f    <- '/home/user/project/data.tsv'
#  x    <- read.table(f, sep = '\t', header = T, stringsAsFactors = F)
#  y    <- some_cool_function(x)
#  outf <- '/home/user/project/output.tsv'
#  write.table(y, outf, sep = '\t', row.names = F, quote = F)

## ----eval=FALSE---------------------------------------------------------------
#  library(scriptloc)
#  script_path <- scriptloc()
#  script_dir  <- dirname(script_path)

## ----eval=FALSE---------------------------------------------------------------
#  #' script-01.R
#  writeLines("Output of scriptloc within first script:")
#  writeLines(scriptloc())
#  writeLines("---------")

## ----eval=FALSE---------------------------------------------------------------
#  #' script-02.R
#  library(scriptloc)
#  source("script-01.R")
#  writeLines("Output of scriptloc within second script:")
#  writeLines(scriptloc())

