Define path to tools as below, or invoke path.sh
1.	HISAT2: export PATH=$PATH:<path_to_hisat2_folder>
2.	Samtools: export PATH=$PATH:<path_to_samtools_folder>
3.	Cufflinks: export PATH=$PATH:<path_to_cufflinks_folder>

In this example, we will analyze a paired-end sequence data from Sample01.
Create link to file containing raw reads in hard drive:

ln -s /Volumes/RNAseq/Sample01/Sample01_1.fq.gz Sample01_1.fq.gz
ln -s /Volumes/RNAseq/Sample01/Sample01_2.fq.gz Sample01_2.fq.gz



Running HISAT2:

base=Sample01

hisat2 --dta-cufflinks -p 1 --rg-id $base -x Gmax -1 Sample01_1.fq.gz -2 Sample01_2.fq.gz --summary-file hisat2-cufflinks/$base.txt -S hisat2-cufflinks/$base.sam &




