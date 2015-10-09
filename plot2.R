## This script reads the "Electric power consumption" dataset and generates a plot of the 
## Global Active Power variable for two specific days

  ## Read the dataset into R
  library(dplyr)
  hpc <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))

  ## Retain only the dataset corresponding to the relevant dates  
  hpc_relevant<-filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")
  
  ## Reformat the date and time variables and create a date/time combined variable
  hpc_date <- strptime(hpc_relevant$Date, format = "%d/%m/%Y")
  date_time <- paste(hpc_date, hpc_relevant$Time)
  hpc_relevant$date_time <- strptime(date_time, format = "%Y-%m-%d %H:%M:%S")
  
  ##  Open png device, creates "plot2.png" in working directory and closes the device
  png(file = "plot2.png", width = 480, height = 480)
  with (hpc_relevant, plot(date_time, Global_active_power, col = "black", type = "l",
                           xlab = "", ylab = "Global Active Power (kilowatts)"))
  dev.off()

  