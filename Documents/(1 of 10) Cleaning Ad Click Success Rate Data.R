library(tidyverse)
library(dplyr)
library(tidyr)

ad_click_df <- ad_click_df <- read.csv("../Desktop/ad_click_dataset.csv",
                                       header= TRUE,
                                       sep = ',',
                                       na.strings = c(""," ", "NA")
                                       )

# We expect to get 816 non-null rows, and 440 non-null and unique rows
count(drop_na(ad_click_df))
table(duplicated(drop_na(ad_click_df)))


# Transform the click to a readable format
ad_click_df <- ad_click_df %>%
  mutate(click, click = factor(click, levels = c(0,1), labels = c("no click","click")))

# 3500 Non-Duplicated Values
ad_click_df['id'] %>%
  add_count(id) %>%
  filter(n == 1) %>%
  summarize(count = n())


# 6500 Duplicated Rows
ad_click_df['id'] %>%
  add_count(id) %>%
  filter(n > 1) %>%
  summarize(count = n())

uniques <- ad_click_df['id'] %>%
  add_count(id) %>%
  filter(n == 1)
duplicates <- ad_click_df['id'] %>%
  add_count(id) %>%
  filter(n > 1)

# 140 Unique and Non-NA rows within the duplicates
no_na_in_duplicates <- drop_na(subset(ad_click_df,ad_click_df$id %in% duplicates$id))
count(no_na_in_duplicates[!duplicated(no_na_in_duplicates), ])

# 300 Unique and Non-NA rows within the uniques
no_na_in_uniques <- drop_na(subset(ad_click_df, ad_click_df$id %in% uniques$id))
count(no_na_in_uniques)

# We can see that we could interpolate some N/A values from duplicated entries
# This is ignored as duplicate entries seem to be fully duplicated, meaning any NAs can be ignored
# A few might slip through this way, but our final count is still good enough to work with
subset(ad_click_df, ad_click_df$id %in% head(duplicates,1)$id)
subset(ad_click_df, ad_click_df$id %in% arrange(duplicates,-n)$id[6499])

# Create a dataframe without duplicates and without NAs
no_dupes <- ad_click_df[!duplicated(ad_click_df),]
ad_click_df <-drop_na(no_dupes)

# Removal of unnecessary Columns
ad_click_df <- ad_click_df[c('age',
                             'gender',
                             "device_type",
                             "browsing_history",
                             "time_of_day",
                             "click"
                             )]

rm(duplicates,no_dupes,no_na_in_duplicates,no_na_in_uniques,uniques)