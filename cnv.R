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


p <- ggplot(df, aes(df$cnv_threshold, group=df$class, fill=df$class)) +
  geom_freqpoly(aes(y=..density..))

p


q <-
