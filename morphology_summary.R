author <- "Haley E. Speed, Ph.D."
analysisDate <- date()
project <- "Gulf War"
info <- data.frame(Author = author, Date = analysisDate, Project = project)
print(info)

library(nlme)
library (dplyr)

## FUNCTION DEFINITIONS

# Get directory and file information 
getUserInput <- function (){
        file.inDir <- readline("Enter the path to the working directory: ")
        file.inName1 <- readline("Enter the filename of group 1: ")
        file.inName2 <- readline("Enter the filename of group 2: ")
        file.inName3 <- readline("Enter the filename of group 3: ")
        file.inName4 <- readline("Enter the filename of group 4: ")
        return (c(file.inName1, file.inName2, file.inName3, file.inName4, 
                  file.inDir))
}

getDataTables <- function (file.name,file.dir) {
        # Constructs path to each file
        file.path <- paste(file.dir,file.name, sep = "\\")
        # Reads in the files into data frames        
        data.group <- read.csv(file.path, header = TRUE)
        # Gets group name from csv filename
        file.groupName <- strsplit(file.name, ".csv")
        # Adds a column named "group" to the existing data set"
        # If you don't transform to character here, you will get a list error 
        # When you try to write to file or do anovas
        data.group <- mutate(data.group, group = as.character(file.groupName))
        return(data.group)
}

# Function to calculate descriptive statistics
getStats <- function (data.group){
        data.n    <- length(data.group$cell)
        data.mean <- c()
        data.sd   <- c()
        data.se   <- c()
        
        # While loop to cycle through all columns containing 
        # numeric data
        i = 2
        maxCol <- length(colnames(data.group)) - 1
        while (i < maxCol){
                data.mean[i-1] <- mean(as.numeric(as.character
                                  (data.group[,i])))
                data.sd[i-1]   <- sd(as.numeric(as.character
                                  (data.group[,i])))
                data.se[i-1]   <- data.sd[i-1]/sqrt(data.n)
                i <- i + 1
        }
        
       return (list(data.mean, data.sd, data.se, data.n))
}

# Calculate one-way ANOVA results
getANOVA <- function (data.compare){
        
        # Define the Model
        lme.dendriteLength      = lme(dendriteLength ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.dendriteSurfaceArea = lme(dendriteSurfaceArea ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.dendriteVolume      = lme(dendriteVolume ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.dendriteBranches    = lme(dendriteBranches ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.dendriteOrders      = lme(dendriteOrders ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.spineArea           = lme(spineArea ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.spineVolume         = lme(spineVolume ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.totalSpines         = lme(totalSpines ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.thinSpines          = lme(thinSpines ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.stubbySpines        = lme(stubbySpines ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.mushroomSpines      = lme(mushroomSpines ~ group, 
                                  random = ~1|cell, data = data.compare)
        lme.filopodia           = lme(filopodia ~ group, 
                                  random = ~1|cell, data = data.compare)
        
        # Run the ANOVA
        anova.dendriteLength <- anova(lme.dendriteLength)
        anova.dendriteSurfaceArea <- anova(lme.dendriteSurfaceArea)
        anova.dendriteVolume <- anova(lme.dendriteVolume)
        anova.dendriteBranches <- anova(lme.dendriteBranches)
        anova.dendriteOrders <- anova(lme.dendriteOrders)
        anova.spineArea <- anova(lme.spineArea)
        anova.spineVolume <- anova(lme.spineVolume)
        anova.totalSpines <- anova(lme.totalSpines)
        anova.thinSpines <- anova(lme.thinSpines)
        anova.stubbySpines <- anova(lme.stubbySpines)
        anova.mushroomSpines <- anova(lme.mushroomSpines)
        anova.filopodia <- anova(lme.filopodia)
        return(list(dendriteLength = anova.dendriteLength, 
                    dendriteSurfaceArea = anova.dendriteSurfaceArea, 
                    dendriteVolume = anova.dendriteVolume, 
                    dendriteBranches = anova.dendriteBranches, 
                    dendriteOrders = anova.dendriteOrders, 
                    spineArea = anova.spineArea, 
                    spineVolume = anova.spineVolume,
                    totalSpines = anova.totalSpines, 
                    thinSpines = anova.thinSpines, 
                    stubbySpines = anova.stubbySpines,
                    mushroomSpines = anova.mushroomSpines, 
                    filopodia = anova.filopodia))
}

## Run the script
# Get user input from the console
files <- getUserInput()
file.path <- files[5]

# Get group names
# Assumes each group is named with "..._summary.csv"
group.name1 <- strsplit(files[1], "_summary.csv")
group.name2 <- strsplit(files[2], "_summary.csv")
group.name3 <- strsplit(files[3], "_summary.csv")
group.name4 <- strsplit(files[4], "_summary.csv")

# Read in data from each file and format it for analysis
data.group1  <- getDataTables(files[1],files[5])
data.group2  <- getDataTables(files[2],files[5])
data.group3  <- getDataTables(files[3],files[5])
data.group4  <- getDataTables(files[4],files[5])

# Combine data for comparison between exposure/treatment groups
data.compare1 <- rbind(data.group1, data.group2)
data.compare2 <- rbind(data.group1, data.group3)
data.compare3 <- rbind(data.group1, data.group4)
data.compare4 <- rbind(data.group2, data.group3)
data.compare5 <- rbind(data.group2, data.group4)
data.compare6 <- rbind(data.group3, data.group4)

# Get descriptive statistics for each group
stats.Group1 <- getStats(data.group1)
stats.Group2 <- getStats(data.group2)
stats.Group3 <- getStats(data.group3)
stats.Group4 <- getStats(data.group4)

# Get one-way anova reports for each possible comparison
anova.compare1 <- getANOVA(data.compare1)
anova.compare2 <- getANOVA(data.compare2)
anova.compare3 <- getANOVA(data.compare3)
anova.compare4 <- getANOVA(data.compare4)
anova.compare5 <- getANOVA(data.compare5)
anova.compare6 <- getANOVA(data.compare6)

# Write data to file
file.compare1 <- paste(group.name1,group.name2, sep = "_vs_")
file.compare2 <- paste(group.name1,group.name3, sep = "_vs_")
file.compare3 <- paste(group.name1,group.name4, sep = "_vs_")
file.compare4 <- paste(group.name2,group.name3, sep = "_vs_")
file.compare5 <- paste(group.name2,group.name4, sep = "_vs_")
file.compare6 <- paste(group.name3,group.name4, sep = "_vs_")

# Write data to file
writeData (anova.compare1, file.compare1, file.path)
writeData (anova.compare2, file.compare2, file.path)
writeData (anova.compare3, file.compare3, file.path)
writeData (anova.compare4, file.compare4, file.path)
writeData (anova.compare5, file.compare5, file.path)
writeData (anova.compare6, file.compare6, file.path)

# Function to write collated data to file
writeData <- function (file.data, file.name, file.path){
        file.name <- paste(file.name, ".csv", sep = "")
        file.path <- paste(file.path, "analyzed", sep = "\\")
        if (!dir.exists(file.path)) {dir.create(file.path)}
        file.path <- paste(file.path, file.name, sep = "\\")
        write.csv(file.data, file.path, row.names = FALSE) 
}


