
# =================================================== #
# Importing, Cleaning and Exporting Data
# Author(s): Md. Ahsanul Islam
# Date: Class 07 on 11 January 2025
# Description: Learn to work with CSV, Excel, SPSS, STATA, json, and 
# SQL Databases.
# Data: Available in the Data folder.
# =================================================== #


# load packages
library(dplyr)


# csv file ----------------------------------------------------------------

# Base R
# setwd("H:/Drive Sync 10/Workshops and Courses/2025 AiQuest/Codes/Data")
# getwd()
# dir()
data_csv <- read.csv("Data/customers-1000000.csv")
system.time({
  data_csv <- read.csv("Data/customers-1000000.csv")
})

data_csv

summary(data_csv)
head(data_csv)
tail(data_csv)

write.csv(data_csv, "Output/customers-1000000.csv", row.names = FALSE)

system.time({
  write.csv(data_csv, "Output/customers-1000000.csv", row.names = FALSE)  
})

write.table(data_csv[1:10,], "Output/rough.csv", sep = "\t")


# readr (tidyverse)
library(readr)

data_csv <- read_csv("Data/customers-1000000.csv")
data_csv

system.time({
  data_csv <- read_csv("Data/customers-1000000.csv")
})

write_csv(data_csv, "Output/customers-1000000.csv")


# data.table
library(data.table)
data_csv <- fread("Data/customers-1000000.csv")

system.time({
  data_csv <- fread("Data/customers-1000000.csv")
})

fwrite(data_csv, "Output/customers-1000000.csv", row.names = FALSE)

system.time({
  fwrite(data_csv, "Output/customers-1000000.csv", row.names = FALSE)
})

# Benchmark test 
library(microbenchmark)
spd <- microbenchmark(
  'baseR' = write.csv(data_csv, "Output/customers-1000000.csv", row.names = FALSE),
  'tidyverse' = write_csv(data_csv, "Output/customers-1000000.csv"),
  'fwrite' = fwrite(data_csv, "Output/customers-1000000.csv", row.names = FALSE),
  times=5
  )
spd


# Excel file --------------------------------------------------------------

library(readxl)
data_excel <- read_excel("Data/StudentSurveyData.xlsx", sheet = "DATA") # Specify sheet name or index

library(writexl)
write_xlsx(data_excel, "Output/StudentSurveyData.xlsx")

data_excel %>% 
  mutate(SpendingTaka = Spending * 123) %>% 
  writexl::write_xlsx("Output/StudentSurveyData.xlsx")

library(openxlsx)
openxlsx::write.xlsx(data_excel, "Output/StudentSurveyData.xlsx")

library(xlsx)  # java is required
xlsx::write.xlsx(data_excel, "Output/StudentSurveyData.xlsx")

# SPSS file ---------------------------------------------------------------

library(haven)
data_spss <- read_sav("Data/teacher-data.sav")

summary(data_spss)
data_spss$Sex <- as.factor(data_spss$Sex)

data_csv %>% 
  slice_sample(n = 10) %>% 
  mutate(across(where(is.character), as.factor)) %>% 
  write_csv("Output/csvAsSPSS.csv")
# 

write_sav(data_spss, "Output/teacher-data.sav")

# library(foreign)

# STATA file --------------------------------------------------------------
library(haven)

data_stata <- read_dta("Data/BDKR81FL.DTA")
str(data_stata)

data_stata %>% 
  select(v001, v015, v034) %>% 
  write_dta("Output/SelectedData.DTA")

write_dta(data_stata, "Output/BDKR81FL.DTA")

# json file ---------------------------------------------------------------

library(jsonlite)
data_json <- fromJSON("Data/population-data.json")

data_json %>% 
  as_tibble() %>% 
  # mutate(Year = as.numeric(Year),
  #        Value = as.numeric(Value)) %>% 
  mutate(across(c(Year, Value), as.numeric)) %>%
  write_json("Output/population_data_typechanged.json", pretty = TRUE)

write_json(data_json, "Output/population_data.json", pretty = TRUE)



# SQL Database ------------------------------------------------------------

mtcars
data(mtcars)
iris
data(iris)

data()

data(population, package = "tidyr")    
data(who, package = "tidyr")           # Details: https://tidyr.tidyverse.org/reference/who.html
population <- data.frame(population)
who <- data.frame(who)

library(DBI)          # Contains functions to interact with the databases
library(RSQLite)      # SQLite database driver

# Create an in-memory SQLite database connection
con <- dbConnect(drv = SQLite(), ":memory:")

# List all tables in the database
dbListTables(con)

# Write the 'population' and 'who' data frames to the database
dbWriteTable(conn = con, name = "pop", value = population)
dbListTables(con)

dbWriteTable(conn = con, name = "who", value = who, overwrite = TRUE)
dbListTables(con)

# Append a subset of the 'mtcars' data frame to a new table
dbWriteTable(con, "mtcars", mtcars[1:5,], append = TRUE)
dbListTables(con)

# Remove the original data frames from the environment
rm(population, who)


# Retrieve data from the 'who' table using SQL
dbGetQuery(
  conn = con,
  statement = "
  SELECT iso2 AS country, year, new_sp_m014, new_sp_f014
  FROM who
  WHERE country IN ('Bangladesh','India') AND year >= 2000 AND year <= 2006
  ")

# Retrieve data from the 'who' table using dplyr
db_new <- tbl(con, "who") %>% 
  filter(country %in% c('Bangladesh', 'India') & year >= 2000 & year <= 2006) %>% 
  select(iso2, year, new_sp_m014, new_sp_f014) %>% 
  collect()         # Retrieves the data into a local tibble

dbDisconnect(con)   # Disconnect from the server



# Connect to Open Database Connectivity (ODBC) compatible databases

# MySQL
con <- dbConnect(RMySQL::MySQL(),
                 dbname = "database_name",
                 host = "your-db-host.cloudprovider.com",
                 port = 3306,
                 user = "your_username",
                 password = "your_password")


con <- dbConnect(RMySQL::MySQL(),
                 dbname = "database_name",
                 host = "your-db-host.cloudprovider.com",
                 port = 3306,
                 user = rstudioapi::showPrompt(
                   title = "Username", message = "Username", default = ""
                 ),
                 password = rstudioapi::askForPassword(
                   prompt = "Password"
                   )
                 )

con <- dbConnect(RPostgres::Postgres(),
                 dbname = "database_name",
                 host = "your-db-host.cloudprovider.com",
                 port = 5432,
                 user = "your_username",
                 password = "your_password")

con <- dbConnect(odbc::odbc(),
                 Driver = "your_driver_name",
                 Server = "your-db-host.cloudprovider.com",
                 Database = "database_name",
                 UID = "your_username",
                 PWD = "your_password",
                 Port = 1234)  # Replace with the database port


# Save workspace ----------------------------------------------------------

save(data_csv, data_stata, file = "Output/csv_file.RData")

save.image("Output/workingData.RData")

load("Output/workingData.RData")
