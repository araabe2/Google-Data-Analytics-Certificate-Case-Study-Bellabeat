## ASK 
**Purpose:** Understand the question being asked \
**Deliverable:** A clear summary of the business task

### Guiding questions:
What is the problem you are trying to solve?
 - Understand user trends within the field of smart devices to provide advice towards further marketing efforts for one or more Bellabeat products.
 - Select **[Bellabeat Spring]**.  How can current trends in smart device usage inform our business strategy for **[Bellabeat Spring]**?  In so discovering, we can tailor our marketing strategy for this product to better match with our desired consumers needs and to reach out to unreached consumers who would partake in the product.

How can your insights drive business decisions?
 - Under-utilized or unreached markets could require different advertisement techniques to reach them.
 - Product development focus could be shifted away from existing products towards a trendier topic within the market, or inform development of new products. (This would be outside the scope of this business task.)
 - Understanding user habits can lead to advertisement content being shifted to more closely relate to usage and prevent the company from feeling out-of-touch, maintaining public image.
 - Allocation of server resources can be altered to provide a cleaner user experience at times of peak usage.
 - Decisions about ad timing can be tuned to provide more clickthrough.
 - Influences popular with the target demographic can be sponsored to raise awareness of the product and its benefits.


### Business task:
 - Using data gathered from non-Bellabeat devices, discover trends and insights to inform Bellabeat marketing strategies.
 - Apply high-level trends and insights to a specific product, Bellabeat Spring, to provide specific suggestions for marketing efforts.


## PREPARE
**Purpose:** Figure out what information is needed to answer the question, how to get it, and acquire it \
**Deliverable:** A description of all data sources used


### Dataset Descriptions:
Dataset: https://zenodo.org/records/53894#.YMoUpnVKiP9
- Description: The data describes user activity of 30 users over two separate 1-month periods.
- Purpose: Discover and describe trends within user activity habits.
- Age of data: March - May of 2016
- Data storage: The formatting of this data is one best suited for an **SQL database**.
- Potential issues with the data **(Fitabase Data 3.12.16-4.11.16)**:
  - Distances are measured in kilometers.
  - Several factors have been dropped from the data, including: Calories burned by Basal Metabolism Rate, resting heart rate, and food consumption.
  - Number of IDs between datasets is not consistent, and ranges from 11 to 35, not the listed 30.
  - dailyActivity_merged: contains dates from 3/25-4/12/2016 instead of 3/12-4/11/2016 for a significant number of users.
  - dailyActivity_merged: User-logged activity seems widely ignored.
  - heartrate_seconds_merged: (5 second intervals) data before 3/31/2016 is less populous than afterwards.
  - hourlyCalories_merged:  Calories possibly contains outliers, considering one number is 933 whereas the majority else are centered around 42.
  - hourlyIntensities_merged: "Intensity" isn't well defined => (RESOLVED) via link below
  - minuteMETsNarrow_merged: "METs": Per notes: "All MET values exported by Fitabase are multiplied by 10.  Please divide by 10 to get accurate MET values." 
  - weightLogInfo_merged: Fat column is widely null.
- Potential issues with the data **(Fitabase Data 4.12.16-5.12.16)**:
  - Distances are measured in kilometers.
  - Several factors have been dropped from the data, including: Calories burned by Basal Metabolism Rate, resting heart rate, and floors climbed. 
  - Number of IDs between datasets is not consistent, and ranges from 8 to 33, not the listed 30.
  - dailyActivity_merged: User-logged activity seems widely ignored.
  - minuteCaloriesWide_merged: Calories0-Calories59 have the same distribution, meaning minute-level-detail is unreliable.
  - minuteCaloriesnarrow_merged: Because of the above line, data here is suspect, too.
  - minuteMETsNarrow_merged: "METs": Per notes: "All MET values exported by Fitabase are multiplied by 10.  Please divide by 10 to get accurate MET values."
  - weightLogInfo_merged: Fat column is widely null.
- Licensing: CC 4.0: International
- **Helpful link for defining terms**: https://www.fitabase.com/media/1748/fitabasedatadictionary.pdf

Dataset: [Link](https://figshare.com/articles/dataset/Data_Sheet_1_Exploring_the_smart_wearable_payment_device_adoption_intention_Using_the_symmetrical_and_asymmetrical_analysis_methods_CSV/20963635/1?file=37250668)
- Description: User-reported results from a survey of 500 Malaysian respondants discussing their comfort levels with adopting smart technology, along with key descriptors of lifestyle.
- Purpose: Allow further insights into the portion of the market that we are targetting advertisements towards.
- Age of data: January - February of 2021
- Data storage: The data is stored as a **CSV**.
- Potential issues with the data:
  - Data columns are not labelled properly.  From [the full research paper](https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2022.863544/full) and table 2, the columns have been matched to their values.
  - Column values do not match supposed measurements.
  - Employment Status does not match the expected factor count given in the article, and must be thrown out.
  - No explanation for the different values of "Ethnicity" are given.
  - Questions Starting with "INT" are out of 7 points, rather than out of 5 points like all other questions
  - Question SI5 is the only question phrased negatively.
- Licensing: CC 4.0: International

Dataset: https://www.kaggle.com/datasets/nithilaa/fitness-analysis
- Description: Exercise habits of 545 acquaintances
- Purpose: Identify trends within different habit striations of exercise partakers to consider where to focus market efforts.
- Age of data: July of 2019
- Data storage: The data is stored as a **CSV**.
- Potential issues with the data:
  - It is unclear how much consent was given to release these results for commercial usage.
  - Significant portions of the data are self-reported.
  - Multiple columns contain unsorted multi-value answers, meaning careful and manual transformation is necessary.
- Licensing: Unknown

Dataset: https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data
- Description: The success of advertisement click through of 4000 users, certain user demographics, and categories such as time of day, advertisement placement, and prior browsing history.
- Purpose: Identify when is best to advertise to users.
- Age of data: **UPLOADED** September 2024
- Data storage: The data is stored as a **CSV**.
- Potential issues with the data:
  - Significant NULL coverage in key columns
  - It is unclear what timeframe the data spans
  - Only 816 fully-non-null rows
  - Only 440 rows after removing duplicates and nulls
- Licensing: Apache 2.0

### Other Possible/Related Resources:
- Suggested market trends within the hydration bottle market: https://www.marketresearchforecast.com/reports/hydration-bottle-market-7431#summary
- Exercise hours (only has examples of data, not the data itself):https://pmc.ncbi.nlm.nih.gov/articles/PMC10192159/
- Age-based advertisement platform consumption (Could influence where we show ads): 
  - (Requires purchase/sign up) https://www.statista.com/statistics/1545610/advertising-media-try-new-product-by-age-usa/
  - (purchasing habits of 1000 users and metrics to predict those habits, SYNTHETIC DATA) https://www.kaggle.com/datasets/salahuddinahmedshuvo/ecommerce-consumer-behavior-analysis-data
  - (Ad click prediction larger and more comprehensive, but less well-defined; might be simulated) https://data.mendeley.com/datasets/wrvjmdtjd9/1
  - (Ad click prediction, might be simulated) https://www.kaggle.com/datasets/ziya07/advertising-campaign-dataset
- Top Influencers (Streamers/youtubers): 
  - https://hypeauditor.com/top-youtube-fitness/
  - https://www.influencer-hero.com/top-influencers/top-120-physical-fitness-workout-influencers-in-the-us
  - https://www.twitchmetrics.net/channels/viewership?game=Fitness+%26+Health
- Diverse user exercise habits, health, age, gender, etc (for a specific Finnish town): https://datacatalogue.cessda.eu/detail?q=a3aea11ff1c80ebbf02c58f6032beb6ef71607ed4d011f21c0eee4c7c8de59af
- Social media usage changes during COVID: https://plos.figshare.com/articles/dataset/The_use_of_mobile_apps_for_health-related_purposes_before_and_during_COVID-19_/20511149?file=36715580


## PROCESS
**Purpose:** Clean, store, and transform the data \
**Deliverable:** Documentation of any cleaning or manipulation of data

### CLEANING STEPS
#### FitBit User Dataset
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

#### Adoption of Wearable Smart Payment Technology Survey Dataset
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

#### Exercise Habits of 545 Respondents Survey Dataset
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

#### Ad Click Success or Failure Dataset
- Transformed "CLICK" column to factors (0 to "no click", 1 to "click")
- Dropped all nulls and duplicated values, leaving 440 unique and non-null rows.
- Dropped all columns except
  - age
  - gender
  - device_type
  - browsing_history
  - time_of_day
  - click

## ANALYZE
**Purpose:** Develop conclusions to answer the question being asked \
**Deliverable:** A summary of your analysis

### Analysis
**Question**: How can we better inform our marketing choies for **[Bellabeat Spring]** by knowing about trends within the Smart Device marketspace?

**Observations from the data**:
From the FitBit User Dataset (Day Slice):
- Data displayed that users **exercised** for the **highest distance** on **Wednesdays and Saturdays**.
- The **lowest exercise distance** was observed on **Fridays**.
- Similarly, the users displayed a tendency to **burn more calories** on **Mondays, Wednesdays, and Saturdays**, and the **least amount** on **Fridays**.
- When wearing their FitBits for exercise, users **most commonly** did **light exercise**.  (This could be the classification for activities like errands and housework.)
- When performing more **vigorous exercise**, users prefered **very active exercise** to **moderate exercise** (For clarity: a greater exercise rate over a medium one).
- For this more **vigorous exercise**, the data displayed a preference for participating on **Mondays and Saturdays**.
From the FitBit User Dataset (Hourly Slice):
- There are **two MET consumption peaks** over the course of a day, one at about **12pm** and a more significant peak at **6pm**.
- There are similar results for hourly step count, although the earlier peak **spans 12 to 1pm**.
- There are similar results for calories burned per hour.  An interesting note is that **calories burned** was **not insignificant during sleep hours**, averaging ~75 at its lowest.
- Average exercise is stays high from 10am to 8pm, with a small afternoon dip between 1 and 4pm.  The maximum exercise intensity is still 6pm.
- On an average weekend, users begin their MET consumption by 1-2 hours than they would on a weekday.
- Users maintain a more even level of hourly MET consumption on the weekend compared to weekday results.  Weekdays have a lower hourly MET consumption rate 9-5pm, after which a significant spike pushes the weekday hourly MET consumption over the maximum weekend hourly MET consumption.
From the Smart Technology Acceptance Survey Dataset:
-  



## SHARE
**Purpose:** Present findings to decision-makers/stakeholders \
**Deliverable:** Supporting visualizations and key findings

## ACT
**Purpose:** Implement the changes to solve the question \
**Deliverable:** Your top high-level content recommendations based on your analysis
