---
title: "Lab 4 Homework"
author: "Elisabeth Sellinger"
date: "2024-01-26"
output:
  html_document: 
    theme: spacelab
    keep_md: true
---



## Instructions
Answer the following questions and complete the exercises in RMarkdown. Please embed all of your code and push your final work to your repository. Your final lab report should be organized, clean, and run free from errors. Remember, you must remove the `#` for the included code chunks to run. Be sure to add your name to the author header above.  

Make sure to use the formatting conventions of RMarkdown to make your report neat and clean!  

## Load the tidyverse

```r
library(tidyverse)
```

## Data
For the homework, we will use data about vertebrate home range sizes. The data are in the class folder, but the reference is below.  

**Database of vertebrate home range sizes.**  
Reference: Tamburello N, Cote IM, Dulvy NK (2015) Energy and the scaling of animal space use. The American Naturalist 186(2):196-211. http://dx.doi.org/10.1086/682070.  
Data: http://datadryad.org/resource/doi:10.5061/dryad.q5j65/1  

**1. Load the data into a new object called `homerange`.**

```r
homerange <- read.csv("data/Tamburelloetal_HomeRangeDatabase.csv")
```

**2. Explore the data. Show the dimensions, column names, classes for each variable, and a statistical summary. Keep these as separate code chunks.**  

```r
dim(homerange)
```

```
## [1] 569  24
```


```r
names(homerange)
```

```
##  [1] "taxon"                      "common.name"               
##  [3] "class"                      "order"                     
##  [5] "family"                     "genus"                     
##  [7] "species"                    "primarymethod"             
##  [9] "N"                          "mean.mass.g"               
## [11] "log10.mass"                 "alternative.mass.reference"
## [13] "mean.hra.m2"                "log10.hra"                 
## [15] "hra.reference"              "realm"                     
## [17] "thermoregulation"           "locomotion"                
## [19] "trophic.guild"              "dimension"                 
## [21] "preymass"                   "log10.preymass"            
## [23] "PPMR"                       "prey.size.reference"
```


```r
str(homerange)
```

```
## 'data.frame':	569 obs. of  24 variables:
##  $ taxon                     : chr  "lake fishes" "river fishes" "river fishes" "river fishes" ...
##  $ common.name               : chr  "american eel" "blacktail redhorse" "central stoneroller" "rosyside dace" ...
##  $ class                     : chr  "actinopterygii" "actinopterygii" "actinopterygii" "actinopterygii" ...
##  $ order                     : chr  "anguilliformes" "cypriniformes" "cypriniformes" "cypriniformes" ...
##  $ family                    : chr  "anguillidae" "catostomidae" "cyprinidae" "cyprinidae" ...
##  $ genus                     : chr  "anguilla" "moxostoma" "campostoma" "clinostomus" ...
##  $ species                   : chr  "rostrata" "poecilura" "anomalum" "funduloides" ...
##  $ primarymethod             : chr  "telemetry" "mark-recapture" "mark-recapture" "mark-recapture" ...
##  $ N                         : chr  "16" NA "20" "26" ...
##  $ mean.mass.g               : num  887 562 34 4 4 ...
##  $ log10.mass                : num  2.948 2.75 1.531 0.602 0.602 ...
##  $ alternative.mass.reference: chr  NA NA NA NA ...
##  $ mean.hra.m2               : num  282750 282.1 116.1 125.5 87.1 ...
##  $ log10.hra                 : num  5.45 2.45 2.06 2.1 1.94 ...
##  $ hra.reference             : chr  "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52 "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52 "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52 "Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52 ...
##  $ realm                     : chr  "aquatic" "aquatic" "aquatic" "aquatic" ...
##  $ thermoregulation          : chr  "ectotherm" "ectotherm" "ectotherm" "ectotherm" ...
##  $ locomotion                : chr  "swimming" "swimming" "swimming" "swimming" ...
##  $ trophic.guild             : chr  "carnivore" "carnivore" "carnivore" "carnivore" ...
##  $ dimension                 : chr  "3D" "2D" "2D" "2D" ...
##  $ preymass                  : num  NA NA NA NA NA NA 1.39 NA NA NA ...
##  $ log10.preymass            : num  NA NA NA NA NA ...
##  $ PPMR                      : num  NA NA NA NA NA NA 530 NA NA NA ...
##  $ prey.size.reference       : chr  NA NA NA NA ...
```


```r
summary(homerange)
```

```
##     taxon           common.name           class              order          
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##     family             genus             species          primarymethod     
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##       N              mean.mass.g        log10.mass     
##  Length:569         Min.   :      0   Min.   :-0.6576  
##  Class :character   1st Qu.:     50   1st Qu.: 1.6990  
##  Mode  :character   Median :    330   Median : 2.5185  
##                     Mean   :  34602   Mean   : 2.5947  
##                     3rd Qu.:   2150   3rd Qu.: 3.3324  
##                     Max.   :4000000   Max.   : 6.6021  
##                                                        
##  alternative.mass.reference  mean.hra.m2          log10.hra     
##  Length:569                 Min.   :0.000e+00   Min.   :-1.523  
##  Class :character           1st Qu.:4.500e+03   1st Qu.: 3.653  
##  Mode  :character           Median :3.934e+04   Median : 4.595  
##                             Mean   :2.146e+07   Mean   : 4.709  
##                             3rd Qu.:1.038e+06   3rd Qu.: 6.016  
##                             Max.   :3.551e+09   Max.   : 9.550  
##                                                                 
##  hra.reference         realm           thermoregulation    locomotion       
##  Length:569         Length:569         Length:569         Length:569        
##  Class :character   Class :character   Class :character   Class :character  
##  Mode  :character   Mode  :character   Mode  :character   Mode  :character  
##                                                                             
##                                                                             
##                                                                             
##                                                                             
##  trophic.guild       dimension            preymass         log10.preymass   
##  Length:569         Length:569         Min.   :     0.67   Min.   :-0.1739  
##  Class :character   Class :character   1st Qu.:    20.02   1st Qu.: 1.3014  
##  Mode  :character   Mode  :character   Median :    53.75   Median : 1.7304  
##                                        Mean   :  3989.88   Mean   : 2.0188  
##                                        3rd Qu.:   363.35   3rd Qu.: 2.5603  
##                                        Max.   :130233.20   Max.   : 5.1147  
##                                        NA's   :502         NA's   :502      
##       PPMR         prey.size.reference
##  Min.   :  0.380   Length:569         
##  1st Qu.:  3.315   Class :character   
##  Median :  7.190   Mode  :character   
##  Mean   : 31.752                      
##  3rd Qu.: 15.966                      
##  Max.   :530.000                      
##  NA's   :502
```

**3. Change the class of the variables `taxon` and `order` to factors and display their levels.**  

```r
homerange$taxon <- as.factor(homerange$taxon)
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```


```r
homerange$order <- as.factor(homerange$order)
levels(homerange$order)
```

```
##  [1] "accipitriformes"       "afrosoricida"          "anguilliformes"       
##  [4] "anseriformes"          "apterygiformes"        "artiodactyla"         
##  [7] "caprimulgiformes"      "carnivora"             "charadriiformes"      
## [10] "columbidormes"         "columbiformes"         "coraciiformes"        
## [13] "cuculiformes"          "cypriniformes"         "dasyuromorpha"        
## [16] "dasyuromorpia"         "didelphimorphia"       "diprodontia"          
## [19] "diprotodontia"         "erinaceomorpha"        "esociformes"          
## [22] "falconiformes"         "gadiformes"            "galliformes"          
## [25] "gruiformes"            "lagomorpha"            "macroscelidea"        
## [28] "monotrematae"          "passeriformes"         "pelecaniformes"       
## [31] "peramelemorphia"       "perciformes"           "perissodactyla"       
## [34] "piciformes"            "pilosa"                "proboscidea"          
## [37] "psittaciformes"        "rheiformes"            "roden"                
## [40] "rodentia"              "salmoniformes"         "scorpaeniformes"      
## [43] "siluriformes"          "soricomorpha"          "squamata"             
## [46] "strigiformes"          "struthioniformes"      "syngnathiformes"      
## [49] "testudines"            "tetraodontiformes\xa0" "tinamiformes"
```

**4. What taxa are represented in the `homerange` data frame? Make a new data frame `taxa` that is restricted to taxon, common name, class, order, family, genus, species.**  

```r
levels(homerange$taxon)
```

```
## [1] "birds"         "lake fishes"   "lizards"       "mammals"      
## [5] "marine fishes" "river fishes"  "snakes"        "tortoises"    
## [9] "turtles"
```


```r
taxa <- select(homerange, "taxon", "common.name", "class", "order", "family", "genus", "species")
head(taxa)
```

```
##          taxon         common.name          class          order       family
## 1  lake fishes        american eel actinopterygii anguilliformes  anguillidae
## 2 river fishes  blacktail redhorse actinopterygii  cypriniformes catostomidae
## 3 river fishes central stoneroller actinopterygii  cypriniformes   cyprinidae
## 4 river fishes       rosyside dace actinopterygii  cypriniformes   cyprinidae
## 5 river fishes       longnose dace actinopterygii  cypriniformes   cyprinidae
## 6 river fishes        muskellunge  actinopterygii    esociformes     esocidae
##         genus     species
## 1    anguilla    rostrata
## 2   moxostoma   poecilura
## 3  campostoma    anomalum
## 4 clinostomus funduloides
## 5 rhinichthys  cataractae
## 6        esox masquinongy
```

**5. The variable `taxon` identifies the common name groups of the species represented in `homerange`. Make a table that shows the counts for each of these `taxon`.**  

```r
table(homerange$taxon)
```

```
## 
##         birds   lake fishes       lizards       mammals marine fishes 
##           140             9            11           238            90 
##  river fishes        snakes     tortoises       turtles 
##            14            41            12            14
```

**6. The species in `homerange` are also classified into trophic guilds. How many species are represented in each trophic guild.**  

```r
herbivores <- filter(homerange, trophic.guild == "herbivore")
sum(table(herbivores$species))
```

```
## [1] 227
```


```r
carnivores <- filter(homerange, trophic.guild == "carnivore")
sum(table(carnivores$species))
```

```
## [1] 342
```


```r
count(homerange, trophic.guild)
```

```
##   trophic.guild   n
## 1     carnivore 342
## 2     herbivore 227
```


```r
homerange %>% group_by(trophic.guild) %>% summarize(n_species=n_distinct(species)) # how many carnivores/herbivores for each specific epithet
```

```
## # A tibble: 2 × 2
##   trophic.guild n_species
##   <chr>             <int>
## 1 carnivore           322
## 2 herbivore           212
```


## Finish 1-6 for 1/25


**7. Make two new data frames, one which is restricted to carnivores and another that is restricted to herbivores.**  

```r
carnivores_data <- filter(homerange, trophic.guild == "carnivore")
head(carnivores_data)
```

```
##          taxon         common.name          class          order       family
## 1  lake fishes        american eel actinopterygii anguilliformes  anguillidae
## 2 river fishes  blacktail redhorse actinopterygii  cypriniformes catostomidae
## 3 river fishes central stoneroller actinopterygii  cypriniformes   cyprinidae
## 4 river fishes       rosyside dace actinopterygii  cypriniformes   cyprinidae
## 5 river fishes       longnose dace actinopterygii  cypriniformes   cyprinidae
## 6 river fishes        muskellunge  actinopterygii    esociformes     esocidae
##         genus     species  primarymethod    N mean.mass.g log10.mass
## 1    anguilla    rostrata      telemetry   16         887   2.947924
## 2   moxostoma   poecilura mark-recapture <NA>         562   2.749736
## 3  campostoma    anomalum mark-recapture   20          34   1.531479
## 4 clinostomus funduloides mark-recapture   26           4   0.602060
## 5 rhinichthys  cataractae mark-recapture   17           4   0.602060
## 6        esox masquinongy      telemetry    5        3525   3.547159
##   alternative.mass.reference mean.hra.m2 log10.hra
## 1                       <NA>   282750.00  5.451403
## 2                       <NA>      282.10  2.450403
## 3                       <NA>      116.11  2.064870
## 4                       <NA>      125.50  2.098644
## 5                       <NA>       87.10  1.940018
## 6                       <NA>    39343.50  4.594873
##                                                                                                                                hra.reference
## 1 Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52:1499-1508.
## 2 Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52:1499-1508.
## 3 Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52:1499-1508.
## 4 Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52:1499-1508.
## 5 Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52:1499-1508.
## 6 Minns, C. K. 1995. Allometry of home range size in lake and river fishes. Canadian Journal of Fisheries and Aquatic Sciences 52:1499-1508.
##     realm thermoregulation locomotion trophic.guild dimension preymass
## 1 aquatic        ectotherm   swimming     carnivore        3D       NA
## 2 aquatic        ectotherm   swimming     carnivore        2D       NA
## 3 aquatic        ectotherm   swimming     carnivore        2D       NA
## 4 aquatic        ectotherm   swimming     carnivore        2D       NA
## 5 aquatic        ectotherm   swimming     carnivore        2D       NA
## 6 aquatic        ectotherm   swimming     carnivore        2D       NA
##   log10.preymass PPMR prey.size.reference
## 1             NA   NA                <NA>
## 2             NA   NA                <NA>
## 3             NA   NA                <NA>
## 4             NA   NA                <NA>
## 5             NA   NA                <NA>
## 6             NA   NA                <NA>
```


```r
herbivores_data <- filter(homerange, trophic.guild == "herbivore")
head(herbivores_data)
```

```
##           taxon             common.name          class       order
## 1 marine fishes       lined surgeonfish actinopterygii perciformes
## 2 marine fishes orangespine unicornfish actinopterygii perciformes
## 3 marine fishes   bluespine unicornfish actinopterygii perciformes
## 4 marine fishes           redlip blenny actinopterygii perciformes
## 5 marine fishes            bermuda chub actinopterygii perciformes
## 6 marine fishes              cherubfish actinopterygii perciformes
##          family         genus    species      primarymethod    N mean.mass.g
## 1  acanthuridae    acanthurus   lineatus direct observation <NA>      109.04
## 2  acanthuridae          naso  lituratus          telemetry    8      772.16
## 3  acanthuridae          naso  unicornis          telemetry    7      151.84
## 4     blennidae ophioblennius atlanticus direct observation   20        6.20
## 5    kyphosidae      kyphosus  sectatrix          telemetry   11     1086.71
## 6 pomacanthidae    centropyge       argi direct observation <NA>        2.50
##   log10.mass alternative.mass.reference mean.hra.m2   log10.hra
## 1  2.0375858                       <NA>       11.13  1.04649516
## 2  2.8877073                       <NA>    32092.86  4.50640842
## 3  2.1813862                       <NA>    17900.00  4.25285303
## 4  0.7923917                       <NA>        0.52 -0.28399666
## 5  3.0361137                       <NA>    34423.00  4.53684872
## 6  0.3979400                       <NA>        1.13  0.05307844
##                                                                                                                                                                                                                                 hra.reference
## 1                                                                                                Nursall JR. 1974. Some Territorial Behavioral Attributes of the Surgeonfish Acanthurus lineatus at Heron Island, Queensland. Copeia 950-959.
## 2                                       Marshell A, Mills JS, Rhodes KL, et al. 2011. Passive acoustic telemetry reveals highly variable home range and movement patterns among unicornfish within a marine reserve. Coral Reefs 30, 631-642.
## 3                                       Marshell A, Mills JS, Rhodes KL, et al. 2011. Passive acoustic telemetry reveals highly variable home range and movement patterns among unicornfish within a marine reserve. Coral Reefs 30, 631-642.
## 4                                                                                              Nursall JR. 1977. Territoriality in Redlip blennies (Ophioblennius atlanticus - Pisces : Blenniidae). Journal of Zoology, London 182, 205-223.
## 5 Eristhee N, Oxenford HA. 2001. Home range size and use of space by Bermuda chub Kyphosus sectatrix (L.) in two marine reserves in the Soufri\xe8re Marine Management Area, St Lucia, West Indies. Journal of Fisheries Biology 59, 129-151.
## 6                                                                                                                      Luckhurst BE, Luckhurst K. 1978. Diurnal Space Utilization in Coral Reef Fish Communities. Marine Biology 49, 325-332.
##     realm thermoregulation locomotion trophic.guild dimension preymass
## 1 aquatic        ectotherm   swimming     herbivore        2D       NA
## 2 aquatic        ectotherm   swimming     herbivore        2D       NA
## 3 aquatic        ectotherm   swimming     herbivore        2D       NA
## 4 aquatic        ectotherm   swimming     herbivore        2D       NA
## 5 aquatic        ectotherm   swimming     herbivore        2D       NA
## 6 aquatic        ectotherm   swimming     herbivore        2D       NA
##   log10.preymass PPMR prey.size.reference
## 1             NA   NA                <NA>
## 2             NA   NA                <NA>
## 3             NA   NA                <NA>
## 4             NA   NA                <NA>
## 5             NA   NA                <NA>
## 6             NA   NA                <NA>
```

**8. Do herbivores or carnivores have, on average, a larger `mean.hra.m2`? Remove any NAs from the data.**  

```r
mean(herbivores_data$mean.hra.m2, na.rm = T)
```

```
## [1] 34137012
```


```r
mean(carnivores_data$mean.hra.m2, na.rm = T)
```

```
## [1] 13039918
```
*Herbivores have a larger, on average `mean.hra.m2`*

**9. Make a new dataframe `owls` that is limited to the mean mass, log10 mass, family, genus, and species of owls in the database. Which is the smallest owl? What is its common name? Do a little bit of searching online to see what you can learn about this species and provide a link below** 

```r
owls <- filter(homerange, order == "strigiformes")
owls1 <- select(owls, "mean.mass.g","log10.mass", "family", "genus", "species") %>% 
arrange(mean.mass.g)
head(owls1)
```

```
##   mean.mass.g log10.mass    family      genus    species
## 1       61.32   1.787602 strigidae glaucidium passerinum
## 2      119.00   2.075547 strigidae   aegolius   funereus
## 3      156.50   2.194514 strigidae     athene     noctua
## 4      252.00   2.401401 strigidae       asio       otus
## 5      285.00   2.454845 tytonidae       tyto       alba
## 6      519.00   2.715167 strigidae      strix      aluco
```
*Glaucidium passerinum is the smallest at 61.32g. Common name is Eurasian pygmy owl. https://animaldiversity.org/accounts/Glaucidium_passerinum/*

**10. As measured by the data, which bird species has the largest homerange? Show all of your work, please. Look this species up online and tell me about it!**.  

```r
birds <- filter(homerange, class == "aves") %>% 
arrange(desc(mean.hra.m2))
head(birds)
```

```
##   taxon            common.name class            order        family      genus
## 1 birds               caracara  aves    falconiformes    falconidae   caracara
## 2 birds      Montagu's harrier  aves    falconiformes  accipitridae     circus
## 3 birds       peregrine falcon  aves    falconiformes    falconidae      falco
## 4 birds           booted eagle  aves  accipitriformes  accipitridae hieraaetus
## 5 birds                ostrich  aves struthioniformes struthionidae   struthio
## 6 birds short-toed snake eagle  aves  accipitriformes  accipitridae  circaetus
##      species primarymethod    N mean.mass.g log10.mass
## 1   cheriway     telemetry   26      1125.0   3.051153
## 2   pygargus    telemetry* <NA>       315.5   2.498999
## 3 peregrinus    telemetry* <NA>       781.5   2.892929
## 4   pennatus     telemetry    4       975.0   2.989005
## 5    camelus     telemetry    1     88250.0   4.945715
## 6   gallicus    telemetry* <NA>      1699.0   3.230193
##   alternative.mass.reference mean.hra.m2 log10.hra
## 1                       <NA>   241000000  8.382017
## 2                       <NA>   200980000  8.303153
## 3                       <NA>   153860000  8.187126
## 4                       <NA>   117300000  8.069298
## 5                       <NA>    84300000  7.925828
## 6                       <NA>    78500000  7.894870
##                                                                                                                                                                                                   hra.reference
## 1                                                Dwyer JF, Fraser JD, Morrison JL. 2013. Range sizes and habitat use of non-breeding Crested Caracaras in Florida. Journal of Field Ornithology 84(3), 223-233.
## 2                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 3                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 4    Martinez JE, Pagan I, Palazon JA, Calvo JF. 2007. Habitat use of booted eagles (Hieraaetus pennatus) in a Special Protection Area: implications for conservation. Biodiversity Conservation 16, 3481-3488.
## 5 Williams JB, Siegfried WR, Milton SJ, Adams NJ, Dean WRT, du Plessis MA, Jackson S. 1993. Field Metabolism, Water Requirements, and Foraging Behavior of Wild Ostriches in the Namib. Ecology 74(2), 390-404.
## 6                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
##         realm thermoregulation locomotion trophic.guild dimension preymass
## 1 terrestrial        endotherm    walking     carnivore        2D       NA
## 2 terrestrial        endotherm     flying     carnivore        3D       NA
## 3 terrestrial        endotherm     flying     carnivore        3D   165.90
## 4 terrestrial        endotherm     flying     carnivore        3D   365.17
## 5 terrestrial        endotherm    walking     herbivore        2D       NA
## 6 terrestrial        endotherm     flying     carnivore        3D   164.95
##   log10.preymass  PPMR
## 1             NA    NA
## 2             NA    NA
## 3       2.219846  4.71
## 4       2.562495  2.56
## 5             NA    NA
## 6       2.217352 10.30
##                                                                                                                                                                                                                                    prey.size.reference
## 1                                                                                                                                                                                                                                                 <NA>
## 2                                                                                                                                                                                                                                                 <NA>
## 3 Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 4 Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 5                                                                                                                                                                                                                                                 <NA>
## 6 Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
```
*The bird species with the largest homerange is the Caracara cheriway (Northern crested caracara) at 241000000m2. https://animaldiversity.org/accounts/Caracara_cheriway/*

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
