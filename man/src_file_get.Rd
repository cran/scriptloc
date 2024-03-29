% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scriptloc.R
\name{src_file_get}
\alias{src_file_get}
\title{Get location of script that was loaded through the source() function}
\usage{
src_file_get(frames)
}
\arguments{
\item{frames}{: This is the output from sys.frames()}
}
\description{
Whenever a script is sourced into an R session using source(), the path of
the file gets attached to the environment with the name ofile, which can be
used to get the file path from within the script. If multiple files are
being sourced before, then these would all be present in a different
environment. Getting the ofile entry that comes last will give us the
sourced file.
}
\note{
If any file defines a variable called ofile, this can potentially
interfere with detection of the filepath in the main user-facing function.

# Specific bad example

# a.R
# ----
ofile <- "something"
script_path <- scriptloc()

# b.R
# ---
source("a.R")
print(script_path) # Would print "something" and not "a.R"
}
