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
