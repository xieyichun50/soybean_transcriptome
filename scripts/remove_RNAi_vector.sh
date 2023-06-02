conda activate bbmap
##this is a PE150 experiment, k=100 means 2/3 of the read length is matched against the vector sequence
dir_fq=/mnt/content_176/yichun/202304soybean_E1_kd_zhili/fastq

head -n6 samples_n_reads_described.txt | while read id1 id2 ;
do
bbduk.sh -Xmx64g in1=${dir_fq}/${id2}.r1.fq in2=${dir_fq}/${id2}.r2.fq out1=${dir_fq}/${id2}.r1.filter.fq out2=${dir_fq}/${id2}.r2.filter.fq literal=TCAGATGAAAGGGAGCAGTGTCAAAAGAAGACGAAATCCACCATATGCGAAGCCTCTAACTTTAGGACATCAAGGAGAAGATTCTGCAGCAACAACAAAAATGAAGAGGAGATGAACAATAAGGGAGTTTCAACAACACTGAAGCTTTACGATGATCCTTGGAAGATCAAGAAGACGCTAACCGATAGCGATTTGGGAATCCTAAGTAGACTCTTGCTGGCTGCAGATTTGGTGAAGAAACAAATTTTGCCTATGTTGGGTGC k=100
done

