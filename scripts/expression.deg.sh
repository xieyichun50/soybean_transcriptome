wd=
dir_fq=${wd}/fastq
dir_bam=${wd}/alignment
dir_exp=${wd}/expression
refgenome=${wd}/ref_genome/Phytozome/PhytozomeV13/Gmax/Wm82.a4.v1/assembly/Gmax_508_v4.0.softmasked.fa
gff=${wd}/ref_genome/Phytozome/PhytozomeV13/Gmax/Wm82.a4.v1/annotation/Gmax_508_Wm82.a4.v1.gene_exons.gff3

/usr/bin/Rscript /mnt/content_176/yichun/scripts/nanopore/create_sample_pair.R -i samples_n_reads_described.txt
/mnt/content_176/yichun/tools/trinityrnaseq/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix gene_count_matrix.txt --method edgeR --samples_file ${wd}/samples_n_reads_described.txt --output edgeR_gene.min_reps2.min_cpm1 --min_reps_min_cpm 2,1 --contrasts ${wd}/sample_pairs.txt
