library(tidyverse)
library(ggplot2)
library(scales)

# This documents contains the code used to create the visuals for the presentation.  It requires data
# in the global environment from:
# 1) (1 of 10) Cleaning Ad Click Success Rate Data.R
# 2) (3 of 10) Cleaning Fitbit Data.R


#--------------------------------------------------------------------------------------------------------#
# Demonstrates the average hourly intensity so that we can investigate the difference between the peaks
average_intensities <- FitBit_hourlyData %>%
  select(ActivityTime, AverageIntensity) %>%
  mutate(time = format(ActivityTime, "%H:%M")) %>%
  select(time, AverageIntensity) %>%
  group_by(time) %>%
  summarize(average_in_hour = mean(AverageIntensity)) %>%
  arrange(desc(average_in_hour)) 

ggplot(data = average_intensities, aes(x = time, y = average_in_hour, group = 1)) + 
  geom_line() + 
  theme(axis.text.x = element_text(angle= 45 , vjust = .8))


# Difference in peaks (7pm vs 12pm)
average_intensities
average_intensities$average_in_hour[1] / average_intensities$average_in_hour[4] 
average_intensities$average_in_hour[1] / mean(average_intensities$average_in_hour)


#--------------------------------------------------------------------------------------------------------#
# Demonstrate the 3 peak days of exercise activity
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
  group_by(day) %>%
  summarize(dist = mean(AverageDistance)) %>%
  
  ggplot(aes(x = factor(day,
                        levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")
                        ),
             y = dist,
             group = 1
             )
         ) +
  geom_line(size = 2, color = rgb(99/256,210/256,151/256)) +
  ylim(2000,2500)+
  geom_hline(data = .%>% filter(day == "Saturday"),
             aes(yintercept = dist),
             size = 2,
             alpha = 0.6,
             linetype = "dashed"
             ) +
  theme_bw()+
  labs(caption = "Data sourced from: https://zenodo.org/records/53894#.YMoUpnVKiP9",
       x = "",
       y = "Average Calories Burned in a Day\n",
       fill = "Week Of \nObservation"
  )


#--------------------------------------------------------------------------------------------------------#
# Demonstrate the peak exercise hours
peak_exercise_hours <- FitBit_hourlyData %>%
  select(Id, ActivityTime, METs, DayOfWeek) %>%
  group_by(Id,ActivityTime) %>%
  mutate(time = format(ActivityTime, "%H:%M"),
         day = format(ActivityTime, "%D")) %>%
  ungroup() %>%
  
  select(Id, day, time, METs, DayOfWeek) %>%
  mutate(Weekend = DayOfWeek %in% c("Saturday","Sunday")) %>%
  group_by(Id,time,Weekend) %>%
  summarize(average_factor = mean(METs)) %>%
  ungroup()

peak_exercise_hours %>%
  ggplot(aes(x = time,
             y = average_factor,
             group = interaction(Id,Weekend),
             color = factor(Weekend, levels = c("TRUE","FALSE"), labels = c("WEEKEND","WEEKDAY"))),
  )+
  geom_smooth(aes(group = Weekend),
              size = 1.5,
              se = FALSE,
              span = .2) +
  labs(caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",color = "Weekend",
       x = "Time of Day",
       y = "MET Consumption",
       ) +
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45,vjust = 0.7))


#--------------------------------------------------------------------------------------------------------#
# Demonstrate CTRs for our target age group
ad_CTR_data <- ad_click_df %>%
  group_by(time_of_day,
           gender,
           age = paste0("AGE: ", cut(age,seq(15,65,by = 10))),
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(time_of_day,gender,age,ctr) %>%
  filter(gender == "Female") %>%
  filter(! age %in% c("AGE: (55,65]"))
  
ad_CTR_data %>%
  ggplot(aes(x = factor(time_of_day, c("Morning","Afternoon","Evening","Night")),
             y = ctr,
             fill = age,
  )) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  facet_wrap(~age) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1)), vjust = 1.5, color = "white", ) +
  labs(caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "",
       y = "Click Through Rate\n",
       fill = "Age") + 
  geom_rect(data = data.frame(age = "AGE: (25,35]", time_of_day = "Night", ctr = 1),
            xmin = -Inf,
            ymin = -Inf,
            xmax = Inf,
            ymax = Inf,
            color = "red",
            fill = NA,
            size = 2
            ) +
  ylim(0,0.6)+
  guides(fill = "none")


#--------------------------------------------------------------------------------------------------------#
# Demonstrate the categories with different advertisement opportunities to explore
browsing_history_CTR_data <- ad_click_df %>%
  group_by(gender,
           browsing_history,
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(browsing_history,gender,ctr, observations,click) %>%
  filter(gender == "Female") %>%
  filter(click == "click")
  

# These categories are covered by current marketing techniques
browsing_history_CTR_data %>%  
  ggplot(aes(x = reorder(browsing_history, -observations),
             fill = ctr
  )) +
  scale_fill_gradient(limits = c(.2,.45), oob = squish) +
  geom_bar( aes(y = observations),
            stat = "identity", position = "dodge", color = "black") +
  geom_bar( aes(y = observations * ctr),
            stat = "identity", position = "dodge", color = "black", fill = "white", alpha = .55) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1), y = ctr*observations),
            vjust = 1.5,
            color = "black",
            size = 8
  ) +
  geom_text(label = "CTR:",
            x = 1,
            y = 12,
            color = "white",
            size = 8)+
  geom_rect(data = data.frame(browsing_history = "Entertainment", observations = NA, ctr = 0),
            xmin = 2.5,
            ymin = -1,
            xmax = 5.5,
            ymax = 32,
            color = "red",
            size = 2,
            fill = NA) +
  geom_rect(data = data.frame(browsing_history = "Entertainment", observations = NA, ctr = 0),
            xmin = .5,
            ymin = -1,
            xmax = 1.5,
            ymax = 42,
            color = "red",
            size = 2,
            fill = NA) +
  labs(caption = "Data sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "",
       y = "Clicks / Total Ads Shown\n",
       fill = "CTR") +
  theme_bw()


# This category has potentially better advertisement techniques to explore
browsing_history_CTR_data %>%  
  ggplot(aes(x = reorder(browsing_history, -observations),
             fill = ctr
  )) +
  scale_fill_gradient(limits = c(.2,.45), oob = squish) +
  geom_bar( aes(y = observations),
            stat = "identity", position = "dodge", color = "black") +
  geom_bar( aes(y = observations * ctr),
            stat = "identity", position = "dodge", color = "black", fill = "white", alpha = .55) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1), y = ctr*observations),
            vjust = 1.5,
            color = "black",
            size = 8
  ) +
  geom_text(label = "CTR:",
            x = 1,
            y = 12,
            color = "white",
            size = 8)+
  geom_rect(data = data.frame(browsing_history = "Entertainment", observations = NA, ctr = 0),
            xmin = 1.5,
            ymin = -1,
            xmax = 2.5,
            ymax = 35,
            color = "red",
            size = 2,
            fill = NA) +
  labs(caption = "Data sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "",
       y = "Clicks / Total Ads Shown\n",
       fill = "CTR") +
  theme_bw()

#--------------------------------------------------------------------------------------------------------#
# Environment cleanup specific to this R document
rm(average_intensities)
rm(browsing_history_CTR_data)
rm(ad_CTR_data)
rm(peak_exercise_hours)