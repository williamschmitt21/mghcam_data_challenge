# Scrub and Shuffle Raw Data
# scrubs PHI and shuffles the rows (i.e. breaks connection
# between study ID and data) for the provided csv files.
# Written By William Schmitt
# Email: waschmitt@mgh.harvard.edu
# Last Updated 2020-09-02

# Table of Contents
# 1) Initial Set-Up
#   1.1) Load packages
#   1.2) Read in files
#   1.3) Functions
#     1.3.1) hash
# 2) Scrub PHI
#   2.1) Remove clinic information
#   2.2) Remove PCP information
# 3) Shuffle Datasets
#   3.1) Combine two datasets
#   3.2) Define groups to shuffle
#   3.3) Combine and shuffle dfs
#   3.4) Write to data folder

###
### 1) Initial Set-Up
###

# 1.1) Load packages

# For data frame manipulation
library(dplyr)
library(tidyr)

# For functional programming
library(purrr)

# For manipulating strings
library(stringr)

# 1.2) Read in files

# Read in csv files and seed for shufffling
setwd('Raw_data')
base_df <- read.csv('Baseline_survey_data_07_07_2020.csv',
                    stringsAsFactors = F)
fu_df <- read.csv('Cleaned_quit_and_CO_data_07_07_2020.csv',
                  stringsAsFactors = F)
seed <- scan(file = 'seed.txt')
setwd('..')

# Set seed for shuffling data (for reproducibility)
set.seed(seed)

# 1.3) Functions

# 1.3.1) hash
hash <- function(x, table) {
  if (is.na(x)) {
    return(NA)
  } else {
    return(match(x, table))
  }
}

###
### 2) Scrub PHI
###

# Remove columns with unscrubbable PHI
base_df <- base_df %>%
  select(
    -what_treatment,
    -notes_1,
  )

# 2.1) Remove clinic information

# Build clinic information from all columns with this info
clinics <- base_df %>%
  pull(
    PCP_Org_BEST
  )
clinics <- fu_df %>%
  select(
    matches('^PCP\\..*\\.Clinic$')
  ) %>%
  pivot_longer(
    everything(),
    names_to = 'VarName',
    values_to = 'ClinicName'
  ) %>%
  pull(
    ClinicName
  ) %>%
  append(
    clinics
  )

# Reduce to unique values and shuffle
uniClins <- unique(clinics)
shfClins <- sample(uniClins)

# Replace values
base_df <- base_df %>%
  mutate(
    PCP_Org_BEST = modify(PCP_Org_BEST, hash, shfClins)
  )
fu_df <- fu_df %>%
  mutate(
    across(
      matches('^PCP\\..*\\.Clinic$'), 
      ~modify(., hash, shfClins)
    )
  )


# 2.2) Remove PCP information
# Pull unique PCP info
pcp <- fu_df %>%
  select(
    matches('^PCP\\..*\\.(NPI$|Name$)')
  ) %>%
  pivot_longer(
    everything(),
    names_to = c('tp', '.value'),
    names_prefix = 'PCP.',
    names_pattern = '(.*)\\.(.*)',
    values_drop_na = T
  ) %>%
  select(
    -tp
  ) %>%
  distinct()

# Shuffle PCP info and turn ' ' into NA
shfPcp <- pcp %>%
  slice_sample(
    n = nrow(pcp)
  ) %>%
  mutate(
    Name = na_if(Name, ' ')
  )

# Replace values
fu_df <- fu_df %>%
  mutate(
    across(
      matches('^PCP\\..*\\.NPI$'),
      ~modify(., hash, shfPcp$NPI)
    ),
    across(
      matches('^PCP\\..*\\.Name$'),
      ~modify(., hash, shfPcp$Name)
    )
  )

###
### 3) Shuffle Datasets
###

# 3.1) Combine two datasets

# Rename filter column
base_df <- base_df %>%
  rename(
    `filter_..x` = `filter_.`
  )
fu_df <- fu_df %>%
  rename(
    `filter_..y` = `filter_.`
  )

# Combine into one
uni_df <- full_join(base_df, fu_df, by = c('study_id' = 'studyid'))


# 3.2) Define groups to shuffle

# Study ID is on its own, make duplicate column for final set
study_id <- uni_df %>%
  select(
    study_id
  ) %>%
  mutate(
    studyid = study_id
  )

# Randomization variables
rndmz <- uni_df %>%
  select(
    matches('_z$'),
    TAU,
    CHW_rand,
    Arm,
    SSS.CHR.Randomization,
    rx_FINAL,
    group_FINAL,
    engagementqual,
    Engaged_BayCoveOnly,
    smallclinicrandomizarion,
    ANYTAU
  )

# Demographics information
demo <- uni_df %>%
  select(
    age_1,
    sex_1,
    race_1,
    new_race_MCM,
    other_race,
    ethnic,
    under40
  )

# All other information
usedCols <- c(
  names(study_id),
  names(rndmz),
  names(demo)
)
other <- uni_df[, !(names(uni_df) %in% usedCols)]

# 3.3) Combine and shuffle dfs
dfs <- list(study_id, rndmz, demo, other)
shfdfs <- list()
for (i in 1:length(dfs)) {
  shfdfs <- append(shfdfs, sample_n(dfs[[i]], nrow(dfs[[i]])))
}
shf_uni_df <- bind_rows(shfdfs)

# Separate into original dataframes
shf_base_df <- shf_uni_df[, names(base_df)]
shf_base_df <- shf_base_df %>%
  rename(
    `filter_$` = `filter_..x`
  )
shf_fu_df <- shf_uni_df[, names(fu_df)]
shf_fu_df <- shf_fu_df %>%
  rename(
    `filter_$` = `filter_..y`
  )

# 3.4) Write to data folder
setwd('data')
write.csv(shf_base_df, file = 'baseline.csv', row.names = F)
write.csv(shf_fu_df, file = 'cleaned_quit_and_co.csv', row.names = F)
setwd('..')


