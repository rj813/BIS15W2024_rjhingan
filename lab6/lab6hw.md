---
title: "dplyr Superhero"
date: "2024-02-20"
output:
  html_document: 
    theme: spacelab
    toc: yes
    toc_float: yes
    keep_md: yes
---

## Learning Goals  
*At the end of this exercise, you will be able to:*    
1. Develop your dplyr superpowers so you can easily and confidently manipulate dataframes.  
2. Learn helpful new functions that are part of the `janitor` package.  

## Instructions
For the second part of lab today, we are going to spend time practicing the dplyr functions we have learned and add a few new ones. This lab doubles as your homework. Please complete the lab and push your final code to GitHub.  

## Load the libraries

```r
library("tidyverse")
```

```
## ── Attaching core tidyverse packages ──────────────────────── tidyverse 2.0.0 ──
## ✔ dplyr     1.1.4     ✔ readr     2.1.4
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.0
## ✔ purrr     1.0.2     
## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
## ✖ dplyr::filter() masks stats::filter()
## ✖ dplyr::lag()    masks stats::lag()
## ℹ Use the conflicted package (<http://conflicted.r-lib.org/>) to force all conflicts to become errors
```

```r
library("janitor")
```

```
## 
## Attaching package: 'janitor'
## 
## The following objects are masked from 'package:stats':
## 
##     chisq.test, fisher.test
```

## Load the superhero data
These are data taken from comic books and assembled by fans. The include a good mix of categorical and continuous data.  Data taken from: https://www.kaggle.com/claudiodavi/superhero-set  

Check out the way I am loading these data. If I know there are NAs, I can take care of them at the beginning. But, we should do this very cautiously. At times it is better to keep the original columns and data intact.  

```r
superhero_info <- read_csv("data/heroes_information.csv", na = c("", "-99", "-"))
```

```
## Rows: 734 Columns: 10
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr (8): name, Gender, Eye color, Race, Hair color, Publisher, Skin color, A...
## dbl (2): Height, Weight
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

```r
superhero_powers <- read_csv("data/super_hero_powers.csv", na = c("", "-99", "-"))
```

```
## Rows: 667 Columns: 168
## ── Column specification ────────────────────────────────────────────────────────
## Delimiter: ","
## chr   (1): hero_names
## lgl (167): Agility, Accelerated Healing, Lantern Power Ring, Dimensional Awa...
## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.
```

## Data tidy
1. Some of the names used in the `superhero_info` data are problematic so you should rename them here. Before you do anything, first have a look at the names of the variables. You can use `rename()` or `clean_names()`.    

```r
names(superhero_info)
```

```
##  [1] "name"       "Gender"     "Eye color"  "Race"       "Hair color"
##  [6] "Height"     "Publisher"  "Skin color" "Alignment"  "Weight"
```

```r
superheroclean_info <- clean_names(superhero_info)
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superheroclean_info$alignment)
```

```
##  superheroclean_info$alignment   n     percent valid_percent
##                            bad 207 0.282016349    0.28473177
##                           good 496 0.675749319    0.68225585
##                        neutral  24 0.032697548    0.03301238
##                           <NA>   7 0.009536785            NA
```

1. Who are the publishers of the superheros? Show the proportion of superheros from each publisher. Which publisher has the highest number of superheros?  

```r
#marvel comics has the highest number of superheros
superheroclean_info %>%
  tabyl(publisher)
```

```
##          publisher   n     percent valid_percent
##        ABC Studios   4 0.005449591   0.005563282
##          DC Comics 215 0.292915531   0.299026426
##  Dark Horse Comics  18 0.024523161   0.025034771
##       George Lucas  14 0.019073569   0.019471488
##      Hanna-Barbera   1 0.001362398   0.001390821
##      HarperCollins   6 0.008174387   0.008344924
##     IDW Publishing   4 0.005449591   0.005563282
##        Icon Comics   4 0.005449591   0.005563282
##       Image Comics  14 0.019073569   0.019471488
##      J. K. Rowling   1 0.001362398   0.001390821
##   J. R. R. Tolkien   1 0.001362398   0.001390821
##      Marvel Comics 388 0.528610354   0.539638387
##          Microsoft   1 0.001362398   0.001390821
##       NBC - Heroes  19 0.025885559   0.026425591
##          Rebellion   1 0.001362398   0.001390821
##           Shueisha   4 0.005449591   0.005563282
##      Sony Pictures   2 0.002724796   0.002781641
##         South Park   1 0.001362398   0.001390821
##          Star Trek   6 0.008174387   0.008344924
##               SyFy   5 0.006811989   0.006954103
##       Team Epic TV   5 0.006811989   0.006954103
##        Titan Books   1 0.001362398   0.001390821
##  Universal Studios   1 0.001362398   0.001390821
##          Wildstorm   3 0.004087193   0.004172462
##               <NA>  15 0.020435967            NA
```

2. Notice that we have some neutral superheros! Who are they? List their names below.  

```r
superheroclean_info %>%
  filter(alignment == "neutral")
```

```
## # A tibble: 24 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Biza… Male   black     Biza… Black         191 DC Comics white      neutral  
##  2 Blac… Male   <NA>      God … <NA>           NA DC Comics <NA>       neutral  
##  3 Capt… Male   brown     Human Brown          NA DC Comics <NA>       neutral  
##  4 Copy… Female red       Muta… White         183 Marvel C… blue       neutral  
##  5 Dead… Male   brown     Muta… No Hair       188 Marvel C… <NA>       neutral  
##  6 Deat… Male   blue      Human White         193 DC Comics <NA>       neutral  
##  7 Etri… Male   red       Demon No Hair       193 DC Comics yellow     neutral  
##  8 Gala… Male   black     Cosm… Black         876 Marvel C… <NA>       neutral  
##  9 Glad… Male   blue      Stro… Blue          198 Marvel C… purple     neutral  
## 10 Indi… Female <NA>      Alien Purple         NA DC Comics <NA>       neutral  
## # ℹ 14 more rows
## # ℹ 1 more variable: weight <dbl>
```

## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
superheroclean_info%>%
  select(alignment, name, race)
```

```
## # A tibble: 734 × 3
##    alignment name          race             
##    <chr>     <chr>         <chr>            
##  1 good      A-Bomb        Human            
##  2 good      Abe Sapien    Icthyo Sapien    
##  3 good      Abin Sur      Ungaran          
##  4 bad       Abomination   Human / Radiation
##  5 bad       Abraxas       Cosmic Entity    
##  6 bad       Absorbing Man Human            
##  7 good      Adam Monroe   <NA>             
##  8 good      Adam Strange  Human            
##  9 good      Agent 13      <NA>             
## 10 good      Agent Bob     Human            
## # ℹ 724 more rows
```

## Not Human
4. List all of the superheros that are not human.

```r
superheroclean_info %>%
  filter(race !="Human")
```

```
## # A tibble: 222 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  2 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  3 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  4 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  5 Ajax  Male   brown     Cybo… Black         193 Marvel C… <NA>       bad      
##  6 Alien Male   <NA>      Xeno… No Hair       244 Dark Hor… black      bad      
##  7 Amazo Male   red       Andr… <NA>          257 DC Comics <NA>       bad      
##  8 Angel Male   <NA>      Vamp… <NA>           NA Dark Hor… <NA>       good     
##  9 Ange… Female yellow    Muta… Black         165 Marvel C… <NA>       good     
## 10 Anti… Male   yellow    God … No Hair        61 DC Comics <NA>       bad      
## # ℹ 212 more rows
## # ℹ 1 more variable: weight <dbl>
```

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
goodguys <- filter(superheroclean_info, alignment == "good")
```


```r
badguys <- filter(superheroclean_info, alignment == "bad")
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
goodguys %>%
  tabyl(race)
```

```
##               race   n     percent valid_percent
##              Alien   3 0.006048387   0.010752688
##              Alpha   5 0.010080645   0.017921147
##             Amazon   2 0.004032258   0.007168459
##            Android   4 0.008064516   0.014336918
##             Animal   2 0.004032258   0.007168459
##          Asgardian   3 0.006048387   0.010752688
##          Atlantean   4 0.008064516   0.014336918
##         Bolovaxian   1 0.002016129   0.003584229
##              Clone   1 0.002016129   0.003584229
##             Cyborg   3 0.006048387   0.010752688
##           Demi-God   2 0.004032258   0.007168459
##              Demon   3 0.006048387   0.010752688
##            Eternal   1 0.002016129   0.003584229
##     Flora Colossus   1 0.002016129   0.003584229
##        Frost Giant   1 0.002016129   0.003584229
##      God / Eternal   6 0.012096774   0.021505376
##             Gungan   1 0.002016129   0.003584229
##              Human 148 0.298387097   0.530465950
##    Human / Altered   2 0.004032258   0.007168459
##     Human / Cosmic   2 0.004032258   0.007168459
##  Human / Radiation   8 0.016129032   0.028673835
##         Human-Kree   2 0.004032258   0.007168459
##      Human-Spartoi   1 0.002016129   0.003584229
##       Human-Vulcan   1 0.002016129   0.003584229
##    Human-Vuldarian   1 0.002016129   0.003584229
##      Icthyo Sapien   1 0.002016129   0.003584229
##            Inhuman   4 0.008064516   0.014336918
##    Kakarantharaian   1 0.002016129   0.003584229
##         Kryptonian   4 0.008064516   0.014336918
##            Martian   1 0.002016129   0.003584229
##          Metahuman   1 0.002016129   0.003584229
##             Mutant  46 0.092741935   0.164874552
##     Mutant / Clone   1 0.002016129   0.003584229
##             Planet   1 0.002016129   0.003584229
##             Saiyan   1 0.002016129   0.003584229
##           Symbiote   3 0.006048387   0.010752688
##           Talokite   1 0.002016129   0.003584229
##         Tamaranean   1 0.002016129   0.003584229
##            Ungaran   1 0.002016129   0.003584229
##            Vampire   2 0.004032258   0.007168459
##     Yoda's species   1 0.002016129   0.003584229
##      Zen-Whoberian   1 0.002016129   0.003584229
##               <NA> 217 0.437500000            NA
```

7. Among the good guys, Who are the Vampires?

```r
goodguys %>%
  filter(race == "Vampire")
```

```
## # A tibble: 2 × 10
##   name  gender eye_color race   hair_color height publisher skin_color alignment
##   <chr> <chr>  <chr>     <chr>  <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Angel Male   <NA>      Vampi… <NA>           NA Dark Hor… <NA>       good     
## 2 Blade Male   brown     Vampi… Black         188 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

8. Among the bad guys, who are the male humans over 200 inches in height?

```r
badguys %>%
  select(gender, height, name) %>%
  filter(gender == "Male") %>%
  filter(height >= 200)
```

```
## # A tibble: 22 × 3
##    gender height name          
##    <chr>   <dbl> <chr>         
##  1 Male      203 Abomination   
##  2 Male      244 Alien         
##  3 Male      257 Amazo         
##  4 Male      213 Apocalypse    
##  5 Male      203 Bane          
##  6 Male      267 Darkseid      
##  7 Male      201 Doctor Doom   
##  8 Male      201 Doctor Doom II
##  9 Male      244 Doomsday      
## 10 Male      244 Killer Croc   
## # ℹ 12 more rows
```

9. Are there more good guys or bad guys with green hair?  
# More good guys with green hair

```r
# 7 good guys with green hair
goodguys %>%
  select(hair_color) %>%
  filter(hair_color == "Green")
```

```
## # A tibble: 7 × 1
##   hair_color
##   <chr>     
## 1 Green     
## 2 Green     
## 3 Green     
## 4 Green     
## 5 Green     
## 6 Green     
## 7 Green
```


```r
# 1 bad guy with green hair
badguys %>%
  select(hair_color) %>%
  filter(hair_color == "Green")
```

```
## # A tibble: 1 × 1
##   hair_color
##   <chr>     
## 1 Green
```


10. Let's explore who the really small superheros are. In the `superhero_info` data, which have a weight less than 50? Be sure to sort your results by weight lowest to highest.  

```r
superheroclean_info %>%
  select(weight, name) %>%
  filter(weight <= 50) %>%
  arrange(weight)
```

```
## # A tibble: 31 × 2
##    weight name           
##     <dbl> <chr>          
##  1      2 Iron Monger    
##  2      4 Groot          
##  3     14 Jack-Jack      
##  4     16 Galactus       
##  5     17 Yoda           
##  6     18 Fin Fang Foom  
##  7     18 Howard the Duck
##  8     18 Krypto         
##  9     25 Rocket Raccoon 
## 10     27 Dash           
## # ℹ 21 more rows
```

11. Let's make a new variable that is the ratio of height to weight. Call this variable `height_weight_ratio`.    

```r
height_weight_ratio <- superheroclean_info$height / superheroclean_info$weight
```

12. Who has the highest height to weight ratio?  
#Groot

```r
superheroclean_info$height_weight_ratio <- height_weight_ratio
superheroclean_info
```

```
## # A tibble: 734 × 11
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 A-Bo… Male   yellow    Human No Hair       203 Marvel C… <NA>       good     
##  2 Abe … Male   blue      Icth… No Hair       191 Dark Hor… blue       good     
##  3 Abin… Male   blue      Unga… No Hair       185 DC Comics red        good     
##  4 Abom… Male   green     Huma… No Hair       203 Marvel C… <NA>       bad      
##  5 Abra… Male   blue      Cosm… Black          NA Marvel C… <NA>       bad      
##  6 Abso… Male   blue      Human No Hair       193 Marvel C… <NA>       bad      
##  7 Adam… Male   blue      <NA>  Blond          NA NBC - He… <NA>       good     
##  8 Adam… Male   blue      Human Blond         185 DC Comics <NA>       good     
##  9 Agen… Female blue      <NA>  Blond         173 Marvel C… <NA>       good     
## 10 Agen… Male   brown     Human Brown         178 Marvel C… <NA>       good     
## # ℹ 724 more rows
## # ℹ 2 more variables: weight <dbl>, height_weight_ratio <dbl>
```



```r
superheroclean_info$name[which.max(superheroclean_info$height_weight_ratio)]
```

```
## [1] "Groot"
```

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  

13. How many superheros have a combination of agility, stealth, super_strength, stamina?


```r
superhero_powers %>%
  filter(Agility == TRUE & Stealth == TRUE & Stamina == TRUE & 'Super Strength' == TRUE)
```

```
## # A tibble: 0 × 168
## # ℹ 168 variables: hero_names <chr>, Agility <lgl>, Accelerated Healing <lgl>,
## #   Lantern Power Ring <lgl>, Dimensional Awareness <lgl>,
## #   Cold Resistance <lgl>, Durability <lgl>, Stealth <lgl>,
## #   Energy Absorption <lgl>, Flight <lgl>, Danger Sense <lgl>,
## #   Underwater breathing <lgl>, Marksmanship <lgl>, Weapons Master <lgl>,
## #   Power Augmentation <lgl>, Animal Attributes <lgl>, Longevity <lgl>,
## #   Intelligence <lgl>, Super Strength <lgl>, Cryokinesis <lgl>, …
```

## Your Favorite
14. Pick your favorite superhero and let's see their powers!  

```r
superhero_powers %>%
  filter(hero_names == "Batman")
```

```
## # A tibble: 1 × 168
##   hero_names Agility `Accelerated Healing` `Lantern Power Ring`
##   <chr>      <lgl>   <lgl>                 <lgl>               
## 1 Batman     TRUE    FALSE                 FALSE               
## # ℹ 164 more variables: `Dimensional Awareness` <lgl>, `Cold Resistance` <lgl>,
## #   Durability <lgl>, Stealth <lgl>, `Energy Absorption` <lgl>, Flight <lgl>,
## #   `Danger Sense` <lgl>, `Underwater breathing` <lgl>, Marksmanship <lgl>,
## #   `Weapons Master` <lgl>, `Power Augmentation` <lgl>,
## #   `Animal Attributes` <lgl>, Longevity <lgl>, Intelligence <lgl>,
## #   `Super Strength` <lgl>, Cryokinesis <lgl>, Telepathy <lgl>,
## #   `Energy Armor` <lgl>, `Energy Blasts` <lgl>, Duplication <lgl>, …
```

15. Can you find your hero in the superhero_info data? Show their info!  

```r
superhero_info %>%
  filter(name == "Batman")
```

```
## # A tibble: 2 × 10
##   name   Gender `Eye color` Race  `Hair color` Height Publisher `Skin color`
##   <chr>  <chr>  <chr>       <chr> <chr>         <dbl> <chr>     <chr>       
## 1 Batman Male   blue        Human black           188 DC Comics <NA>        
## 2 Batman Male   blue        Human Black           178 DC Comics <NA>        
## # ℹ 2 more variables: Alignment <chr>, Weight <dbl>
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
