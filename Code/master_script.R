################################################################################
## Master Script
## Author: Charlie McMurry
################################################################################


##############################
# 1 - Load libraries
##############################

  library(knitr)
  library(xtable)
  library(ggplot2)
  library(tidyr)
  library(dplyr)
  library(scales)
  library(rootSolve)
  library(nloptr)
  library(ggthemes)
  library(reshape2)
  library(read.dbc)
  library(naniar)
  library(stringr)
  library(readr)
  library(lubridate)
  library(foreign)
  library(haven)
  library(geobr)
  library(stargazer)
  library(starpolishr)
  library(Hmisc)
  library(rlist)
  library(readxl)
  library(plm)
  library(lmtest)
  library(multiwayvcov)
  library(tidyverse)
  library(caret)


##############################
# 2 - Other setup
##############################
  
  options(scipen = 999)
  rm(list=ls())
  cat("\f")


##############################
# 3 - Set directory paths
##############################

  rm(list=ls())
  path        = '/Users/ianm1/Dropbox/Econ_191_paper/'
  code_path   = paste0(path,'Code/')
  input_path  = paste0(path,'Inputs/')
  output_path = paste0(path,'Outputs/')


##############################
# 4 - Code
##############################

  # Run these in this order!
  
  # Run this script to load all necessary data
    setwd(code_path)
    source('load_data.R', echo = TRUE)
  
  # Run this script to prepare the data for analysis
    setwd(code_path)
    source('prep_data.R', echo = TRUE)
    
  # Run this script to explore the final dataset
    setwd(code_path)
    source('stats.R', echo = TRUE)  
    
  # Run this script to run regressions
    setwd(code_path)
    source('regressions.R', echo = TRUE)    
    
    