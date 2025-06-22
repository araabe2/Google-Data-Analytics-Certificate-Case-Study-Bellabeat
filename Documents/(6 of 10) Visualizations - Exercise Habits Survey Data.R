library(tidyverse)
library(ggplot2)

# This documents contains the code used to investigate what might be important trends within the survey of user
# exercise habits dataset.  It requires data in the global environment from:
#  - (2 of 10) Cleaning Exercise Habits Survey Data.R


#--------------------------------------------------------------------------------------------------------#
# age, gender vs preferred exercise time
exercise_habits_survey_df %>%
  select(gender,
         age,
         prefered_exercise_time
  ) %>%
  group_by(gender,age,prefered_exercise_time) %>%
  summarize(factor_count = n()) %>%
  ungroup()%>%
  complete(gender, age, prefered_exercise_time, fill = list(factor_count = 0), explicit = TRUE) %>%
  group_by(gender,age) %>%
  mutate(gender_groups = sum(factor_count),
         factor_scaled_to_100 = factor_count * 100 / gender_groups) %>%
  group_by(gender,prefered_exercise_time) %>%
  mutate(factor_scaled_Totals = sum(factor_scaled_to_100)) %>%
  
  ggplot(aes(x = factor(prefered_exercise_time, c("Early morning", "Afternoon", "Evening")),
             group = age,
             color = age))+
  geom_line(aes(y = factor_scaled_to_100), size = 2, linetype = "dashed")+
  geom_line(aes(y = factor_scaled_Totals), size = 2, alpha = .3, color = "black")+
  facet_wrap(~gender,) +
  labs(title = "Prefered Exercise Time, Based on Age and Gender",
       x = "Time of Day",
       y = "Responses (Scaled to be Out of 100 for Each Age Group)\n",
       color = "Age") +
  geom_text(label = "Scaled Total",
            data = data.frame(age = c(NA,NA),gender= c("Female","Male")),
            x = c(3.5,3.5),
            y = c(225,150),
            hjust = 1,
            vjust = 0,
            size = 5,
            color = "black"
  )


#--------------------------------------------------------------------------------------------------------#
# age, gender vs importance of exercise
exercise_habits_survey_df %>%
  select(gender,
         age,
         personal_exercise_importance
  ) %>%
  group_by(gender,age,personal_exercise_importance) %>%
  summarize(factor_count = n()) %>%
  ungroup()%>%
  complete(gender, age, personal_exercise_importance, fill = list(factor_count = 0), explicit = TRUE) %>%
  group_by(gender,age) %>%
  mutate(gender_groups = sum(factor_count),
         factor_scaled_to_100 = factor_count * 100 / gender_groups) %>%
  group_by(gender,personal_exercise_importance) %>%
  mutate(factor_scaled_Totals = sum(factor_scaled_to_100)) %>%
  
  ggplot(aes(x = personal_exercise_importance,
             group = age,
             color = age))+
  geom_line(aes(y = factor_scaled_to_100), size = 2, linetype = "twodash")+
  geom_line(aes(y = factor_scaled_Totals), size = 2, alpha = .3, color = "black")+
  facet_wrap(~gender,) +
  labs(title = "Personal Value Placed on Exercise, Based on Age and Gender",
       x = "Perceived Exercise Importance (5 is 'Most Important')",
       y = "Responses (Scaled to be Out of 100 for Each Age Group)\n",
       color = "Age") +
  geom_text(label = "Scaled Total",
            data = data.frame(age = c(NA,NA),gender= c("Female","Male")),
            x = c(5,5),
            y = c(125,100),
            hjust = 1,
            vjust = 0,
            size = 5,
            color = "black"
  )


#--------------------------------------------------------------------------------------------------------#
# age, gender vs exercise frequency
exercise_habits_survey_df %>%
  select(gender,
         age,
         exercise_frequency
  ) %>%
  group_by(gender,age,exercise_frequency) %>%
  summarize(factor_count = n()) %>%
  ungroup()%>%
  complete(gender, age, exercise_frequency, fill = list(factor_count = 0), explicit = TRUE) %>%
  group_by(gender,age) %>%
  mutate(gender_groups = sum(factor_count),
         factor_scaled_to_100 = factor_count * 100 / gender_groups) %>%
  group_by(gender,exercise_frequency) %>%
  mutate(factor_scaled_Totals = sum(factor_scaled_to_100)) %>%
  
  ggplot(aes(x = factor(exercise_frequency,
                        levels = c("Never","1 to 2 times a week","2 to 3 times a week","3 to 4 times a week","4 to 5 times a week","5 to 6 times a week", "Everyday"),
                        labels = c("0","1-2","2-3","3-4","4-5","5-6","7")
  ),
  group = age,
  color = age))+
  geom_line(aes(y = factor_scaled_to_100), size = 2, linetype = "twodash")+
  geom_line(aes(y = factor_scaled_Totals), size = 2, alpha = .3, color = "black")+
  facet_wrap(~gender,) +
  labs(title = "Weekly Exercise Frequency, Based on Age and Gender",
       x = "Reported Days of Exercise Per Week",
       y = "Responses (Scaled to be Out of 100 for Each Age Group)\n",
       color = "Age") +
  geom_text(label = "Scaled Total",
            data = data.frame(age = c(NA,NA),gender= c("Female","Male")),
            x = c(6,6),
            y = c(70,90),
            hjust = 1,
            vjust = 0,
            size = 5,
            color = "black"
  )


#--------------------------------------------------------------------------------------------------------#
# age, gender vs exercise per day
exercise_habits_survey_df %>%
  select(gender,
         age,
         exercise_per_day
  ) %>%
  group_by(gender,age,exercise_per_day) %>%
  summarize(factor_count = n()) %>%
  ungroup()%>%
  complete(gender, age, exercise_per_day, fill = list(factor_count = 0), explicit = TRUE) %>%
  group_by(gender,age) %>%
  mutate(gender_groups = sum(factor_count),
         factor_scaled_to_100 = factor_count * 100 / gender_groups) %>%
  group_by(gender,exercise_per_day) %>%
  mutate(factor_scaled_Totals = sum(factor_scaled_to_100)) %>%
  
  ggplot(aes(x = factor(exercise_per_day,
                        levels = c("I don't really exercise","30 minutes", "1 hour", "2 hours","3 hours and above"),
                        labels = c("0", "30", "60", "120", "180+")
  ),
  group = age,
  color = age))+
  geom_line(aes(y = factor_scaled_to_100), size = 2, linetype = "twodash")+
  geom_line(aes(y = factor_scaled_Totals), size = 2, alpha = .3, color = "black")+
  facet_wrap(~gender,) +
  labs(title = "Daily Exercise Total, Based on Age and Gender",
       x = "Reported Total Exercise Per Day (In Minutes)",
       y = "Responses (Scaled to be Out of 100 for Each Age Group)\n",
       color = "Age") +
  geom_text(label = "Scaled Total",
            data = data.frame(age = c(NA,NA), gender= c("Female","Male")),
            x = c(5,5),
            y = c(140,175),
            hjust = 1,
            vjust = 0,
            size = 5,
            color = "black"
  )


#--------------------------------------------------------------------------------------------------------#
# age, gender vs exercise grouping
exercise_habits_survey_df %>%
  select(gender,
         age,
         exercise_grouping
  ) %>%
  group_by(gender,age,exercise_grouping) %>%
  summarize(factor_count = n()) %>%
  ungroup()%>%
  complete(gender, age, exercise_grouping, fill = list(factor_count = 0), explicit = TRUE) %>%
  group_by(gender,age) %>%
  mutate(gender_groups = sum(factor_count),
         factor_scaled_to_100 = factor_count * 100 / gender_groups) %>%
  group_by(gender,exercise_grouping) %>%
  mutate(factor_scaled_Totals = sum(factor_scaled_to_100)) %>%
  
  ggplot(aes(x = factor(exercise_grouping,
                        levels = c("I don't really exercise", "Alone", "With a friend", "With a group", "Within a class environment"),
                        labels = c("No \nExercise","As an \nIndividual","With a\nFriend", "As a\nGroup", "With a\n class")
  ),
  group = age,
  color = age))+
  geom_line(aes(y = factor_scaled_to_100), size = 2,linetype = "twodash")+
  geom_line(aes(y = factor_scaled_Totals), size = 2, alpha = .3, color = "black")+
  facet_wrap(~gender,) +
  labs(title = "Primary Exercise Grouping, Based on Age and Gender",
       x = "Usual Exercise Grouping",
       y = "Responses (Scaled to be Out of 100 for Each Age Group)\n",
       color = "Age") +
  geom_text(label = "Scaled Total",
            data = data.frame(age = c(NA,NA), gender= c("Female","Male")),
            x = c(4.75,4.75),
            y = c(130,130),
            hjust = 1,
            vjust = 0,
            size = 5,
            color = "black"
  )


#--------------------------------------------------------------------------------------------------------#
# age, gender vs previous health equipment purchase
exercise_habits_survey_df %>%
  select(gender,
         age,
         past_fitness_equipment_purchase
  ) %>%
  group_by(gender,age,past_fitness_equipment_purchase) %>%
  summarize(factor_count = n()) %>%
  ungroup()%>%
  complete(gender, age, past_fitness_equipment_purchase, fill = list(factor_count = 0), explicit = TRUE) %>%
  group_by(gender,age) %>%
  mutate(gender_groups = sum(factor_count),
         factor_scaled_to_100 = factor_count * 100 / gender_groups) %>%
  group_by(gender,past_fitness_equipment_purchase) %>%
  mutate(factor_scaled_Totals = sum(factor_scaled_to_100)) %>%
  filter(past_fitness_equipment_purchase == "Yes") %>%
  
  ggplot(aes(x = gender,
             group = age,
             color = age))+
  geom_line(aes(y = factor_scaled_to_100), size = 2,)+
  geom_line(aes(y = factor_scaled_Totals), size = 2, alpha = .3, color = "black")+
  labs(title = "Past Health Equipment Purchase, Based on Age and Gender",
       subtitle = "Filtered for People with Confirmed Purchases",
       x = "Gender",
       y = "Responses (Scaled to be Out of 100 for Each Age Group)\n",
       color = "Age") +
  geom_text(label = "Scaled Total",
            data = data.frame(age = c(NA,NA)),
            x = 2.35,
            y = 160,
            hjust = 1,
            size = 5,
            color = "black"
  )


#--------------------------------------------------------------------------------------------------------#
# age, gender vs form of exercise
exercise_habits_survey_df %>%
  select(gender,
         age,
         form_none,
         form_walking_or_jogging,
         form_gym,
         form_team_sport,
         form_yoga,
         form_swimming,
         form_weights,
         form_zumba
  ) %>%
  group_by(gender, age) %>%
  mutate(age_range_count = n()) %>%
  pivot_longer(cols = c(form_none,
                        form_walking_or_jogging,
                        form_gym,
                        form_team_sport,
                        form_yoga,
                        form_swimming,
                        form_weights,
                        form_zumba),
               names_to = "form"
  )%>%
  filter(value == TRUE) %>%
  select(gender,age,form, age_range_count) %>%
  group_by(gender,age,age_range_count, form) %>%
  summarize(factorcount = n()) %>%
  mutate(factor_scaled_to_100 = factorcount * 100/ age_range_count) %>%
  ungroup() %>%
  select(gender,age, form, factor_scaled_to_100) %>%    
  complete(gender, age, form, fill = list(factor_scaled_to_100 = 0), explicit = TRUE) %>%
  
  ggplot(aes(y = factor(form,
                        levels = c("form_gym",
                                   "form_none",
                                   "form_swimming",
                                   "form_team_sport",
                                   "form_walking_or_jogging",
                                   "form_weights",
                                   "form_yoga",
                                   "form_zumba"),
                        labels = c("gym",
                                   "none",
                                   "swimming",
                                   "team \nsport",
                                   "walking or \njogging",
                                   "weights",
                                   "yoga",
                                   "zumba")
  ),
  x = factor(age, 
             level = c("15 to 18", "19 to 25", "26 to 30", "30 to 40", "40 and above"),
             label = c("15 to 18", "19 to 25", "26 to 30", "30 to 40", "40+")),
  fill = factor_scaled_to_100)) + 
  geom_tile() + 
  scale_fill_gradient2(low = "darkred", mid = "white", high = "darkblue", midpoint = 35)+
  facet_wrap(~gender)+
  labs(title = "Exercise Form Participation, Based on Age and Gender",
       subtitle = "Chance for Someone Within Any Age Range to Select Any Exercise Form (Independent Chances)",
       x = "Age Range",
       y = "Exercise Form\n",
       fill = "Chance to \nSelect (%) ")



#--------------------------------------------------------------------------------------------------------#
# exercise importance vs exercise frequency
exercise_habits_survey_df %>%
  select(personal_exercise_importance,
         exercise_frequency
  ) %>%
  group_by(personal_exercise_importance,exercise_frequency) %>%
  summarize(factorcount = n()) %>%
  ungroup()%>%
  complete(personal_exercise_importance, exercise_frequency, fill = list(factorcount = 0), explicit = TRUE) %>%
  group_by(personal_exercise_importance) %>%
  arrange(factor(exercise_frequency,
                 levels = c("Never","1 to 2 times a week","2 to 3 times a week","3 to 4 times a week","4 to 5 times a week","5 to 6 times a week", "Everyday"),
                 labels = c("0","1-2","2-3","3-4","4-5","5-6","7")),
          .by_group = TRUE) %>%
  mutate(factorTotals = sum(factorcount),
         cumTotals = cumsum(factorcount)
  ) %>%
  
  ggplot(aes(x = factor(exercise_frequency,
                        levels = c("Never","1 to 2 times a week","2 to 3 times a week","3 to 4 times a week","4 to 5 times a week","5 to 6 times a week", "Everyday"),
                        labels = c("0","1-2","2-3","3-4","4-5","5-6","7")
  ),
  group = personal_exercise_importance,
  color = factor(personal_exercise_importance)))+
  
  geom_line(aes(y = (cumTotals/factorTotals * 100)),
            size = 2)+
  
  labs(title = "Impact of Perceived Exercise Value on Exercise Frequency",
       subtitle = "Chance of having completed all exercise plans after [Reported Days of Exercise Per Week]",
       x = "\n Reported Days of Exercise Per Week (Cumulative Sum)",
       y = "Chance ( % )\n",
       color = "Exercise \nImportance \nRating")  +
  geom_label(data = data.frame(personal_exercise_importance = NA),
             aes(label = "The further right the line is,\n the more exercise being done.",
                 x = 6.5,
                 y = 15,
             ),
             vjust = "bottom",
             hjust = "right",
             color = "black",
             size = 6,
             fill = "lightyellow",
             label.padding = unit(.7, "lines"))
