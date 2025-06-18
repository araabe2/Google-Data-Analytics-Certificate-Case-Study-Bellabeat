## PREPARE
**Purpose:** Figure out what information is needed to answer the question, how to get it, and acquire it \
**Deliverable:** A description of all data sources used


### Dataset Descriptions:
#### Dataset: FitBit User Data
- https://zenodo.org/records/53894#.YMoUpnVKiP9
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
  - minuteMETsNarrow_merged: "METs": Per data definition in the link below: "All MET values exported by Fitabase are multiplied by 10.  Please divide by 10 to get accurate MET values." 
  - weightLogInfo_merged: Fat column is widely null.
- Potential issues with the data **(Fitabase Data 4.12.16-5.12.16)**:
  - Distances are measured in kilometers.
  - Several factors have been dropped from the data, including: Calories burned by Basal Metabolism Rate, resting heart rate, and floors climbed. 
  - Number of IDs between datasets is not consistent, and ranges from 8 to 33, not the listed 30.
  - dailyActivity_merged: User-logged activity seems widely ignored.
  - minuteCaloriesWide_merged: Calories0-Calories59 have the same distribution, meaning minute-level-detail is unreliable.
  - minuteCaloriesnarrow_merged: Because of the above line, data here is suspect, too.
  - minuteMETsNarrow_merged: "METs": Per data definition in the link below: "All MET values exported by Fitabase are multiplied by 10.  Please divide by 10 to get accurate MET values."
  - weightLogInfo_merged: Fat column is widely null.
- Licensing: CC 4.0: International
- **Helpful link for defining terms**: https://www.fitabase.com/media/1748/fitabasedatadictionary.pdf

<br/><br/>

#### Dataset: Adoption of Wearable Smart Payment Technology Survey
- [Link](https://figshare.com/articles/dataset/Data_Sheet_1_Exploring_the_smart_wearable_payment_device_adoption_intention_Using_the_symmetrical_and_asymmetrical_analysis_methods_CSV/20963635/1?file=37250668)
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

<br/><br/>

#### Dataset: Exercise Habits Survey
- https://www.kaggle.com/datasets/nithilaa/fitness-analysis
- Description: Exercise habits of 545 acquaintances
- Purpose: Identify trends within different habit striations of exercise partakers to consider where to focus market efforts.
- Age of data: July of 2019
- Data storage: The data is stored as a **CSV**.
- Potential issues with the data:
  - It is unclear how much consent was given to release these results for commercial usage.
  - Significant portions of the data are self-reported.
  - Multiple columns contain unsorted multi-value answers, meaning careful and manual transformation is necessary.
- Licensing: Unknown

<br/><br/>

#### Dataset: Ad Click Success/Failure Data
- https://www.kaggle.com/datasets/marius2303/ad-click-prediction-dataset/data
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

<br/><br/>

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

<br/><br/>

[NEXT STAGE (PROCESS)](https://github.com/araabe2/Google-Data-Analytics-Certificate-Case-Study-Bellabeat/blob/main/Phase%203%3A%20Process.md)
