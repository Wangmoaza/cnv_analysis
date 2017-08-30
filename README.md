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
* *ccle_ess_cnv_cyclops_role.tsv* : merging deep_input_c3_pert_v2LogN and CCLE_BR_lines_mutation.txt. Chose cases that have cnv info. In the format gene / cell / ess / cnv / CYCLOPS / role
* *cyclops_tcga_ccle_del.txt* : subset of CYLOPS (from project DRIVE) genes that have more cases where # of deletion > # of amplification in both TCGA and CCLE.
* *cyclops_tcga_del.txt* : subset of CYLOPS (from project DRIVE) genes that have more cases where # of deletion > # of amplification in TCGA.
* *cyclops_essential_partial_loss_ratio.tsv* : subset of CYCLOPS (from project DRIVE) genes. In the format gene / essential and partial loss count / partial loss count /  essential and homologous loss count / homologous loss count / essential and neutral count /neutral count / (essential and partial loss)/(partial) ratio / (essential and neutral)/(neutral) ratio 
    * Partial loss: -1.28 <= cnv < -0.1, Homologus loss: cnv < -1.28, Neutral: cnv >= -0.1.
    * Dataset used : breast_essential_c1.mat for essentiality information, CCLE_BR_lines_CNV.txt for cnv (log2 ratio).
    * Excluded genes that had < 3 cases for partial-loss and homologous-loss. 128 genes left.
   

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

#### 2017-08-28

* Cell line cnv vs. CYCLOPS
    - 133 CYCLOPS genes x 34 cell lines
    - No threshold
        - # of CYCLOPS genes where deleted case # > amplified case # : 45
        - # of CYCLOPS genes where deleted case # < amplified case # : 78
    - Threshold 0.1, -0.1
        + # of CYCLOPS genes where deleted case # > amplified case # : 51
        + # of CYCLOPS genes where deleted case # < amplified case # : 78
    - Maybe CYLOPS gene list does not apply well to CCLE BRCA cell lines?
* Cell lines cnv vs. oncogenes
    - 110 oncogenes x 34 cell lines
    - No threshold
        + # of oncogenes where deleted case # > amplified case # : 34
        + # of oncogenes where deleted case # < amplified case # : 67
    - Threshold 0.1, -0.1
        + # of oncogenes where deleted case # > amplified case # : 41
        + # of oncogenes where deleted case # < amplified case # : 58
* Cell lines cnv vs. tsg
    - 86 tsg x 34 cell lines
    - No threshold
        - # of tsg where deleted case # > amplified case # : 32
        - # of tsg where deleted case # < amplified case # : 47
    - Threshold 0.1, -0.1
        + # of tsg where deleted case # > amplified case # : 41
        + # of tsg where deleted case # < amplified case # : 34

* Good results. 87 out of 88 breast_cyclops and cnv < 0 cases were essential. Seems like breast_cyclops set is good representation of breast cancer CYCLOPS genes.


#### 2017-08-30

* CYCLOPS gene analysis. Find out CYCLOPS gene subset that fits breast cancer cell line samples. See *cyclops_essential_partial_loss_ratio.tsv* file description. 