################################################################################
## Script 2B: National
## Author: Charlie McMurry
################################################################################


# Section 1B: prepare afrobarometer data for analysis

  trust_by_country =  afro_barom %>%
                      mutate(trust_prez = ifelse(Q43A == 'Somewhat' | Q43A == 'A lot', 1, 0),
                             trust_parl = ifelse(Q43B == 'Somewhat' | Q43B == 'A lot', 1, 0),
                             trust_prty = ifelse(Q43E == 'Somewhat' | Q43E == 'A lot', 1, 0),
                             trust_plce = ifelse(Q43G == 'Somewhat' | Q43G == 'A lot', 1, 0),
                             trust_crts = ifelse(Q43I == 'Somewhat' | Q43I == 'A lot', 1, 0),
                             obey_law   = ifelse(Q38B == 'Agree' | Q38B == 'Strongly Agree', 1, 0),
                             informed   = ifelse(Q12A == 'Every day', 1, ifelse(
                                                 Q12B == 'Every day', 1, ifelse(
                                                 Q12C == 'Every day', 1, ifelse(
                                                 Q12D == 'Every day', 1, ifelse(
                                                 Q12E == 'Every day', 1, 0))))
                                                 )
                             ) %>%
                      group_by(COUNTRY) %>%
                      summarise(n = n(),
                                trust_prez = mean(trust_prez),
                                trust_parl = mean(trust_parl),
                                trust_prty = mean(trust_prty),
                                trust_plce = mean(trust_plce),
                                trust_crts = mean(trust_crts),
                                trust_govt = mean(c(trust_prez, trust_parl, trust_prty, trust_plce, trust_crts)),
                                obey_law   = mean(obey_law),
                                informed   = mean(informed))
  

  
# Section 3: Calculate change in movement due to lockdown imposition + other lockdown stats
  
  
  # create list of countries and dates to iterate through
    dates = list(country = lockdown_dates$country, date = lockdown_dates$date)
  
  
     # create dataframe of countries and their corresponding average movement x # days before lockdown
       week_before = data.frame(country = character(0), before_avg = numeric(0))
  
       for (i in seq(from = 1, to = length(dates$country))){
         country = dates$country[i]
         google_filter = google %>% filter(country_region == country)
         date = dates$date[i]
         before_avg = mean(c(
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d'))-7)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d'))-6)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d'))-5)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d'))-4)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d'))-3)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d'))-2)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d'))-1)]
                             ), na.rm=T)
         week_before = week_before %>% add_row(country = country, before_avg = before_avg)
       }
  
  
     # create dataframe of countries and their corresponding average movement x # of days after lockdown
       week_after = data.frame(country = character(0), after_avg = numeric(0))
  
       for (i in seq(from = 1, to = length(dates$country))){
         country = dates$country[i]
         google_filter = google %>% filter(country_region == country)
         date = dates$date[i]
         after_avg =  mean(c(
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(lockdown_dates$date[1] - as.Date("2020-02-14", format = '%Y-%m-%d'))+7)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(lockdown_dates$date[1] - as.Date("2020-02-14", format = '%Y-%m-%d'))+6)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(lockdown_dates$date[1] - as.Date("2020-02-14", format = '%Y-%m-%d'))+5)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(lockdown_dates$date[1] - as.Date("2020-02-14", format = '%Y-%m-%d'))+4)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(lockdown_dates$date[1] - as.Date("2020-02-14", format = '%Y-%m-%d'))+3)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(lockdown_dates$date[1] - as.Date("2020-02-14", format = '%Y-%m-%d'))+2)],
                             google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(lockdown_dates$date[1] - as.Date("2020-02-14", format = '%Y-%m-%d'))+1)]
         ), na.rm=T)
         week_after = week_after %>% add_row(country = country, after_avg = after_avg)
       }
       
       
# Section 4: Combine into final dataset and analyze it
       
    # create final dataset
      compliance = left_join(lockdown_dates, week_before, by = 'country') %>%
                   left_join(week_after, by = 'country') %>%
                   mutate(arith_change = after_avg - before_avg) %>% 
                   mutate(pct_change = 100 * ((after_avg - before_avg) / (before_avg + 100)) ) %>% 
                   mutate(strict = ifelse(type == 3, 1, 0)) %>%
                   left_join(trust_by_country, by = c('country' = 'COUNTRY')) %>%
                   left_join(GDP_pc, by = c('country' = 'Country_Name')) %>%
                   left_join(density, by = c('country' = 'Region')) %>%
                   left_join(urban, by = c('country' = 'Country_Name')) %>%
                   left_join(covid_stats %>% select(-c(date)), by = c('country' = 'country'))
       
       
    # create correlation matrix to evaluate controls
      rcorr(as.matrix(compliance %>% select(-c(country, date, Country_Code, before_avg, after_avg, n, type))))
       
       
    # filter out Morocco and countries with no data
       compliance_filter = compliance %>% 
                           filter(country != 'Morocco') %>%
                           filter(is.nan(pct_change) == FALSE)
       
       
    # create summary stats table
       x = compliance_filter$total_deaths
       print(paste0("Mean is: ", mean(x)))
       print(paste0("Median is: ", median(x)))
       print(paste0("SD is: ", sd(x)))
       print(paste0("Min is: ", min(x)))
       print(paste0("Max is: ", max(x)))
       
       
    # summarize countries in sample
       x = compliance_filter$density
       pop = compliance_filter$population
       print(paste0("Mean is: ", weighted.mean(x, pop)))
       
       
       
    # run preliminary regressions
       summary(lm(compliance ~ trust_prez + I(trust_prez^2), data = compliance_filter))
       summary(lm(compliance ~ obey_law, data = compliance_filter))
       summary(lm(compliance ~ trust_prez + strict + informed + total_cases + total_deaths + stringency + life_expectancy + hdi, data = compliance_filter))
       
       
       compliance_filter %>% ggplot() + aes(x = trust_prez, y = pct_change) + geom_point() +  theme_clean() +
                             geom_text(aes(label = country), nudge_y = 3) +
                             labs(title = "Trust in Government and Lockdown Compliance",
                                  y= "% Change in Movement",
                                  x = "% Trust President") +
                             theme(plot.caption = element_text(size = 5),
                                   plot.title = element_text(size = 9, face = "bold"),
                                   legend.position = "bottom",
                                   legend.title = element_text(size = 7),
                                   legend.text = element_text(size = 7)) +
                             ggsave(paste0(output_path, "graph.png"))
       