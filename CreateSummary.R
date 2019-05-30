install.packages('yaml')
require('yaml')
setwd('C:/Users/Sreejith Sreekumaran/Desktop/CricketProject/Data')
getwd()

match.summary<-data.frame(row=integer(),city=factor(),venue=factor(),dates=factor(),gender=factor(),match_type=factor(),result=factor(),team1=factor(),team2=factor(),outcome.winner=factor(),outcome.runs=integer(),outcome.wickets=integer(),outcome.method=integer(),toss.winner=factor(),toss.decision=factor(),player_of_match=factor() )

rbind.match.columns <- function(input1, input2) {
  n.input1 <- ncol(input1)
  n.input2 <- ncol(input2)
  
  if (n.input2 < n.input1) {
    TF.names <- which(names(input2) %in% names(input1))
    column.names <- names(input2[, TF.names])
  } else {
    TF.names <- which(names(input1) %in% names(input2))
    column.names <- names(input1[, TF.names])
  }
  
  return(rbind(input1[, column.names], input2[, column.names]))
}

##

temp<-list.files(pattern = "*.yaml")
filecount<-length(temp)

#i=12
for (i in 1:filecount){

  match<-read_yaml(file=temp[i], fileEncoding = "UTF-8",text)
  match.info<-as.data.frame(match$info)

  match.info$city<-ifelse(is.null(match$info$city),'',match$info$city) 
  match.info$venue<-ifelse(is.null(match$info$venue),'',match$info$venue)
  match.info$dates<-match$info$dates
  match.info$gender<-match$info$gender
  match.info$match_type<-match$info$match_type
  match.info$result<-ifelse(is.null(match$info$result),'',match$info$result)
  match.info$team1<-match$info$teams[1]
  match.info$team2<-match$info$teams[2]
  match.info$outcome.winner<-ifelse(is.null(match$info$outcome$winner),'No Result', match$info$outcome$winner)
  match.info$outcome.runs<-ifelse(is.null(match$info$outcome$by$runs),0, match$info$outcome$by$runs)
  match.info$outcome.wickets<-ifelse(is.null(match$info$outcome$by$wickets),0, match$info$outcome$by$wickets)
  match.info$outcome.method<-ifelse(is.null(match$info$outcome$by$method),'', match$info$outcome$by$method)
  match.info$toss.winner<-match$info$toss$winner 
  match.info$toss.decision<-match$info$toss$decision
  match.info$player_of_match<-ifelse(is.null(match$info$player_of_match),'', match$info$player_of_match)
  
#  ifelse(i==1,match.summary<-match.info[1,],match.summary<-rbind(match.summary,match.info[1,]))

  match.summary<-rbind.match.columns(match.summary,match.info[1,])
  #  match.info<-rbind(match.info,match.info[1,])
  
  lastfile<-temp[i]
  }

#match.summary1<-match.summary[,c(16:17,13,1:3,6,8,11,10,18,4:5,19)]
lastfile
filecount
View(match.summary)

write.table(match.summary,file = 'AllODISummary.csv',sep=',')
save(match.summary,file = 'AllODISummary.RData')
#View(match.summary1)

#rm(list=ls())
  
