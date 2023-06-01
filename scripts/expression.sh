wd=
dir_fq=${wd}/fastq
dir_bam=${wd}/alignment
dir_exp=${wd}/expression
refgenome=${wd}/ref_genome/Phytozome/PhytozomeV13/Gmax/Wm82.a4.v1/assembly/Gmax_508_v4.0.softmasked.fa
gff=${wd}/ref_genome/Phytozome/PhytozomeV13/Gmax/Wm82.a4.v1/annotation/Gmax_508_Wm82.a4.v1.gene_exons.gff3

cat ${wd}/samples_n_reads_described.txt | while read id1 id2 ;
do

echo "stringtie -e -B -p 76 -G ${gff} -A ${dir_exp}/${id2}_gene_count.txt -o ${dir_exp}/ballgown/${id2}_ballgown/${id2}.gtf ${dir_bam}/$id2.sorted.bam"
stringtie -e -B -p 76 -G ${gff} -A ${dir_exp}/${id2}_gene_count.txt -o ${dir_exp}/ballgown/${id2}_ballgown/${id2}.gtf ${dir_bam}/$id2.sorted.bam

done

prepDE.py -i ${dir_exp}/ballgown -l 150 -g gene_count_matrix.csv -t transcript_count_matrix.csv
sed 's/,/\t/g;s/_ballgown//g' gene_count_matrix.csv > gene_count_matrix.txt
sed 's/,/\t/g;s/_ballgown//g' transcript_count_matrix.csv >　transcript_count_matrix.txt
/usr/bin/Rscript /mnt/content_176/yichun/fungi/hourglass/scripts/edgeR_TMM_norm.R
/usr/bin/Rscript /mnt/content_176/yichun/scripts/illumina/ballgown2fpkm.R -i ${dir_exp}/ballgown -o gene_count_matrix.fpkm.txt
