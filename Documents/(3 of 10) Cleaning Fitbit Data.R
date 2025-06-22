library(tidyverse)
library(dplyr)
library(lubridate)

March_location <- "../Desktop/FitBit User Data/mturkfitbit_export_3.12.16-4.11.16/Fitabase Data 3.12.16-4.11.16/"
April_location <- "../Desktop/FitBit User Data/mturkfitbit_export_4.12.16-5.12.16/Fitabase Data 4.12.16-5.12.16/"

MarchFitBit_dailyActivity <- read.csv(paste(March_location, "dailyActivity_merged.CSV", sep = ""), header = TRUE, sep = ",")
MarchFitBit_hourlyCalories <- read.csv(paste(March_location, "hourlyCalories_merged.CSV", sep = ""), header = TRUE, sep = ",")
MarchFitBit_hourlyIntensities <- read.csv(paste(March_location, "hourlyIntensities_merged.CSV", sep = ""), header = TRUE, sep = ",")
MarchFitBit_hourlySteps <- read.csv(paste(March_location, "hourlySteps_merged.CSV", sep = ""), header = TRUE, sep = ",")
MarchFitBit_minuteMETsNarrow <- read.csv(paste(March_location, "minuteMETsNarrow_merged.CSV", sep = ""), header = TRUE, sep = ",")

AprilFitBit_dailyActivity <- read.csv(paste(April_location, "dailyActivity_merged.CSV", sep = ""), header = TRUE, sep = ",")
AprilFitBit_hourlyCalories <- read.csv(paste(April_location, "hourlyCalories_merged.CSV", sep = ""), header = TRUE, sep = ",")
AprilFitBit_hourlyIntensities <- read.csv(paste(April_location, "hourlyIntensities_merged.CSV", sep = ""), header = TRUE, sep = ",")
AprilFitBit_hourlySteps <- read.csv(paste(April_location, "hourlySteps_merged.CSV", sep = ""), header = TRUE, sep = ",")
AprilFitBit_minuteMETsNarrow <- read.csv(paste(April_location, "minuteMETsNarrow_merged.CSV", sep = ""), header = TRUE, sep = ",")

# Code space saving function
validate <- function(df){
  print(deparse(substitute(df)))
  print(n_distinct(df["Id"]))
  print(count(df) - count(drop_na(df)))
  print(table(duplicated(df)))
}

validate(MarchFitBit_dailyActivity)
validate(MarchFitBit_hourlyCalories)
validate(MarchFitBit_hourlyIntensities)
validate(MarchFitBit_hourlySteps)
validate(MarchFitBit_minuteMETsNarrow)

validate(AprilFitBit_dailyActivity)
validate(AprilFitBit_hourlyCalories)
validate(AprilFitBit_hourlyIntensities)
validate(AprilFitBit_hourlySteps)
validate(AprilFitBit_minuteMETsNarrow)
# No nulls or duplicate rows, inconsistent ID counts, though.  Most of April is 33 and most of March is 34.

id_35 <- distinct(MarchFitBit_dailyActivity["Id"]) 
id_34 <- distinct(MarchFitBit_hourlyCalories["Id"])
id_33 <- distinct(AprilFitBit_dailyActivity["Id"])

intersect(id_35,id_34) # 34 values
intersect(id_35,id_33) # 33 values
intersect(id_34,id_33) # 32 values <- indicates something wrong

setdiff(id_35,id_34) # 4388161847 in 35, but not in 34
setdiff(id_35,id_33) # 2891001357 and 6391747486 in 35, but not in 33
setdiff(id_34,id_33) # 2891001357 and 6391747486 in 34, but not in 33
setdiff(id_33,id_34) # 4388161847 in 33, but not in 34
setdiff(id_33,id_35) # None
setdiff(id_34,id_35) # None

# 4388161847 is in both id_35 and id_33
# 2891001357 and 6391747486 are both in id_35 and id_34

# Correct Date/Time formatting for slicing purposes
MarchFitBit_dailyActivity$ActivityDate <- mdy(MarchFitBit_dailyActivity$ActivityDate)
MarchFitBit_minuteMETsNarrow$ActivityMinute <- mdy_hms(MarchFitBit_minuteMETsNarrow$ActivityMinute)
MarchFitBit_hourlySteps$ActivityHour <- mdy_hms(MarchFitBit_hourlySteps$ActivityHour)
MarchFitBit_hourlyCalories$ActivityHour <- mdy_hms(MarchFitBit_hourlyCalories$ActivityHour)
MarchFitBit_hourlyIntensities$ActivityHour<- mdy_hms(MarchFitBit_hourlyIntensities$ActivityHour)

str(MarchFitBit_dailyActivity)
str(MarchFitBit_minuteMETsNarrow)
str(MarchFitBit_hourlySteps)
str(MarchFitBit_hourlyCalories)
str(MarchFitBit_hourlyIntensities)

AprilFitBit_dailyActivity$ActivityDate <- mdy(AprilFitBit_dailyActivity$ActivityDate)
AprilFitBit_minuteMETsNarrow$ActivityMinute <- mdy_hms(AprilFitBit_minuteMETsNarrow$ActivityMinute)
AprilFitBit_hourlySteps$ActivityHour <- mdy_hms(AprilFitBit_hourlySteps$ActivityHour)
AprilFitBit_hourlyCalories$ActivityHour <- mdy_hms(AprilFitBit_hourlyCalories$ActivityHour)
AprilFitBit_hourlyIntensities$ActivityHour<- mdy_hms(AprilFitBit_hourlyIntensities$ActivityHour)

str(AprilFitBit_dailyActivity)
str(AprilFitBit_minuteMETsNarrow)
str(AprilFitBit_hourlySteps)
str(AprilFitBit_hourlyCalories)
str(AprilFitBit_hourlyIntensities)

# Lower the granularity of METs to match other metrics of interest
# Also convert METs to 1/10th the value, as per the instructions from the datasheet defining MET storage
MarchFitBit_hourlyMETs <- MarchFitBit_minuteMETsNarrow %>%
  mutate(ActivityTime = floor_date(as.POSIXct(.$ActivityMinute), unit = "hour")) %>%
  group_by(Id, ActivityTime) %>%
  summarize(METs = sum(METs)/10, .groups = "drop")

AprilFitBit_hourlyMETs <- AprilFitBit_minuteMETsNarrow %>%
  mutate(ActivityTime = floor_date(as.POSIXct(.$ActivityMinute), unit = "hour")) %>%
  group_by(Id, ActivityTime) %>%
  summarize(METs = sum(METs)/10, .groups = "drop")

# Concatenate Month data together
FitBit_dailyActivity <- rbind(MarchFitBit_dailyActivity,AprilFitBit_dailyActivity)
df_hourlyMets <- rbind(MarchFitBit_hourlyMETs,AprilFitBit_hourlyMETs)
df_hourlySteps <- rbind(MarchFitBit_hourlySteps,AprilFitBit_hourlySteps)
df_hourlyIntensities <- rbind(MarchFitBit_hourlyIntensities,AprilFitBit_hourlyIntensities)
df_hourlyCalories <- rbind(MarchFitBit_hourlyCalories,AprilFitBit_hourlyCalories)

# Merge all hourly data to one source
df_hourly <- merge(df_hourlyMets,df_hourlySteps, by.x = c("Id", "ActivityTime"),by.y = c("Id","ActivityHour"),all = TRUE)
df_hourly <- merge(df_hourly,df_hourlyCalories, by.x = c("Id", "ActivityTime"),by.y = c("Id","ActivityHour"),all = TRUE)
df_hourly <- merge(df_hourly,df_hourlyIntensities, by.x = c("Id", "ActivityTime"),by.y = c("Id","ActivityHour"),all = TRUE)

#this leaves us with two dataframes:  dailyActivity and df_hourly that contains all other data

validate(df_hourly) # Contains 6 null values and 2625 duplicates 
validate(FitBit_dailyActivity) # All good here

# Inspect Nulls
df_hourly[!complete.cases(df_hourly),] # nulls are only in METs on the very last day of the results: 2016-5-12

# Inspect duplicate rows
duplicates <- df_hourly %>%
  group_by_all() %>%
  filter(n() > 1)
# view(count(duplicates)) # All have 16 copies for some reason (commented to not open it up when running)

# Remove duplicate rows
FitBit_hourlyData <- distinct(df_hourly)

# Add convenience
FitBit_hourlyData <- FitBit_hourlyData %>%
  mutate(HourOfDay = hour(ActivityTime))

FitBit_hourlyData <- FitBit_hourlyData %>%
  mutate(DayOfWeek = weekdays(ActivityTime))


# Output
FitBit_dailyActivity
FitBit_hourlyData

# Clean Environment
rm(AprilFitBit_dailyActivity,AprilFitBit_hourlyCalories,AprilFitBit_hourlyIntensities,AprilFitBit_hourlyMETs,AprilFitBit_hourlySteps,AprilFitBit_minuteMETsNarrow)
rm(MarchFitBit_dailyActivity,MarchFitBit_hourlyCalories,MarchFitBit_hourlyIntensities,MarchFitBit_hourlyMETs,MarchFitBit_hourlySteps,MarchFitBit_minuteMETsNarrow)
rm(df_hourly,df_hourlyCalories,df_hourlyIntensities,df_hourlyMets,df_hourlySteps)
rm(id_33,id_34,id_35,duplicates,April_location,March_location,validate)