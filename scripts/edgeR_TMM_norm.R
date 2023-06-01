#load package
suppressPackageStartupMessages(library(optparse))
suppressPackageStartupMessages(library(edgeR))

##Create parameters
option_list <- list(
  make_option(c("-s","--suffix"), type="character", default=NULL,
              help="suffix' [default %default]",
              dest="suffix"),
  make_option(c("-v", "--verbose"), action="store_true", default=TRUE,
              help="Print out all parameter settings [default]")
)

options(error=traceback)

parser <- OptionParser(usage = "%prog -i orthologs.txt -o out [options]",option_list=option_list)
opt = parse_args(parser)

####Read in TMM expression matrix
rawcount<-read.delim(paste0("gene_count_matrix", opt$suffix,".txt"), header = TRUE)
row.names(rawcount)<-rawcount$gene_id
TMM<-rawcount[,2:ncol(rawcount)]

data=as.matrix(TMM)

####Read in sample group
trait<-read.delim(paste0("samples_n_reads_described", opt$suffix,".txt"), header = FALSE)
group <- factor(trait[,2])
y<-DGEList(counts=data,group=group)
y <- calcNormFactors(y, method = "TMM")
TMM.norm<-cpm(y)

write.table(TMM.norm, file = paste0("gene_count_matrix.TMM", opt$suffix,".txt"), sep = "\t")

TMM.norm.log2<-log2(TMM.norm+1)
write.table(TMM.norm.log2, file = paste0("gene_count_matrix.TMM_log2", opt$suffix,".txt"), sep = "\t")

rawcount<-read.delim(paste0("transcript_count_matrix", opt$suffix,".txt"), header = TRUE)
row.names(rawcount)<-rawcount$gene_id
TMM<-rawcount[,2:ncol(rawcount)]

data=as.matrix(TMM)

####Read in sample group
trait<-read.delim(paste0("samples_n_reads_described", opt$suffix,".txt"), header = FALSE)
group <- factor(trait[,2])
y<-DGEList(counts=data,group=group)
y <- calcNormFactors(y, method = "TMM")
TMM.norm<-cpm(y)

write.table(TMM.norm, file = paste0("transcript_count_matrix.TMM",opt$suffix,".txt"), sep = "\t")

TMM.norm.log2<-log2(TMM.norm+1)
write.table(TMM.norm.log2, file = paste0("transcript_count_matrix.TMM_log2",opt$suffix,".txt"), sep = "\t")
