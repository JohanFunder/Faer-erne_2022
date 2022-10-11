### konverter til decimal i stedet for degrees
#install.packages("measurements") 
library(measurements)


data1$GPSLongitude<-gsub('deg','',data1$GPSLongitude)
data1$GPSLongitude<-gsub('\'','',data1$GPSLongitude)
data1$GPSLongitude<-gsub("",'',data1$GPSLongitude)
data1$GPSLongitude<-gsub('\\"',"",data1$GPSLongitude)
data1$GPSLongitude<-gsub('\\  '," ",data1$GPSLongitude)
data1$GPSLongitude<-gsub('S',"",data1$GPSLongitude)
data1$GPSLongitude1=measurements::conv_unit(data1$GPSLongitude,from = "deg_min_sec",to="dec_deg")

data1$GPSLongitude1
str(data1$GPSLongitude1)






#### Rename all R-JPG to TIFF

# Create new folder
dir.create("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG_TIFF_rigtig", 
           showWarnings = TRUE, recursive = FALSE, mode = "0777")

## Create a list with all files to copy
files_to_copy <- list.files("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG", full.names = T)

# 3. Copy the TIFF files into a new folder
sapply(files_to_copy, function(x) file.copy(from=x, to="E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG_TIFF_rigtig",
                                            copy.mode = TRUE))


# Rename JPG to TIFF
# rename_TIFF <- sub('.JPG','.TIFF', list.files("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG_TIFF_rigtig",
#                                              full.names = T))

## Create a list with all files to rename to TIFF
files_to_rename <- list.files("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG_TIFF_rigtig", full.names = T)


oldNames<-list.files("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG_TIFF_rigtig", 
                     full.names = T)
newNames<-paste(sep="",oldNames,".JPEG")
for (i in 1:length(oldNames)) file.rename(oldNames[i],newNames[i])

###Editing "GPSlongitude" by multiplying with -1 to each images value

#Set working directory
setwd("C:/Users/johan/Desktop/PhD_AU_OneDrive/Pilot_projekt/Suler/R.Projekt_Suler/R.Projekt_Suler")

#Object containing images
image_files <- dir("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG_TIFF_rigtig",full.names = TRUE)
image_files


exif_call(args = "-GPSlongitude+=*-1", path = image_files)

exif_call(args = "-GPSlongitude+=-GPSlongitude", path = "E:/Mykines_suler/Suler_IR_Converter/Test_org.jpg")

exif_call(args = "-GPSlongitude+=-1", path = "E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG/DJI_20220721204821_0006_T_FLIR.jpg")


## Med renamed tiff filer
exif_call(args = "-GPSlongitude+=-1", path = "E:/Mykines_suler/Suler_IR_Converter/21.07.2022/TIFF/DJI_20220721204822_0007_T_tiff")



exif_read("E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG/DJI_20220721204821_0006_T_FLIR.jpg") # test image

exif_read("E:/Mykines_suler/Suler_IR_Converter/Test_org.jpg")


##  exiftool -GPSlongitude*=-1 E:/Mykines_suler/Suler_IR_Converter/21.07.2022/R-JPG/DJI_20220721204822_0007_T_FLIR.jpg

exif_call(args =  Edits_df$editFilePath, paste0("-DateTimeOriginal+=", Edits_df$newDateTime))
