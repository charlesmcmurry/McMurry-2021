################################################################################
## Script 2: Prepare Data
## Author: Charlie McMurry
################################################################################


# Section 1: clean afrobarometer data and aggregate at subnational level

  trust_by_subregion =  afro_barom %>% 
                        #Botswana
                        mutate(REGION = ifelse(substr(REGION, 1, 7) == "Central", "Central", as.character(REGION))) %>% 
                        mutate(REGION = ifelse(REGION == "Barolong", "Southern", as.character(REGION))) %>% 
                        mutate(REGION = ifelse(COUNTRY == "Botswana" & REGION == "Central", "Central_Botswana", as.character(REGION))) %>% 
                        #Cabo Verde
                        mutate(REGION = ifelse(COUNTRY == "Cabo Verde" & REGION == "Santiago - Praia", "Praia", as.character(REGION))) %>%
                        #Ghana
                        mutate(REGION = ifelse(COUNTRY == "Ghana" & REGION == "Central", "Central_Ghana", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Ghana" & REGION == "Northern", "Northern_Ghana", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Ghana" & REGION == "Western", "Western_Ghana", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Ghana" & REGION == "Eastern", "Eastern_Ghana", as.character(REGION))) %>%
                        #Kenya
                        mutate(REGION = ifelse(REGION == "Eastern_duplicated_302", "East", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Western_duplicated_305", "West", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Kenya" & REGION == "Central", "Central_Kenya", as.character(REGION))) %>%
                        #Mauritius
                        mutate(REGION = ifelse(REGION == "Black River", "Rivière Noire", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Plaine Wilhems", "Plaines Wilhems", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Riv Du Rempart", "Rivière du Rempart", as.character(REGION))) %>%
                        #Namibia
                        mutate(REGION = ifelse(substr(REGION, 1, 7) == "Kavango", "Kavango", as.character(REGION))) %>%
                        #Nigeria
                        mutate(REGION = ifelse(REGION == "Fct Abuja", "Federal Capital Territory", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Plateau_duplicated_651", "Plateau", as.character(REGION))) %>%
                        #Senegal
                        mutate(REGION = ifelse(REGION == "Thies", "Thiès", as.character(REGION))) %>%
                        #South Africa
                        mutate(REGION = ifelse(REGION == "Kwazulu-Natal", "KwaZulu-Natal", as.character(REGION))) %>%
                        #Togo
                        mutate(REGION = ifelse(COUNTRY == "Togo" & REGION == "Central", "Centrale", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Lome", "Maritime", as.character(REGION))) %>%
                        #Uganda
                        mutate(REGION = ifelse(REGION == "Acholi", "Northern", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Busoga", "Eastern", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Eastern_duplicated_783", "Eastern", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Karamoja", "Northern", as.character(REGION))) %>%
                        mutate(REGION = ifelse(REGION == "Lango", "Northern", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Uganda" & REGION == "Central", "Central_Uganda", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Uganda" & REGION == "Northern", "Northern_Uganda", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Uganda" & REGION == "Western", "Western_Uganda", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Uganda" & REGION == "Eastern", "Eastern_Uganda", as.character(REGION))) %>%
                        #Zambia
                        mutate(REGION = ifelse(COUNTRY == "Zambia" & REGION == "Central", "Central_Zambia", REGION)) %>% 
                        mutate(REGION = ifelse(COUNTRY == "Zambia" & REGION == "Northern_duplicated_825", "Northern_Zambia", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Zambia" & REGION == "Southern", "Southern_Zambia", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Zambia" & REGION == "Western_duplicated_828", "Western_Zambia", as.character(REGION))) %>%
                        mutate(REGION = ifelse(COUNTRY == "Zambia" & REGION == "Eastern_duplicated_823", "Eastern_Zambia", as.character(REGION))) %>%
                        #Ok cleaning is done!
                        mutate(trust_president     = ifelse(Q43A == 'Somewhat' | Q43A == 'A lot', 1, 0),
                               trust_parliament    = ifelse(Q43B == 'Somewhat' | Q43B == 'A lot', 1, 0),
                               trust_ruling_party  = ifelse(Q43E == 'Somewhat' | Q43E == 'A lot', 1, 0),
                               trust_police        = ifelse(Q43G == 'Somewhat' | Q43G == 'A lot', 1, 0),
                               trust_courts        = ifelse(Q43I == 'Somewhat' | Q43I == 'A lot', 1, 0),
                               obey_law_always     = ifelse(Q38B == 'Agree' | Q38B == 'Strongly Agree', 1, 0),
                               informed            = ifelse(Q12A == 'Every day', 1, ifelse(
                                                            Q12B == 'Every day', 1, ifelse(
                                                            Q12C == 'Every day', 1, ifelse(
                                                            Q12D == 'Every day', 1, ifelse(
                                                            Q12E == 'Every day', 1, 0))))),
                               fear_intimidation   = ifelse(Q40  == 'Somewhat' | Q40 == 'A lot', 1, 0),
                               healthcare_contact  = ifelse(Q49D == 'Yes', 1, 0),
                               healthcare_easiness = ifelse(Q49E == 'Easy' | Q49E == 'Very easy', 1, 0),
                               medical_response    = ifelse(Q49F == 'After a short time' | Q49F == 'Right away', 1, 0),
                               good_public_health  = ifelse(Q56G == 'Very Well' | Q56G == 'Fairly Well', 1, 0),
                               own_smartphone      = ifelse(Q90  == 'Yes, has internet', 1, 0),
                               college_educated    = ifelse(Q97 == 'Some university' | Q97 == 'University completed', 1, 0),
                               agriculture         = ifelse(Q95A == 'Agriculture / farming / fishing / forestry', 1, 0),
                               clinic_nearby       = ifelse(EA_FAC_D == "Yes", 1, 0),
                               urban               = ifelse(URBRUR == "Urban", 1, 0),
                               bantu = ifelse(Q2A %in% bantu$name, 1, 0)
                               ) %>% 
                        group_by(COUNTRY, REGION) %>%  
                        summarise(n = n(),
                                  trust_president    = 100*mean(trust_president),
                                  trust_parliament   = 100*mean(trust_parliament),
                                  trust_ruling_party = 100*mean(trust_ruling_party),
                                  trust_govt         = mean(c(trust_president, trust_parliament, trust_ruling_party)),
                                  trust_police       = 100*mean(trust_police),
                                  trust_courts       = 100*mean(trust_courts),
                                  obey_law_always    = 100*mean(obey_law_always),
                                  informed           = 100*mean(informed),
                                  fear_intimidation  = 100*mean(fear_intimidation),
                                  healthcare_contact = 100*mean(healthcare_contact),
                                  medical_response   = 100*mean(medical_response),
                                  good_public_health = 100*mean(good_public_health),
                                  own_smartphone     = 100*mean(own_smartphone),
                                  college_educated   = 100*mean(college_educated),
                                  agriculture        = 100*mean(agriculture),
                                  clinic_nearby      = 100*mean(clinic_nearby),
                                  urban              = 100*mean(urban),
                                  bantu              = 100*mean(bantu)
                                  )
  
  
  

# Section 2: clean names of google subregions
  
  
  # create final list of filtered countries 
  
    countries_filtered = list(countries_final)
  
  
  # clean subregion names in google data 
  
    google_cleaned =  google %>% 
                      #Botswana
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Serowe", "Central", as.character(sub_region_1))) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Orapa", "Central", as.character(sub_region_1))) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Central", "Central_Botswana", as.character(sub_region_1))) %>% 
                      #Burkina Faso 
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Boucle du Mouhoun Region", "Boucle Du Mouhoun", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Centre-Est Region", "Centre Est", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Centre-Nord Region", "Centre Nord", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Centre-Ouest Region", "Centre Ouest", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Centre Region", "Centre", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Hauts-Bassins Region", "Hauts Bassins", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Nord Region", "Nord", as.character(sub_region_1))) %>%
                      #Cabo Verde
                      mutate(sub_region_1 = ifelse(sub_region_1 == "SÃ£o Vicente", "São Vicente", as.character(sub_region_1))) %>% 
                      #Gabon
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Haut-Ogooue", "Haut-Ogooué", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Ogooue-Maritime", "Ogooué-Maritime", as.character(sub_region_1))) %>%
                      #Ghana
                      mutate(sub_region_1 = ifelse(metro_area == "Accra Metropolitan Area", "Greater Accra", as.character(sub_region_1))) %>%
                      mutate(sub_region_1 = ifelse(metro_area == "Kumasi Metropolitan Area", "Ashanti", as.character(sub_region_1))) %>%
                      #Kenya
                      mutate(sub_region_2 = ifelse(country_region == "Kenya", sub_region_1, sub_region_2)) %>% 
                      mutate(sub_region_2 = ifelse(str_sub(sub_region_2, -7, -1) == " County", str_sub(sub_region_2, 1, -8), sub_region_2)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Mombasa', 'Kwale', 'Kilifi', 'Tana River', 'Lamu', 'Taita-Taveta'), "Coast", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Garissa', 'Wajir', 'Mandera'), "North Eastern", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Marsabit', 'Isiolo', 'Meru', 'Tharaka-Nithi', 'Embu', 'Kitui', 'Machakos', 'Makueni'), "East", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Nyandarua', 'Nyeri', 'Kirinyaga', 'Muranga', 'Kiambu'), "Central", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Turkana', 'West Pokot', 'Samburu', 'Trans-Nzoia', 'Uasin Gishu', 'Elgayo-Marakwet', 'Nandi', 'Baringo', 'Laikipia', 'Nakuru', 'Narok', 'Kajiado', 'Kericho', 'Bomet'), "Rift Valley", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Kakamega', 'Vihiga', 'Bungoma', 'Busia'), "West", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Siaya', 'Kisumu', 'Homa Bay', 'Migori', 'Kisii', 'Nyamira'), "Nyanza", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_2 %in% c('Nairobi'), "Nairobi", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(country_region == "Kenya" & sub_region_1 == "Central", "Central_Kenya", sub_region_1)) %>% 
                      #Mauritius
                      mutate(sub_region_1 = ifelse(sub_region_1 == "RiviÃ¨re du Rempart District", "Rivière du Rempart", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(sub_region_1 == "RiviÃ¨re Noire District", "Rivière Noire", sub_region_1)) %>% 
                      mutate(sub_region_1 = ifelse(str_sub(sub_region_1, -9, -1) == " District", str_sub(sub_region_1, 1, -10), sub_region_1)) %>%
                      #Namibia
                      mutate(sub_region_1 = ifelse(str_sub(sub_region_1, -7, -1) == " Region", str_sub(sub_region_1, 1, -8), sub_region_1)) %>% 
                      #Nigeria
                      mutate(sub_region_1 = ifelse(sub_region_1 == "Ogun State", "Ogun", sub_region_1)) %>% 
                      #Senegal
                      mutate(sub_region_1 = ifelse(sub_region_1 == "ThiÃ¨s", "Thiès", sub_region_1)) %>%
                      mutate(sub_region_1 = ifelse(sub_region_1 == "SÃ©dhiou", "Sédhiou", sub_region_1)) %>% 
                      #Uganda
                      mutate(sub_region_1 = ifelse(country_region == "Uganda" & sub_region_1 == "Central", "Central_Uganda", sub_region_1)) %>%
                      mutate(sub_region_1 = ifelse(country_region == "Uganda" & sub_region_1 == "Northern", "Northern_Uganda", sub_region_1)) %>%
                      mutate(sub_region_1 = ifelse(country_region == "Uganda" & sub_region_1 == "Western", "Western_Uganda", sub_region_1)) %>%
                      mutate(sub_region_1 = ifelse(country_region == "Uganda" & sub_region_1 == "Eastern", "Eastern_Uganda", sub_region_1)) %>%
                      # Zambia
                      mutate(sub_region_1 = ifelse(metro_area == "Lusaka Metropolitan Area", "Lusaka", sub_region_1)) %>% 
                      #Zimbabwe
                      mutate(sub_region_1 = ifelse(str_sub(sub_region_1, -9, -1) == " Province", str_sub(sub_region_1, 1, -10), sub_region_1)) %>%
                      #Ok cleaning is done!
                      filter(sub_region_1 != '') 
  
  
  # collapse google data for comparison 
  
    google_cleaned_2 = google_cleaned %>% 
                       group_by(country_region, sub_region_1, sub_region_2, metro_area) %>% 
                       summarise(n = n())

  
  
  
# Section 4: get list of subregions that appear in both afrobarometer and google data
  
  
  # create empty dataframe to populate
  
    subregions_1 = data.frame(country = character(0), sr1 = character(0), sr2 = character(0), n_afro = numeric(0), n_goog = numeric(0))
  
  
  # iterate through all countries 
    
    for (i in countries_final){
      test_country = i
      
      test_rows = full_join(filter(trust_by_subregion, COUNTRY == test_country), 
                       filter(google_cleaned_2, country_region == test_country),
                       by = c('REGION' = 'sub_region_1')) %>% 
             select(c(COUNTRY, REGION, sub_region_2, n.x, n.y)) %>% 
             filter(is.na(n.x) == FALSE & is.na(n.y) == FALSE) %>% 
             rename(n_afro = n.x, n_goog = n.y)
      
      subregions_1 = rbind(subregions_1, test_rows)
    }
    
    
  # choose which sr1 / sr2 combos to use if duplicate sr1's 
    
    subregions_2 = subregions_1 %>% arrange(desc(n_goog), -n_goog)
    subregions_2 = subregions_2[!duplicated(subregions_2$REGION),]
  
    
  
  
# Section 5: Calculate change in movement due to lockdown imposition 
  
  
  # create list of regions and dates to iterate through
    
    trust_by_subregion_2 = trust_by_subregion %>% filter(COUNTRY %in% subregions_2$COUNTRY & REGION %in% subregions_2$REGION) %>% arrange(REGION)
    dates_subregion = left_join(select(trust_by_subregion_2, c('COUNTRY', 'REGION')), lockdown_dates, by = c('COUNTRY' = 'country'))
    
  
  # create dataframe of regions and their corresponding average movement ONE WEEK before/after lockdown
    
    one_w_before_subregion = data.frame(country = character(0), region = character(0), before_avg = numeric(0))
    
  
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
      
        google_filter    = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        before_avg_value = mean(c(
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -7)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -6)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -5)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -4)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -3)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -2)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -1)]
                                  ), na.rm=T)
        
        one_w_before_subregion = one_w_before_subregion %>% add_row(country = country_value, region = region_value, before_avg = before_avg_value)
        }
    }

    
    one_w_after_subregion = data.frame(country = character(0), region = character(0), after_avg = numeric(0))
    
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
        
        google_filter = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        after_avg_value = mean(c(
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +7)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +6)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +5)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +4)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +3)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +2)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +1)]
                                 ), na.rm=T)
        
        one_w_after_subregion = one_w_after_subregion %>% add_row(country = country_value, region = region_value, after_avg = after_avg_value)
      }
    }
    
    movement_change_1w =  full_join(one_w_before_subregion, one_w_after_subregion, by = c('country', 'region')) %>% 
                          mutate(arith_change = after_avg - before_avg) %>% 
                          mutate(pct_change = 100 * ((after_avg - before_avg) / (before_avg + 100)) )
 
    
  # create dataframe of regions and their corresponding average movement TWO WEEKS before/after lockdown
    
    two_w_before_subregion = data.frame(country = character(0), region = character(0), before_avg = numeric(0))
    
    
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
        
        google_filter = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        before_avg_value = mean(c(
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-14)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-13)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-12)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-11)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-10)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -9)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -8)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -7)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -6)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -5)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -4)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -3)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -2)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -1)]
                                ), na.rm=T)
        
        two_w_before_subregion = two_w_before_subregion %>% add_row(country = country_value, region = region_value, before_avg = before_avg_value)
      }
    }
    
    
    two_w_after_subregion = data.frame(country = character(0), region = character(0), after_avg = numeric(0))
    
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
        
        google_filter    = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        after_avg_value = mean(c(
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+14)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+13)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+12)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+11)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+10)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +9)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +8)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +7)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +6)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +5)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +4)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +3)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +2)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +1)]
                                 ), na.rm=T)
        
        two_w_after_subregion = two_w_after_subregion %>% add_row(country = country_value, region = region_value, after_avg = after_avg_value)
      }
    }
    
    movement_change_2w =  full_join(two_w_before_subregion, two_w_after_subregion, by = c('country', 'region')) %>% 
                          mutate(arith_change = after_avg - before_avg) %>% 
                          mutate(pct_change = 100 * ((after_avg - before_avg) / (before_avg + 100)) )
    
    
  # create dataframe of regions and their corresponding average movement ONE MONTH before/after lockdown
    
    one_m_before_subregion = data.frame(country = character(0), region = character(0), before_avg = numeric(0))
    
    
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
        
        google_filter = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        before_avg_value = mean(c(
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-30)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-29)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-28)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-27)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-26)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-25)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-24)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-23)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-22)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-21)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-20)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-19)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-18)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-17)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-16)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-15)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-14)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-13)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-12)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-11)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )-10)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -9)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -8)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -7)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -6)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -5)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -4)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -3)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -2)],
                                  google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -1)]
        ), na.rm=T)
        
        one_m_before_subregion = one_m_before_subregion %>% add_row(country = country_value, region = region_value, before_avg = before_avg_value)
      }
    }
    
    
    one_m_after_subregion = data.frame(country = character(0), region = character(0), after_avg = numeric(0))
    
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
        
        google_filter    = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        after_avg_value = mean(c(
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+30)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+29)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+28)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+27)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+26)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+25)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+24)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+23)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+22)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+21)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+20)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+19)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+18)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+17)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+16)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+15)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+14)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+13)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+12)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+11)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') )+10)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +9)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +8)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +7)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +6)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +5)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +4)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +3)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +2)],
                                 google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +1)]
        ), na.rm=T)
        
        one_m_after_subregion = one_m_after_subregion %>% add_row(country = country_value, region = region_value, after_avg = after_avg_value)
      }
    }
    
    movement_change_1m =  full_join(one_m_before_subregion, one_m_after_subregion, by = c('country', 'region')) %>% 
      mutate(arith_change = after_avg - before_avg) %>% 
      mutate(pct_change = 100 * ((after_avg - before_avg) / (before_avg + 100)) )
    
    
  # create dataframe of regions and their corresponding average movement ONE DAY before/after lockdown
    
    one_d_before_subregion = data.frame(country = character(0), region = character(0), before_avg = numeric(0))
    
    
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
        
        google_filter = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        before_avg_value = mean(c(google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) -1)]), na.rm=T)
        
        one_d_before_subregion = one_d_before_subregion %>% add_row(country = country_value, region = region_value, before_avg = before_avg_value)
      }
    }
    
    
    one_d_after_subregion = data.frame(country = character(0), region = character(0), after_avg = numeric(0))
    
    for (i in seq(from = 1, to = length(dates_subregion$COUNTRY))){
      
      country_value    = dates_subregion$COUNTRY[i]
      region_value     = dates_subregion$REGION[i]
      date             = dates_subregion$date[i]
      
      if( (country_value %in% google_cleaned$country_region) & (region_value %in% google_cleaned$sub_region_1) ){
        
        google_filter = google_cleaned %>% filter(country_region == country_value) %>% filter(sub_region_1 == region_value)
        
        after_avg_value = mean(c(google_filter$retail_and_recreation_percent_change_from_baseline[(as.numeric(date - as.Date("2020-02-14", format = '%Y-%m-%d') ) +1)]), na.rm=T)
        
        one_d_after_subregion = one_d_after_subregion %>% add_row(country = country_value, region = region_value, after_avg = after_avg_value)
      }
    }
    
    movement_change_1d =  full_join(one_d_before_subregion, one_d_after_subregion, by = c('country', 'region')) %>% 
                          mutate(arith_change = after_avg - before_avg) %>% 
                          mutate(pct_change = 100 * ((after_avg - before_avg) / (before_avg + 100)) )
    
    
    
    
# Section 6: combine everything into final datasets
    
    
    # add in population data
    
      pop_subregion = read_excel(paste0(input_path, "population_subregion.xlsx")) %>% 
                      filter(used == 1) %>% 
                      select(-c(source, urban_x, used, ADM0_CODE, ADM1_CODE, issue_adm1)) %>% 
                      mutate(area = as.numeric(area)) %>% 
                      mutate(population = as.numeric(population)) %>% 
                      mutate(density = as.numeric(density)) %>%
                      mutate(luminosity_avg = ifelse(is.na(luminosity_avg), 0, luminosity_avg))
      
      pop_mean = mean(pop_subregion$population)
      pop_median = median(pop_subregion$population)
      
      
    # generate final datasets for different timeframes
      
      dataset_names = c("final_data_1w", "final_data_2w", "final_data_1d", "final_data_1m")
      
      for (i in 1:4){
        
        if(i==1){
          dataset = movement_change_1w
        } else if(i==2){
          dataset = movement_change_2w
        } else if(i==3){
          dataset = movement_change_1d
        } else if(i==4){
          dataset = movement_change_1m
        }
        
        assign(dataset_names[i],
               left_join(dataset, lockdown_dates, by = 'country') %>% 
               mutate(strict = ifelse(type == 3, 1, 0)) %>% 
               left_join(trust_by_subregion, by = c('country' = 'COUNTRY', 'region' = 'REGION')) %>% 
               left_join(pop_subregion, by = c('country' = 'country', 'region' = 'region')) %>% 
               left_join(covid_stats %>% select(-c(date, population)), by = c('country' = 'country')) %>% 
               left_join(polity %>% select(c(country, polity)), by = c('country' = 'country')) %>% 
               mutate(GDP_light = log(luminosity_avg)) %>% 
               mutate(GDP_light_pc = log( (luminosity_avg) / population) ) %>%
               mutate(nigeria = ifelse(country == 'Nigeria', 1, 0)) %>% 
               mutate(trust_nigeria = trust_govt * nigeria) %>% 
               mutate(large_region = ifelse(population > pop_median, 1, 0)) %>% 
               mutate(trust_large = trust_govt * large_region) %>% 
               mutate(small_region = ifelse(population < 1000000, 1, 0)) %>% 
               mutate(trust_small = trust_govt * small_region) %>% 
               mutate(bantu_majority = ifelse(bantu > .5, 1 ,0)) %>% 
               mutate(trust_bantu = trust_govt * bantu_majority) %>% 
               mutate(trust_polity = trust_govt * polity) %>%
               filter(is.na(pct_change) == FALSE) %>% 
               arrange(country, region) 
               )
      }
      
      
    # generate final dataset (for +/- 1 week) that excludes Mauritius
    
      final_data_1w_NM = final_data_1w %>% filter(country != 'Mauritius')
      
 