library(tidyverse)
library(ggplot2)

# This documents contains the code used to investigate what might be important trends within the FitBit user
# dataset, hour-wide subset.  It requires data in the global environment from:
#  - (3 of 10) Cleaning Fitbit Data.R


#--------------------------------------------------------------------------------------------------------#
## Hourly MET data for an individual
FitBit_hourlyData %>%
  select(Id, ActivityTime, METs) %>%
  group_by(Id,ActivityTime) %>% 
  filter(Id == 1503960366) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, METs) %>%
  
  ggplot(aes(x = time,
             y = METs,
             group = day)
  )+
  geom_line(alpha = .1,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              color = "black",
              se = FALSE) +
  labs(title = "Hourly METs Expended for an Individual",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Expended METs"
       )+
  geom_label(data = data.frame(day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 400,
             fill = "lightyellow",
             label.padding = unit(.7, "lines"))


## Hourly MET data for the whole group
FitBit_hourlyData %>%
  select(Id, ActivityTime, METs) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, METs) %>%
  group_by(Id,time) %>%
  summarize(average_factor = mean(METs)) %>%
  ungroup() %>%
  
  ggplot(aes(x = time,
             y = average_factor,
             group = Id)
  )+
  geom_line(alpha = .15,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              size = 2,
              color = "black",
              se = FALSE,
              span = .3)+
  geom_label(data = data.frame(Id = NA, day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 250,
             fill = "lightyellow",
             label.padding = unit(.7, "lines")
  )+
  labs(title = "Average Hourly METs Expended  for 35 People",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Expended METs"
  )


#--------------------------------------------------------------------------------------------------------#
# Hourly Step Counts For an Individual
FitBit_hourlyData %>%
  select(Id, ActivityTime, StepTotal) %>%
  group_by(Id,ActivityTime) %>% 
  filter(Id == 1503960366) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, StepTotal) %>%
  
  ggplot(aes(x = time,
             y = StepTotal,
             group = day)
  )+
  geom_line(alpha = .1,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              color = "black",
              se = FALSE) +
  labs(title = "Hourly Step Count for an Individual",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Steps Per Hour"
  )+
  geom_label(data = data.frame(day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 6000,
             fill = "lightyellow",
             label.padding = unit(.7, "lines"))


# Hourly Step Counts for the Whole Group
FitBit_hourlyData %>%
  select(Id, ActivityTime, StepTotal) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, StepTotal) %>%
  group_by(Id,time) %>%
  summarize(average_factor = mean(StepTotal)) %>%
  ungroup() %>%
  
  ggplot(aes(x = time,
             y = average_factor,
             group = Id)
  )+
  geom_line(alpha = .15,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              size = 2,
              color = "black",
              se = FALSE,
              span = .3)+
  geom_label(data = data.frame(Id = NA, day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 3000,
             fill = "lightyellow",
             label.padding = unit(.7, "lines")
  )+
  labs(title = "Average Hourly Step Count for 35 People",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Steps Per Hour"
  )


#--------------------------------------------------------------------------------------------------------#
# Hourly Calories Burned for an Individual
FitBit_hourlyData %>%
  select(Id, ActivityTime, Calories) %>%
  group_by(Id,ActivityTime) %>% 
  filter(Id == 1503960366) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, Calories) %>%
  
  ggplot(aes(x = time,
             y = Calories,
             group = day)
  )+
  geom_line(alpha = .1,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              color = "black",
              se = FALSE) +
  labs(title = "Hourly Calories Burned for an Individual",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Calories Burned Per Hour"
  )+
  geom_label(data = data.frame(day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 325,
             fill = "lightyellow",
             label.padding = unit(.7, "lines"))

# Hourly Calories Burned for the Whole Group
FitBit_hourlyData %>%
  select(Id, ActivityTime, Calories) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, Calories) %>%
  group_by(Id,time) %>%
  summarize(average_factor = mean(Calories)) %>%
  ungroup() %>%
  
  ggplot(aes(x = time,
             y = average_factor,
             group = Id)
  )+
  geom_line(alpha = .15,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              size = 2,
              color = "black",
              se = FALSE,
              span = .3)+
  geom_label(data = data.frame(Id = NA, day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 375,
             fill = "lightyellow",
             label.padding = unit(.7, "lines")
  )+
  labs(title = "Average Hourly Calories Burned for 35 People",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Calories Burned Per Hour"
  )


#--------------------------------------------------------------------------------------------------------#
# Hourly Intensities for an Individual
FitBit_hourlyData %>%
  select(Id, ActivityTime, TotalIntensity) %>%
  group_by(Id,ActivityTime) %>% 
  filter(Id == 1503960366) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, TotalIntensity) %>%
  
  ggplot(aes(x = time,
             y = TotalIntensity,
             group = day)
  )+
  geom_line(alpha = .1,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              color = "black",
              se = FALSE) +
  labs(title = "Hourly Exercise Intensity for an Individual",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Average Exercise Intensity"
  )+
  geom_label(data = data.frame(day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 160,
             fill = "lightyellow",
             label.padding = unit(.7, "lines"))


# Hourly Intensities for Whole Group
FitBit_hourlyData %>%
  select(Id, ActivityTime, TotalIntensity) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, TotalIntensity) %>%
  group_by(Id,time) %>%
  summarize(average_factor = mean(TotalIntensity)) %>%
  ungroup() %>%
  
  ggplot(aes(x = time,
             y = average_factor,
             group = Id)
  )+
  geom_line(alpha = .15,
            color = "darkblue") +
  geom_smooth(aes(group = "Id"),
              alpha = 1,
              size = 2,
              color = "black",
              se = FALSE,
              span = .3)+
  geom_label(data = data.frame(Id = NA, day = NA),
             label = "--- Average Line",
             size = 5,
             hjust = 0,
             vjust = 1,
             x = 1,
             y = 87.5,
             fill = "lightyellow",
             label.padding = unit(.7, "lines")
  )+
  labs(title = "Average Hourly Exercise Intensity for 35 People",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       x = "Time of Day",
       y = "Average Exercise Intensity"
  )


#--------------------------------------------------------------------------------------------------------#
# Weekend VS Weekday MET data, individual
FitBit_hourlyData %>%
  select(Id, ActivityTime, METs, DayOfWeek) %>%
  filter(Id == 1503960366) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  select(Id, day, time, METs, DayOfWeek) %>%
  mutate(Weekend = DayOfWeek %in% c("Saturday","Sunday")) %>%
  group_by(day,time,Weekend) %>%
  summarize(average_factor = mean(METs)) %>%
  ungroup() %>%
  
  ggplot(aes(x = time,
             y = average_factor,
             group = day,
             color = factor(Weekend, levels = c("TRUE","FALSE"), labels = c("WEEKEND","WEEKDAY")))
  )+
  geom_line(alpha = .2) +
  geom_smooth(aes(group = Weekend),
              alpha = 1,
              size = 1.5,
              se = FALSE,
              span = .2)+
  labs(title = "Weekend VS Weekday Hourly MET consumption for an individual",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       color = "Weekend",
       x = "Time of Day",
       y = "MET Consumption") +
  theme(axis.text.x = element_text(angle = 45))


# Weekend VS Weekday MET data, Group
FitBit_hourlyData %>%
  select(Id, ActivityTime, METs, DayOfWeek) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  
  select(Id, day, time, METs, DayOfWeek) %>%
  mutate(Weekend = DayOfWeek %in% c("Saturday","Sunday")) %>%
  group_by(Id,time,Weekend) %>%
  summarize(average_factor = mean(METs)) %>%
  ungroup() %>%
  
  ggplot(aes(x = time,
             y = average_factor,
             group = interaction(Id,Weekend),
             color = factor(Weekend, levels = c("TRUE","FALSE"), labels = c("WEEKEND","WEEKDAY")))
  )+
  geom_line(alpha = .2)+
  geom_smooth(aes(group = Weekend),
              alpha = 1,
              size = 1.5,
              se = FALSE,
              span = .2) +
  labs(title = "Average Weekend VS Weekday Hourly MET consumption for 35 People",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       color = "Weekend",
       x = "Time of Day",
       y = "MET Consumption") +
  theme(axis.text.x = element_text(angle = 45))


# Closer Look
FitBit_hourlyData %>%
  select(Id, ActivityTime, METs, DayOfWeek) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  
  select(Id, day, time, METs, DayOfWeek) %>%
  mutate(Weekend = DayOfWeek %in% c("Saturday","Sunday")) %>%
  group_by(Id,time,Weekend) %>%
  summarize(average_factor = mean(METs)) %>%
  ungroup() %>%
  
  ggplot(aes(x = time,
             y = average_factor,
             group = interaction(Id,Weekend),
             color = factor(Weekend, levels = c("TRUE","FALSE"), labels = c("WEEKEND","WEEKDAY")))
  )+
  geom_smooth(aes(group = Weekend),
              alpha = 1,
              size = 1.5,
              se = FALSE,
              span = .2) +
  labs(title = "Average Weekend VS Weekday Hourly MET consumption for 35 People",
       subtitle = "Spanning 3/12/2016 to 5/12/2016",
       color = "Weekend",
       x = "Time of Day",
       y = "MET Consumption") +
  theme(axis.text.x = element_text(angle = 45))

