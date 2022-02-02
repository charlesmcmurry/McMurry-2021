################################################################################
## Master Script
## Author: Charles McMurry
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
  library(networkD3)
  library(webshot)


##############################
# 2 - Other setup
##############################
  
  options(scipen = 999)
  rm(list=ls())
  cat("\f")


##############################
# 3 - Set directory paths
##############################

  code_path   = "replace this with the filepath of the 'Code' folder"
  input_path  = "replace this with the filepath of the 'Inputs' folder"
  output_path = "replace this with the filepath of where you'd like the regressions to go"


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
    
  # Run this script to run regressions
    setwd(code_path)
    source('regressions.R', echo = TRUE)    
    
    