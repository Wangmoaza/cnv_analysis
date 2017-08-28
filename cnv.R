library(ggplot2)
setwd('/home/hwangbo/kiwonjob/cnv_analysis')
df <- read.table('essential_gene_cnv_gistic.tsv', header=T, sep='\t')
df$X <- NULL

df$class <- NA
for(i in 1:nrow(df)) {
  row <- df[i,]
  if ((row$normal_ess == 1) & (row$tumor_ess == 1)){
    df[i, 8] = 'both'
  }
  else if((row$normal_ess == 0) & (row$tumor_ess == 1)){
    df[i, 8] = 'tumor'
  }
  else{
    df[i, 8] = 'normal'
  }
}

# histogram density
p <- ggplot(df, aes(df$cnv_threshold, group=df$class, fill=df$class)) +
  geom_histogram(aes(y=..density..), position=position_dodge(0.6), binwidth=0.5) +
  xlab("GISTIC2 threshold") +
  labs("essential genes") +
  scale_fill_discrete(name = "Essential genes")
p

# histogram count
p <- ggplot(df, aes(df$cnv_threshold, group=df$class, fill=df$class)) +
  geom_histogram(position=position_dodge(0.6), binwidth=0.5) +
  xlab("GISTIC2 threshold") +
  scale_fill_discrete(name = "Essential genes")
p


cyclops_df <- subset(df, df$role=='CYCLOPS' & df$class == 'both')
p <- ggplot(cyclops_df, aes(cyclops_df$cnv_threshold)) +
  geom_histogram(binwidth=0.5) +
  xlab("GISTIC2 threshold") +
  labs("essential genes") +
  scale_fill_discrete(name = "Essential genes")
p



# boxplot
library(scales) # for alpha function
ggplot(df, aes(x=df$class, y=df$cnv_val, color=df$class, group=df$class)) +
  geom_point(position=position_jitter(width=0.3), alpha=0.5) +
  geom_boxplot(size=1.4, alpha=0, outlier.size=0)+
  geom_boxplot(size=1.4, alpha=0, outlier.size=0, color=alpha("black",0.3)) +
  scale_fill_discrete(name = "Essential genes") +
  xlab('Essential genes') +
  ylab('GISTIC score') +
  scale_fill_discrete(guide=FALSE)

