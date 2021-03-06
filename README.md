# rnaseq-hisat2-cufflinks

This workflow has been specifically designed to help students studying soybean transcriptome.
The tools used in this workflow were developed by several groups as cited below.
1. Kim, D., Paggi, J.M., Park, C. Bennett, C, Salzberg, S.L. Graph-based genome alignment and genotyping with HISAT2 and HISAT-genotype. Nat Biotechnol 37, 907–915 (2019).
2. Trapnell, C., Williams, B., Pertea, G, Mortazavi, A., Kwan, G., van Baren, J., Salzberg, S., Wold, B., Pachter, L.. Transcript assembly and quantification by RNA-Seq reveals unannotated transcripts and isoform switching during cell differentiation. Nat Biotechnol 28, 511–515 (2010).
3. Li, H., Handsaker, B., Wysoker, A., Fennell, T., Ruan, J., Homer, N., Marth, G., Abecasis, G., Durbin, R. and 1000 Genome Project Data Processing Subgroup. The Sequence alignment/map (SAM) format and SAMtools. Bioinformatics, 25, 2078-9 (2009).


Tools needed and installation links:
1. HISAT2 : https://ccb.jhu.edu/software/hisat2/manual.shtml
2. Samtools : http://www.htslib.org
3. Cufflinks : : http://github.com/cole-trapnell-lab/cufflinks


Reference genome, gene annotation files can be downloaded from Phytozome database (https://phytozome.jgi.doe.gov/pz/portal.html)

To download:
1. Register as user (for first time user)
2. Go to Download in menu bar
3. Click on Phytozome (all version)
4. Click on PhytozomeV12 -> Gmax
5. Three files to be downloaded : 
    - annotation folder: Gmax_275_Wm82.a2.v1.annotation_info.txt; Gmax_275_Wm82.a2.v1.gene.gff3
    - assembly: Gmax_275_v2.0.fa
6. Create new folder in local computer for these files: for example, reference in Desktop.

Workflow:

1. One time action: build HISAT2 index for reference genome

            hisat2-build Gmax_275_v2.0.fa Gmax &


2. Create rnaseq_analysis directory.

3. Create directory for each sample. For example, Sample01.

   In Sample01 directory, create link to raw reads (paired-end data of Sample01 : Sample01_fq.gz and Sample01_2.fq.gz)

            ln -s <path_to_folder>/Sample01_1.fq.gz Sample01_1.fq.gz
            ln -s <path_to_folder>/Sample01_2.fq.gz Sample01_2.fq.gz
            
            
4.  Export path to directory containing hisat2, samtools, cufflinks.

    <path_to_folder> defines path to where the tools are stored. 
    
    For example, if hisat2 is stored in Desktop/Sofwares directory, then define the path as /Desktop/Softwares/hisat2.
    

            export PATH=$PATH:~/<path_to_folder>/cufflinks/:~/<path_to_folder>/hisat2/~/<path_to_folder>/samtools
            
    Do this every time you open Terminal.
    
    Or, create a .bashrc file in rnaseq_directory to store the path. 
  
    
            touch .bashrc
            
            nano .bashrc
            
    
    In .bashrc, type or copy-paste the path above.
    
    Save by using ^O (Ctrl-C then Ctrl-O), exit by using ^E (Ctrl-C then Ctrl-E).
    
    You still need to call .bashrc every time you open the Terminal, but no need to type the whole path.
    
  
            source .bashrc 
    
    
5.  The hisat2.sh workflow contains series of commands from alignment using hisat2 to BAM file creation for cufflinks input.

    In Sample01 directory:

        sh hisat2.sh  <threads>  <path_to_folder>/<reference_genome_index> <pair1> <pair2> 
        
    threads : number of threads to be used in hisat2 analysis
    reference_genome_index : index of reference genome created by hisat2-build (Gmax)
    pair1 : first pair of paired-end files
    pair2 : second pair of paired-end files
    
    For example, we will run Sample01 using thread=3 
    
        sh hisat2.sh 3 Desktop/reference/Gmax Sample01_1.fq.gz Sample01_2.fq.gz
        
        
   The original flow from hisat2 to samtools can be seen in hisat2.sh.
   
   
6.  Cufflinks - cuffmerge - cuffdiff

    Create directory for cufflinks, cuffmerge, and cuffdiff
    
            mkdir cufflinks
            mkdir cuffmerge
            mkdir cuffdiff
        
    In directory cufflinks, perform following command to calculate FPKM of each sample. For example, for Sample01:

            cd cufflinks
   
            cufflinks -o Sample01 -G <path_to_folder>/Gmax_275_Wm82.a2.v1.gene.gff3 ../Sample01/Sample01.bam & 
            
            
     After finishing cufflinks for all samples, continue to cuffmerge in cuffmerge directory.


            cd cuffmerge
            
            
     Get a list of files "transcript.gtf" from each sample's cufflinks directory, and save as list.txt.
     
     
             find ../cufflinks/ -name "transcripts.gtf" > list.txt &
             
             
     Run cuffmerge.
     
     
            cuffmerge -g <path_to_folder>/Gmax_275_Wm82.a2.v1.gene.gff3 -s <path_to_folder>/Gmax.fa list.txt &



     This will create a directory named merged_asm containing merged.gtf.
     
     Finally, run cuffdiff in cuffdiff directory. For example, running comparison between Sample01 and Sample02.
     
     
            cd cuffdiff
            
            cuffdiff -o Sample01-02 -L Sample01,Sample02 -b ../../Gmax.fa -u ../cuffmerge/merged_asm/merged.gtf ../Sample01/Sample01.bam,../Sample01_2/Sample01_2.bam ../Sample02/Sample02.bam,../Sample02_2/Sample02_2.bam &
            
            
     In command above, we compare Sample01 and Sample02, both have two replications. 
     
     -L condition labels
     
     -b reference genome
     
     -u merged gtf list produced after cuffmerge
     
     
     
     
            
            
            
     
     
     
     
     
     
             
     
             
             
     
            
            
            
            


        
        

    
    
    
    
            
    
    
            
    
            
    
    





