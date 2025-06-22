library(tidyverse)
library(dplyr)
library(tidyr)

exercise_habits_survey_df <- read.csv("../Desktop/545_acquaintances_fitness_analysis.csv",header = TRUE, sep = ",")

# No duplicates or NA values
count(drop_na(exercise_habits_survey_df))
table(duplicated(drop_na(exercise_habits_survey_df)))

for (col in colnames(exercise_habits_survey_df)){
  print(table(exercise_habits_survey_df[col]))
}

## Columns of interest:
# Your.gender
# Your.age
# How.important.is.exercise.to.you..
# How.do.you.describe.your.current.level.of.fitness..
# How.often.do.you.exercise.
# What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.
# What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.
# Do.you.exercise.___________..
# What.time.if.the.day.do.you.prefer.to.exercise.
# How.long.do.you.spend.exercising.per.day..
# Would.you.say.you.eat.a.healthy.balanced.diet..
# How.healthy.do.you.consider.yourself.
# Have.you.ever.purchased.a.fitness.equipment.

# Several Columns need unzipping:
table(exercise_habits_survey_df$What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.)
table(exercise_habits_survey_df$What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.)

# Exercise Barriers answers are: (Lifted from a Google sheets text split and collation)
# I don't have enough time
# I can't stay motivated
# I'll become too tired
# I exercise regularly with no barriers
# I don't really enjoy exercising
# I have an injury
# I'm too lazy <- multiple values that reduce to this
# I am not regular in anything                -\
# Less stamina                                  |
# No gym near me                                |  
# Travel                                        |
# Allergies                                     | Combined to "Other"
# I always busy with my regular works           |
# My friends don't come                         |
# Travel time I skip                          -/

df <- exercise_habits_survey_df %>%
  mutate(barriers_time = case_when(
    grepl("I don't have enough time",What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.) ~ TRUE,
    .default = FALSE),
    barriers_motivation = case_when(
      grepl("I can't stay motivated",What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    barriers_energy = case_when(
      grepl("I'll become too tired",What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    barriers_none = case_when(
      grepl("I exercise regularly with no barriers",What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    barriers_enjoyment = case_when(
      grepl("I don't really enjoy exercising",What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    barriers_injury = case_when(
      grepl("I have an injury",What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    barriers_laziness = case_when(
      grepl("Laz", ignore.case = TRUE, What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE)
    )%>%
  mutate(barriers_other = case_when(barriers_time == FALSE ~ TRUE,
         .default = FALSE)
         )


                                # Should be:
table(df$barriers_time)         # 290
table(df$barriers_motivation)   # 178
table(df$barriers_energy)       # 112
table(df$barriers_none)         # 67
table(df$barriers_enjoyment)    # 59
table(df$barriers_injury)       # 31
table(df$barriers_laziness)     # 10
table(df$barriers_other)        # 8, is only 3 because 5 others are secondary to other options

## Exercise Forms Answers are: (Lifted from a Google sheets text split and collation)
# I don't really exercise
# Walking or jogging
# Gym
# Team sport
# Yoga
# Swimming
# Lifting weights
# Zumba dance

df <- df %>%
  mutate(form_walking_or_jogging = case_when(
    grepl("Walking or jogging", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
    .default = FALSE),
    form_gym = case_when(
      grepl("Gym", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    form_team_sport = case_when(
      grepl("team sport", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    form_yoga = case_when(
      grepl("yoga", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    form_swimming = case_when(
      grepl("swimming", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    form_weights = case_when(
      grepl("lifting weights", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    form_zumba = case_when(
      grepl("zumba dance", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
    form_none = case_when(
      grepl("I don't really exercise", ignore.case = TRUE, What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply.) ~ TRUE,
      .default = FALSE),
  )

                                      # Should be:
table(df$form_none)                   # 90
table(df$form_walking_or_jogging)     # 324
table(df$form_gym)                    # 140
table(df$form_team_sport)             # 93
table(df$form_yoga)                   # 81
table(df$form_swimming)               # 41
table(df$form_weights)                # 47
table(df$form_zumba)                  # 33

# Reduce to needed columns
df <- df[c(
  "Your.gender",
  "Your.age",
  "How.important.is.exercise.to.you..",
  "How.do.you.describe.your.current.level.of.fitness..",
  "How.often.do.you.exercise.",
    "barriers_time",
  "barriers_motivation",
  "barriers_energy",
  "barriers_none",
  "barriers_enjoyment",
  "barriers_injury",
  "barriers_laziness",
  "barriers_other",
    "form_walking_or_jogging",
  "form_gym",
  "form_team_sport",
  "form_yoga",
  "form_swimming",
  "form_weights",
  "form_zumba",
  "form_none",
  "Do.you.exercise.___________..",
  "What.time.if.the.day.do.you.prefer.to.exercise.",
  "How.long.do.you.spend.exercising.per.day..",
  "Would.you.say.you.eat.a.healthy.balanced.diet..",
  "How.healthy.do.you.consider.yourself.",
  "Have.you.ever.purchased.a.fitness.equipment."
  )]

exercise_habits_survey_df <- df %>%
  rename(
    gender = Your.gender,
    age = Your.age,
    personal_exercise_importance = How.important.is.exercise.to.you..,
    level_of_fitness = How.do.you.describe.your.current.level.of.fitness..,
    exercise_frequency = How.often.do.you.exercise.,
    exercise_grouping = Do.you.exercise.___________..,
    prefered_exercise_time = What.time.if.the.day.do.you.prefer.to.exercise.,
    exercise_per_day = How.long.do.you.spend.exercising.per.day..,
    balanced_diet_frequency = Would.you.say.you.eat.a.healthy.balanced.diet..,
    perceived_health = How.healthy.do.you.consider.yourself.,
    past_fitness_equipment_purchase = Have.you.ever.purchased.a.fitness.equipment.
  )

for (col in colnames(exercise_habits_survey_df)){
  print(table(exercise_habits_survey_df[col]))
}

rm(col,df)