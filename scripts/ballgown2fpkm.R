#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(ballgown))
suppressPackageStartupMessages(library(optparse))

##Create parameters
option_list <- list(
  make_option(c("-i","--input"), type="character", default=NA,
              help="ballgown directory [default %default]",
              dest="input"),
  make_option(c("-o","--output"), type="character", default="gene_count_matrix.fpkm.txt",
              help="sample_pairs.txt [default %default]",
              dest="output"),
  make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
              help="Print out all parameter settings [default]")
)

options(error=traceback, warn = -1)

parser <- OptionParser(usage = "%prog -i ballgown -o out [options]",option_list=option_list)
opt = parse_args(parser)

inputdata = ballgown(dataDir=opt$input,
                     samplePattern='*_ballgown', meas='all')

## get FPKM:
fpkm.table<-gexpr(inputdata)
write.table(as.data.frame(fpkm.table),
            opt$output,
            row.names = T, quote = F, sep = "\t")
