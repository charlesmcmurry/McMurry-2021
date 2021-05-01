################################################################################
## Script 4: Regressions
## Author: Charlie McMurry
################################################################################


# Section 1: run regressions (pre-robustness checks)


  # basic regression with no controls
  
    reg1.1 = lm(pct_change ~ trust_govt, data = final_data_1w)
    summary(reg1.1)
  
  
  # same as above but with controls
  
    reg1.2 = lm(pct_change ~ trust_govt + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response, data = final_data_1w)
    summary(reg1.2)

    
  # same as above but with clustered standard errors AND country fixed effects
    
    reg1.3 = plm(pct_change ~ trust_govt + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg1.3)
  
  
  # compile all of the above into one table and export it
  
    regtable_1 = stargazer(reg1.1, reg1.2, reg1.3,
                           type = 'latex',
                           font.size = 'tiny',
                           omit.stat=c("f", "ser"),
                           covariate.labels = c('Trust government', 'Democracy', 'Stringency', 'ln(GDP)', 'Informed', 'Density', 'Urban', 'Cases', 'Response'),
                           dep.var.labels = c("Percent Change in Movement"),
                           omit="country", 
                           add.lines = list(c("Country fixed effects", rep("No", 2), "Yes"),
                                            c("Clustered SEs", rep("No", 2), "Yes")),
                           # title = "Table 1: Main Regression Results",
                           #notes = c('Regional GDP estimated using', 'nighttime light intensity.'),
                           out = paste0(output_path,"regtable_1.htm"))
    
    #star_tex_write(regtable_1, file = paste0(output_path,"regtable_1.tex"), headers = FALSE)
  
  
  

# Section  2: run robustness checks

    
  # format of regression name = 2.x.y (where x = check #, y = specification #)
  
    
  # check 1: excluding Mauritius
    reg2.1.1 = plm(pct_change ~ trust_govt + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w_NM, model="pooling", index=c("country"))
    summary(reg2.1.1)
  
  
  # check 2: using the following explanatory vars: [all individual trust vars], obey_law, fear_intimidation
    reg2.2.1 = plm(pct_change ~ trust_president + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.2.1)
    
    reg2.2.2 = plm(pct_change ~ trust_parliament + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.2.2)
    
    reg2.2.3 = plm(pct_change ~ trust_ruling_party + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.2.3)
    
    reg2.2.4 = plm(pct_change ~ obey_law_always + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.2.4)
    
    reg2.2.5 = plm(pct_change ~ fear_intimidation + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.2.5)
    
    
# check 3: different populations
    
    # cross effects of Nigeria
    reg2.3.1 = plm(pct_change ~ trust_govt + trust_nigeria + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.3.1)
    
    # cross effects of above median population
    reg2.3.2 = plm(pct_change ~ trust_govt + trust_large + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.3.2)
    
    # cross effects of fraction speaking Bantu languages
    reg2.3.3 = plm(pct_change ~ trust_govt + trust_bantu + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.3.3)
    
    # GDP per capita rather than GDP
    reg2.3.4 = plm(pct_change ~ trust_govt + GDP_light_pc + polity + stringency + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1w, model="pooling", index=c("country"))
    summary(reg2.3.4)
  
  
# check 4: different timeframes for movement change (+/- 1 day, 2 weeks)
 
    # 1 day timeframe
      final_data_1d_filter = final_data_1d %>% filter(region != 'Moka' & region != 'Savanne')
      reg2.4.1 = plm(pct_change ~ trust_govt + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1d_filter, model="pooling", index=c("country"))
      summary(reg2.4.1) 
    
    # 2 week timeframe
      reg2.4.2 = plm(pct_change ~ trust_govt + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_2w, model="pooling", index=c("country"))
      summary(reg2.4.2)
      
    # 1 month timeframe
      reg2.4.3 = plm(pct_change ~ trust_govt + polity + stringency + GDP_light + informed + density + urban + total_cases + medical_response + factor(country) - 1, data = final_data_1m, model="pooling", index=c("country"))
      summary(reg2.4.3)
      
    
  # combine all robustness checks into one table
  
    regtable_2 =  stargazer(reg1.3, reg2.1.1, reg2.2.1, reg2.2.2, reg2.2.3, reg2.3.1, reg2.3.2, reg2.3.3, reg2.3.4, reg2.4.1, reg2.4.2, reg2.4.3,
                            type = 'latex',
                            font.size = 'tiny',
                            omit.stat=c("f", "ser"),
                            covariate.labels = c('Trust government', "Trust president", "Trust parliament", "Trust ruling party", "Trust × Nigeria", "Trust × Populous", 'Trust × Bantu %', 'ln(GDP p/c)', 'Democracy', 'Stringency', 'ln(GDP)', 'Informed', 'Density', 'Urban', 'Cases', 'Response'),
                            dep.var.labels = c("Percent Change in Movement"),
                            omit="country", 
                            add.lines = list( c("Country fixed effects", rep("Yes", 12)),
                                              c("Clustered SEs", rep("Yes", 12)),
                                              c("Excludes Mauritius", "No", "Yes", rep("No", 10)),
                                              c("Timeframe", rep("1 week", 9), "1 day", "2 weeks", "1 month")),
                            # title = "Table 2: Robustness Checks",
                            notes = c(
                                      # 'Standard errors in parentheses.', 'Trust in government = average of region\'s trust in president, parliament, and ruling party.', 
                                      'Nigeria = 1 for subregions in Nigeria. Populous = 1 for the top 50% most populous subregions in the dataset.' 
                                      # 'Regional GDP estimated using nighttime light intensity.'
                                      ),
                            out = paste0(output_path,"regtable_2.htm")) 
  
