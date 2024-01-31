---
title: "dplyr Superhero"
date: "2024-01-31"
output:
  html_document: 
    theme: spacelab
    toc: true
    toc_float: true
    keep_md: true
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
## ✔ dplyr     1.1.4     ✔ readr     2.1.5
## ✔ forcats   1.0.0     ✔ stringr   1.5.1
## ✔ ggplot2   3.4.4     ✔ tibble    3.2.1
## ✔ lubridate 1.9.3     ✔ tidyr     1.3.1
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
superhero_info <- read_csv("data/heroes_information.csv", na = c("", "-99", "-")) #can assign na values in read_csv
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
superhero_info <- clean_names(superhero_info)
```

## `tabyl`
The `janitor` package has many awesome functions that we will explore. Here is its version of `table` which not only produces counts but also percentages. Very handy! Let's use it to explore the proportion of good guys and bad guys in the `superhero_info` data.  

```r
tabyl(superhero_info$alignment)
```

```
##  superhero_info$alignment   n     percent valid_percent
##                       bad 207 0.282016349    0.28473177
##                      good 496 0.675749319    0.68225585
##                   neutral  24 0.032697548    0.03301238
##                      <NA>   7 0.009536785            NA
```

1. Who are the publishers of the superheros? Show the proportion of superheros from each publisher. Which publisher has the highest number of superheros?  

```r
tabyl(superhero_info$publisher)
```

```
##  superhero_info$publisher   n     percent valid_percent
##               ABC Studios   4 0.005449591   0.005563282
##                 DC Comics 215 0.292915531   0.299026426
##         Dark Horse Comics  18 0.024523161   0.025034771
##              George Lucas  14 0.019073569   0.019471488
##             Hanna-Barbera   1 0.001362398   0.001390821
##             HarperCollins   6 0.008174387   0.008344924
##            IDW Publishing   4 0.005449591   0.005563282
##               Icon Comics   4 0.005449591   0.005563282
##              Image Comics  14 0.019073569   0.019471488
##             J. K. Rowling   1 0.001362398   0.001390821
##          J. R. R. Tolkien   1 0.001362398   0.001390821
##             Marvel Comics 388 0.528610354   0.539638387
##                 Microsoft   1 0.001362398   0.001390821
##              NBC - Heroes  19 0.025885559   0.026425591
##                 Rebellion   1 0.001362398   0.001390821
##                  Shueisha   4 0.005449591   0.005563282
##             Sony Pictures   2 0.002724796   0.002781641
##                South Park   1 0.001362398   0.001390821
##                 Star Trek   6 0.008174387   0.008344924
##                      SyFy   5 0.006811989   0.006954103
##              Team Epic TV   5 0.006811989   0.006954103
##               Titan Books   1 0.001362398   0.001390821
##         Universal Studios   1 0.001362398   0.001390821
##                 Wildstorm   3 0.004087193   0.004172462
##                      <NA>  15 0.020435967            NA
```
#### Marvel has the highest proportion

2. Notice that we have some neutral superheros! Who are they? List their names below.  

```r
superhero_info %>% 
  select("name", "alignment") %>% 
  filter(alignment == "neutral")
```

```
## # A tibble: 24 × 2
##    name         alignment
##    <chr>        <chr>    
##  1 Bizarro      neutral  
##  2 Black Flash  neutral  
##  3 Captain Cold neutral  
##  4 Copycat      neutral  
##  5 Deadpool     neutral  
##  6 Deathstroke  neutral  
##  7 Etrigan      neutral  
##  8 Galactus     neutral  
##  9 Gladiator    neutral  
## 10 Indigo       neutral  
## # ℹ 14 more rows
```
#### Names: Bizarro	neutral, Black Flash, Captain Cold, Copycat, Deadpool, Deathstroke, Etrigan, Galactus, Gladiator, Indigo

## `superhero_info`
3. Let's say we are only interested in the variables name, alignment, and "race". How would you isolate these variables from `superhero_info`?

```r
superhero_info %>% 
  select("name", "alignment", "race")
```

```
## # A tibble: 734 × 3
##    name          alignment race             
##    <chr>         <chr>     <chr>            
##  1 A-Bomb        good      Human            
##  2 Abe Sapien    good      Icthyo Sapien    
##  3 Abin Sur      good      Ungaran          
##  4 Abomination   bad       Human / Radiation
##  5 Abraxas       bad       Cosmic Entity    
##  6 Absorbing Man bad       Human            
##  7 Adam Monroe   good      <NA>             
##  8 Adam Strange  good      Human            
##  9 Agent 13      good      <NA>             
## 10 Agent Bob     good      Human            
## # ℹ 724 more rows
```

## Not Human
4. List all of the superheros that are not human.

```r
superhero_info %>% 
  select("name", "race") %>% 
  filter(race != "Human") %>% 
  filter(race != "Human / Radiation")
```

```
## # A tibble: 211 × 2
##    name         race           
##    <chr>        <chr>          
##  1 Abe Sapien   Icthyo Sapien  
##  2 Abin Sur     Ungaran        
##  3 Abraxas      Cosmic Entity  
##  4 Ajax         Cyborg         
##  5 Alien        Xenomorph XX121
##  6 Amazo        Android        
##  7 Angel        Vampire        
##  8 Angel Dust   Mutant         
##  9 Anti-Monitor God / Eternal  
## 10 Anti-Venom   Symbiote       
## # ℹ 201 more rows
```

## Good and Evil
5. Let's make two different data frames, one focused on the "good guys" and another focused on the "bad guys".

```r
good <- superhero_info %>% 
  filter(alignment == "good")

bad <- superhero_info %>% 
  filter(alignment == "bad")
```

6. For the good guys, use the `tabyl` function to summarize their "race".

```r
superhero_info %>% 
  tabyl(race)
```

```
##                race   n     percent valid_percent
##               Alien   7 0.009536785   0.016279070
##               Alpha   5 0.006811989   0.011627907
##              Amazon   2 0.002724796   0.004651163
##             Android   9 0.012261580   0.020930233
##              Animal   4 0.005449591   0.009302326
##           Asgardian   5 0.006811989   0.011627907
##           Atlantean   5 0.006811989   0.011627907
##             Bizarro   1 0.001362398   0.002325581
##          Bolovaxian   1 0.001362398   0.002325581
##               Clone   1 0.001362398   0.002325581
##       Cosmic Entity   4 0.005449591   0.009302326
##              Cyborg  11 0.014986376   0.025581395
##            Czarnian   1 0.001362398   0.002325581
##  Dathomirian Zabrak   1 0.001362398   0.002325581
##            Demi-God   2 0.002724796   0.004651163
##               Demon   6 0.008174387   0.013953488
##             Eternal   2 0.002724796   0.004651163
##      Flora Colossus   1 0.001362398   0.002325581
##         Frost Giant   2 0.002724796   0.004651163
##       God / Eternal  14 0.019073569   0.032558140
##             Gorilla   1 0.001362398   0.002325581
##              Gungan   1 0.001362398   0.002325581
##               Human 208 0.283378747   0.483720930
##     Human / Altered   3 0.004087193   0.006976744
##       Human / Clone   1 0.001362398   0.002325581
##      Human / Cosmic   2 0.002724796   0.004651163
##   Human / Radiation  11 0.014986376   0.025581395
##          Human-Kree   2 0.002724796   0.004651163
##       Human-Spartoi   1 0.001362398   0.002325581
##        Human-Vulcan   1 0.001362398   0.002325581
##     Human-Vuldarian   1 0.001362398   0.002325581
##       Icthyo Sapien   1 0.001362398   0.002325581
##             Inhuman   4 0.005449591   0.009302326
##               Kaiju   1 0.001362398   0.002325581
##     Kakarantharaian   1 0.001362398   0.002325581
##           Korugaran   1 0.001362398   0.002325581
##          Kryptonian   7 0.009536785   0.016279070
##           Luphomoid   1 0.001362398   0.002325581
##               Maiar   1 0.001362398   0.002325581
##             Martian   1 0.001362398   0.002325581
##           Metahuman   2 0.002724796   0.004651163
##              Mutant  63 0.085831063   0.146511628
##      Mutant / Clone   1 0.001362398   0.002325581
##             New God   3 0.004087193   0.006976744
##            Neyaphem   1 0.001362398   0.002325581
##           Parademon   1 0.001362398   0.002325581
##              Planet   1 0.001362398   0.002325581
##              Rodian   1 0.001362398   0.002325581
##              Saiyan   2 0.002724796   0.004651163
##             Spartoi   1 0.001362398   0.002325581
##           Strontian   1 0.001362398   0.002325581
##            Symbiote   9 0.012261580   0.020930233
##            Talokite   1 0.001362398   0.002325581
##          Tamaranean   1 0.001362398   0.002325581
##             Ungaran   1 0.001362398   0.002325581
##             Vampire   2 0.002724796   0.004651163
##     Xenomorph XX121   1 0.001362398   0.002325581
##              Yautja   1 0.001362398   0.002325581
##      Yoda's species   1 0.001362398   0.002325581
##       Zen-Whoberian   1 0.001362398   0.002325581
##              Zombie   1 0.001362398   0.002325581
##                <NA> 304 0.414168937            NA
```

7. Among the good guys, Who are the Vampires?

```r
good %>% 
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
#### Among the good guys, the Vampires are Angel and Blade

8. Among the bad guys, who are the male humans over 200 inches in height?

```r
bad %>% 
  filter(height >= "200")
```

```
## # A tibble: 28 × 10
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Abom… Male   green     Huma… No Hair     203   Marvel C… <NA>       bad      
##  2 Alien Male   <NA>      Xeno… No Hair     244   Dark Hor… black      bad      
##  3 Amazo Male   red       Andr… <NA>        257   DC Comics <NA>       bad      
##  4 Anti… Male   yellow    God … No Hair      61   DC Comics <NA>       bad      
##  5 Apoc… Male   red       Muta… Black       213   Marvel C… grey       bad      
##  6 Bane  Male   <NA>      Human <NA>        203   DC Comics <NA>       bad      
##  7 Bloo… Female blue      Human Brown       218   Marvel C… <NA>       bad      
##  8 Bloo… Male   white     <NA>  No Hair      30.5 Marvel C… <NA>       bad      
##  9 Dark… Male   red       New … No Hair     267   DC Comics grey       bad      
## 10 Doct… Male   brown     Human Brown       201   Marvel C… <NA>       bad      
## # ℹ 18 more rows
## # ℹ 1 more variable: weight <dbl>
```

9. Are there more good guys or bad guys with green hair?  

```r
table(good$hair_color)
```

```
## 
##           Auburn            black            Black            blond 
##               10                3              108                2 
##            Blond             Blue            Brown    Brown / Black 
##               85                1               55                1 
##    Brown / White            Green             Grey           Indigo 
##                4                7                2                1 
##          Magenta          No Hair           Orange   Orange / White 
##                1               37                2                1 
##             Pink           Purple              Red      Red / White 
##                1                1               40                1 
##           Silver Strawberry Blond            White           Yellow 
##                3                4               10                2
```

```r
table(bad$hair_color)
```

```
## 
##           Auburn            Black     Black / Blue            blond 
##                3               42                1                1 
##            Blond             Blue            Brown           Brownn 
##               11                1               27                1 
##             Gold            Green             Grey          No Hair 
##                1                1                3               35 
##           Purple              Red       Red / Grey     Red / Orange 
##                3                9                1                1 
## Strawberry Blond            White 
##                3               10
```
#### There are more good guys with green hair (7) than bad guys with green hair (1)

10. Let's explore who the really small superheros are. In the `superhero_info` data, which have a weight less than 50? Be sure to sort your results by weight lowest to highest.  

```r
superhero_info %>% 
  select("name", "weight") %>% 
  filter(weight < 50) %>% 
  arrange(weight)
```

```
## # A tibble: 19 × 2
##    name              weight
##    <chr>              <dbl>
##  1 Iron Monger            2
##  2 Groot                  4
##  3 Jack-Jack             14
##  4 Galactus              16
##  5 Yoda                  17
##  6 Fin Fang Foom         18
##  7 Howard the Duck       18
##  8 Krypto                18
##  9 Rocket Raccoon        25
## 10 Dash                  27
## 11 Longshot              36
## 12 Robin V               38
## 13 Wiz Kid               39
## 14 Violet Parr           41
## 15 Franklin Richards     45
## 16 Swarm                 47
## 17 Hope Summers          48
## 18 Jolt                  49
## 19 Snowbird              49
```

11. Let's make a new variable that is the ratio of height to weight. Call this variable `height_weight_ratio`.    

```r
superhero_info %>% 
  mutate(height_weight_ratio = height/weight)
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

12. Who has the highest height to weight ratio?  

```r
superhero_info %>% 
  mutate(height_weight_ratio = height/weight) %>% 
  arrange(desc(height_weight_ratio))
```

```
## # A tibble: 734 × 11
##    name  gender eye_color race  hair_color height publisher skin_color alignment
##    <chr> <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
##  1 Groot Male   yellow    Flor… <NA>          701 Marvel C… <NA>       good     
##  2 Gala… Male   black     Cosm… Black         876 Marvel C… <NA>       neutral  
##  3 Fin … Male   red       Kaka… No Hair       975 Marvel C… green      good     
##  4 Long… Male   blue      Human Blond         188 Marvel C… <NA>       good     
##  5 Jack… Male   blue      Human Brown          71 Dark Hor… <NA>       good     
##  6 Rock… Male   brown     Anim… Brown         122 Marvel C… <NA>       good     
##  7 Dash  Male   blue      Human Blond         122 Dark Hor… <NA>       good     
##  8 Howa… Male   brown     <NA>  Yellow         79 Marvel C… <NA>       good     
##  9 Swarm Male   yellow    Muta… No Hair       196 Marvel C… yellow     bad      
## 10 Yoda  Male   brown     Yoda… White          66 George L… green      good     
## # ℹ 724 more rows
## # ℹ 2 more variables: weight <dbl>, height_weight_ratio <dbl>
```
#### Groot has the highest height to weight ratio at 175.25

## `superhero_powers`
Have a quick look at the `superhero_powers` data frame.  

```r
glimpse(superhero_powers)
```

```
## Rows: 667
## Columns: 168
## $ hero_names                     <chr> "3-D Man", "A-Bomb", "Abe Sapien", "Abi…
## $ Agility                        <lgl> TRUE, FALSE, TRUE, FALSE, FALSE, FALSE,…
## $ `Accelerated Healing`          <lgl> FALSE, TRUE, TRUE, FALSE, TRUE, FALSE, …
## $ `Lantern Power Ring`           <lgl> FALSE, FALSE, FALSE, TRUE, FALSE, FALSE…
## $ `Dimensional Awareness`        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Cold Resistance`              <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ Durability                     <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE,…
## $ Stealth                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Absorption`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Flight                         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Danger Sense`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Underwater breathing`         <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ Marksmanship                   <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Weapons Master`               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Power Augmentation`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Animal Attributes`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Longevity                      <lgl> FALSE, TRUE, TRUE, FALSE, FALSE, FALSE,…
## $ Intelligence                   <lgl> FALSE, FALSE, TRUE, FALSE, TRUE, TRUE, …
## $ `Super Strength`               <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, TRUE, TR…
## $ Cryokinesis                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Telepathy                      <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Energy Armor`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Blasts`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Duplication                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Size Changing`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Density Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Stamina                        <lgl> TRUE, TRUE, TRUE, FALSE, TRUE, FALSE, F…
## $ `Astral Travel`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Audio Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Dexterity                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnitrix                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Super Speed`                  <lgl> TRUE, FALSE, FALSE, FALSE, TRUE, TRUE, …
## $ Possession                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Animal Oriented Powers`       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Weapon-based Powers`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Electrokinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Darkforce Manipulation`       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Death Touch`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Teleportation                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Enhanced Senses`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Telekinesis                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Beams`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Magic                          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ Hyperkinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Jump                           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Clairvoyance                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Dimensional Travel`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Power Sense`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Shapeshifting                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Peak Human Condition`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Immortality                    <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, TRUE,…
## $ Camouflage                     <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE…
## $ `Element Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Phasing                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Astral Projection`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Electrical Transport`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Fire Control`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Projection                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Summoning                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Memory`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Reflexes                       <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ Invulnerability                <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, TRUE,…
## $ `Energy Constructs`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Force Fields`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Self-Sustenance`              <lgl> FALSE, TRUE, FALSE, FALSE, FALSE, FALSE…
## $ `Anti-Gravity`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Empathy                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Nullifier`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Radiation Control`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Psionic Powers`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Elasticity                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Substance Secretion`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Elemental Transmogrification` <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Technopath/Cyberpath`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Photographic Reflexes`        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Seismic Power`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Animation                      <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE…
## $ Precognition                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Mind Control`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Fire Resistance`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Absorption`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Hearing`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Nova Force`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Insanity                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Hypnokinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Animal Control`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Natural Armor`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Intangibility                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Sight`               <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Molecular Manipulation`       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Heat Generation`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Adaptation                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Gliding                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Suit`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Mind Blast`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Probability Manipulation`     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Gravity Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Regeneration                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Light Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Echolocation                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Levitation                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Toxin and Disease Control`    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Banish                         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Manipulation`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ `Heat Resistance`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Natural Weapons`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Time Travel`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Smell`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Illusions                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Thirstokinesis                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Hair Manipulation`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Illumination                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnipotent                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Cloaking                       <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Changing Armor`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Power Cosmic`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, TRUE…
## $ Biokinesis                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Water Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Radiation Immunity`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Telescopic`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Toxin and Disease Resistance` <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Spatial Awareness`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Energy Resistance`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Telepathy Resistance`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Molecular Combustion`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnilingualism                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Portal Creation`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Magnetism                      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Mind Control Resistance`      <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Plant Control`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Sonar                          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Sonic Scream`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Time Manipulation`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Enhanced Touch`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Magic Resistance`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Invisibility                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Sub-Mariner`                  <lgl> FALSE, FALSE, TRUE, FALSE, FALSE, FALSE…
## $ `Radiation Absorption`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Intuitive aptitude`           <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Microscopic`         <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Melting                        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Wind Control`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Super Breath`                 <lgl> FALSE, FALSE, FALSE, FALSE, TRUE, FALSE…
## $ Wallcrawling                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Night`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Infrared`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Grim Reaping`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Matter Absorption`            <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `The Force`                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Resurrection                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Terrakinesis                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Heat`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Vitakinesis                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Radar Sense`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Qwardian Power Ring`          <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Weather Control`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - X-Ray`               <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Thermal`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Web Creation`                 <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Reality Warping`              <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Odin Force`                   <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Symbiote Costume`             <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Speed Force`                  <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Phoenix Force`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Molecular Dissipation`        <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ `Vision - Cryo`                <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omnipresent                    <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
## $ Omniscient                     <lgl> FALSE, FALSE, FALSE, FALSE, FALSE, FALS…
```

```r
superhero_powers <- clean_names(superhero_powers)
head(superhero_powers)
```

```
## # A tibble: 6 × 168
##   hero_names  agility accelerated_healing lantern_power_ring
##   <chr>       <lgl>   <lgl>               <lgl>             
## 1 3-D Man     TRUE    FALSE               FALSE             
## 2 A-Bomb      FALSE   TRUE                FALSE             
## 3 Abe Sapien  TRUE    TRUE                FALSE             
## 4 Abin Sur    FALSE   FALSE               TRUE              
## 5 Abomination FALSE   TRUE                FALSE             
## 6 Abraxas     FALSE   FALSE               FALSE             
## # ℹ 164 more variables: dimensional_awareness <lgl>, cold_resistance <lgl>,
## #   durability <lgl>, stealth <lgl>, energy_absorption <lgl>, flight <lgl>,
## #   danger_sense <lgl>, underwater_breathing <lgl>, marksmanship <lgl>,
## #   weapons_master <lgl>, power_augmentation <lgl>, animal_attributes <lgl>,
## #   longevity <lgl>, intelligence <lgl>, super_strength <lgl>,
## #   cryokinesis <lgl>, telepathy <lgl>, energy_armor <lgl>,
## #   energy_blasts <lgl>, duplication <lgl>, size_changing <lgl>, …
```

13. How many superheros have a combination of agility, stealth, super_strength, stamina?

```r
superhero_powers %>%
  filter(agility & stealth & super_strength & stamina)
```

```
## # A tibble: 40 × 168
##    hero_names  agility accelerated_healing lantern_power_ring
##    <chr>       <lgl>   <lgl>               <lgl>             
##  1 Alex Mercer TRUE    TRUE                FALSE             
##  2 Angel       TRUE    TRUE                FALSE             
##  3 Ant-Man II  TRUE    FALSE               FALSE             
##  4 Aquaman     TRUE    TRUE                FALSE             
##  5 Batman      TRUE    FALSE               FALSE             
##  6 Black Flash TRUE    FALSE               FALSE             
##  7 Black Manta TRUE    FALSE               FALSE             
##  8 Brundlefly  TRUE    FALSE               FALSE             
##  9 Buffy       TRUE    TRUE                FALSE             
## 10 Cable       TRUE    TRUE                FALSE             
## # ℹ 30 more rows
## # ℹ 164 more variables: dimensional_awareness <lgl>, cold_resistance <lgl>,
## #   durability <lgl>, stealth <lgl>, energy_absorption <lgl>, flight <lgl>,
## #   danger_sense <lgl>, underwater_breathing <lgl>, marksmanship <lgl>,
## #   weapons_master <lgl>, power_augmentation <lgl>, animal_attributes <lgl>,
## #   longevity <lgl>, intelligence <lgl>, super_strength <lgl>,
## #   cryokinesis <lgl>, telepathy <lgl>, energy_armor <lgl>, …
```
#### 40 superheros have a combination of agility, stealth, super_strength, stamina.

## Your Favorite
14. Pick your favorite superhero and let's see their powers!  

```r
superhero_powers %>%
  filter(hero_names == "Iron Man") %>%
  select_if(all)
```

```
## Warning in .p(column, ...): coercing argument of type 'character' to logical
```

```
## # A tibble: 1 × 21
##   accelerated_healing durability energy_absorption flight underwater_breathing
##   <lgl>               <lgl>      <lgl>             <lgl>  <lgl>               
## 1 TRUE                TRUE       TRUE              TRUE   TRUE                
## # ℹ 16 more variables: marksmanship <lgl>, super_strength <lgl>,
## #   energy_blasts <lgl>, stamina <lgl>, super_speed <lgl>,
## #   weapon_based_powers <lgl>, energy_beams <lgl>, reflexes <lgl>,
## #   force_fields <lgl>, power_suit <lgl>, radiation_immunity <lgl>,
## #   vision_telescopic <lgl>, magnetism <lgl>, invisibility <lgl>,
## #   vision_night <lgl>, vision_thermal <lgl>
```

15. Can you find your hero in the superhero_info data? Show their info!  

```r
superhero_info %>% 
  filter(name == "Iron Man")
```

```
## # A tibble: 1 × 10
##   name   gender eye_color race  hair_color height publisher skin_color alignment
##   <chr>  <chr>  <chr>     <chr> <chr>       <dbl> <chr>     <chr>      <chr>    
## 1 Iron … Male   blue      Human Black         198 Marvel C… <NA>       good     
## # ℹ 1 more variable: weight <dbl>
```

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.  
