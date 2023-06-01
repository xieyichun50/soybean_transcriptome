wd=
dir_fq=${wd}/fastq
dir_bam=${wd}/alignment
dir_exp=${wd}/expression
refgenome=${wd}/ref_genome/Phytozome/PhytozomeV13/Gmax/Wm82.a4.v1/assembly/Gmax_508_v4.0.softmasked.fa
gff=${wd}/ref_genome/Phytozome/PhytozomeV13/Gmax/Wm82.a4.v1/annotation/Gmax_508_Wm82.a4.v1.gene_exons.gff3

hisat2-build -p 76 -f ${refgenome} ${refgenome}

cat samples_n_reads_described.txt | while read id1 id2 ;
do

echo "fastp -i ${dir_fq}/${id2}/*_1.fq* -I ${dir_fq}/${id2}/*_2.fq* -o ${dir_fq}/${id2}.r1.fq -O ${dir_fq}/${id2}.r2.fq --cut_right -W 4 -M 20 -l 15 -j ${dir_fq}/${id2}.fastp.json -h ${dir_fq}/${id2}.fastp.html -R ${id2}.fastp_report -w 16"
fastp -i ${dir_fq}/${id2}/*_1.fq* -I ${dir_fq}/${id2}/*_2.fq* -o ${dir_fq}/${id2}.r1.fq -O ${dir_fq}/${id2}.r2.fq --cut_right -W 4 -M 20 -l 15 -j ${dir_fq}/${id2}.fastp.json -h ${dir_fq}/${id2}.fastp.html -R ${id2}.fastp_report -w 16

echo "hisat2 -x ${refgenome} -1 ${dir_fq}/${id2}.r1.fq -2 ${dir_fq}/${id2}.r2.fq -S ${dir_bam}/${id2}.sam --phred33 --dta-cufflinks --novel-splicesite-outfile ${dir_bam}/${id2}.splicesite.txt -p 40 --fr"
hisat2 -x ${refgenome} -1 ${dir_fq}/${id2}.r1.fq -2 ${dir_fq}/${id2}.r2.fq -S ${dir_bam}/${id2}.sam --phred33 --dta-cufflinks --novel-splicesite-outfile ${dir_bam}/${id2}.splicesite.txt -p 40 --fr

echo "samtools view --threads 76 -b -S ${dir_bam}/${id2}.sam > ${dir_bam}/${id2}.bam"
samtools view --threads 76 -b -S ${dir_bam}/${id2}.sam > ${dir_bam}/${id2}.bam
rm ${dir_bam}/${id2}.sam

echo "samtools sort --threads 76 ${dir_bam}/${id2}.bam -o ${dir_bam}/${id2}.sorted.bam"
samtools sort --threads 76 ${dir_bam}/${id2}.bam -o ${dir_bam}/${id2}.sort.bam
rm ${dir_bam}/${id2}.bam

echo "picard MarkDuplicates -INPUT ${dir_bam}/${id2}.sort.bam -OUTPUT ${dir_bam}/${id2}.sorted.bam -METRICS_FILE ${dir_bam}/${id2}.sort.matrics.txt -REMOVE_DUPLICATES false -ASSUME_SORTED true"
picard MarkDuplicates -INPUT ${dir_bam}/${id2}.sort.bam -OUTPUT ${dir_bam}/${id2}.sorted.bam -METRICS_FILE ${dir_bam}/${id2}.sort.matrics.txt -REMOVE_DUPLICATES false -ASSUME_SORTED true

echo "samtools index -@ 76 ${dir_bam}/${id2}.sorted.bam"
samtools index -@ 76 ${dir_bam}/${id2}.sorted.bam

done
