library(tidyverse)
library(dplyr)
library(tidyr)

survey_smart_payment_sentiment <- read.csv("../Desktop/Data_Sheet_1_Exploring the smart wearable payment device adoption intention_ Using the symmetrical and asymmetrical analysis methods.CSV",
                                           header = TRUE, sep = ",")

# No duplicates or NA values
count(drop_na(survey_smart_payment_sentiment))
table(duplicated(drop_na(survey_smart_payment_sentiment)))


## First step is to rename the demographic variables in the smart payment sentiment survey
# Female represent 160 values, Male represents 150 values
table(survey_smart_payment_sentiment$X.1.Gender)
# Assume the more populous result is female: 
survey_smart_payment_sentiment <- survey_smart_payment_sentiment %>%
  mutate(X.1.Gender, X.1.Gender = factor(X.1.Gender, levels = c(1, 2), labels = c("m", "f")))

# 18-25: 121 values; 26-35: 140 values; 36-45: 33 values; 46-55: 14 values; 56-65: 2 values
table(survey_smart_payment_sentiment$X.2.Age)

# Assume order is consistent
survey_smart_payment_sentiment <- survey_smart_payment_sentiment %>%
  mutate(X.2.Age, 
         X.2.Age = 
           factor(X.2.Age, 
                  levels = c(1, 2, 3, 4, 5), 
                  labels = c("18-25", "26-35", "36-45", "46-55", "56-65")
           )
  )

# Average monthly Income (RM => Malaysian Ringgit, currently 1RM = $0.24)
# <4000RM: 119; 4001-8000: 85; 8001-12000: 40; 12001-16000: 50; 16001-20000: 10; >20000:6
table(survey_smart_payment_sentiment$X.7.AverageMonthlyIncome)

# Assume order is consistent
survey_smart_payment_sentiment <- survey_smart_payment_sentiment %>%
  mutate(X.7.AverageMonthlyIncome, 
         X.7.AverageMonthlyIncome = 
           factor(X.7.AverageMonthlyIncome, 
                  levels = c(1, 2, 3, 4, 5, 6), 
                  labels = c("0-4000", "4001-8000", "8001-12000", "12001-16000", "16001-20000", "20000+")
           )
  )

# Single: 189; Married: 113; Divorced: 6; Widowed: 2
table(survey_smart_payment_sentiment$X.4.Maritalstatus)
# Assume order is consistent
survey_smart_payment_sentiment <- survey_smart_payment_sentiment %>%
  mutate(X.4.Maritalstatus, 
         X.4.Maritalstatus = 
           factor(X.4.Maritalstatus, 
                  levels = c(1, 2, 3, 4), 
                  labels = c("Single", "Married", "Divorced", "Widowed")
           )
  )

# Secondary School Certificate: 20; Diploma Certificate: 33; Bachelor's Degree/Equiv: 186; Master's Degree: 64; PHD: 7
table(survey_smart_payment_sentiment$X.5.Education)
# Assume order is consistent
survey_smart_payment_sentiment <- survey_smart_payment_sentiment %>%
  mutate(X.5.Education, 
         X.5.Education = 
           factor(X.5.Education, 
                  levels = c(1, 2, 3, 4, 5), 
                  labels = c("Secondary School Certification",
                             "Diploma Certificate",
                             "Bachelor's Degree or Equivalent",
                             "Master's Degree",
                             "PHD")
           )
  )


# Employed Full Time: 215; Part Time: 42; Seeking Opportunities: 53
table(survey_smart_payment_sentiment$X.6.Employmentstatus)
# Does not match expected number of columns, and must be ignored

#survey_smart_payment_sentiment$

drop_columns <- !names(survey_smart_payment_sentiment) %in% 
  c("X.6.Employmentstatus","X.3.Ethnicity","InformedconsentAsarespondentmyparticipationiscompletelyvoluntary","Timestamp")
df <- survey_smart_payment_sentiment[,drop_columns]

## Review/Simplify the columns
colnames(df)
# PEOU = perceived usefulness of product, T = trust in product/producers, LC = personal fit with lifestyle,
# FC = perceived availability of resources, SI1-4: I'm positively influenced to use this, SI5: I am negatively influenced to wear this; 
# Int = willingness to try the product 


## Since SI5 is the only "negative" connotation question, it should be flipped so that 1 is now 5 and 5 is now 1
df<- df %>%
  mutate(SI5 = (6 - SI5.IdonotusewearablepaymentdevicebecausemyfamilythinksIshouldno))


df <- df %>% 
  mutate(`perceived_usefulness_average` = rowMeans(select(.,
                                                          PEOU1.Itwouldbeeasytobecomeskillfulinusingwearablepaymentdevice,
                                                          PEOU2.Interactionswithwearablepaymentdevicewouldbeclearandunders,
                                                          PEOU3.Itwouldbeeasytofollowallthestepstousewearablepaymentdevice,
                                                          PEOU4.Itwouldbeeasytointeractwithwearablepaymentdevice,
                                                          PEOU5.Ilikethefactthatpaymentsdonethroughwearablepaymentdevicere,
                                                          PEOU6.Ibelieveitiseasytotransfermoneythroughwearablepaymentdevic
  )))

df <- df %>%
  mutate(`trust_average` = rowMeans(select(.,
                                           T1.Wearablepaymentdevicesaretrustworthy,
                                           T2.Ibelievetheproductsandservicesprovidedbywearablepaymentdevice,
                                           T3.Ibelievewearablepaymentdevicesvendorswillkeeptheirpromisestoc,
                                           T4Ibelievethatincaseofanyissuethewearablepaymentdeviceproviderwi,
                                           T5.Ibelievethatthewearablepaymentdeviceprovidersfollowconsumerla
  )))

df <- df %>% 
  mutate(`lifestyle_fit_average` = rowMeans(select(.,
                                                   LC1.Ibelievethatusingwearablepaymentdeviceissuitableforme,
                                                   LC2.Ibelievethatusingwearablepaymentdevicewillfitmylifestyle,
                                                   LC3.UsingwearablepaymentdevicefitswellwiththewayIliketotransferm,
                                                   LC4.Usingwearablepaymentdeviceiscompatiblewithmycurrentmoneytran,
                                                   LC5.Usingwearablepaymentdeviceincreasesmyproductivityinmydailyli,
                                                   LC6.Usingwearablepaymentdeviceenhancesmyeffectivenessinmydailyli
  )))

df <- df %>% 
  mutate(`resource_availability_average` = rowMeans(select(.,
                                                           FC1.Ihavetheresourcesnecessarytousewearablepaymentdevice,
                                                           FC2.Ihavetheknowledgenecessarytousewearablepaymentdevice,
                                                           FC3.IcangethelpfromotherswhenIhavedifficultiesusingwearablepayme,
                                                           FC4.WearablepaymentdeviceiscompatiblewithothertechnologiesIuse,
                                                           FC5.Ihavetheresourcesnecessarytouseawearablepaymentdevice
  )))

df <- df %>% 
  mutate(`social_influence_average` = rowMeans(select(.,
                                                      SI1.PeoplewhoinfluencemybehaviorthinkthatIshouldusewearablepayme,
                                                      SI2.PeoplewhoareimportanttomethinkthatIshouldusewearablepaymentd,
                                                      SI3.PeoplewhoseopinionsIvaluepreferthatIusewearablepaymentdevice,
                                                      SI4.Peoplewhoareimportanttomewouldrecommendtousewearablepaymentd,
                                                      SI5
  )))

df <- df %>% 
  mutate(`intention_average` = rowMeans(select(.,
                                               INT1Iwouldliketobuywearablepaymentdevicestotrysomeappsonthem,
                                               INT2Iamwillingtoprovidethenecessarypersonalinformationtotheservi,
                                               INT3Iwilltrywearablepaymentdevicesinthenearfuture,
                                               INT4Iwouldliketodotransactionsusingwearablepaymentdeviceinthenea,
                                               INT5Itrytousethewearablepaymentdeviceasmuchaspossible,
                                               INT6Ibelieveitisworthwhileformetousewearablepaymentdevices
  )))


## Note: INT questions are out of 7 compared to all the rest that are out of 5 => (5*5 + 7)= 32
df$dummy <- df$intention_average * 5/7
df <- df %>% 
  mutate(total_weighted_average = rowMeans(select(.,
    c(perceived_usefulness_average,
      trust_average,
      lifestyle_fit_average,
      resource_availability_average,
      social_influence_average,
      dummy))
  ))



# Drop columns that have been averaged
df <- df [c("X.1.Gender",
            "X.2.Age",
            "X.4.Maritalstatus",
            "X.5.Education",
            "X.7.AverageMonthlyIncome",
            "perceived_usefulness_average",
            "trust_average",
            "lifestyle_fit_average",
            "resource_availability_average",
            "social_influence_average",
            "intention_average",
            "total_weighted_average")
]

df <- df %>%
  rename(
    Gender = X.1.Gender,
    Age = X.2.Age,
    Marital_status = X.4.Maritalstatus,
    Education = X.5.Education,
    Average_montly_income = X.7.AverageMonthlyIncome
  )


survey_smart_payment_sentiment <- df

rm(df,drop_columns)