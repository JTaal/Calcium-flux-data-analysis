## function to shift intensity peaks to align to their maximum 

#Designate pathways
inputPath <- readline(prompt="Give the input folder: ")
outputPath <- readline(prompt="Give the output folder: ")
outputPath <- paste(outputPath, "\\", sep="")

#list all the files in the folder
files <- list.files(path = inputPath)

#Big Bertha of data conversion
for(file in files){
  dataPathway <- paste(inputPath, file, sep="/")
  outputName <- paste(outputPath, file, sep="/")
  
  #Read data
  dat <- read.csv(dataPathway, header=T, sep=",", stringsAsFactors = F)
  colnames(dat) <- c("time",paste("cell",2:ncol(dat)-1,sep = "_"))
  #Invert the data rows
  inv_dat <- dat[nrow(dat):1,2:ncol(dat)]
  inv_dat$time <- dat$time
  
  #testData <- inv_dat[,c("cell_100","cell_55","time")]
  
  #plotDat <- testData
  plotDat <- dat[,2:ncol(dat)]
  plotDat$time <- dat$time
  #plot the unedited cell data
  #loop through the data
  par(mfrow=c(2,2))
  for(c in 1:ncol(plotDat)-1){
    
    if(c==1){
      plot(x=plotDat$time,y=plotDat[,c],col=c,type="l",ylab="Intensity",xlab="time (s)",ylim=c(0,max(plotDat[,1:ncol(plotDat)-1],na.rm = T)+5))
    }
    if(c>=2){
      lines(x=plotDat$time,y=plotDat[,c],col=c)
    }
  }
  
  ###
  ###
  ### sync to 0s time
  ###
  ###
  
  # generate a list to store a vector for each cell
  datList <- vector(mode="list",length=ncol(inv_dat)-1)
  tmpList <- vector(mode="list",length=ncol(inv_dat)-1)
  
  for(c in 1:length(tmpList)){
    datList[[c]] <- inv_dat[,c]
    # remove every NA (therefore, not captured time points for cells that attach later)
    tmpList[[c]] <- datList[[c]][!is.na(datList[[c]])]
  }
  
  # Plot each cell with available data
  for(c in 1:length(tmpList)){
    tmpDat <- tmpList[[c]]
    if(c == 1){
      # X will be a sequence of time starting at 0 with 5s increments for each datapoint captured per cell
      plot(x=seq(from=0,length.out = length(tmpDat),by=5),
           y=tmpDat,col=c,ylab="intensity",xlab="time",xlim=c(0,600),ylim=c(0,50),type="l")
    }
    if(c >1){
      lines(x=seq(from=0,length.out = length(tmpDat),by=5),
            y=tmpDat,col=c,ylab="intensity",xlab="time")
      
    }
    
  }
  
  #Writing data back into a matrix 
  n.obs <- sapply(tmpList, length)
  seq.max <- seq_len(max(n.obs))
  writeOut <- sapply(tmpList, "[", i = seq.max)
  writeOut <- cbind(writeOut, seq(from=0,length.out = length(seq.max), by=5))
  colnames(writeOut) <- colnames(inv_dat)[1:ncol(inv_dat)]
  colsOrd <- c("time",paste("cell",1:length(tmpList),sep="_"))
  writeOut <- writeOut[,colsOrd]
  write.csv(writeOut, file = outputName, quote = F,row.names = F)
}