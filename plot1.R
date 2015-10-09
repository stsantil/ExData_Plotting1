## This script reads the "Electric power consumption" dataset and generates a histogram of the 
## Global Active Power variable for two specific days

  ## Read the dataset into R
  library(dplyr)
  hpc <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))
 
  ## Retain only the dataset corresponding to the relevant dates  
  hpc_relevant<-filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
  
  ##  Open png device, creates "plot1.png" in working directory and closes the device
  png(file = "plot1.png", width = 480, height = 480)
  hist(hpc_relevant$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()
  