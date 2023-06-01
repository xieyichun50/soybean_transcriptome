#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(optparse))

##Create parameters
option_list <- list(
  make_option(c("-i","--input"), type="character", default=NA,
              help="samples_n_reads_described.txt [default %default]",
              dest="input"),
  make_option(c("-o","--output"), type="character", default="sample_pairs.txt",
              help="sample_pairs.txt [default %default]",
              dest="output"),
  make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
              help="Print out all parameter settings [default]")
)

options(error=traceback, warn = -1)

parser <- OptionParser(usage = "%prog -i samples_n_reads_decribed.txt -o out [options]",option_list=option_list)
opt = parse_args(parser)

##manually add file
{
  #opt$input="samples_n_reads_described.txt"
  #opt$output="sample_pairs.txt"
}

input<-read.delim(opt$input, header = F)
names(input)<-c("id1","id2")
sample_pair<-as.data.frame(expand_grid(sampleA=unique(input$id1),
                                       sampleB=unique(input$id1)))
write.table(sample_pair, opt$output, row.names = F, col.names = F, sep = "\t", quote = F)
