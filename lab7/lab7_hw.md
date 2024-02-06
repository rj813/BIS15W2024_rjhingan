---
title: "Lab 7 Homework"
author: "Rohan Jhingan"
date: "2024-02-05"
output:
  html_document: 
    theme: spacelab
    keep_md: yes
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the libraries

```r
library(tidyverse)
library(janitor)
library(skimr)
```

For this assignment we are going to work with a large data set from the [United Nations Food and Agriculture Organization](http://www.fao.org/about/en/) on world fisheries. These data are pretty wild, so we need to do some cleaning. First, load the data.  

Load the data `FAO_1950to2012_111914.csv` as a new object titled `fisheries`.

```r
fisheries <- readr::read_csv(file = "data/FAO_1950to2012_111914.csv")
```

```
## Rows: 17692 Columns: 71
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (69): Country, Common name, ISSCAAP taxonomic group, ASFIS species#, ASF...
## dbl  (2): ISSCAAP group#, FAO major fishing area
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

1. Do an exploratory analysis of the data (your choice). What are the names of the variables, what are the dimensions, are there any NA's, what are the classes of the variables?  

```r
fisheries %>%
  glimpse
```

```
## Rows: 17,692
## Columns: 71
## $ Country                   <chr> "Albania", "Albania", "Albania", "Albania", …
## $ `Common name`             <chr> "Angelsharks, sand devils nei", "Atlantic bo…
## $ `ISSCAAP group#`          <dbl> 38, 36, 37, 45, 32, 37, 33, 45, 38, 57, 33, …
## $ `ISSCAAP taxonomic group` <chr> "Sharks, rays, chimaeras", "Tunas, bonitos, …
## $ `ASFIS species#`          <chr> "10903XXXXX", "1750100101", "17710001XX", "2…
## $ `ASFIS species name`      <chr> "Squatinidae", "Sarda sarda", "Sphyraena spp…
## $ `FAO major fishing area`  <dbl> 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, 37, …
## $ Measure                   <chr> "Quantity (tonnes)", "Quantity (tonnes)", "Q…
## $ `1950`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1951`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1952`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1953`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1954`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1955`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1956`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1957`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1958`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1959`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1960`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1961`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1962`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1963`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1964`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1965`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1966`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1967`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1968`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1969`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1970`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1971`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1972`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1973`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1974`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1975`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1976`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1977`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1978`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1979`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1980`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1981`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1982`                    <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, …
## $ `1983`                    <chr> NA, NA, NA, NA, NA, NA, "559", NA, NA, NA, N…
## $ `1984`                    <chr> NA, NA, NA, NA, NA, NA, "392", NA, NA, NA, N…
## $ `1985`                    <chr> NA, NA, NA, NA, NA, NA, "406", NA, NA, NA, N…
## $ `1986`                    <chr> NA, NA, NA, NA, NA, NA, "499", NA, NA, NA, N…
## $ `1987`                    <chr> NA, NA, NA, NA, NA, NA, "564", NA, NA, NA, N…
## $ `1988`                    <chr> NA, NA, NA, NA, NA, NA, "724", NA, NA, NA, N…
## $ `1989`                    <chr> NA, NA, NA, NA, NA, NA, "583", NA, NA, NA, N…
## $ `1990`                    <chr> NA, NA, NA, NA, NA, NA, "754", NA, NA, NA, N…
## $ `1991`                    <chr> NA, NA, NA, NA, NA, NA, "283", NA, NA, NA, N…
## $ `1992`                    <chr> NA, NA, NA, NA, NA, NA, "196", NA, NA, NA, N…
## $ `1993`                    <chr> NA, NA, NA, NA, NA, NA, "150 F", NA, NA, NA,…
## $ `1994`                    <chr> NA, NA, NA, NA, NA, NA, "100 F", NA, NA, NA,…
## $ `1995`                    <chr> "0 0", "1", NA, "0 0", "0 0", NA, "52", "30"…
## $ `1996`                    <chr> "53", "2", NA, "3", "2", NA, "104", "8", NA,…
## $ `1997`                    <chr> "20", "0 0", NA, "0 0", "0 0", NA, "65", "4"…
## $ `1998`                    <chr> "31", "12", NA, NA, NA, NA, "220", "18", NA,…
## $ `1999`                    <chr> "30", "30", NA, NA, NA, NA, "220", "18", NA,…
## $ `2000`                    <chr> "30", "25", "2", NA, NA, NA, "220", "20", NA…
## $ `2001`                    <chr> "16", "30", NA, NA, NA, NA, "120", "23", NA,…
## $ `2002`                    <chr> "79", "24", NA, "34", "6", NA, "150", "84", …
## $ `2003`                    <chr> "1", "4", NA, "22", NA, NA, "84", "178", NA,…
## $ `2004`                    <chr> "4", "2", "2", "15", "1", "2", "76", "285", …
## $ `2005`                    <chr> "68", "23", "4", "12", "5", "6", "68", "150"…
## $ `2006`                    <chr> "55", "30", "7", "18", "8", "9", "86", "102"…
## $ `2007`                    <chr> "12", "19", NA, NA, NA, NA, "132", "18", NA,…
## $ `2008`                    <chr> "23", "27", NA, NA, NA, NA, "132", "23", NA,…
## $ `2009`                    <chr> "14", "21", NA, NA, NA, NA, "154", "20", NA,…
## $ `2010`                    <chr> "78", "23", "7", NA, NA, NA, "80", "228", NA…
## $ `2011`                    <chr> "12", "12", NA, NA, NA, NA, "88", "9", NA, "…
## $ `2012`                    <chr> "5", "5", NA, NA, NA, NA, "129", "290", NA, …
```

2. Use `janitor` to rename the columns and make them easier to use. As part of this cleaning step, change `country`, `isscaap_group_number`, `asfis_species_number`, and `fao_major_fishing_area` to data class factor. 

```r
fisheries <- clean_names(fisheries)
```


```r
fisheries$country <- as_factor(fisheries$country)
```


```r
fisheries$fao_major_fishing_area <- as_factor(fisheries$fao_major_fishing_area)  
```


```r
fisheries$isscaap_group_number <- as_factor(fisheries$isscaap_group_number)
```


```r
fisheries$asfis_species_number <- as_factor(fisheries$asfis_species_number)
```

 
We need to deal with the years because they are being treated as characters and start with an X. We also have the problem that the column names that are years actually represent data. We haven't discussed tidy data yet, so here is some help. You should run this ugly chunk to transform the data for the rest of the homework. It will only work if you have used janitor to rename the variables in question 2!  

```r
fisheries_tidy <- fisheries %>% 
  pivot_longer(-c(country,common_name,isscaap_group_number,isscaap_taxonomic_group,asfis_species_number,asfis_species_name,fao_major_fishing_area,measure),
               names_to = "year",
               values_to = "catch",
               values_drop_na = TRUE) %>% 
  mutate(year= as.numeric(str_replace(year, 'x', ''))) %>% 
  mutate(catch= str_replace(catch, c(' F'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('...'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('-'), replacement = '')) %>% 
  mutate(catch= str_replace(catch, c('0 0'), replacement = ''))

fisheries_tidy$catch <- as.numeric(fisheries_tidy$catch)
```

3. How many countries are represented in the data? Provide a count and list their names.

```r
#there are 203 countries
fisheries_tidy %>%
  count(country)
```

```
## # A tibble: 203 × 2
##    country                 n
##    <fct>               <int>
##  1 Albania               934
##  2 Algeria              1561
##  3 American Samoa        556
##  4 Angola               2119
##  5 Anguilla              129
##  6 Antigua and Barbuda   356
##  7 Argentina            3403
##  8 Aruba                 172
##  9 Australia            8183
## 10 Bahamas               423
## # ℹ 193 more rows
```

4. Refocus the data only to include country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch.

```r
fisheries_tidy %>%
  select(country, isscaap_taxonomic_group, asfis_species_name, asfis_species_number, year, catch)
```

```
## # A tibble: 376,771 × 6
##    country isscaap_taxonomic_group asfis_species_name asfis_species_number  year
##    <fct>   <chr>                   <chr>              <fct>                <dbl>
##  1 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1995
##  2 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1996
##  3 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1997
##  4 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1998
##  5 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            1999
##  6 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2000
##  7 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2001
##  8 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2002
##  9 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2003
## 10 Albania Sharks, rays, chimaeras Squatinidae        10903XXXXX            2004
## # ℹ 376,761 more rows
## # ℹ 1 more variable: catch <dbl>
```

5. Based on the asfis_species_number, how many distinct fish species were caught as part of these data?

```r
#There were 1551 distinct species of fish caught
fisheries_tidy %>%
  count(asfis_species_number)
```

```
## # A tibble: 1,551 × 2
##    asfis_species_number     n
##    <fct>                <int>
##  1 10903XXXXX             138
##  2 1750100101            1923
##  3 17710001XX            2675
##  4 2280203101             130
##  5 1480403301             915
##  6 1702021301            1450
##  7 1703926101            1105
##  8 2280100117             305
##  9 10801003XX             103
## 10 3210200202             699
## # ℹ 1,541 more rows
```

6. Which country had the largest overall catch in the year 2000?

```r
#China had the largest overall catch in 2000
large_catch <- fisheries_tidy %>%
  filter(year == 2000) %>%
  group_by(country) %>%
  summarise(catch=sum(catch, na.rm = T)) %>%
  arrange(desc(catch))
```


```r
print(large_catch)
```

```
## # A tibble: 193 × 2
##    country                  catch
##    <fct>                    <dbl>
##  1 China                    25899
##  2 Russian Federation       12181
##  3 United States of America 11762
##  4 Japan                     8510
##  5 Indonesia                 8341
##  6 Peru                      7443
##  7 Chile                     6906
##  8 India                     6351
##  9 Thailand                  6243
## 10 Korea, Republic of        6124
## # ℹ 183 more rows
```

7. Which country caught the most sardines (_Sardina pilchardus_) between the years 1990-2000?

```r
#Morocco caught the most sardines between 1990-2000
fisheries_tidy %>%
  filter(year >= 1990 & year <= 2000) %>%
  filter(asfis_species_name == "Sardina pilchardus") %>% 
  group_by(country) %>%
  summarise(big_sardine=sum(catch, na.rm=T)) %>%
  arrange(desc(big_sardine))
```

```
## # A tibble: 37 × 2
##    country               big_sardine
##    <fct>                       <dbl>
##  1 Morocco                      7470
##  2 Spain                        3507
##  3 Russian Federation           1639
##  4 Ukraine                      1030
##  5 France                        966
##  6 Portugal                      818
##  7 Greece                        528
##  8 Italy                         507
##  9 Serbia and Montenegro         478
## 10 Denmark                       477
## # ℹ 27 more rows
```

8. Which five countries caught the most cephalopods between 2008-2012?

```r
#Between 2008-2012, Spain, India, China, Algeria, and France caught the most cephalopods
fisheries_tidy %>%
  filter(year >= 2008 & year <= 2012) %>%
  filter(common_name == "Cephalopods nei") %>% 
  group_by(country) %>%
  summarise(big_cephalopods=sum(catch, na.rm=T)) %>%
  arrange(desc(big_cephalopods))
```

```
## # A tibble: 16 × 2
##    country                  big_cephalopods
##    <fct>                              <dbl>
##  1 India                                570
##  2 China                                257
##  3 Spain                                198
##  4 Algeria                              162
##  5 France                               101
##  6 Mauritania                            90
##  7 TimorLeste                            76
##  8 Italy                                 66
##  9 Mozambique                            16
## 10 Cambodia                              15
## 11 Taiwan Province of China              13
## 12 Madagascar                            11
## 13 Croatia                                7
## 14 Israel                                 0
## 15 Somalia                                0
## 16 Viet Nam                               0
```

9. Which species had the highest catch total between 2008-2012? (hint: Osteichthyes is not a species)

```r
#The Alaska Pollok was the highest catch from 2008-2012.
fisheries_tidy %>%
  filter(year >= 2008 & year <= 2012) %>%
  group_by(asfis_species_name) %>%
  summarise(high_catch=sum(catch, na.rm=T)) %>%
  arrange(desc(high_catch))
```

```
## # A tibble: 1,472 × 2
##    asfis_species_name    high_catch
##    <chr>                      <dbl>
##  1 Osteichthyes              107808
##  2 Theragra chalcogramma      41075
##  3 Engraulis ringens          35523
##  4 Katsuwonus pelamis         32153
##  5 Trichiurus lepturus        30400
##  6 Clupea harengus            28527
##  7 Thunnus albacares          20119
##  8 Scomber japonicus          14723
##  9 Gadus morhua               13253
## 10 Thunnus alalunga           12019
## # ℹ 1,462 more rows
```

10. Use the data to do at least one analysis of your choice.

```r
fisheries_tidy %>%
  filter(country == "India") %>%
  filter(year >= 2000 & year <= 2010) %>%
  group_by(common_name) %>%
  summarise(high_species=sum(catch, na.r=T)) %>%
  arrange(desc(high_species))
```

```
## # A tibble: 53 × 2
##    common_name                   high_species
##    <chr>                                <dbl>
##  1 Marine fishes nei                    12388
##  2 Indian oil sardine                    8014
##  3 Croakers, drums nei                   6258
##  4 Bombayduck                            5795
##  5 Giant tiger prawn                     5015
##  6 Natantian decapods nei                4888
##  7 Hairtails, scabbardfishes nei         3264
##  8 Ponyfishes(=Slipmouths) nei           1199
##  9 Cephalopods nei                       1153
## 10 Percoids nei                          1147
## # ℹ 43 more rows
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
