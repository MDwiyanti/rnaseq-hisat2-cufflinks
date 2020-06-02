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
6. Create new folder in local computer for these files.

Build HISAT2 index for reference genome:

$ hisat2-build Gmax_275_v2.0.fa Gmax &







