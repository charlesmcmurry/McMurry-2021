################################################################################
## Script 1: Load Data
## Author: Charlie McMurry
################################################################################


# Section 1: load data

  setwd(input_path)
  
  # Afrobarometer round 7 survey
    afro_barom = read.spss('r7_merged_data_34ctry.release.sav', use.value.label=TRUE, to.data.frame=TRUE)
    
    
  # define panel of countries available to study
    countries = unique(afro_barom$COUNTRY)
  
    
  # data from CGD on school closures
    # school_closures = read.csv('CGD - COVID education policy tracking - School closure tracker- Global.csv') %>% 
    #                   filter(Country %in% unique(afro_barom$COUNTRY))
  
    
  # data from CGD on school re-openings
    # school_openings = read.csv('CGD - COVID education policy tracking - School reopening tracker- Global.csv') %>% 
    #                   filter(Country %in% unique(afro_barom$COUNTRY))
  
    
  # joining school closures and reopenings data
    # school_data = left_join(school_closures, school_openings, by = 'Country', suffix = c('_x', '_y'))
    
    
  # Oxford government response tracker
    OXCGRT = read.csv('covid-policy-tracker-master/data/OxCGRT_latest.csv') %>% 
             mutate(CountryName = ifelse(CountryName == "Cape Verde", "Cabo Verde", ifelse(
                                         CountryName == "Cote d'Ivoire", "Côte d'Ivoire", ifelse(
                                         CountryName == "Eswatini", "eSwatini", CountryName)))
                    ) %>% 
             filter(CountryName %in% countries) %>% 
             mutate(Date = as.Date(paste0(Date, "01"), format = "%Y%m%d"))
    
    for (i in countries) {
      if(i %in% unique(OXCGRT$Country_Name) == FALSE){
        print(paste0(i, " can't be found"))
      }
    }
    
    
  # google movement data
    google =  read.csv('Global_Mobility_Report.csv') %>% 
              mutate(country_region = ifelse(country_region == "Cape Verde", "Cabo Verde", ifelse(
                                       country_region == "CÃ´te d'Ivoire", "Côte d'Ivoire", ifelse(
                                       country_region == "Eswatini", "eSwatini", country_region)))
                     ) %>% 
              filter(country_region %in% countries) %>% 
              #filter(sub_region_1 != "") %>% 
              #filter(metro_area == "") %>% 
              mutate(date = as.Date(date, format='%Y-%m-%d'))


    for (i in countries) {
      if(i %in% unique(google$country_region) == FALSE){
        print(paste0(i, " can't be found"))
      }
    }
    
                        
  # World bank GDP per capita (PPP 2017) data
    GDP_pc = read_csv('API_NY.GDP.PCAP.PP.KD_DS2_en_csv_v2_1623008.csv') %>% 
             mutate(Country_Name = ifelse(Country_Name == "Gambia, The", "Gambia", ifelse(
                                          Country_Name == "Sao Tome and Principe", "São Tomé and Príncipe", ifelse(
                                          Country_Name == "Cote d'Ivoire", "Côte d'Ivoire", ifelse(
                                          Country_Name == "Eswatini", "eSwatini", Country_Name))))) %>% 
             filter(Country_Name %in% countries) %>% 
             select(Country_Name, Country_Code, `2019`) %>% 
             rename(GDP_pc = `2019`) %>% 
             mutate(GDP_pc = as.numeric(GDP_pc))
    
    for (i in countries) {
      if(i %in% unique(GDP_pc$Country_Name) == FALSE){
        print(paste0(i, " can't be found"))
      }
    }
    
    
  # UN population density data
    density = read_excel('WPP2019_POP_F06_POPULATION_DENSITY.xlsx') %>% 
              mutate(Region = ifelse(Region == "Gambia, The", "Gambia", ifelse(
                                     Region == "Sao Tome and Principe", "São Tomé and Príncipe", ifelse(
                                     Region == "Cote d'Ivoire", "Côte d'Ivoire", ifelse(
                                     Region == "United Republic of Tanzania", "Tanzania", ifelse(
                                     Region == "Eswatini", "eSwatini", Region)))))) %>% 
              filter(Region %in% countries) %>% 
              select(Region, `2019`) %>% 
              rename(density = `2019`) %>% 
              mutate(density = as.numeric(density))
    
    for (i in countries) {
      if(i %in% unique(density$Region) == FALSE){
        print(paste0(i, " can't be found"))
      }
    }
    
    
  # World Bank urbanization data
    urban = read_csv('WB_urban_population_percent.csv') %>% 
            mutate(Country_Name = ifelse(Country_Name == "Gambia, The", "Gambia", ifelse(
                                         Country_Name == "Sao Tome and Principe", "São Tomé and Príncipe", ifelse(
                                         Country_Name == "Cote d'Ivoire", "Côte d'Ivoire", ifelse(
                                         Country_Name == "United Republic of Tanzania", "Tanzania", ifelse(
                                         Country_Name == "Eswatini", "eSwatini", Country_Name)))))) %>% 
            filter(Country_Name %in% countries) %>% 
            select(Country_Name, `2019`) %>% 
            rename(urban = `2019`)
    
    for (i in countries) {
      if(i %in% unique(urban$Country_Name) == FALSE){
        print(paste0(i, " can't be found"))
      }
    }
    
    
  # OWID covid stats data
    covid = read_excel('owid-covid-data.xlsx') %>% 
            mutate(location = ifelse(location == "Gambia, The", "Gambia", ifelse(
                                     location == "Sao Tome and Principe", "São Tomé and Príncipe", ifelse(
                                     location == "Cote d'Ivoire", "Côte d'Ivoire", ifelse(
                                     location == "Cape Verde", "Cabo Verde", ifelse(
                                     location == "United Republic of Tanzania", "Tanzania", ifelse(
                                     location == "Swaziland", "eSwatini", ifelse(
                                     location == "Eswatini", "eSwatini", location))))))
                                     )
                   ) %>% 
            filter(location %in% countries) 
    
    for (i in countries) {
      if(i %in% unique(covid$location) == FALSE){
        print(paste0(i, " can't be found"))
        }
    }    
    
    
  # national subregion GPD data from Gennaioli et al (2013)
    GDP_sub = read_excel("regions_data_web_july2012_Schleifer.xls", sheet = "Table02Data") %>% 
              filter(Code %in% c("GAB", "GHA", "KEN", "UGA", "BFA", "NAM", "NGA", "ZAF", "ZMB", "ZWE")) %>% 
              mutate(Region = ifelse(Code == "BFA" & Region == "Hauts-Bassins", "Hauts Bassins", as.character(Region))) %>% 
              mutate(Region = ifelse(Code == "GHA" & Region == "Gt. Accra", "Greater Accra", as.character(Region))) %>% 
              mutate(Region = ifelse(Code == "KEN" & Region == "Central", "Central_Kenya", as.character(Region))) %>% 
              mutate(Region = ifelse(Code == "KEN" & Region == "Eastern", "East", as.character(Region))) %>% 
              mutate(Region = ifelse(Code == "KEN" & Region == "Western", "West", as.character(Region))) %>% 
              mutate(Region = ifelse(Code == "KEN" & Region == "Central", "Central_Kenya", as.character(Region))) %>% 
              mutate(Country =  ifelse(Code == "GAB", "Gabon", 
                                ifelse(Code == "GHA", "Ghana", 
                                ifelse(Code == "KEN", "Kenya",
                                ifelse(Code == "UGA", "Uganda",
                                ifelse(Code == "BFA", "Burkina Faso",
                                ifelse(Code == "NAM", "Namibia",
                                ifelse(Code == "NGA", "Nigeria",
                                ifelse(Code == "ZAF", "South Africa",
                                ifelse(Code == "ZMB", "Zambia",
                                ifelse(Code == "ZWE", "Zimbabwe", ""))))))))))) %>% 
              select(c("Country", "Region", "lnRegGDP"))
    
    
  # Bantu languages list
    bantu = read_excel('bantu_languages.xlsx')
    
    
  # Polity democracy scores
    polity =  read_excel('p5v2018.xls') %>% 
              mutate(country = ifelse(country == 'Cape Verde', "Cabo Verde", as.character(country))) %>% 
              filter(country %in% countries) %>% 
              filter(year == 2018)
              
    for (i in countries) {
      if(i %in% unique(polity$country) == FALSE){
        print(paste0(i, " can't be found"))
      }
    } 
    
  

# Section 2: for each country, find date upon which "C6_Stay at home requirements" went from 0 to 2 or 3 (if ever) and record C6_Flag variable
  
  x = integer(0)
  class(x) = "Date"
  
  lockdown_dates = data.frame(country=character(0), date=x, type=numeric(0), flag=numeric(0)) 
  
  for (i in countries) {
    OXCGRT_filter = OXCGRT %>% filter(CountryName == i)
    
    for (j in seq(from = 1, to = nrow(OXCGRT_filter))) {
      if ( sum( OXCGRT_filter$C6_Stay.at.home.requirements[j] >=2, na.rm=T ) == 1) {
        print(i)
        country_name = i
        country_date = OXCGRT_filter$Date[j]
        country_type = OXCGRT_filter$C6_Stay.at.home.requirements[j]
        country_flag = OXCGRT_filter$C6_Flag[j]
        lockdown_dates = lockdown_dates %>% add_row(country = i, date = country_date, type = country_type, flag = country_flag)
        break
      }
    }
  }
  
  
  # countries with no lockdown:
    for (i in countries) {
      if(i %in% lockdown_dates$country == FALSE){
        print(paste0(i, " didn't lock down"))
      }
    }
  
  
  # countries where I'll need to find sub-national level lockdown dates
    lockdown_dates %>% filter(flag == 0) %>% select(country)
    
  
  # final list of usable countries
    countries_final =  c("Botswana", "Burkina Faso", "Cabo Verde", "Gabon", "Ghana", "Kenya", "Mauritius", 
                         "Namibia", "Nigeria", "Senegal", "South Africa", "Togo", "Uganda", "Zambia", "Zimbabwe")
    
    
  # create list of countries and dates to iterate through
    dates = list(country = lockdown_dates$country, date = lockdown_dates$date)

    

    
# Section 3: create dataframe of coronavirus statistics on lockdown date
 
    covid_stats = data.frame(country = character(0), date = as.Date(character(0)),
                             new_cases = numeric(0), new_cases_pm = numeric(0), total_cases = numeric(0), total_cases_pm = numeric(0),
                             new_deaths = numeric(0), new_deaths_pm = numeric(0), total_deaths = numeric(0), total_deaths_pm = numeric(0),
                             stringency = numeric(0), median_age = numeric(0), life_expectancy = numeric(0), hdi = numeric(0), population = numeric(0))

    for (i in seq(from = 1, to = length(dates$country))) {
        country         = dates$country[i]
        lockdown_date   = dates$date[i]
        covid_filter    = covid %>% filter(location == country) %>% filter(date == lockdown_date)
        new_cases       = covid_filter$new_cases[1]
        new_cases_pm    = covid_filter$new_cases_per_million[1]
        total_cases     = covid_filter$total_cases[1]
        total_cases_pm  = covid_filter$total_cases_per_million[1]
        new_deaths      = covid_filter$new_deaths[1]
        new_deaths_pm   = covid_filter$new_deaths_per_million[1]
        total_deaths    = covid_filter$total_deaths[1]
        total_deaths_pm = covid_filter$total_deaths_per_million[1]
        stringency      = covid_filter$stringency_index[1]
        median_age      = covid_filter$median_age[1]
        life_expectancy = covid_filter$life_expectancy[1]
        hdi             = covid_filter$human_development_index[1]
        population      = covid_filter$population[1]
        covid_stats = covid_stats %>% add_row(country = country, date = lockdown_date,
                                              new_cases = new_cases, new_cases_pm = new_cases_pm, total_cases = total_cases, total_cases_pm = total_cases_pm,
                                              new_deaths = new_deaths, new_deaths_pm = new_deaths_pm, total_deaths = total_deaths, total_deaths_pm = total_deaths_pm,
                                              stringency = stringency, median_age = median_age, life_expectancy = life_expectancy, hdi = hdi, population = population)
    }

     