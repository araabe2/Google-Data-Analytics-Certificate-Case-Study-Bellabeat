# PROCESS
**Purpose:** Clean, store, and transform the data \
**Deliverable:** Documentation of any cleaning or manipulation of data

**- [Ask](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%201%3A%20Ask.md) - [Prepare](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%202%3A%20%20Prepare.md) - [Process](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%203%3A%20Process.md) - [Analyze](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%204:%20Analysis.md) - [Share](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%205%20+%206:%20Share%20+%20Act.md) - [Act](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%205%20+%206:%20Share%20+%20Act.md) -**

## Cleaning Steps
### FitBit User Dataset
- Subset of data chosen, focusing on datasets with hourly intervals of exercise-related data (labeled for their **starting month**, although both groupings span a second month as well)
  - MarchFitBit_dailyActivity, AprilFitBit_dailyActivity
  - MarchFitBit_hourlyCalories, AprilFitBit_hourlyCalories
  - MarchFitBit_hourlyIntensities, AprilFitBit_hourlyIntensities
  - MarchFitBit_hourlySteps, AprilFitBit_hourlySteps
  - MarchFitBit_minuteMETsNarrow, AprilFitBit_minuteMETsNarrow
- Corrected datetime columns to mdy_hms time type
  - For March/April daily activity, date is instead set to mdy
- Lowered the granularity of March/April MET data to hourly groupings
- Scaled METs down by a factor of 1/10, as per the instructions in the definition document
- Concatenated March/April data into single dataframes
- Merged all hourly data into a single dataframe
- Removed duplicate rows from "Hourly" dataframe
- Ignored rows containing nulls from "Hourly" dataframe, as they are all on the last day of reporting, and are only 6 values
- Split "Hour of the Day" into its own column for Hourly Data
- Split "Day of the Week" into its own column for Hourly Data
- Split "Day of the Week" into its own column for Daily Activity Data
- Results are:
  - FitBit_dailyActivity: Contains combined March/April daily data
  - FitBit_hourlyData: Contains combined March/April hourly data for all desired metrics

### Adoption of Wearable Smart Payment Technology Survey Dataset
- (ASSUMED DUE TO ARTICLE REFERENCING THE DATA) Female is more populous than Male => Transformed gender integers to factors
  - 1 -> "m"
  - 2 -> "f"
- (ASSUMED DUE TO ARTICLE REFERENCING THE DATA) Order is maintained => Transformed age factor to age ranges
  - 1 -> "18-25"
  - 2 -> "26-35"
  - 3 -> "36-45"
  - 4 -> "46-55"
  - 5 -> "56-65"
- (ASSUMED DUE TO ARTICLE REFERENCING THE DATA) Order is maintained => Transformed Average Monthly Income factor to income ranges (in Malaysian Ringgit (RM))
  - 1 -> "0-4000"
  - 2 -> "4001-8000"
  - 3 -> "8001-12000"
  - 4 -> "12001-16000"
  - 5 -> "16001-20000"
  - 6 -> "20000+"
- (ASSUMED DUE TO ARTICLE REFERENCING THE DATA) Order is maintained => Transformed Marital Status factor to readable format
  - 1 -> "Single"
  - 2 -> "Married"
  - 3 -> "Divorced"
  - 4 -> "Widowed" 
- (ASSUMED DUE TO ARTICLE REFERENCING THE DATA) Order is maintained => Transformed Education factor to readable format
  - 1 -> "Secondary School Certification"
  - 2 -> "Diploma Certificate"
  - 3 -> "Bachelor's Degree or Equivalent"
  - 4 -> "Master's Degree"
  - 5 -> "PHD"
- Dropped columns "X.6.Employmentstatus" and "X.3.Ethnicity" due to unresolvable lack of clarity
- Dropped columns "InformedconsentAsarespondentmyparticipationiscompletelyvoluntary" and "Timestamp" due to lack of usefulness
- Question SI5 is the only question phrased negatively -> transformed question SI5 to (6-SI5) to invert positive/negative response values
- Merged questions into groupings based on average score given and theme of questions asked
  - perceived_usefulness_average <- questions labelled with "PEOU" 1-6
  - trust_average <- questions labelled with "T" 1-5
  - lifestyle_fit_average <- questions labelled with "LC" 1-6
  - resource_availability_average <- questions labelled with "FC" 1-5
  - social_influence_average <- questions labelled with "SI" 1-4 and new (inverted) SI5 category
  - intention_average <- questions labelled with "INT" 1-6
- Added column "total_weighted_average". To compensate for intention_average being out of 7 points where all other questions are out of 5 points, weighted average is used.
- Renamed columns to more usable names:
  - Gender <- X.1.Gender
  - Age <- X.2.Age
  - Marital_status <- X.4.Maritalstatus
  - Education <- X.5.Education
  - Average_montly_income <- X.7.AverageMonthlyIncome

### Exercise Habits Survey Dataset
- Split the multi-valued column "What.barriers..if.any..prevent.you.from.exercising.more.regularly.............Please.select.all.that.apply." into boolean columns:
  - Time (I don't have enough time) (290 Values)
  - Motivation (I can't stay motivated) (178 Values)
  - Energy (I'll become too tired) (112 Values)
  - None (I exercise regularly with no barriers) (67 Values)
  - Enjoyment (I don't really enjoy exercising) (59 Values)
  - Injury (I have an injury) (31 Values) 
  - I'm too lazy (Any value that contain's "laz", since multiple values reduce to the same term) (10 Values)
  - Other (Any row that does not have at least one other checked) <- This technically loses 5 (of 8) instances, as they are subsequent to other barrier types. (3 Values)
- Split the multi-valued column "What.form.s..of.exercise.do.you.currently.participate.in...........................Please.select.all.that.apply." into boolean columns:
  - None (I don't really exercise) (90 Values)
  - Walking or jogging (324 Values)
  - Gym (140 Values)
  - Team sport (93 Values)
  - Yoga (81 Values)
  - Swimming (41 Values)
  - Weights (Lifting weights) (47 Values)
  - Zumba (Zumba dance) (33 Values)
- Reduced columns to needed columns only:
  - Your.gender
  - Your.age
  - How.important.is.exercise.to.you..
  - How.do.you.describe.your.current.level.of.fitness..
  - How.often.do.you.exercise.
  - [Barriers Boolean Columns]
  - [Exercise Forms Boolean Columns]
  - Do.you.exercise.___________..
  - What.time.if.the.day.do.you.prefer.to.exercise.
  - How.long.do.you.spend.exercising.per.day..
  - Would.you.say.you.eat.a.healthy.balanced.diet..
  - How.healthy.do.you.consider.yourself.
  - Have.you.ever.purchased.a.fitness.equipment.
- Renamed columns to easier to reference values
  - gender <- Your.gender
  - age <- Your.age
  - personal_exercise_importance <- How.important.is.exercise.to.you..
  - level_of_fitness <- How.do.you.describe.your.current.level.of.fitness..
  - exercise_frequency <- How.often.do.you.exercise.
  - exercise_grouping <- Do.you.exercise.___________..
  - prefered_exercise_time <- What.time.if.the.day.do.you.prefer.to.exercise.
  - exercise_per_day <- How.long.do.you.spend.exercising.per.day..
  - balanced_diet_frequency <- Would.you.say.you.eat.a.healthy.balanced.diet..
  - perceived_health <- How.healthy.do.you.consider.yourself.
  - past_fitness_equipment_purchase <- Have.you.ever.purchased.a.fitness.equipment.

### Ad Click Success/Failure Dataset
- Transformed "CLICK" column to factors (0 to "no click", 1 to "click")
- Dropped all nulls and duplicated values, leaving 440 unique and non-null rows.
- Dropped all columns except
  - age
  - gender
  - device_type
  - browsing_history
  - time_of_day
  - click

<br/>

[NEXT STAGE (ANALYZE)](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%204:%20Analysis.md)
