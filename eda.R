# ---
# R Exploratory Data Analysis"
# DAPT 621 Intro to R
# ---
#
# # Business Scenario
#
# Suppose you are a data consultant recently hired by Company ABC, a mid-size company with 119 employees, to advise on global compensation for analytics positions throughout the company. Currently, the company has three offices: one in Columbus, Ohio, one in Toronto, Canada, and another in Munich, Germany and is shifting from a partially remote set-up to a fully remote one. Company ABC was able to obtain a listing of 607 salaries over 3 years on various technical positions from around the world to use as a benchmark and would like to understand what salaries look like in different locations.
#
# # Data Overview
#
# | Column             | Description                                                                                                                                                                                    |
# |------------------------|------------------------------------------------|
# | work_year          | The year the salary was paid.                                                                                                                                                                  |
# | experience_level   | The experience level in the job during the year with the following possible values: EN Entry-level / Junior MI Mid-level / Intermediate SE Senior-level / Expert EX Executive-level / Director |
# | employment_type    | The type of employment for the role: PT Part-time FT Full-time CT Contract FL Freelance                                                                                                        |
# | job_title          | The role worked in during the year.                                                                                                                                                            |
# | salary             | The total gross salary amount paid.                                                                                                                                                            |
# | salary_currency    | The currency of the salary paid as an ISO 4217 currency code.                                                                                                                                  |
# | salary_in_usd      | The salary in USD (FX rate divided by avg. USD rate for the respective year via fxdata.foorilla.com).                                                                                          |
# | employee_residence | Employee's primary country of residence in during the work year as an ISO 3166 country code.                                                                                                   |
# | remote_ratio       | The overall amount of work done remotely, possible values are as follows: 0 No remote work (less than 20%) 50 Partially remote 100 Fully remote (more than 80%)                                |
# | company_location   | The country of the employer's main office or contracting branch as an ISO 3166 country code.                                                                                                   |
# | company_size       | The average number of people that worked for the company during the year: S less than 50 employees (small) M 50 to 250 employees (medium) L more than 250 employees (large)                    |
#
# # Read CSV Data into R
#
# # read.csv
#
# `read.csv` is a base R package (or actually a wrapper around the `read.table` package) specific for reading in comma delimited files. Remember, in RStudio, you can always type `?` before the function to see the function's description and usage.
#
#

?read.csv

#
#
# Let's read in our sample data *ds_salaries.csv* and take a look at the first 5 rows using the `head()` function.
#
#

filepath <- 'https://danadbm.github.io/r-wrangle/ds_salaries.csv'
sal <- read.csv(filepath)

#
#
# # head
#
# Notice that 5 rows are returned if no number of rows is specified. Try `head(sal, 10)` to see the first 10 rows.
#
#

head(sal, 2)

#
#
# # tail
#
# Check the last 5 rows of the data with the `tail()` function.
#
#

tail(sal)

#
#
# How did R know to return exactly 5 rows?
#
# # Explore the data frame
#
# First, what is a **data frame**?
#
# -   data object displayed in tabular format / as a table
#
# -   rows and columns
#
# -   each column is vector of values of the same type
#
# # dim, ncol, nrow
#
# For a quick return of the dimensions, `dim`, `ncol`, and `nrow` can be used on the data frame.
#
#

dim(sal)

#
#
#

ncol(sal)

#
#
#

nrow(sal)

#
#
# # str
#
# Check the structure of our data object with the `str` function. Quickly view the dimensions, column names, column types, and sample values.
#
#

str(sal)

#
#
# # summary
#
# Use the `summary` function to see summary statistics for each column.
#
#

summary(sal)

#
#
#
# # names
#
# Use the `names` function to see the column names in the data frame.
#
#

names(sal)

#
#
#
# # Access elements in the data frame (`df`) using base R
#
# It is good to understand how data can be accessed in a data frame using base R syntax; however, it is more common to use libraries like `dplyr` and `data.table`. `dplyr` will be the focus after reviewing base R syntax.
#
# **For the purposes of this demo, we will look at only a subset of the original data and focus on Canadian employees only (`employee_residence == 'CA'`).** 
#
# The code `sal_ca <- sal[sal$employee_residence == 'CA', ]` will create a new data frame, `sal_ca` that is limited to the Canadian employees.
#

sal_ca <- sal[sal$employee_residence == 'CA', ]

#
#
# # Select column as a vector
#
# *Each of these options will return a single column as a vector.*
#
# Select a column by name.
#
# `df$columnname`
#
#

sal_ca$salary

#
#
# `df[["column name"]]`
#
#

# single or double quotes can be used
# salary[['salary']]
sal_ca[["salary"]]

#
#
# `df[ , "column name"]`
#
#

sal_ca[ , "salary"]

#
#
# Select a column by position.
#
# `df[[column number]]`
#
#

sal_ca[[5]]

#
#
# `df[ , column number]`
#
#

sal_ca[ , 5]

#
#
# # Select column(s) as a data frame
#
# *Each of these options will return a data frame.*
#
# Select one column by name.
#
# `df["column name"]`
#
#

sal_ca["salary"]

#
#
# Select multiple columns by name.
#
# `df[c("column name", "column name", ...)]` or `df[, c("column name", "column name", ...)]`
#
#

sal_ca[c('work_year', 'salary')]

#
#
# Multiple columns, first saving vector of names into a variable.
#
#

cols <- c('work_year', 'salary')
sal_ca[cols]

#
#
# Select one column by position.
#
# `df[column number]`
#
#

sal_ca[5]

#
#
# Select multiple consecutive columns by position.
#
# `df[column number:column number]`
#
#

sal_ca[1:3]

#
#
# # Select row(s) as a data frame
#
# *Each of these options will return a data frame.*
#
# Select one row by position.
#
# `df[row number, ]` - note the comma placement!
#
#

sal_ca[1, ]

#
#
# Select multiple rows by position.
#
# `df[row number:row number, ]` - note the comma placement!
#
#

sal_ca[1:5, ]

#
#
# Select multiple rows by using a criteria. What is a criteria? It is a logical statement that will be compared to every row of the data.
#
# Only rows that meet the criteria are returned.
#
# Example criteria: `work_year` equal to `2022`?
#
#

sal_ca$work_year == 2022

#
#
# Now add the criteria to the data frame.
#
# `df[row critera, ]` - note the comma placement!
#
#

sal_ca[sal_ca$work_year == 2021, ]

#
#
# Another example criteria: Are there any missing values in `salary_in_usd`?
#
# `is.na(df$columnname)`
#
#

is.na(sal_ca$salary_in_usd)

#
#
# Now add the criteria to the data frame.
#
# `df[row critera, ]` - note the comma placement!
#
#

sal_ca[is.na(sal_ca$salary_in_usd), ]

#
#
# # Select row(s) and column(s) as a data frame
#
# Generally, data can be accessed from a data frame using the syntax:
#
# `df[row selection / criteria , column selection]`
#
# # **Example 1**: Show the columns `job_title` and `salary_in_usd` for full time employees.
#
#

sal_ca[sal_ca$employment_type == 'FT', c('job_title', 'salary_in_usd')]

#
#
# # **Example 2**: Show the columns `job_title` and `salary_in_usd` for salaries greater than or equal to \$100k.
#
#

sal_ca[sal_ca$salary_in_usd >= 100000, c('job_title', 'salary_in_usd')]

#
#
# Oops, this doesn't give what we need. Why are rows with blank (`NA`) salaries being returned? What does the criteria / logical statement return?
#
#

sal_ca$salary_in_usd >= 100000

#
#
# Let's add an exclusion for `NA` salaries in the criteria. Note the use of `&` to combine two logical statements.
#
#

sal_ca[sal_ca$salary_in_usd >= 100000 & !is.na(sal_ca$salary_in_usd), c('job_title', 'salary_in_usd')]

#
#
# # **Exercise**: Create a subset of the salary data that shows only entry level employees from mid-size companies and only the `experience_level`, `job_title`, `company_size`, and `salary_in_usd` columns and save as a new data frame, `sal_ca_en`.
#
# | `experience_level` | `job_title`    | `company_size` | `salary_in_usd`  |
# |--------------------|----------------|----------------------|------------------|
# | EN                 | Data Scientist | M                   | ...              |
# | EN                 | Data Analyst   | M                   | ...              |
# | ...                | ...            | ...                  | ...              |
#
# : sal_ca_en
#
#

# insert code to save new data frame here

#
#
#

# insert code to view data frame here

#
#
