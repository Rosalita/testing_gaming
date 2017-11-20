
#install.packages("data.table", dependencies=TRUE)

#library(data.table)
library(ggplot2)

# Set working dir
setwd ("/Dev/Git/testing_gaming")
#setwd("~/git/tester_survey")

# Read in data
data <- read.csv("data.csv", header = TRUE, sep =",")

#tidy up column names
colnames(data) <- c("time","test_job","ima_test", "ima_game","yrs_test","yrs_game", "hpw_test", 
                    "hpw_game","skill_test", "skill_game","q_test","q_game","is_gtester")

str(data)
dim(data)


data$ima_test
#check levels 
levels(data$ima_test)
#re-order levels to run from strongly agree to strongly disagree rather than alphabetical order
data$ima_test <- factor(data$ima_test, levels(data$ima_test)[c(4,1,3,2,5)])

data$ima_game
#check levels
levels(data$ima_game)
#re-order levels to run from strongly agree to strongly disagree rather than alphabetical order
data$ima_game <- factor(data$ima_game, levels(data$ima_game)[c(4,1,3,2,5)])

tester <- (data$ima_test)
gamer <- (data$ima_game)

#compare table of i am a tester with i am a gamer
table(tester,gamer)

