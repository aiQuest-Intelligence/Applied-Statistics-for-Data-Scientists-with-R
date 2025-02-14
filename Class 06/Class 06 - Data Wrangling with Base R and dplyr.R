
# =================================================== #
# Data Wrangling with Base R and dplyr
# Author(s): Md. Ahsanul Islam
# Date: Class 06 at 10 January 2025
# Description: Learn about filtering rows, selecting columns, creating 
# columns, removing columns, editing columns and rows, reshaping data set.
# Data: None.
# =================================================== #



# Load packages -----------------------------------------------------------

# install.packages(dplyr)

library(dplyr)


# Sample data -------------------------------------------------------------

data <- data.frame(
  ID = 1:10,                                
  Name = c("Shihab", "Kabir", "Mahbub", "Pranto", "Nusrat", 
           "Mumu", "Meraj", "Supto", "Mujahid", "Asik"),
  Age = c(25, 30, 35, 40, 28, 32, 45, 29, 50, 27),
  Salary = c(50000, 55000, 60000, 45000, 70000, 
             52000, 48000, 68000, 65000, 40000),
  Department = c("HR", "Finance", "IT", "HR", "IT", 
                 "Finance", "IT", "HR", "Finance", "IT"),
  Performance_Score = c(88, 92, 85, 78, 90, 94, 86, 80, 89, 75)
)

print(data)


# Filtering rows ----------------------------------------------------------

## Base R examples ####

# Filter rows where Age > 30
data[data$Age > 30, ]

data[Age > 30, ]

attach(data)
data[data$Age > 30, ]
detach(data)


# Filter rows where Department is "IT"
data[data$Department == "IT", ]

# Filter rows where Performance_Score >= 90
data[data$Performance_Score >= 90, ]

# Filter rows where Age > 30 and Department is "Finance"
data[data$Age > 30 & data$Department == "Finance", ]

# Filter rows where Department is in a specific set
data[data$Department %in% c("HR", "IT"), ]

# Exclude rows where Department is "HR"
data[data$Department != "HR", ]


## dplyr examples ####

# pipe ( %>% ) operator is actually part of 'magrittr' package

round(mean(c(12, 34, 24, 35, 23, 34, 12.342)), 1)

c(12, 34, 24, 35, 23, 34, 12.342) %>% 
  mean() %>% 
  round(1)

# Shortcut for %>% : CTRL + SHIFT + M  
  
c(12, 34, 24, 35, 23, 34, 12.342) |>
  mean() |>
  round(1)


# Filter rows where Age > 30
filter(data, Age > 30)
data %>% filter(Age > 30)

# Filter rows where Department is "IT"
data %>% filter(Department == "IT")

# Filter rows where Performance_Score >= 90
data %>% filter(Performance_Score >= 90)

# Filter rows where Age > 30 and Department is "Finance"
data %>% filter(Age > 30, Department == "Finance")

# Filter rows where Name is in a specific set
data %>% filter(Department %in% c("IT", "Finance"))

# Exclude rows where Department is "HR"
data %>% filter(Department != "HR")


data %>% slice(10)
data %>% slice(1:10)
set.seed(0)
data %>% slice_sample(n = 3)


# Selecting columns  ------------------------------------------------------

## Base R ####

# Select a single column by name
data["Name"]  # Returns a data frame
data$Name     # Returns a vector

# Select multiple columns by name
data[,c("Name", "Age")]

# Select columns by position
data[, c(1, 2, 5, 6)]  # First and second columns

# Exclude columns by name
data[ , !(names(data) %in% c("Department"))]

# Exclude columns by position
data[, -3]  # Excludes the third column

## dplyr ####

# Select a single column by name
data %>% select(Name)

# Select multiple columns by name
data %>% select(Name, Age)

# Select columns by position
data %>% select(1, 2, 6)

# Exclude columns by name
data2 <- data %>% select(-c(Department, ID))

# Exclude columns by position
data %>% select(-3)

# Select columns based on patterns (e.g., columns starting with "P")
data %>% select(starts_with("P"))
data %>% select(contains("age"))

# Select columns based on data type
data %>% select(where(is.numeric))
data %>% select(where(is.character))




# Creating columns --------------------------------------------------------

## Base R ####

# Add a new column with a existing values
data$Experience <- c(2, 5, 10, 3, 8, 4, 2, 1, 1, 6)

# Add a constant value
data$Constant_Column <- 1
data

# Add a calculated column
data$Bonus <- data$Salary * data$Performance_Score * 0.0001
data

# Add a column using conditional logic
data$High_Performer <- ifelse(data$Performance_Score >= 85, TRUE, FALSE)
data
data[data$High_Performer, ]

data$Low_Performer <- !data$High_Performer
data

## dplyr ####

# Add a new column with a computed value
data3 <- data %>% 
  mutate(
    Experience = c(2, 5, 10, 3, 8, 4, 2, 1, 1, 6),   # Add a new column with a existing values
    Constant_Column = 1,                             # Add a constant value
    High_Performer = Performance_Score >= 85,        # Add a column using conditional logic
    Low_Performer = !High_Performer,                 # Add a column using conditional logic
    Bonus = Salary * Performance_Score * 0.0001      # Add a calculated column
    )


# Removing columns --------------------------------------------------------

## Base R ####

# Remove a column by assigning NULL
data3$Constant_Column <- NULL
data3

# Remove multiple columns using subset
data3 <- data3[ , !(names(data3) %in% c("High_Performer", "Low_Performer", "Experience"))]
data3

## dplyr ####

data <- data.frame(
  ID = 1:10,                                
  Name = c("Shihab", "Kabir", "Mahbub", "Pranto", "Nusrat", 
           "Mumu", "Meraj", "Supto", "Mujahid", "Asik"),
  Age = c(25, 30, 35, 40, 28, 32, 45, 29, 50, 27),
  Salary = c(50000, 55000, 60000, 45000, 70000, 
             52000, 48000, 68000, 65000, 40000),
  Department = c("HR", "Finance", "IT", "HR", "IT", 
                 "Finance", "IT", "HR", "Finance", "IT"),
  Performance_Score = c(88, 92, 85, 78, 90, 94, 86, 80, 89, 75)
)

## Removing Columns with dplyr

# Remove a single column
data <- data %>% select(-Performance_Score)

# Remove multiple columns
data <- data %>% select(-c(Department, Age))

# Remove columns based on a condition
data %>% select(-where(is.character))
# Note: You can use "selection helpers" in select()



# Editing column ------------------------------------------------------------
data <- data.frame(
  ID = 1:10,                                
  Name = c("Shihab", "Kabir", "Mahbub", "Pranto", "Nusrat", 
           "Mumu", "Meraj", "Supto", "Mujahid", "Asik"),
  Age = c(25, 30, 35, 40, 28, 32, 45, 29, 50, 27),
  Salary = c(50000, 55000, 60000, 45000, 70000, 
             52000, 48000, 68000, 65000, 40000),
  Department = c("HR", "Finance", "IT", "HR", "IT", 
                 "Finance", "IT", "HR", "Finance", "IT"),
  Performance_Score = c(88, 92, 85, 78, 90, 94, 86, 80, 89, 75)
)
## Base R ####

# Rename a column
colnames(data)[which(colnames(data) == "Salary")] <- "Monthly_Salary"

# Modify an existing column
data$Age <- data$Age + 1

## dplyr ####

data <- data.frame(
  ID = 1:10,                                
  Name = c("Shihab", "Kabir", "Mahbub", "Pranto", "Nusrat", 
           "Mumu", "Meraj", "Supto", "Mujahid", "Asik"),
  Age = c(25, 30, 35, 40, 28, 32, 45, 29, 50, 27),
  Salary = c(50000, 55000, 60000, 45000, 70000, 
             52000, 48000, 68000, 65000, 40000),
  Department = c("HR", "Finance", "IT", "HR", "IT", 
                 "Finance", "IT", "HR", "Finance", "IT"),
  Performance_Score = c(88, 92, 85, 78, 90, 94, 86, 80, 89, 75)
)

# Rename a column
data %>% rename(Monthly_Salary = Salary)

# Modify an existing column
data %>% mutate(Age = Age + 1)



# Editing Rows ------------------------------------------------------------

## Base R ####

# Update values in specific rows
data[data$Name == "Shihab", "Performance_Score"] <- 80
data

# Add a new row
new_row <- data.frame(
  ID = 11, 
  Name = "Nadia", 
  Age = 26, 
  Salary = 60000, 
  Department = "IT",
  Performance_Score = 88
)
data <- rbind(data, new_row)

# Remove a row
data <- data[data$Name != "Nadia", ]


## dplyr ####

data <- data.frame(
  ID = 1:10,                                
  Name = c("Shihab", "Kabir", "Mahbub", "Pranto", "Nusrat", 
           "Mumu", "Meraj", "Supto", "Mujahid", "Asik"),
  Age = c(25, 30, 35, 40, 28, 32, 45, 29, 50, 27),
  Salary = c(50000, 55000, 60000, 45000, 70000, 
             52000, 48000, 68000, 65000, 40000),
  Department = c("HR", "Finance", "IT", "HR", "IT", 
                 "Finance", "IT", "HR", "Finance", "IT"),
  Performance_Score = c(88, 92, 85, 78, 90, 94, 86, 80, 89, 75)
)

# Update values in specific rows
data %>% mutate(
  Performance_Score = if_else(Name == "Shihab", 80, if_else(
    Department == "HR", 60, Performance_Score
  ))
)

# Add a new row
new_row <- data.frame(
  ID = 11, 
  Name = "Nadia", 
  Age = 26, 
  Salary = 60000, 
  Department = factor("IT"),
  Performance_Score = 88
)
data <- bind_rows(data, new_row)

# Remove a row
data <- data %>% filter(Name != "Nadia")

# Arranging ---------------------------------------------------------------

data %>% 
  arrange(Performance_Score)

data %>% 
  arrange(desc(Performance_Score))

data %>% 
  arrange(Department, desc(Performance_Score))

# Reshaping ---------------------------------------------------------------

# A sample data
data_wide <- data.frame(
  country = c("BD", "Ghana", "UK", "Canada"),
  continent = c("Asia", "Africa", "Europe", "North America"),
  GDP_1960 = c(10, 20, 30, 40),
  GDP_1970 = c(13, 23, 33, 45),
  GDP_2010 = c(15, 25, 35, 60),
  stringsAsFactors = FALSE
)
data_wide

# install.packages("tidyr")
library(tidyr)

data_long <- data_wide %>%
  tidyr::pivot_longer(cols = starts_with("GDP_"),   # Selecting columns starting with "GDP_"
               names_to = "Year",            # The name of the new column that will hold the years
               names_prefix = "GDP_",        # Remove "GDP_" from the column names
               values_to = "GDP"             # The name of the new column that will hold the GDP values
  )
data_long

data_wide_back <- data_long %>%
  pivot_wider(names_from = "Year",   # Columns created based on unique values in the "Year" column
              values_from = "GDP"    # Values for each "Year" will come from the "GDP" column
  )
data_wide_back

data_wide_back <- data_long %>%
  filter(Year != "1960") %>% 
  pivot_wider(names_from = "Year",   # Columns created based on unique values in the "Year" column
              values_from = "GDP",   # Values for each "Year" will come from the "GDP" column
              names_prefix = "GDP_"
  )
data_wide_back



# Joining Datasets --------------------------------------------------------

# Sample dataset 1
employees <- data.frame(
  ID = c(1, 2, 3, 4, 5),
  Name = c("Shihab", "Kabir", "Mahbub", "Pranto", "Nusrat"),
  Department = c("HR", "IT", "Finance", "IT", "HR")
)
employees

# Sample dataset 2
  salaries <- data.frame(
  ID = c(1, 2, 3, 4, 6),
  Salary = c(50000, 60000, 70000, 75000, 40000)
)

employees
salaries

left_join(employees, salaries, by = "ID")
inner_join(employees, salaries, by = "ID")
right_join(employees, salaries, by = "ID")
full_join(employees, salaries, by = "ID")



# Add-ins -----------------------------------------------------------------

# install.packages("ViewPipeSteps")
# install.packages("styler")
# install.packages("reprex")
# install.packages("questionr")

