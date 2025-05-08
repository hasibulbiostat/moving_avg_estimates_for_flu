#### load library TTR for calculating a simple moving average 
library(TTR)
#### load library zoo for the roll mean function which computes a simple moving average by taking obs on each side 


library(zoo) 

file_path <- file.path('C:','Users','hasib','OneDrive','Desktop','moving_avg_estimate_for_flu','Data','household_1_season_1.csv')

data <- read.csv(file_path,header=T)






last_sym_onset_date <- max(data$day_ill)

daily_cases<-cut(data$day_ill,breaks=seq(0,last_sym_onset_date,1))

daily_cases <- table(daily_cases)

names(daily_cases) <-NULL

SMA(daily_cases,n=3)



simple_moving_avg <- rollmean(daily_cases,7,na.pad = T)

simple_moving_avg <- ifelse(is.na(simple_moving_avg),0,simple_moving_avg)

simple_moving_avg <- simple_moving_avg/mean(simple_moving_avg)

simple_moving_avg_df <- data.frame(simple_moving_avg_est = round(simple_moving_avg,2))



file_write_out = file.path('C:','Users','hasib','OneDrive','Desktop','moving_avg_estimate_for_flu','output',
                           'simp_mov_avg_estimates_season1.csv')

write.csv(simple_moving_avg_df,row.names=F,file=file_write_out)
