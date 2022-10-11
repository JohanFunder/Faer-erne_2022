#Installing package from GitHub
if(!require(devtools)) {install.packages("devtools")}
#devtools::install_github("JoshOBrien/exiftoolr",force = TRUE)
#Installing/updating ExifTool program into exiftoolr directory
#exiftoolr::install_exiftool()


#First, manually download "exiftool" and then unzip it to a directory (here, my downloads folder). 
library(exiftoolr)
td <- "C:/Users/johan/Desktop/PhD_AU_OneDrive/Pilot_projekt/Suler/R.Projekt_Suler/R.Projekt_Suler"  # directory containing *unzipped* folder “exiftool-11.55”
exiftool_path <- dir(td, full.names = TRUE)
configure_exiftoolr(command = exiftool_path)

exif_read("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG/DJI_20220721211933_0027_T_FLIR.jpg") # test image


#####---------------------------------------------------------------------------
## Ret forkerte koordinater (Westing/Easting)
##*** Først for 22.07.2022


#### Prøv med system2
library(tidyverse)

system2("exiftool", args="exif:GpsLongitudeRef*=West -GPSLongitude -t -r -m E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG",
        stderr = T)


system2("exiftool",args="-EXIF:GPSlongitude -csv -t -r -m -n  E:/Mykines_suler/Suler_IR_Converter/22.07.2022/R-JPG",
        stdout="E:/Mykines_suler/Suler_IR_Converter/22.07.2022/photodata.csv",
        stderr = T)


data1 <- read.csv("E:/Mykines_suler/Suler_IR_Converter/22.07.2022/photodata.csv")
#View(data1)

head(data1$GPSLongitude)


data1$GPSLongitude2 <- as.numeric(data1$GPSLongitude)
str(data1$GPSLongitude2)
# data1$GPSLongitude2

data1$GPSLongitude3 <- data1$GPSLongitude2*-1
head(data1$GPSLongitude3,15)


## Angiv nye col names
data <- data1[c("SourceFile","GPSLongitude3")]
colnames(data) <- c("SourceFile","GPSLongitude")
head(data)
# Skriv csv fil
write.csv(data, file = "E:/Mykines_suler/Suler_IR_Converter/22.07.2022/Long.csv",row.names=F)


## Indlæs csv fil med opdaterede koordinater og skriv til hver fil ved at evoke exiftool
### Now add the "w" coordinate for each image
system2("exiftool", args= "-csv=E:/Mykines_suler/Suler_IR_Converter/22.07.2022/Long.csv E:/Mykines_suler/Suler_IR_Converter/22.07.2022/R-JPG -m")


### Now add the "w" coordinate for each image
 system2("exiftool", args="-GpsLongitudeRef=W -t -r -m E:/Mykines_suler/Suler_IR_Converter/22.07.2022/R-JPG",
        stderr = T)



## Read gps meata data for at tjekke om opdatering med transformationen har fundet sted
exif_read("E:/Mykines_suler/Suler_IR_Converter/22.07.2022/R-JPG/DJI_20220722085302_0306_T_FLIR.jpg") # test image




#####---------------------------------------------------------------------------
## Ret forkerte koordinater (Westing/Easting)
##*** Så for 21.07.2022


#### Prøv med system2
library(tidyverse)

#system2("exiftool", args="exif:GpsLongitudeRef*=West -GPSLongitude -t -r -m E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG",
#        stderr = T)


system2("exiftool",args="-EXIF:GPSlongitude -csv -t -r -m -n  E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG",
        stdout="E:/Mykines_suler/Suler_IR_Converter/21.07.2022/photodata.csv",
        stderr = T)


data1 <- read.csv("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/photodata.csv")
#View(data1)

head(data1$GPSLongitude)


data1$GPSLongitude2 <- as.numeric(data1$GPSLongitude)
str(data1$GPSLongitude2)
# data1$GPSLongitude2

data1$GPSLongitude3 <- data1$GPSLongitude2*-1
head(data1$GPSLongitude3,15)


## Angiv nye col names
data <- data1[c("SourceFile","GPSLongitude3")]
colnames(data) <- c("SourceFile","GPSLongitude")
head(data)
# Skriv csv fil
write.csv(data, file = "E:/Mykines_suler/Suler_IR_Converter/21.07.2022/Long.csv",row.names=F,quote = F)


## Indlæs csv fil med opdaterede koordinater og skriv til hver fil ved at evoke exiftool
### Now add the "w" coordinate for each image
system2("exiftool", args= "-csv=E:/Mykines_suler/Suler_IR_Converter/21.07.2022/Long.csv E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG -m")


### Now add the "w" coordinate for each image
 system2("exiftool", args="-GpsLongitudeRef=W -t -r -m E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG",
        stderr = T)



## Read gps meata data for at tjekke om opdatering med transformationen har fundet sted
exif_read("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG/DJI_20220721213825_0307_T_FLIR.jpg") # test image




