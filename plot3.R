## This script reads the "Electric power consumption" dataset and generates a plot of the 
## Energy sub metering variables for two specific days

  ## Read the dataset into R
  library(dplyr)
  hpc <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))

  ## Retain only the dataset corresponding to the relevant dates  
  hpc_relevant<-filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")

  ## Reformat the date and time variables and create a date/time combined variable
  hpc_date <- strptime(hpc_relevant$Date, format = "%d/%m/%Y")
  date_time <- paste(hpc_date, hpc_relevant$Time)
  hpc_relevant$date_time <- strptime(date_time, format = "%Y-%m-%d %H:%M:%S")

  ##  Open png device, creates "plot3.png" in working directory and closes the device
  png(file = "plot3.png", width = 480, height = 480)
  with (hpc_relevant, plot(date_time, Sub_metering_1, col = "black", type = "l",
                         xlab = "", ylab = "Energy sub metering"))
  lines(hpc_relevant$date_time, hpc_relevant$Sub_metering_2, col = "red", type = "l")
  lines(hpc_relevant$date_time, hpc_relevant$Sub_metering_3, col = "blue", type = "l")
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
       lty = c(1,1,1), col = c("black", "red", "blue"))
  dev.off()

