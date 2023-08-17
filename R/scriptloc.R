#' Get location of script that was loaded through the source() function
#'
#' Whenever a script is sourced into an R session using source(), the path of
#' the file gets attached to the environment with the name ofile, which can be
#' used to get the file path from within the script. If multiple files are
#' being sourced before, then these would all be present in a different
#' environment. Getting the ofile entry that comes last will give us the
#' sourced file.
#'
#' @param frames : This is the output from sys.frames()
#'
#' @note If any file defines a variable called ofile, this can potentially
#' interfere with detection of the filepath in the main user-facing function.
#'
#' # Specific bad example
#'
#' # a.R
#' # ----
#' ofile <- "something"
#' script_path <- scriptloc()
#'
#' # b.R
#' # ---
#' source("a.R")
#' print(script_path) # Would print "something" and not "a.R"
src_file_get <- function(frames) {
    nframes <- length(frames)
    if (nframes > 0) {
        all_ofiles <- sapply(frames, `[[`, "ofile")
        len_ofiles <- sapply(all_ofiles, length)
        if (all(len_ofiles == 0)) {
            return(NULL)
        } else {
            ofiles <- unlist(all_ofiles[len_ofiles > 0])
            return(ofiles <- ofiles[length(ofiles)])
        }
    }
}

#' Get location of script that was executed through Rscript
#'
#' When a script is being called from the command line using Rscript,
#' the relative path of the script being called will be present in the
#' command line arguments passed to the file. This is used to
#' get the relative path of the script.
#'
#' @param cargs - Output from commandArgs(trailingOnly = F)
script_file_get <- function(cargs) {
    fpat    <- "^--file="
    fpat_l  <- grepl(fpat, cargs)
    npat    <- sum(fpat_l)
    if (npat > 0) {
        # As far as I understand, this shouldn't ever be triggered
        if (sum(fpat_l) > 1) {
            warning("Multiple --file args present. Choosing the first one.") 
        }
        ind <- which(fpat_l)[1]
        return(sub(fpat, "", cargs[ind]))
    } else {
        return(NULL)
    }
}

#' Get location of script in a fashion analagous to ${BASH_SOURCE[0]}
#'
#' There are two ways in which code from an R file can be executed: through
#' the command line by invoking Rscript or by using the source() function.
#' This function tries to see if either of the methods were used, and if not,
#' deduces that the function is being called from an interactive session and
#' therefore returns NULL.
#' @examples
#' writeLines("library(scriptloc); script_path <- scriptloc(); print(script_path)", "example.R")
#' source("example.R")
#' file.remove("example.R")
#' @return Returns either a single string with path to the file being executed, or NULL
#' @export
scriptloc <- function() {

    ofile <- src_file_get(sys.frames())
    sfile <- script_file_get(commandArgs(trailingOnly = F))
    loc <- if (!is.null(ofile)) {
        ofile
    } else if (!is.null(sfile)) {
        sfile
    } else {
        NULL
    }
    if (is.null(loc)) {
        warning("No sourced script file and R session is interactive")
    }
    return(loc)
}

#' Return directory where the script exists
#'
#' This is a convenient wrapper to dirname(scriptloc())
#' @examples
#' writeLines("library(scriptloc); script_dir <- script_dir_get(); print(script_dir)", "dir-example.R")
#' source("dir-example.R")
#' file.remove("dir-example.R")
#' @return Returns either a single string with path to the file being executed, or NULL
#' @export
script_dir_get <- function() dirname(scriptloc::scriptloc())
