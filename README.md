# CNV anaylsis of TCGA BRCA samples

part of KAIST internship

## file descriptions

* *matched samples.txt* : TCGA BRCA cases that have normal-tumor matched samples
* *Normal_prediction.tsv* : essential gene prediction on normal samples of TCGA cases
* *Tumor_prediction.tsv* : essential gene prediction on tumor samples of TCGA cases
* *CYCLOPS_FDR0.25.txt* : CYCLOPS gene list from 2012 paper
* *CYCLOPS_project_drive.txt* : CYCLOPS gene lits from 2017 project DRIVE supplemetnary table
* *Gistic2_CopyNumber_Gistic2_all_data_by_genes* : TCGA BRCA cnv dataset
* *Gistic2_CopyNumber_Gistic2_all_thresholded.by_genes* : TCGA BRCA cnv gistic2 threshold dataset
* *Cancer_Role.tsv* : gene roles in cancer. oncogene or TSG.
* *essential_gene_cnv_gistic.tsv* : combined Tumor_prediction.tsv, Normal_prediction.tsv, CYCLOPS_project_drive.txt, Gistic2_all_data, Gistic2_al_thresholded to one file in the format case/gene/normal_ess/tumor_ess/cnv_threshold/cnv_val/role

### results

* *GO_tumor_cnv_deletion.png* : Enrichr gene enrichment analysis
* *GO_tumor_cnv_duplication.png* : Enrichr gene enrichment analysis
* *essential_cyclops_gistic2_threshold_count_hist.pdf* : CYCLOPS genes
* *essential_gistic2_threshold_count_hist.pdf* : compare normal/tumor/both
* *essential_gistic2_threshold_density_hist.pdf* : compare normal/tumor/both
* *essential_gscore_box.pdf* : compare normal/tumor/both
### src

* GISTIC2_summary.md : GISTIC2 tool summary

## lab-note by date

#### 2017-08-11

* downloaded TCGA BRCA datasets from UCSC Xena
    - [copy number (gistic2)](https://xenabrowser.net/datapages/?dataset=TCGA.BRCA.sampleMap/Gistic2_CopyNumber_Gistic2_all_data_by_genes&host=https://tcga.xenahubs.net)
    - [copy number (gistic2_thresholded)](https://xenabrowser.net/datapages/?dataset=TCGA.BRCA.sampleMap/Gistic2_CopyNumber_Gistic2_all_thresholded.by_genes&host=https://tcga.xenahubs.net)
* studying GISTIC summarized in file GISTIC2_summary.md

#### 2017-08-16

* cnv analysis. arranged dataset for use. combined TCGA cnv dataset, essentiality prediction of normal-tumor matched cases, CYCLOPS gene list (from project DRIVE), cancer gene role list. source code in cnv_analysis.ipynb
* histogram and boxplot of results. source code in cnv.R

#### 2017-08-17

* Enrichr gene enrichment analysis
    - dataset: essential_gene_cnv_gistic.tsv
    - tumor-only essential genes, GISTIC threshold < 0 or > 0
    - GO Biological Process 2017b bar graph sorted by combined score
    - output file : GO_tumor_cnv_deletion.png, GO_tumor_cnv_duplication.png
