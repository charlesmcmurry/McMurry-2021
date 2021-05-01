################################################################################
## Script 3: Statistics
## Author: Charlie McMurry
################################################################################


# plot relationship studied (with outliers)
  
  final_data_1w %>% ggplot() + 
                    aes(x = trust_govt, y = pct_change) + 
                    geom_point() + 
                    #geom_text(aes(label=country), size = 3, nudge_y = 3) +
                    geom_smooth(method = "lm", se = FALSE) +
                    theme_clean() +       
                    labs(
                      # title = "Trust in Government and Lockdown Compliance",
                      y     = "% change in movement after lockdown", 
                      x     = "% Who Trust Government"
                    ) +
                    theme(plot.caption = element_text(size = 5), 
                          plot.title = element_text(size = 9, face = "bold"), 
                          legend.position = "bottom", 
                          legend.title = element_text(size = 7),
                          legend.text = element_text(size = 7)) +
                    ggsave(paste0(output_path, "scatter.png"))

  final_data_1w_NM %>%  ggplot() + 
                        aes(x = trust_govt, y = pct_change) + 
                        geom_point() + 
                        #geom_text(aes(label=country), size = 3, nudge_y = 3) +
                        geom_smooth(method = "lm", se = FALSE) +
                        theme_clean() +       
                        labs(
                          # title = "Trust in Government and Lockdown Compliance",
                          y     = "% change in movement after lockdown", 
                          x     = "% Who Trust Government"
                        ) +
                        theme(plot.caption = element_text(size = 5), 
                              plot.title = element_text(size = 9, face = "bold"), 
                              legend.position = "bottom", 
                              legend.title = element_text(size = 7),
                              legend.text = element_text(size = 7)) +
                        ggsave(paste0(output_path, "scatter_NM.png"))
  
  
# examine correlations 
  
  rcorr(as.matrix(final_data_1w %>% select(-c(country, region, date, Country_Code, before_avg, after_avg, type))))
  rcorr(as.matrix(final_data_1w %>% select(c(total_cases, GDP_pc, density, stringency))))
  rcorr(as.matrix(final_data_1w %>% select(c(GDP_pc, lnRegGDP, GDP_light, GDP_light_pc))))
  rcorr(as.matrix(final_data_1w %>% select(c(trust_govt, polity, stringency, GDP_light, informed, density, urban, total_cases, medical_response))))
  
  
# summarize subregions in sample
  
  x = final_data_1w$urban
  pop = final_data_1w$population
  print(paste0("Mean is: ", weighted.mean(x, pop)))
  
  
# study GDP proxy
  
  rcorr(as.matrix(final_data_1w %>% select(c("GDP_light", "GDP_light_pc", "lnRegGDP", "GDP_pc", "college_educated", "own_smartphone", "urban", "population"))))
  
  final_data_1w %>% ggplot() + 
                    aes(x = own_smartphone, y = GDP_light_pc) + 
                    geom_point() + 
                    geom_smooth(method = "lm", se = FALSE) +
                    theme_clean() +       
                    labs(y = "log GDP per capita (estimate)", 
                         x = "% who own a smartphone") +
                    theme(plot.caption = element_text(size = 5), 
                          plot.title = element_text(size = 9, face = "bold"), 
                          legend.position = "bottom", 
                          legend.title = element_text(size = 7),
                          legend.text = element_text(size = 7)) +
                    ggsave(paste0(output_path, "own_smartphone.png"))
  
  final_data_1w %>% ggplot() + 
                    aes(x = log(GDP_pc), y = GDP_light_pc) + 
                    geom_point() + 
                    geom_smooth(method = "lm", se = FALSE) +
                    theme_clean() +       
                    labs(y = "region's log GDP per capita (estimate)", 
                         x = "country's log GDP per capita") +
                    theme(plot.caption = element_text(size = 5), 
                          plot.title = element_text(size = 9, face = "bold"), 
                          legend.position = "bottom", 
                          legend.title = element_text(size = 7),
                          legend.text = element_text(size = 7)) +
                    ggsave(paste0(output_path, "GDP_pc.png"))
  
  final_data_1w %>% ggplot() + 
                    aes(x = lnRegGDP, y = GDP_light) + 
                    geom_point() + 
                    geom_smooth(method = "lm", se = FALSE) +
                    theme_clean() +       
                    labs(y = "region's log GDP (my estimate)", 
                         x = "region's log GDP (Gennaoli et al estimate)") +
                    theme(plot.caption = element_text(size = 5), 
                          plot.title = element_text(size = 9, face = "bold"), 
                          legend.position = "bottom", 
                          legend.title = element_text(size = 7),
                          legend.text = element_text(size = 7)) +
                    ggsave(paste0(output_path, "lnRegGDP.png"))
  
  
  
# create summary stats table
  
  # step 1 : create list of variables to generate summary stats for
  
    summary_vars = list(final_data_1w$pct_change, final_data_1w$trust_govt, final_data_1w$polity, final_data_1w$stringency, final_data_1w$GDP_light, 
                        final_data_1w$informed, final_data_1w$density, final_data_1w$urban, final_data_1w$total_cases, 
                        final_data_1w$medical_response)
    
    summary_var_names = list("PctChange", "Trust", "Democracy", "Stringency", "ln(GDP)", "Informed", "Density", "Urban", "Cases", "Response")
    
    length(summary_vars) == length(summary_var_names)
  
  
  # step 2: populate empty dataframe with stats on each variable
  
    summary_table = data.frame(Variable = character(0), Mean = numeric(0), SD = numeric(0), Min = numeric(0), Median = numeric(0), Max = numeric(0))
    
    for (i in seq(from = 1, to = length(summary_vars))){
      
      variable_value = summary_var_names[[i]]
      mean_value     = mean(summary_vars[[i]])
      median_value   = median(summary_vars[[i]])
      SD_value       = sd(summary_vars[[i]])
      min_value      = min(summary_vars[[i]])
      max_value      = max(summary_vars[[i]])
      
      summary_table = summary_table %>% add_row(Variable = variable_value, Mean = mean_value, SD = SD_value, 
                                                Min = min_value, Median = median_value, Max = max_value)
    }
  
  
  # step 3: convert dataframe into a table that can be easily copied
  
    write_excel_csv(summary_table, paste0(output_path, "Summary_Stats.csv"))
    
    