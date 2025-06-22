library(tidyverse)
library(ggplot2)

# This documents contains the code used to investigate what might be important trends within the survey of 
# consumers' thoughts about wearable smart payment devices.  It requires data in the global environment from:
#  - (4 of 10) Cleaning Smart Payment Survey Data.R


#--------------------------------------------------------------------------------------------------------#
# age, gender vs all question categories
survey_smart_payment_sentiment %>%
  select(Age,
         Gender,
         perceived_usefulness_average,
         trust_average,
         lifestyle_fit_average,
         resource_availability_average,
         social_influence_average,
         intention_average,
         total_weighted_average) %>%
  group_by(Age,Gender) %>%
  pivot_longer(names_to = "scores",
               cols = c(perceived_usefulness_average:total_weighted_average)) %>%
  filter(scores != "total_weighted_average") %>%
  
  ggplot(aes(x = Age,
             y = ifelse(scores == "intention_average", value * 5/7, value),
             group_by(Age),
             fill = factor(Gender,levels = c("m","f"), labels = c("Male","Female"))
  ))+
  geom_boxplot(position = position_dodge(width = 0.8),
               staplewidth = 1) + 
  facet_wrap(~factor(scores,
                     levels = c("perceived_usefulness_average",
                                "trust_average",
                                "lifestyle_fit_average",
                                "resource_availability_average",
                                "social_influence_average",
                                "intention_average",
                                "total_weighted_average")
  )) + 
  labs(title = "The Effect of Age and Gender on Smart Payment Device Perception",
       fill = "Gender",
       y = "Scores")


#--------------------------------------------------------------------------------------------------------#
# Age, gender vs TOTALS
survey_smart_payment_sentiment %>%
  select(Age,
         Gender,
         total_weighted_average) %>%
  group_by(Age,Gender) %>%
  
  ggplot(aes(x = Age,
             y = total_weighted_average,
             group_by(Age),
             fill = factor(Gender,levels = c("m","f"), labels = c("Male","Female"))
  ))+
  geom_boxplot(position = position_dodge(width = 0.8),
               staplewidth = 1) + 
  labs(title = "The Effect of Age and Gender on Smart Payment Device Perception",
       fill = "Gender",
       y = "Scores")

# education vs all question categories
survey_smart_payment_sentiment %>%
  select(Education,
         perceived_usefulness_average,
         trust_average,
         lifestyle_fit_average,
         resource_availability_average,
         social_influence_average,
         intention_average,
         total_weighted_average) %>%
  group_by(Education) %>%
  pivot_longer(names_to = "scores",
               cols = c(perceived_usefulness_average:total_weighted_average)) %>%
  filter(scores != "total_weighted_average") %>%
  
  ggplot(aes(x = Education,
             y = ifelse(scores == "intention_average", value * 5/7, value),
             group_by(Age),
             fill = Education
  ))+
  geom_boxplot(position = position_dodge(width = 0.8),
               staplewidth = 1) + 
  facet_wrap(~factor(scores,
                     levels = c("perceived_usefulness_average",
                                "trust_average",
                                "lifestyle_fit_average",
                                "resource_availability_average",
                                "social_influence_average",
                                "intention_average",
                                "total_weighted_average")
  )) + 
  labs(title = "The Effect of Education on Smart Payment Device Perception",
       fill = "Education",
       y = "Scores") + 
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())


#--------------------------------------------------------------------------------------------------------#
# education vs TOTALS
survey_smart_payment_sentiment %>%
  select(Education,
         perceived_usefulness_average,
         trust_average,
         lifestyle_fit_average,
         resource_availability_average,
         social_influence_average,
         intention_average,
         total_weighted_average) %>%
  group_by(Education) %>%
  pivot_longer(names_to = "scores",
               cols = c(perceived_usefulness_average:total_weighted_average)) %>%
  filter(scores == "total_weighted_average") %>%
  
  ggplot(aes(x = Education,
             y = ifelse(scores == "intention_average", value * 5/7, value),
             group_by(Age),
             fill = Education
  ))+
  geom_boxplot(position = position_dodge(width = 0.8),
               staplewidth = 1) + 
  facet_wrap(~factor(scores,
                     levels = c("perceived_usefulness_average",
                                "trust_average",
                                "lifestyle_fit_average",
                                "resource_availability_average",
                                "social_influence_average",
                                "intention_average",
                                "total_weighted_average")
  )) + 
  labs(title = "The Effect of Education on Smart Payment Device Perception",
       fill = "Education",
       y = "Scores") + 
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())


#--------------------------------------------------------------------------------------------------------#
# income vs all question categories
survey_smart_payment_sentiment %>%
  select(Average_montly_income,
         perceived_usefulness_average,
         trust_average,
         lifestyle_fit_average,
         resource_availability_average,
         social_influence_average,
         intention_average,
         total_weighted_average) %>%
  group_by(Average_montly_income) %>%
  pivot_longer(names_to = "scores",
               cols = c(perceived_usefulness_average:total_weighted_average)) %>%
  filter(scores != "total_weighted_average") %>%
  
  ggplot(aes(x = Average_montly_income,
             y = ifelse(scores == "intention_average", value * 5/7, value),
             group_by(Age),
             fill = Average_montly_income
  ))+
  geom_boxplot(position = position_dodge(width = 0.8),
               staplewidth = 1) + 
  facet_wrap(~factor(scores,
                     levels = c("perceived_usefulness_average",
                                "trust_average",
                                "lifestyle_fit_average",
                                "resource_availability_average",
                                "social_influence_average",
                                "intention_average",
                                "total_weighted_average")
  )) + 
  labs(title = "The Effect of Income on Smart Payment Device Perception",
       fill = "Average Monthly\nIncome (In RM)",
       y = "Scores") + 
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())


#--------------------------------------------------------------------------------------------------------#
# income vs TOTALS
survey_smart_payment_sentiment %>%
  select(Average_montly_income,
         perceived_usefulness_average,
         trust_average,
         lifestyle_fit_average,
         resource_availability_average,
         social_influence_average,
         intention_average,
         total_weighted_average) %>%
  group_by(Average_montly_income) %>%
  pivot_longer(names_to = "scores",
               cols = c(perceived_usefulness_average:total_weighted_average)) %>%
  filter(scores == "total_weighted_average") %>%
  
  ggplot(aes(x = Average_montly_income,
             y = ifelse(scores == "intention_average", value * 5/7, value),
             group_by(Age),
             fill = Average_montly_income
  ))+
  geom_boxplot(position = position_dodge(width = 0.8),
               staplewidth = 1) + 
  facet_wrap(~factor(scores,
                     levels = c("perceived_usefulness_average",
                                "trust_average",
                                "lifestyle_fit_average",
                                "resource_availability_average",
                                "social_influence_average",
                                "intention_average",
                                "total_weighted_average")
  )) + 
  labs(title = "The Effect of Income on Smart Payment Device Perception",
       fill = "Average Monthly\nIncome (In RM)",
       y = "Scores") + 
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())
