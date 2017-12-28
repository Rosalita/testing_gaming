
#install.packages("data.table", dependencies=TRUE)

#library(data.table)
library(ggplot2)

# Set working dir
#setwd ("/Dev/Git/testing_gaming")
setwd("/git/testing_gaming")

# Read in data
data <- read.csv("data.csv", header = TRUE, sep =",")

#tidy up column names
colnames(data) <- c("time","test_job","ima_test", "ima_game","yrs_test","yrs_game", "hpw_test",
                    "hpw_game","skill_test", "skill_game","q_test","q_game","is_gtester")

#clean up data, some skill questions have NA
# remove any responses which state NA for testing skill
# note to self, make important questions mandatory next time *facepalm*

index <- which(data$skill_test != 'NA' )
data <- data[index,]

# fix row numbers after removing NAs
row.names(data) <- 1:nrow(data)

# There is still a NA for one entry in gaming skill, decided to treat this as a 0 value
index <- which(is.na(data$skill_game ))
data[index,"skill_game"] <- 0

str(data)
dim(data)

#tally up table of responses to i am a tester / i am a gamer

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

# everyone agreed they were either a tester or a gamer or some combination of both.
# The people that disagreed they were testers, said they were gamers
# The people that disagreed they were gamers, said they were testers


# examine differences between testing and gaming skill

# Total skill
# testing skill + gaming skill

total_skill <- (data$skill_test + data$skill_game)

# difference between testing and gaming skill
# gaming skill - testing skill

diff_skill <- data$skill_test - data$skill_game

# bind these values to the df

data <- cbind(data, total_skill, diff_skill)


skilldf <- data[,13:15]

#bind the raw numbers on to this df

skilldf <- cbind(skilldf, data$skill_test)
skilldf <- cbind(skilldf, data$skill_game)

# fix column names
colnames(skilldf) <- (c('is_gtester', 'total_skill', 'diff_skill', 'skill_test', 'skill_game'))


#compare testing skill between non-gamers and gamers

p <- ggplot(skilldf, aes(x = is_gtester, y = skill_test), color=skill__game) +
  geom_boxplot(fill=c('cyan', 'magenta'), color="black") +
  ggtitle("Total Skill in testing") +
  labs(y= "Total Skill", x = "Is a games tester?")

p + geom_jitter(shape=16, position=position_jitter(0.05), color ='black', size = 3,alpha =0.3)


#compare gaming skill between non-gamers and gamers

p <- ggplot(skilldf, aes(x = is_gtester, y = skill_game), color=skill_game) +
  geom_boxplot(fill=c('cyan', 'magenta'), color="black") +
  ggtitle("Total Skill in gaming") +
  labs(y= "Total Skill", x = "Is a games tester?")

p + geom_jitter(shape=16, position=position_jitter(0.05), color ='black', size = 3,alpha =0.3)

#compare total skill between non-gamers and gamers

p <- ggplot(skilldf, aes(x = is_gtester, y = total_skill), color=total_skill) +
  geom_boxplot(fill=c('cyan', 'magenta'), color="black") +
  ggtitle("Total Skill in testing and gaming ") +
  labs(y= "Total Skill", x = "Is a games tester?")

p + geom_jitter(shape=16, position=position_jitter(0.05), color ='black', size = 3,alpha =0.3)


