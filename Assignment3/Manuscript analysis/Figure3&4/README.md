```
install.packages('knitr')
install.packages('kableExtra')
install.packages('dplyr')
install.packages('tidyr')
install.packages('ReinforcementLearning')
install.packages('ape')
install.packages('circlize')
install.packages("cooccur")
install.packages('corrplot')
install.packages('cowplot')
install.packages('forcats')
install.packages('gdata')
install.packages('ggbeeswarm')
install.packages('ggcorrplot')

install.packages("devtools")
devtools::install_github("briatte/ggnet")


install.packages('ggplotify')
install.packages("ggplot2")
install.packages('ggrepel')
install.packages('ggridges')
install.packages('gridExtra')
install.packages('ggthemes')


if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("ggtree")

install.packages('igraph')
install.packages('miscTools')
install.packages('pals')
install.packages('pheatmap')
install.packages('phylobase')
install.packages('qgraph')
install.packages('rcompanion')
install.packages('tidyverse')
install.packages('TRONCO')


if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")

BiocManager::install("TRONCO")

install.packages('vegan')
install.packages('widyr')
```



```
library(knitr)
library(kableExtra)
library(dplyr)
library(tidyr)
library(ReinforcementLearning)
library(ape)
library(circlize)
```

```
final_sample_summary<-readRDS(file="/cloud/project/data/final_sample_summary.rds")
pheno<-readRDS(file="/cloud/project/data/pheno.rds")
```

```
DTAI_genes <- c("ASXL1","DNMT3A","TET2","IDH1","IDH2")

DTAI_samples<-names(final_sample_summary)[do.call(c,lapply(names(final_sample_summary),function(sample){
  any(grepl(paste(DTAI_genes,sep="|",collapse="|"),colnames(final_sample_summary[[sample]]$NGT)))
}))]

DTAI_AML_samples <- pheno%>%filter(Sample%in%DTAI_samples&grepl("AML",Dx))%>%pull(Sample)
```

```
create_reward_matrix<-function(Known_mat,weights){
  
  num_type <- 2
  num_mutations <- nrow(Known_mat); 
  mutant_names  <- rownames(Known_mat)
  num_clones    <- ncol(Known_mat)
  num_states    <- num_type^num_mutations
  
  possible_mut_list<- unlist(apply(as.matrix(Known_mat),1,function(x){list(0:max(unique(as.numeric(x[-1])))) }),recursive = FALSE)
 
  states<-data.frame(expand.grid(possible_mut_list))
  state_interactions<-data.frame(expand.grid(apply(states[,1:num_mutations],1,function(x){paste(x,collapse="_",sep="_")}),
                                             apply(states[,1:num_mutations],1,function(x){paste(x,collapse="_",sep="_")})))
  
  state_interactions$possible<-ifelse(apply(state_interactions,1,function(x){
    A<-as.numeric(do.call(cbind,strsplit(as.character(x[1]),split="_")))
    B<-as.numeric(do.call(cbind,strsplit(as.character(x[2]),split="_")))
    sum(abs(A-B))<=1
  }),0,NA)
  
  state_interactions$action<-apply(state_interactions,1,function(x){
    A<-as.numeric(do.call(cbind,strsplit(as.character(x[1]),split="_")))
    B<-as.numeric(do.call(cbind,strsplit(as.character(x[2]),split="_")))
    if(!is.na(x["possible"])){
      if(sum(abs(B-A))==0){
        return("stay")
      } else{
        return(mutant_names[which((B-A)==1)])
      }
    }
  })
  
  dat<-setNames(state_interactions%>%filter(action%in%c(mutant_names,"stay")),
                c("State","NextState","Reward","Action"))[,c(1,4,2,3)]
  
  dat$Reward <- as.numeric(apply(dat,1,function(x){
    ifelse(x$NextState%in%names(weights),weights[x$NextState],x$Reward)
  }))
  dat$Reward <- as.numeric(apply(dat,1,function(x){
    ifelse(x$Action%in%"stay",0,x$Reward)
  }))
  dat$State <- as.character(dat$State)
  dat$NextState <- as.character(dat$NextState)
  dat$Action <- as.character(dat$Action)
  
  control <- list(alpha = 0.8, gamma = 0.9)
  model <- ReinforcementLearning(data = dat, s = "State", a = "Action", r = "Reward",  s_new = "NextState",  iter =  1,control=control)
  x<- model$Q
  rownames(x) <- substring(rownames(x),1)
  Q_mat <- setNames(melt(x),c("State","Action","Q"))
  set<-inner_join(dat,Q_mat,by=c("State","Action"))
  set$Valid <- TRUE
  return(set)
  }
```

```
create_reward_matrix_retrain<-function(Known_mat,weights){
  
  num_type <- 2
  num_mutations <- nrow(Known_mat); 
  mutant_names  <- rownames(Known_mat)
  num_clones    <- ncol(Known_mat)
  num_states    <- num_type^num_mutations
  
  possible_mut_list<- unlist(apply(as.matrix(Known_mat),1,function(x){list(0:max(unique(as.numeric(x[-1])))) }),recursive = FALSE)
 
  states<-data.frame(expand.grid(possible_mut_list))
  state_interactions<-data.frame(expand.grid(apply(states[,1:num_mutations],1,function(x){paste(x,collapse="_",sep="_")}),
                                             apply(states[,1:num_mutations],1,function(x){paste(x,collapse="_",sep="_")})))
  
  state_interactions$possible<-ifelse(apply(state_interactions,1,function(x){
    A<-as.numeric(do.call(cbind,strsplit(as.character(x[1]),split="_")))
    B<-as.numeric(do.call(cbind,strsplit(as.character(x[2]),split="_")))
    sum(abs(A-B))<=1
  }),0,NA)
  
  state_interactions$action<-apply(state_interactions,1,function(x){
    A<-as.numeric(do.call(cbind,strsplit(as.character(x[1]),split="_")))
    B<-as.numeric(do.call(cbind,strsplit(as.character(x[2]),split="_")))
    if(!is.na(x["possible"])){
      if(sum(abs(B-A))==0){
        return("stay")
      } else{
        return(mutant_names[which((B-A)==1)])
      }
    }
  })
  
  dat<-setNames(state_interactions%>%filter(action%in%c(mutant_names,"stay")),
                c("State","NextState","Reward","Action"))[,c(1,4,2,3)]
  
  dat$Reward <- as.numeric(apply(dat,1,function(x){
    ifelse(x$NextState%in%names(weights),weights[x$NextState],x$Reward)
  }))
  dat$Reward <- as.numeric(apply(dat,1,function(x){
    ifelse(x$Action%in%"stay",0,x$Reward)
  }))
  dat$State <- as.character(dat$State)
  dat$NextState <- as.character(dat$NextState)
  dat$Action <- as.character(dat$Action)
  
  control <- list(alpha = 0.8, gamma = 0.9)
  model1 <- ReinforcementLearning(data = dat, s = "State", a = "Action", r = "Reward",  s_new = "NextState",  iter =  1,control=control)
  model <- ReinforcementLearning(data = dat, s = "State", a = "Action", r = "Reward",  s_new = "NextState",  iter =  1000,control=list(alpha = 0.8, gamma = 0.9,epsilon=0.4),model=model1)

  
  x<- model$Q
  rownames(x) <- substring(rownames(x),1)
  Q_mat <- setNames(melt(x),c("State","Action","Q"))
  set<-inner_join(dat,Q_mat,by=c("State","Action"))
  set$Valid <- TRUE
  return(set)
  }
```

```
graph_results<-list()
graph_results  <- lapply(DTAI_AML_samples[1:5], function(i){
  print(i)
  mutations <-setdiff(colnames(final_sample_summary[[i]]$NGT),"Clone")
  Known_mat <-final_sample_summary[[i]]$Clones%>%
                                        separate(col=Clone,
                                                 remove = FALSE,
                                                 into=`mutations`)%>%
                                        select(c(all_of(mutations),Clone))%>%
                                        pivot_longer(cols=`mutations`,
                                                     names_to="Genes",
                                                     values_to="Genotype")%>%
                                        pivot_wider(names_from=Clone,
                                                    values_from = Genotype)%>%
                                        mutate_at(vars(-Genes), 
                                                  funs(as.numeric))
                                              
  weights <-final_sample_summary[[i]]$Clones$Count/sum(final_sample_summary[[i]]$Clones$Count)*100
  names(weights)<- final_sample_summary[[i]]$Clones$Clone
  graph_results[[i]]<-create_reward_matrix_retrain(Known_mat,weights)
})

names(graph_results) <-DTAI_AML_samples[1:5]
```
