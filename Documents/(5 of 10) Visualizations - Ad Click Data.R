library(tidyverse)
library(ggplot2)
library(tidytext)

# This documents contains the code used to investigate what might be important trends within the successful ad
# click data.  It requires data in the global environment from:
#  - (1 of 10) Cleaning Ad Click Success Rate Data.R


#--------------------------------------------------------------------------------------------------------#
# gender vs time of day of successful, unsuccessful clicks
# V1
ad_click_df %>%
  group_by(time_of_day,gender,click) %>%
  summarize(factorcount = n()) %>%
  ggplot(aes(x = factor(time_of_day, c("Morning","Afternoon","Evening","Night")),
             y = factorcount,
             group = gender,
             color = gender,
             linetype = (gender != "Female")
  )) +
  geom_point(size = 4) +
  geom_line(size = 2) +
  facet_wrap(~click)

# V2
ad_click_df %>%
  group_by(time_of_day,gender,click) %>%
  summarize(factorcount = n()) %>%
  ungroup() %>%
  pivot_wider(names_from = "click", values_from = factorcount) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`,`observations`)) %>%
  ggplot(aes(x = factor(time_of_day, c("Morning","Afternoon","Evening","Night")),
             y = value,
             alpha = (click == "click"),
             fill = gender)) +
  scale_alpha_manual(name = "Ad Click (alpha)", labels = c("Total Observations", "Clicked Through"),values = c("TRUE" = 1, "FALSE" = 0.35))+
  geom_col(data = .%>% filter(click == "click"), position = "dodge")+
  geom_col(data = .%>% filter(click == "observations"), position = "dodge") +
  geom_text(aes(label = ifelse(click =="click",
                               scales::percent(ctr, accuracy = 1),
                               ""), 
                group = gender),
            position = position_dodge(0.9),
            vjust = 2, 
            color = "white",
            size = 5,
            alpha = 1
  ) +  
  geom_text(aes(label = ifelse(click =="observations",
                               value,
                               ""), 
                group = gender),
            position = position_dodge(0.9),
            vjust = -.2, 
            color = "black",
            size = 5,
            alpha = 1
  ) +
  labs(title = "Gender-Based Ad Click-Through Rates", x = "Time Of Day", y = "Occurrences", fill = "Gender") +
  theme(axis.title = element_text(size = 12))


#--------------------------------------------------------------------------------------------------------#
## Age, Gender vs Time of day of successful clicks
# Female Slice
ad_click_df %>%
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
  ggplot(aes(x = factor(time_of_day, c("Morning","Afternoon","Evening","Night")),
             y = ctr,
             fill = age,
  )) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  facet_wrap(~age) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1)), vjust = 1.5, color = "white", ) +
  labs(title = "Click Through Rates for Female Users, Based on Age",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Time Of Day",
       y = "Click Through Rate",
       fill = "Age") + 
  guides(fill = "none")

# Male Slice
ad_click_df %>%
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
  filter(gender == "Male") %>%
  ggplot(aes(x = factor(time_of_day, c("Morning","Afternoon","Evening","Night")),
             y = ctr,
             fill = age
  )) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  facet_wrap(~age) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1)), vjust = 1.5, color = "white") +
  labs(title = "Click Through Rates for Male Users, Based on Age",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Time Of Day",
       y = "Click Through Rate",
       fill = "Age") + 
  guides(fill = "none")

# Non-Binary Slice
ad_click_df %>%
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
  filter(gender == "Non-Binary") %>%
  ggplot(aes(x = factor(time_of_day, c("Morning","Afternoon","Evening","Night")),
             y = ctr,
             fill = age
  )) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  facet_wrap(~age) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1)), vjust = 1.5, color = "white") +
  labs(title = "Click Through Rates for Non-Binary Users, Based on Age",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Time Of Day",
       y = "Click Through Rate",
       fill = "Age") + 
  guides(fill = "none")

# No Gender Slice
ad_click_df %>%
  group_by(time_of_day,
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
  select(time_of_day,age,ctr) %>%
  ggplot(aes(x = factor(time_of_day, c("Morning","Afternoon","Evening","Night")),
             y = ctr,
             fill = age
  )) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  facet_wrap(~age) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1)), vjust = 1.5, color = "white") +
  labs(title = "Click Through Rates for All Users, Based on Age",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Time Of Day",
       y = "Click Through Rate",
       fill = "Age") + 
  guides(fill = "none")


#--------------------------------------------------------------------------------------------------------#
## Age, gender vs browsing history of successful, unsuccessful clicks
# FEMALE
ad_click_df %>%
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
  filter(click == "click") %>%
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
  labs(title = "Browsing History vs Click Through Rate (CTR), Female Slice",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Browsing History",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")


# MALE
ad_click_df %>%
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
  filter(gender == "Male") %>%
  filter(click == "click") %>%
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
            y = 14,
            color = "white",
            size = 8)+
  labs(title = "Browsing History vs Click Through Rate (CTR), Male Slice",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Browsing History",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")


# Non-Binary
ad_click_df %>%
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
  filter(gender == "Non-Binary") %>%
  filter(click == "click") %>%
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
            y = 10,
            color = "white",
            size = 8)+
  labs(title = "Browsing History vs Click Through Rate (CTR), Non-Binary Slice",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Browsing History",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")

# No Gender
ad_click_df %>%
  group_by(browsing_history,
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(browsing_history,ctr, observations,click) %>%
  filter(click == "click") %>%
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
            y = 30,
            color = "white",
            size = 8)+
  labs(title = "Browsing History vs Click Through Rate (CTR), Combined Gender Slice",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Browsing History",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")

# AGE FACETS
ad_click_df %>%
  group_by(age = paste0("AGE: ", cut(age,seq(15,65,by = 10))),
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
  select(browsing_history,ctr, observations,click) %>%
  filter(click == "click") %>%
  ggplot(aes(x = reorder_within(browsing_history, within = age, by = -observations),
             fill = ctr
  )) +
  scale_fill_gradient(limits = c(.2,.45), oob = squish) +
  geom_bar( aes(y = observations),
            stat = "identity", position = "dodge", color = "black") +
  geom_bar( aes(y = observations * ctr),
            stat = "identity", position = "dodge", color = "black", fill = "white", alpha = .55) +
  geom_text(aes(label = scales::percent(ctr, accuracy = 1), y = ctr*observations),
            vjust = "top",
            color = "black",
            size = 3,
  ) +
  scale_x_reordered() +
  facet_wrap(~age, scales = "free_x")+
  labs(title = "Browsing History vs Click Through Rate (CTR), Sliced By Age",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Browsing History",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


#--------------------------------------------------------------------------------------------------------#
## Gender, Age vs Device Type
# FEMALE Slice
ad_click_df %>%
  group_by(gender,
           device_type,
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(device_type,ctr, observations,click) %>%
  filter(click == "click") %>%
  filter(gender == "Female") %>%
  ggplot(aes(x = reorder(device_type, -observations),
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
            y = 24,
            color = "white",
            size = 8)+
  labs(title = "Device Type vs Click Through Rate (CTR), Female Slice",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Device Type",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")

# MALE Slice
ad_click_df %>%
  group_by(gender,
           device_type,
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(device_type,ctr, observations,click) %>%
  filter(click == "click") %>%
  filter(gender == "Male") %>%
  ggplot(aes(x = reorder(device_type, -observations),
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
            y = 25,
            color = "white",
            size = 8)+
  labs(title = "Device Type vs Click Through Rate (CTR), Male Slice",
       x = "Device Type",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")

# Non-Binary Slice
ad_click_df %>%
  group_by(gender,
           device_type,
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(device_type,ctr, observations,click) %>%
  filter(click == "click") %>%
  filter(gender == "Non-Binary") %>%
  ggplot(aes(x = reorder(device_type, -observations),
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
            y = 25,
            color = "white",
            size = 8)+
  labs(title = "Device Type vs Click Through Rate (CTR), Non-Binary Slice",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Device Type",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")


# No Gender
ad_click_df %>%
  group_by(device_type,
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(device_type,ctr, observations,click) %>%
  filter(click == "click") %>%
  ggplot(aes(x = reorder(device_type, -observations),
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
            y = 55,
            color = "white",
            size = 8)+
  labs(title = "Device Type vs Click Through Rate (CTR), Combined Gender Slice",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Device Type",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")

# AGE FACETS
ad_click_df %>%
  group_by(age = paste0("AGE: ", cut(age,seq(15,65,by = 10))),
           device_type,
           click
  ) %>%
  summarize(factorcount = n()) %>%
  pivot_wider(names_from = "click", values_from = factorcount, values_fill = 0) %>%
  mutate(observations = rowSums(across(c(`no click`, "click"))),
         ctr = click / observations,
         ctf = `no click` / observations
  ) %>%
  pivot_longer(names_to = "click", cols= c("click",`no click`), values_to= "factorcount") %>%
  select(device_type,ctr, observations,click) %>%
  filter(click == "click") %>%
  ggplot(aes(x = reorder_within(device_type, within = age, by = -observations),
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
            size = 3,
  ) +
  scale_x_reordered() +
  facet_wrap(~age, scales = "free_x")+
  labs(title = "Device Type vs Click Through Rate (CTR), Age Slice Facets",
       caption = "\nData sourced from: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data",
       x = "Device Type",
       y = "Clicks / Total Ads Shown",
       fill = "CTR")+
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

