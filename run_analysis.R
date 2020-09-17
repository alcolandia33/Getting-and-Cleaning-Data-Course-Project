


library(reshape2)


#1. obtener el conjunto de datos de la web

Dir <- "./rawData"
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

DFn <- paste(Dir, "/", "rawData.zip", sep = "")
dataDir <- "./data"

if (!file.exists(Dir)) {
  dir.create(Dir)
  download.file(url = Url, destfile = DFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = DFn, exdir = dataDir)
}


#2. fusionar(train, test) del conjunto de datos

x_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
s_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

# datos test 
x_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
s_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))

# funcionar datos (train, test) 
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
s_data <- rbind(s_train, s_test)


#3. cargar información de funciones y actividades


feature <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))

# etiqueta de actividad
a_label <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
a_label[,2] <- as.character(a_label[,2])

# extraer características cols y nombres nombrados 'mean, std'
selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)


#4.extraer datos por columnas y usando un nombre descriptivo
x_data <- x_data[selectedCols]
allData <- cbind(s_data, y_data, x_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)


#5. generar un conjunto de datos ordenado

meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./datos_ordenados.txt", row.names = FALSE, quote = FALSE)
