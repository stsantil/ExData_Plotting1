## This script reads the "Electric power consumption" dataset and generates 4 plots of  
## different variables for two specific days

  ## Read the dataset into R
  library(dplyr)
  hpc <- tbl_df(read.table("household_power_consumption.txt", header=TRUE, sep= ";", na.strings = c("?","")))

  ## Retain only the dataset corresponding to the relevant dates  
  hpc_relevant<-filter(hpc, Date == "1/2/2007" | Date == "2/2/2007")

  ## Reformat the date and time variables and create a date/time combined variable
  hpc_date <- strptime(hpc_relevant$Date, format = "%d/%m/%Y")
  date_time <- paste(hpc_date, hpc_relevant$Time)
  hpc_relevant$date_time <- strptime(date_time, format = "%Y-%m-%d %H:%M:%S")

  ##  Open png device, creates "plot4.png" in working directory and closes the device
  png(file = "plot4.png", width = 480, height = 480)
  par(mfrow = c(2,2))
  with (hpc_relevant, {
      #1st graph
      plot(date_time, Global_active_power, col = "black", type = "l",
         xlab = "", ylab = "Global Active Power")
      #2nd graph
      plot(date_time, Voltage, col = "black", type = "l",
       xlab = "datetime", ylab = "Voltage")
      #3rd graph
      plot(date_time, Sub_metering_1, col = "black", type = "l",
                         xlab = "", ylab = "Energy sub metering")
      lines(hpc_relevant$date_time, hpc_relevant$Sub_metering_2, col = "red", type = "l")
      lines(hpc_relevant$date_time, hpc_relevant$Sub_metering_3, col = "blue", type = "l")
      legend("topright", legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), 
          bty = "n", lty = c(1,1,1), col = c("black", "red", "blue"))
      #4th graph
      plot(date_time, Global_reactive_power, col = "black", type = "l",
           xlab = "datetime")
  })
  dev.off()
