## Run the transcriptome analysis pipeline 

Hisat2-(picard MarkDuplicates)-stringtie-ballgown-edgeR

Run:
- Step1: sh alignment.sh
- Step2: sh expression.sh
- Step3: sh expression.deg.sh


- Pertea, M., Kim, D., Pertea, G. et al. Transcript-level expression analysis of RNA-seq experiments with HISAT, StringTie and Ballgown. Nat Protoc 11, 1650–1667 (2016). https://doi.org/10.1038/nprot.2016.095
- Mark D. Robinson and others, edgeR: a Bioconductor package for differential expression analysis of digital gene expression data, Bioinformatics, Volume 26, Issue 1, January 2010, Pages 139–140, https://doi.org/10.1093/bioinformatics/btp616

#### A demo on samples_n_reads_described.txt
```
E1_L    E1_L_1
E1_L    E1_L_2
E1_L    E1_L_3
E1_R    E1_R_1
E1_R    E1_R_2
E1_R    E1_R_3
ZGDD_L  ZGDD_L_1
ZGDD_L  ZGDD_L_2
ZGDD_L  ZGDD_L_3
ZGDD_R  ZGDD_R_1
ZGDD_R  ZGDD_R_2
ZGDD_R  ZGDD_R_3
```
