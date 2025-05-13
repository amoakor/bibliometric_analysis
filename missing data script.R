#Step 1: Install and Load Required Packages

install.packages("naniar")  # For visualizing missing data
install.packages("mice")    # For advanced missing data analysis
library(naniar)
library(mice)
#Step 2: Visualize Missing Data
#Use naniar to visualize the pattern of missing data in your dataset.


# Visualize missing data pattern
vis_miss(x_emerEval)
#This will create a heatmap showing where missing values (NA) are located in your dataset.

#Step 3: Check the Proportion of Missing Data
#Calculate the proportion of missing data for each variable.

# Proportion of missing data for each column
colSums(is.na(x_emerEval)) / nrow(x_emerEval)
#Step 4: Analyze Patterns of Missingness
#Use the md.pattern() function from the mice package to analyze patterns of missingness.


# Analyze missing data patterns
md.pattern(x_emerEval)
#This will display a table showing the combinations of missing and observed data, along with the frequency of each pattern.

#Step 5: Test for MCAR
#To test if the data is Missing Completely at Random (MCAR), you can use Little's MCAR test (available in the BaylorEdPsych package).


install.packages("BaylorEdPsych")  # Install the package if not already installed
library(BaylorEdPsych)

# Perform Little's MCAR test
LittleMCAR(x_emerEval)
#If the p-value is greater than 0.05, the data is likely MCAR.

#Step 6: Investigate MAR and MNAR
#For MAR and MNAR, you need to examine relationships between missing data and observed variables. This is often done through domain knowledge and statistical modeling.

#Example: Check if missingness in one variable is related to another variable

# Create a binary indicator for missingness in a specific column
x_emerEval <- x_emerEval %>%
  mutate(missing_indicator = is.na(column_name))

# Compare means of another variable by missingness
x_emerEval %>%
  group_by(missing_indicator) %>%
  summarise(mean_value = mean(other_column, na.rm = TRUE))
#If the means differ significantly, the missingness may be related to the observed data (MAR).

#Step 7: Advanced Analysis with mice
#The mice package can be used to perform multiple imputation and analyze missing data patterns more deeply.


# Perform multiple imputation
imputed_data <- mice(x_emerEval, m = 5, maxit = 50, method = "pmm", seed = 123)

# Summarize imputed data
summary(imputed_data)

# Visualize imputation results
stripplot(imputed_data)
#Key Points:
#Use naniar and mice for visualizing and analyzing missing data.

#Use Little's MCAR test to check if data is Missing Completely at Random.

#Investigate relationships between missingness and observed variables to determine MAR or MNAR.

#Domain knowledge is critical for understanding the nature of missing data.



install.packages("ellmer")
library(ellmer)
install.packages("pal")
chat <- chat_openai()
library(usethis)
library(pal)
install.packages("mall")

#usethis::edit_r_environ()

#{ellmer}----------------------------

#chat <- chat_openai(
  #system_prompt = ""
   #)

#chat$chat ("What is API?")






