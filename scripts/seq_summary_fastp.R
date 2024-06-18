#!/usr/bin/env Rscript
suppressPackageStartupMessages(library(tidyr))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(jsonlite))
suppressPackageStartupMessages(library(optparse))

##Create parameters
option_list <- list(
  make_option(c("-i","--input"), type="character", default=NA,
              help="samples_n_reads_described.txt [default %default]",
              dest="input"),
  make_option(c("-o","--output"), type="character", default="sequencing_summary.txt",
              help="sequencing_summary.txt [default %default]",
              dest="output"),
  make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
              help="Print out all parameter settings [default]")
)

options(error=traceback, warn = -1)

parser <- OptionParser(usage = "%prog -i samples_n_reads_decribed.txt -o out [options]",option_list=option_list)
opt = parse_args(parser)

##manually add file
{
  #setwd("/mnt/content_176/yichun/202308soybean_heatstress_zhili")
  #opt$input="samples_n_reads_described.txt"
  #opt$output="sequencing_summary.txt"
}

input<-read.delim(opt$input, header = F)
names(input)<-c("id1","id2")
input$`Clean reads`<-NA
input$`Clean bases`<-NA
input$`Q20 (%)`<-NA
input$`Q30 (%)`<-NA
input$`GC (%)`<-NA
input$`Mapping rate (%)`<-NA

for (i in 1:nrow(input)) {
  seq.json<-fromJSON(paste0("fastq/", input$id2[i], ".fastp.json"))
  input$`Clean reads`[i]<-seq.json$summary$after_filtering$total_reads
  input$`Clean bases`[i]<-seq.json$summary$after_filtering$total_bases
  input$`Q20 (%)`[i]<-seq.json$summary$after_filtering$q20_rate*100
  input$`Q30 (%)`[i]<-seq.json$summary$after_filtering$q30_rate*100
  input$`GC (%)`[i]<-seq.json$summary$after_filtering$gc_content*100
  rm(seq.json)
}

write.table(input, opt$output, row.names = F, quote = F, sep = "\t")
