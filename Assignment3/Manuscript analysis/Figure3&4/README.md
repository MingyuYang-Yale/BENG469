#### Open Terminal: downloand R markdown file
```
scp beng469_my393@farnam.hpc.yale.edu:/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/Figure3ab.Rmd ./
```

#### Open Rstudio Cloud (https://rstudio.cloud/projects)

##### Open a new project and upload:

**Figure3ab.Rmd** 
**final_sample_summary.rds** 

***

```
ssh -Y beng469_**my393**@farnam.hpc.yale.edu
srun --pty --x11 -p interactive --mem=50g bash
```

```
cd /gpfs/ysm/project/beng469/beng469_my393
cd Assignment3-SNV
```

```
git clone https://github.com/bowmanr/scDNA_myeloid.git
module load R/3.6.1-foss-2018b
```

#### open R
```
R
```
```
install.packages('knitr')
install.packages('kableExtra')
install.packages('ReinforcementLearning')
install.packages('dplyr')
install.packages('tidyr')
install.packages('reshape2')
install.packages('igraph')
```

```
vi Figure3.r
```

```
#install.packages('knitr')
#install.packages('kableExtra')
#install.packages('ReinforcementLearning')
#install.packages('dplyr')
#install.packages('tidyr')
#install.packages('reshape2')
#install.packages('igraph')

library(knitr)
library(kableExtra)
library(ReinforcementLearning)
library(dplyr)
library(tidyr)
library(reshape2)
library(igraph)
library(RColorBrewer)

final_sample_summary<-readRDS(file="/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/scDNA_myeloid_data/final_sample_summary.rds")
pheno<-readRDS(file="/gpfs/ysm/project/beng469/beng469_my393/Assignment3-SNV/scDNA_myeloid_data/pheno.rds")

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

graph_results <-list()
graph_results  <- lapply(names(final_sample_summary), function(i){
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

names(graph_results) <- names(final_sample_summary)

saveRDS(graph_results,file="MDP_allsamples_results.rds")

graph_results<-readRDS(file="MDP_allsamples_results.rds")


query_initiating_mutations<-function(graph_results){
  start_index<-paste(rep(0,length(strsplit(graph_results$State[1],split="_")[[1]])),sep="_",collapse="_")
  possible_starting_actions<-graph_results%>%filter(State==start_index&Action!="stay")%>%pull(Action)
  final_results<-list()
  initating_action_count<-0
  for(initating_action in possible_starting_actions){
    print(initating_action)
    set <- graph_results
    initating_action_count<-initating_action_count+1
    storage_results<- list()
    branches<-0
    state_to_kill <- set%>%filter(State==start_index&Action==initating_action)%>%pull(NextState)
    start_killed <- sum(set%>%filter(State==state_to_kill)%>%pull(Valid))
    while(start_killed>0){
      #print(branches)
      # print(start_killed)
      branches <- branches +1
      number_of_mutations<-0
      state_log<- list()
      optimal_reward<-list()
      action_log<-list()
      current_state<- start_index
      indicator<-TRUE
      nextState<-0
      while(current_state!=nextState)  {
        # print(number_of_mutations)
        number_of_mutations <- number_of_mutations+1
        if(number_of_mutations==1){
          state_log[[number_of_mutations]] <- start_index
        }
        current_state  <- state_log[[number_of_mutations]]
        nextState_indicator<- FALSE
        
        while(nextState_indicator==FALSE){
          
          if(number_of_mutations==1){
            max_potential_action_index<-  set%>%
              filter(State==current_state&Action==initating_action)
          } else {
            #############fix 0113
            if (set%>% filter(State==current_state&Valid==TRUE) %>% dim %>% .[1] > 0) {
              max_potential_action_index <- set%>% filter(State==current_state&Valid==TRUE)%>%
                filter(Q==max(Q))%>%sample_n(1)
            }
            else {max_potential_action_index  <- data.frame()}
            ######################
          }
          if(nrow(max_potential_action_index)==0){
            break
          }
          max_potential_action <- max_potential_action_index%>%pull(NextState)
          next_valid_action <- any(set%>%filter(State==max_potential_action&Action!="stay")%>%pull(Valid))
          if(next_valid_action==TRUE){
            nextState <-max_potential_action
            current_action <-  max_potential_action_index%>%pull(Action)
            nextState_indicator==TRUE
            break
          } else{
            set[set$State%in%max_potential_action_index["State"]&
                  set$Action%in%max_potential_action_index["Action"],"Valid"] <- FALSE
          }
        }
        if(nrow(set%>%filter(State==current_state&Action==current_action))==0){
          optimal_reward[[number_of_mutations]] <-NA
        } else {
          optimal_reward[[number_of_mutations]] <- set%>%
            filter(State==current_state&Action==current_action)%>%
            pull(Reward)
        }
        state_log[[number_of_mutations+1]]<- nextState
        action_log[[number_of_mutations]] <- current_action
        if(current_action==nextState){
          indicator==FALSE
          state_log[[number_of_mutations+1]]<-NULL
          break
        }
      }
      optimal_reward[[number_of_mutations+1]] <- NA
      action_log[[number_of_mutations+1]] <- NA
      storage_results[[branches]] <-data.frame("states"=do.call(rbind,state_log),#[1:(length(state_log)-1)]),
                                               "actions"=do.call(rbind,action_log),
                                               "reward"=do.call(rbind,optimal_reward),
                                               "nextState"=do.call(rbind,c(state_log[2:length(state_log)],NA)) )
      storage_results[[branches]] <- storage_results[[branches]]%>%
        filter(states!=nextState)
      storage_results[[branches]]$cumulative_reward <- cumsum(storage_results[[branches]]$reward)
      
      #storage_results[[branches]] <-storage_results[[branches]][1:which.max(storage_results[[branches]]$cumulative_reward), ]
      set[set$State%in%current_state&set$Action%in%current_action,"Valid"] <- FALSE
      start_killed <- sum(set%>%filter(State==state_to_kill)%>%pull(Valid))
    }
    final_results[[initating_action_count]]<-storage_results[!duplicated(storage_results)]
  }
  names(final_results)<-possible_starting_actions
  return(final_results)
}

final_results<-list()
for(i in 1:length(graph_results)){
  print(names(graph_results)[i])
  final_results[[i]]<-query_initiating_mutations(graph_results[[i]])
}

names(final_results) <- names(graph_results)
saveRDS(final_results,file="MDP_trajectory_allsamples_for_each_gene.rds")

```
