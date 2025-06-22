library(tidyverse)
library(ggplot2)
library(tidytext)

# This documents contains the code used to investigate what might be important trends within the FitBit user
# dataset, day-wide subset.  It requires data in the global environment from:
#  - (3 of 10) Cleaning Fitbit Data.R


#--------------------------------------------------------------------------------------------------------#
# Total Distance vs Day of the week
FitBit_dailyActivity %>%
  mutate(day = weekdays(ActivityDate),
         day = factor(day,
                      levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
         ),
         week = week(ActivityDate)
  ) %>%
  select(week, day, TotalDistance) %>%
  group_by(week,day) %>%
  summarize(AverageDistance = mean(TotalDistance)) %>%
  ungroup() %>%
  complete(week, day, fill = list(AverageDistance = 0), explicit = TRUE) %>%
  filter(week %in% c(12:18)) %>%
  
  ggplot(aes(x = factor(day,
                        levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
  ),
  y = AverageDistance / (18 - (12 - 1)), # because of the week filter and bars stacking
  group = interaction(week,day),
  fill = factor(week,levels = c(12:18), labels = c(2:8)) # Renames the weeks to be true to observations
  )
  ) +
  geom_bar(stat = 'identity',
           color = "black",
           alpha = 1,
           position = "stack") +
  geom_hline(data = .%>% filter(day == "Wednesday") ,
             aes(yintercept = sum(AverageDistance)/7),
             linetype = "dashed",
             size = 1,
             alpha = .5,
             color = "black") +
  labs(title = "Average Distance Travelled by Day of the Week",
       caption = "Data sourced from: https://zenodo.org/records/53894#.YMoUpnVKiP9",
       x = "",
       y = "Average Distance Travelled in a Day (KM) \n",
       fill = "Week Of \nObservation"
  )


#--------------------------------------------------------------------------------------------------------#
# Calories vs day of the week
FitBit_dailyActivity %>%
  mutate(day = weekdays(ActivityDate),
         day = factor(day,
                      levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
         ),
         week = week(ActivityDate)
  ) %>%
  select(week, day, Calories) %>%
  group_by(week,day) %>%
  summarize(AverageDistance = mean(Calories)) %>%
  ungroup() %>%
  complete(week, day, fill = list(AverageDistance = 0), explicit = TRUE) %>%
  filter(week %in% c(12:18)) %>%
  
  ggplot(aes(x = factor(day,
                        levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
  ),
  y = AverageDistance / (18 - (12 - 1)), # because of the week filter and bars stacking
  group = interaction(week,day),
  fill = factor(week,levels = c(12:18), labels = c(2:8)) # Renames the weeks to be true to observations
  )
  ) +
  geom_bar(stat = 'identity',
           color = "black",
           alpha = 1,
           position = "stack") +
  geom_hline(data = .%>% filter(day == "Wednesday") ,
             aes(yintercept = sum(AverageDistance)/7),
             linetype = "dashed",
             size = 1,
             alpha = .5,
             color = "black") +
  labs(title = "Average Calories Burned by Day of the Week",
       caption = "Data sourced from: https://zenodo.org/records/53894#.YMoUpnVKiP9",
       x = "",
       y = "Average Calories Burned in a Day\n",
       fill = "Week Of \nObservation"
  )


#--------------------------------------------------------------------------------------------------------#
# Day of Week Vs Activity Zone Minutes (ALL)
FitBit_dailyActivity %>%
  mutate(day = weekdays(ActivityDate),
         day = factor(day,
                      levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
         ),
         week = week(ActivityDate)
  ) %>%
  filter(Calories!= 0) %>%
  filter(TotalDistance != 0) %>%
  
  select(week, day, c(VeryActiveMinutes:SedentaryMinutes)) %>%
  group_by(week,day) %>%
  summarize(veryActiveMins = mean(VeryActiveMinutes),
            fairlyActiveMins = mean(FairlyActiveMinutes),
            lightlyActiveMins = mean(LightlyActiveMinutes),
            sedentaryMins = mean(SedentaryMinutes)) %>%
  ungroup() %>%
  filter(week %in% c(12:18)) %>%
  group_by(day) %>%
  summarize(average_active = mean(veryActiveMins),
            average_fair = mean(fairlyActiveMins),
            average_light = mean(lightlyActiveMins),
            average_sedentary = mean(sedentaryMins)) %>%
  pivot_longer(names_to = "activity_zone",cols = c(average_active:average_sedentary)) %>%
  
  ggplot(aes(x = factor(day,
                        levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
  ),
  y = ifelse(activity_zone == "average_sedentary", value/ 4, value),
  group = activity_zone,
  color = factor(activity_zone,
                 levels = c("average_active","average_fair","average_light","average_sedentary"),
                 labels = c("Active","Fair","Light","Sedentary\n(Scaled by 1/4)")
  )
  )) +
  geom_point(size = 3,
             show.legend = FALSE)+    
  geom_line(size = 1.5)+  
  
  labs(title = "Average Minutes in Activity Zones by Day of the Week",
       caption = "Data sourced from: https://zenodo.org/records/53894#.YMoUpnVKiP9",
       x = "",
       y = "Minutes\n",
       color = "Activity Zone"
  ) +
  geom_text(data = data.frame(activity_zone = "average_sedentary"),
            aes(label = "Actual Value is 4x Larger"),
            hjust = 1,
            vjust = 1,
            x = 7,
            y = 250,
            size = 5,
            show.legend = FALSE
  )


#--------------------------------------------------------------------------------------------------------#
# Day of Week Vs Activity Zone Minutes (SUBSET)
FitBit_dailyActivity %>%
  mutate(day = weekdays(ActivityDate),
         day = factor(day,
                      levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
         ),
         week = week(ActivityDate)
  ) %>%
  filter(Calories!= 0) %>%
  filter(TotalDistance != 0) %>%
  
  select(week, day, c(VeryActiveMinutes:SedentaryMinutes)) %>%
  group_by(week,day) %>%
  summarize(veryActiveMins = mean(VeryActiveMinutes),
            fairlyActiveMins = mean(FairlyActiveMinutes),
            lightlyActiveMins = mean(LightlyActiveMinutes),
            sedentaryMins = mean(SedentaryMinutes)) %>%
  ungroup() %>%
  filter(week %in% c(12:18)) %>%
  group_by(day) %>%
  summarize(average_active = mean(veryActiveMins),
            average_fair = mean(fairlyActiveMins),
            average_light = mean(lightlyActiveMins),
            average_sedentary = mean(sedentaryMins)) %>%
  pivot_longer(names_to = "activity_zone",cols = c(average_active:average_sedentary)) %>%
  filter(activity_zone %in% c("average_active","average_fair")) %>%
  
  ggplot(aes(x = factor(day,
                        levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"),
  ),
  y = ifelse(activity_zone == "average_sedentary", value/ 4, value),
  group = activity_zone,
  color = factor(activity_zone,
                 levels = c("average_active","average_fair","average_light","average_sedentary"),
                 labels = c("Active","Fair","Light","Sedentary\n(Scaled by 1/4)")
  )
  )) +
  geom_point(size = 3,
             show.legend = FALSE)+    
  geom_line(size = 1.5)+  
  
  labs(title = "Average Minutes in Activity Zones by Day of the Week",
       subtitle = "Subset: Highly Active and Fairly Active",
       caption = "Data sourced from: https://zenodo.org/records/53894#.YMoUpnVKiP9",
       x = "",
       y = "Minutes\n",
       color = "Activity Zone"
  )
