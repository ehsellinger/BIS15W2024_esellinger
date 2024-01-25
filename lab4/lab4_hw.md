---
title: "Lab 4 Homework"
author: "Elisabeth Sellinger"
date: "2024-01-25"
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
owls1 <- select(owls, "mean.mass.g","log10.mass", "family", "genus", "species")
owls1 ## sort from low to high to find smallest owl
```

```
##   mean.mass.g log10.mass    family      genus     species
## 1      119.00   2.075547 strigidae   aegolius    funereus
## 2      252.00   2.401401 strigidae       asio        otus
## 3      156.50   2.194514 strigidae     athene      noctua
## 4     2191.00   3.340642 strigidae       bubo        bubo
## 5     1510.00   3.178977 strigidae       bubo virginianus
## 6       61.32   1.787602 strigidae glaucidium  passerinum
## 7     1920.00   3.283301 strigidae     nyctea   scandiaca
## 8      519.00   2.715167 strigidae      strix       aluco
## 9      285.00   2.454845 tytonidae       tyto        alba
```
*Glaucidium passerinum is the smallest at 61.32g. Common name is Eurasian pygmy owl. https://animaldiversity.org/accounts/Glaucidium_passerinum/*

**10. As measured by the data, which bird species has the largest homerange? Show all of your work, please. Look this species up online and tell me about it!**.  

```r
birds <- filter(homerange, class == "aves")
birds # filter mean.hra.m2 from high to low to find largest homerange
```

```
##     taxon                    common.name class            order
## 1   birds                   golden eagle  aves  accipitriformes
## 2   birds                 common buzzard  aves  accipitriformes
## 3   birds         short-toed snake eagle  aves  accipitriformes
## 4   birds                Bonelli's eagle  aves  accipitriformes
## 5   birds                   booted eagle  aves  accipitriformes
## 6   birds               Egyptian vulture  aves  accipitriformes
## 7   birds                        gadwall  aves     anseriformes
## 8   birds            northern brown kiwi  aves   apterygiformes
## 9   birds              European nightjar  aves caprimulgiformes
## 10  birds                  oystercatcher  aves  charadriiformes
## 11  birds                      inca dove  aves    columbidormes
## 12  birds             common wood pigeon  aves    columbiformes
## 13  birds           European turtle dove  aves    columbiformes
## 14  birds                European roller  aves    coraciiformes
## 15  birds                         hoopoe  aves    coraciiformes
## 16  birds           great spotted cuckoo  aves     cuculiformes
## 17  birds                  common cuckoo  aves     cuculiformes
## 18  birds             greater roadrunner  aves     cuculiformes
## 19  birds           banded ground-cuckoo  aves     cuculiformes
## 20  birds                  Cooper's hawk  aves    falconiformes
## 21  birds               Northern goshawk  aves    falconiformes
## 22  birds           Eurasian sparrowhawk  aves    falconiformes
## 23  birds             sharp-shinned hawk  aves    falconiformes
## 24  birds                red-tailed hawk  aves    falconiformes
## 25  birds            red-shouldered hawk  aves    falconiformes
## 26  birds                Swainson's hawk  aves    falconiformes
## 27  birds                    hen harrier  aves    falconiformes
## 28  birds              Montagu's harrier  aves    falconiformes
## 29  birds                       red kite  aves    falconiformes
## 30  birds                       caracara  aves    falconiformes
## 31  birds          red-throated caracara  aves    falconiformes
## 32  birds                  lanner falcon  aves    falconiformes
## 33  birds                 prairie falcon  aves    falconiformes
## 34  birds               peregrine falcon  aves    falconiformes
## 35  birds               American kestrel  aves    falconiformes
## 36  birds               European kestrel  aves    falconiformes
## 37  birds                   hazel grouse  aves      galliformes
## 38  birds                    sage grouse  aves      galliformes
## 39  birds                   dusky grouse  aves      galliformes
## 40  birds               willow ptarmigan  aves      galliformes
## 41  birds                 grey partridge  aves      galliformes
## 42  birds                   black grouse  aves      galliformes
## 43  birds           western capercaillie  aves      galliformes
## 44  birds        greater prairie-chicken  aves      galliformes
## 45  birds                brown wood rail  aves       gruiformes
## 46  birds                      corncrake  aves       gruiformes
## 47  birds                      king rail  aves       gruiformes
## 48  birds              melodious warbler  aves    passeriformes
## 49  birds                long-tailed tit  aves    passeriformes
## 50  birds                       woodlark  aves    passeriformes
## 51  birds       red-throated ant tanager  aves    passeriformes
## 52  birds        red-crowned ant tanager  aves    passeriformes
## 53  birds           Eurasian treecreeper  aves    passeriformes
## 54  birds       streaked fantail warbler  aves    passeriformes
## 55  birds                   common raven  aves    passeriformes
## 56  birds             spotted nutcracker  aves    passeriformes
## 57  birds           Peruvian plantcutter  aves    passeriformes
## 58  birds            grasshopper sparrow  aves    passeriformes
## 59  birds                 indigo bunting  aves    passeriformes
## 60  birds                 Abert's towhee  aves    passeriformes
## 61  birds                  canyon towhee  aves    passeriformes
## 62  birds          American tree sparrow  aves    passeriformes
## 63  birds               chipping sparrow  aves    passeriformes
## 64  birds                  common linnet  aves    passeriformes
## 65  birds               common chaffinch  aves    passeriformes
## 66  birds                 European serin  aves    passeriformes
## 67  birds             eastern meadowlark  aves    passeriformes
## 68  birds             western meadowlard  aves    passeriformes
## 69  birds           yellow-breasted chat  aves    passeriformes
## 70  birds              red-backed shrike  aves    passeriformes
## 71  birds              loggerhead shrike  aves    passeriformes
## 72  birds             lesser grey shrike  aves    passeriformes
## 73  birds                woodchat shrike  aves    passeriformes
## 74  birds           northern mockingbird  aves    passeriformes
## 75  birds                  white wagtail  aves    passeriformes
## 76  birds         western yellow wagtail  aves    passeriformes
## 77  birds             spotted flycatcher  aves    passeriformes
## 78  birds              northern wheatear  aves    passeriformes
## 79  birds                common redstart  aves    passeriformes
## 80  birds                       whinchat  aves    passeriformes
## 81  birds         black-capped chickadee  aves    passeriformes
## 82  birds             Carolina chickadee  aves    passeriformes
## 83  birds                   Oak titmouse  aves    passeriformes
## 84  birds                      marsh tit  aves    passeriformes
## 85  birds               mourning warbler  aves    passeriformes
## 86  birds            common yellowthroat  aves    passeriformes
## 87  birds           prothonotary warbler  aves    passeriformes
## 88  birds                       ovenbird  aves    passeriformes
## 89  birds           Blackburnian warbler  aves    passeriformes
## 90  birds             Kirtland's warbler  aves    passeriformes
## 91  birds               magnolia warbler  aves    passeriformes
## 92  birds         chestnut-sided warbler  aves    passeriformes
## 93  birds        American yellow warbler  aves    passeriformes
## 94  birds              American redstart  aves    passeriformes
## 95  birds   black-throated green warbler  aves    passeriformes
## 96  birds                 Canada warbler  aves    passeriformes
## 97  birds      Western Bonelli's warbler  aves    passeriformes
## 98  birds         tooth-billed bowerbird  aves    passeriformes
## 99  birds               common firecrest  aves    passeriformes
## 100 birds                      goldcrest  aves    passeriformes
## 101 birds              European nuthatch  aves    passeriformes
## 102 birds                        wrentit  aves    passeriformes
## 103 birds              Marmora's warbler  aves    passeriformes
## 104 birds               Dartford warbler  aves    passeriformes
## 105 birds                 Berwick's wren  aves    passeriformes
## 106 birds                  Carolina wren  aves    passeriformes
## 107 birds                     house wren  aves    passeriformes
## 108 birds                  Eurasian wren  aves    passeriformes
## 109 birds               eastern bluebird  aves    passeriformes
## 110 birds             eastern wood pewee  aves    passeriformes
## 111 birds               least flycatcher  aves    passeriformes
## 112 birds       American gray flycatcher  aves    passeriformes
## 113 birds               eastern kingbird  aves    passeriformes
## 114 birds             black-capped vireo  aves    passeriformes
## 115 birds                   Bell's vireo  aves    passeriformes
## 116 birds               white-eyed vireo  aves    passeriformes
## 117 birds                 red-eyed vireo  aves    passeriformes
## 118 birds                  great bittern  aves   pelecaniformes
## 119 birds                  least bittern  aves   pelecaniformes
## 120 birds               black woodpecker  aves       piciformes
## 121 birds               Eurasian wryneck  aves       piciformes
## 122 birds        white-backed woodpecker  aves       piciformes
## 123 birds     middle spotted woodpeckers  aves       piciformes
## 124 birds Eurasian three-toed woodpecker  aves       piciformes
## 125 birds         grey-headed woodpecker  aves       piciformes
## 126 birds      European green woodpecker  aves       piciformes
## 127 birds                         kakapo  aves   psittaciformes
## 128 birds                   greater rhea  aves       rheiformes
## 129 birds                    lesser rhea  aves       rheiformes
## 130 birds                     boreal owl  aves     strigiformes
## 131 birds                 long-eared owl  aves     strigiformes
## 132 birds                     little owl  aves     strigiformes
## 133 birds             Eurasian eagle-owl  aves     strigiformes
## 134 birds               great horned owl  aves     strigiformes
## 135 birds             Eurasian pygmy owl  aves     strigiformes
## 136 birds                      snowy owl  aves     strigiformes
## 137 birds                      tawny owl  aves     strigiformes
## 138 birds                       barn owl  aves     strigiformes
## 139 birds                        ostrich  aves struthioniformes
## 140 birds                 ornate tinamou  aves     tinamiformes
##                family          genus         species      primarymethod    N
## 1        accipitridae         aquila      chrysaetos         telemetry* <NA>
## 2        accipitridae          buteo           buteo         telemetry* <NA>
## 3        accipitridae      circaetus        gallicus         telemetry* <NA>
## 4        accipitridae     hieraaetus       fasciatus         telemetry* <NA>
## 5        accipitridae     hieraaetus        pennatus          telemetry    4
## 6        accipitridae       neophron    percnopterus         telemetry* <NA>
## 7            anatidae           anas        strepera          telemetry    3
## 8         apterygidae        apteryx       australis          telemetry    6
## 9       caprimulgidae    caprimulgus       europaeus         telemetry* <NA>
## 10     haematopodidae     haematopus      ostralegus          telemetry    8
## 11         columbidae    scardafella            inca direct observation <NA>
## 12         columbidae        columba        palumbus         telemetry* <NA>
## 13         columbidae   streptopelia          turtur         telemetry* <NA>
## 14         coraciidae       coracias        garrulus         telemetry* <NA>
## 15           upupidae          upupa           epops         telemetry* <NA>
## 16          cuculidae       clamator      glandarius         telemetry* <NA>
## 17          cuculidae        cuculus         canorus         telemetry* <NA>
## 18          cuculidae      geococcyx   californianus          telemetry    9
## 19          cuculidae    neopmorphus      radiolosus          telemetry    1
## 20       accipitridae      accipiter        cooperii direct observation <NA>
## 21       accipitridae      accipiter        gentilis direct observation <NA>
## 22       accipitridae      accipiter           nisus         telemetry* <NA>
## 23       accipitridae      accipiter        striatus direct observation <NA>
## 24       accipitridae          buteo     jamaicensis direct observation <NA>
## 25       accipitridae          buteo        lineatus direct observation <NA>
## 26       accipitridae          buteo       swainsoni direct observation <NA>
## 27       accipitridae         circus         cyaneus direct observation <NA>
## 28       accipitridae         circus        pygargus         telemetry* <NA>
## 29       accipitridae         milvus          milvus         telemetry* <NA>
## 30         falconidae       caracara        cheriway          telemetry   26
## 31         falconidae       daptrius      americanus direct observation    6
## 32         falconidae          falco       biarmicus         telemetry* <NA>
## 33         falconidae          falco       mexicanus direct observation <NA>
## 34         falconidae          falco      peregrinus         telemetry* <NA>
## 35         falconidae          falco      sparverius direct observation <NA>
## 36         falconidae          falco     tinnunculus               <NA> <NA>
## 37        phasianidae         bonasa         bonasia         telemetry* <NA>
## 38        phasianidae   centrocercus    urophasianus          telemetry    5
## 39        phasianidae    dendragapus        obscurus direct observation    3
## 40        phasianidae        lagopus         lagopus direct observation <NA>
## 41        phasianidae         perdix          perdix         telemetry* <NA>
## 42        phasianidae         tetrao          tetrix         telemetry* <NA>
## 43        phasianidae         tetrao       urogallus         telemetry* <NA>
## 44        phasianidae    typmanuchus cupido pinnatus          telemetry   71
## 45           rallidae       aramides           wolfi          telemetry    1
## 46           rallidae           crex            crex          telemetry   20
## 47           rallidae         rallus         elegans          telemetry   18
## 48     acrocephalisae      hippolais      polyglotta         telemetry* <NA>
## 49       aegithalidae     aegithalos        caudatus         telemetry* <NA>
## 50          alaudidae        lululla         arborea direct observation <NA>
## 51       cardinalidae          habia      fuscicauda direct observation <NA>
## 52       cardinalidae          habia          rubica direct observation <NA>
## 53          certhidae        certhia      familiaris         telemetry* <NA>
## 54       cisticolidae      cisticola        juncidis         telemetry* <NA>
## 55           corvidae         corvus           corax         telemetry* <NA>
## 56           corvidae      nucifraga   caryocatactes direct observation <NA>
## 57         cotingidae      phytotoma       raimondii     mark-recapture    6
## 58        emberizidae     ammodramus      savannarum direct observation   54
## 59        emberizidae      passerina          cyanea direct observation   10
## 60        emberizidae         pipilo          aberti direct observation <NA>
## 61        emberizidae         pipilo          fuscus direct observation   34
## 62        emberizidae       spizella         arborea direct observation   30
## 63        emberizidae       spizella       passerina direct observation <NA>
## 64       fringillidae      carduelis       cannabina         telemetry* <NA>
## 65       fringillidae      fringilla         coelebs         telemetry* <NA>
## 66       fringillidae        serinus         serinus         telemetry* <NA>
## 67          icteridae      sturnella           magna direct observation <NA>
## 68          icteridae      sturnella        neglecta direct observation <NA>
## 69           incertae        icteria          virens direct observation    8
## 70           laniidae        laniuis        collurio direct observation <NA>
## 71           laniidae        laniuis    ludovicianus direct observation <NA>
## 72           laniidae         lanius           minor         telemetry* <NA>
## 73           laniidae         lanius         senator         telemetry* <NA>
## 74            mimidae          mimus     polyglottos direct observation <NA>
## 75       motacillidae      motacilla            alba         telemetry* <NA>
## 76       motacillidae      motacilla           flava direct observation <NA>
## 77       muscicapidae      muscicapa         striata         telemetry* <NA>
## 78       muscicapidae       oenanthe        oenanthe direct observation <NA>
## 79       muscicapidae    phoenicurus     phoenicurus         telemetry* <NA>
## 80       muscicapidae       saxicola         rubetra         telemetry* <NA>
## 81            paridae          parus    atricapillus direct observation <NA>
## 82            paridae          parus    carolinensis direct observation <NA>
## 83            paridae          parus       inornatus direct observation <NA>
## 84            paridae          parus       palustris direct observation <NA>
## 85          parulidae geothlypis\xa0    philadelphia direct observation <NA>
## 86          parulidae     geothylpis         trichas direct observation <NA>
## 87          parulidae   protonotaria          citrea direct observation <NA>
## 88          parulidae        seiurus    aurocapillus direct observation <NA>
## 89          parulidae      setophaga           fusca direct observation <NA>
## 90          parulidae      setophaga       kirtlandi direct observation <NA>
## 91          parulidae      setophaga        magnolia direct observation <NA>
## 92          parulidae      setophaga    pensylvanica direct observation <NA>
## 93          parulidae      setophaga        petechia direct observation    8
## 94          parulidae      setophaga       ruticilla direct observation <NA>
## 95          parulidae      setophaga          virens direct observation <NA>
## 96          parulidae       wilsonia      canadensis direct observation <NA>
## 97     phylloscopidae   phylloscopus         bonelli         telemetry* <NA>
## 98  ptilonorhynchidae   scenopoeetes    dentirostris          telemetry    4
## 99          regulidae        regulus    ignicapillus         telemetry* <NA>
## 100         regulidae        regulus         regulus         telemetry* <NA>
## 101         stittidae          sitta        europaea         telemetry* <NA>
## 102          sylvidae        chamaea        fasciata direct observation <NA>
## 103         sylviidae         sylvia           sarda         telemetry* <NA>
## 104         sylviidae         sylvia          undata         telemetry* <NA>
## 105     troglodytidae     thryomanes        bewickiI direct observation <NA>
## 106     troglodytidae    thryothorus    ludovicianus direct observation    6
## 107     troglodytidae    troglodytes           aedon direct observation <NA>
## 108     troglodytidae    troglodytes     troglodytes direct observation <NA>
## 109          turdidae         sialia          sialis direct observation <NA>
## 110        tyrannidae       contopus          virens direct observation <NA>
## 111        tyrannidae      empidonax         minimus direct observation <NA>
## 112        tyrannidae      empidonax        wrightii direct observation <NA>
## 113        tyrannidae       tyrannus        tyrannus direct observation <NA>
## 114        vireonidae          vireo    atricapillus direct observation <NA>
## 115        vireonidae          vireo           belli direct observation <NA>
## 116        vireonidae          vireo         griseus direct observation    2
## 117        vireonidae          vireo       olivaceus direct observation <NA>
## 118          ardeidae       botaurus       stellaris          telemetry    8
## 119          ardeidae     ixobrychus          exilis          telemetry   33
## 120           picidae      dryocopus         martius         telemetry* <NA>
## 121           picidae           jynx       torquilla         telemetry* <NA>
## 122           picidae       picoides        leucotos         telemetry* <NA>
## 123           picidae       picoides          medius         telemetry* <NA>
## 124           picidae       picoides     tridactylus         telemetry* <NA>
## 125           picidae          picus           canus         telemetry* <NA>
## 126           picidae          picus         viridis         telemetry* <NA>
## 127       strigopidae       strigops     habroptilus          telemetry   13
## 128           rheidae           rhea       americana          telemetry   10
## 129           rheidae           rhea         pennata          telemetry    7
## 130         strigidae       aegolius        funereus         telemetry* <NA>
## 131         strigidae           asio            otus         telemetry* <NA>
## 132         strigidae         athene          noctua         telemetry* <NA>
## 133         strigidae           bubo            bubo         telemetry* <NA>
## 134         strigidae           bubo     virginianus direct observation <NA>
## 135         strigidae     glaucidium      passerinum         telemetry* <NA>
## 136         strigidae         nyctea       scandiaca direct observation <NA>
## 137         strigidae          strix           aluco direct observation   55
## 138         tytonidae           tyto            alba         telemetry* <NA>
## 139     struthionidae       struthio         camelus          telemetry    1
## 140         tinamidae    nothoprocta          ornata direct observation   14
##     mean.mass.g log10.mass
## 1       3000.00  3.4771213
## 2        846.00  2.9273704
## 3       1699.00  3.2301934
## 4       2049.00  3.3115420
## 5        975.00  2.9890046
## 6       2203.00  3.3430145
## 7        719.00  2.8567289
## 8       2320.00  3.3654880
## 9         48.00  1.6812412
## 10       521.00  2.7168377
## 11        47.70  1.6785184
## 12       150.00  2.1760913
## 13       140.33  2.1471505
## 14       103.00  2.0128372
## 15        67.00  1.8260748
## 16       151.50  2.1804126
## 17       128.00  2.1072100
## 18       300.00  2.4771213
## 19       433.00  2.6364879
## 20       469.00  2.6711728
## 21       978.00  2.9903389
## 22       807.00  2.9068735
## 23       141.00  2.1492191
## 24      1126.00  3.0515384
## 25       626.00  2.7965743
## 26       971.00  2.9872192
## 27       521.00  2.7168377
## 28       315.50  2.4989994
## 29      1033.70  3.0143945
## 30      1125.00  3.0511525
## 31       625.00  2.7958800
## 32       675.00  2.8293038
## 33       721.00  2.8579353
## 34       781.50  2.8929290
## 35       112.00  2.0492180
## 36       200.00  2.3010300
## 37       410.00  2.6127839
## 38      1750.00  3.2430380
## 39      1050.00  3.0211893
## 40       620.00  2.7923917
## 41       381.50  2.5814945
## 42      1139.00  3.0565237
## 43      2936.00  3.4677561
## 44       900.00  2.9542425
## 45       506.00  2.7041505
## 46       165.00  2.2174839
## 47       266.00  2.4248816
## 48        11.00  1.0413927
## 49         8.00  0.9030900
## 50        30.00  1.4771213
## 51        37.70  1.5763414
## 52        32.80  1.5158738
## 53         8.77  0.9429996
## 54         9.80  0.9912261
## 55      1410.00  3.1492191
## 56       130.00  2.1139434
## 57        42.00  1.6232493
## 58        16.70  1.2227165
## 59        14.30  1.1553360
## 60        46.30  1.6655810
## 61        44.70  1.6503075
## 62        18.10  1.2576786
## 63        12.20  1.0863598
## 64      1550.00  3.1903317
## 65        23.25  1.3664230
## 66        10.70  1.0293838
## 67        89.00  1.9493900
## 68        89.00  1.9493900
## 69        27.00  1.4313638
## 70        30.00  1.4771213
## 71        48.10  1.6821451
## 72        44.22  1.6456187
## 73        35.00  1.5440680
## 74        50.10  1.6998377
## 75        21.22  1.3267454
## 76        17.50  1.2430380
## 77        12.80  1.1072100
## 78        25.20  1.4014005
## 79        15.21  1.1821292
## 80        16.48  1.2169572
## 81        11.00  1.0413927
## 82        10.10  1.0043214
## 83        16.60  1.2201081
## 84        11.00  1.0413927
## 85        11.30  1.0530784
## 86         9.80  0.9912261
## 87        16.10  1.2068259
## 88        18.90  1.2764618
## 89         9.70  0.9867717
## 90        14.00  1.1461280
## 91         8.60  0.9344985
## 92         9.60  0.9822712
## 93         9.50  0.9777236
## 94         9.00  0.9542425
## 95         9.00  0.9542425
## 96         9.30  0.9684829
## 97         7.50  0.8750613
## 98       158.00  2.1986571
## 99         5.30  0.7242759
## 100        5.15  0.7118072
## 101       18.30  1.2624511
## 102       14.80  1.1702617
## 103       10.50  1.0211893
## 104        8.80  0.9444827
## 105       11.00  1.0413927
## 106       18.50  1.2671717
## 107       11.20  1.0492180
## 108        9.50  0.9777236
## 109       30.80  1.4885507
## 110       13.80  1.1398791
## 111        9.90  0.9956352
## 112       12.30  1.0899051
## 113       40.40  1.6063814
## 114        8.50  0.9294189
## 115       10.00  1.0000000
## 116       11.40  1.0569049
## 117       17.60  1.2455127
## 118      900.00  2.9542425
## 119       67.00  1.8260748
## 120      277.37  2.4430595
## 121       38.00  1.5797836
## 122      109.25  2.0384214
## 123       59.00  1.7708520
## 124       65.65  1.8172347
## 125      124.50  2.0951694
## 126      186.67  2.2710745
## 127     1941.00  3.2880255
## 128    25000.00  4.3979400
## 129    15000.00  4.1760913
## 130      119.00  2.0755470
## 131      252.00  2.4014005
## 132      156.50  2.1945143
## 133     2191.00  3.3406424
## 134     1510.00  3.1789769
## 135       61.32  1.7876021
## 136     1920.00  3.2833012
## 137      519.00  2.7151674
## 138      285.00  2.4548449
## 139    88250.00  4.9457147
## 140      622.00  2.7937904
##                                                                                                                                                                                       alternative.mass.reference
## 1                                                                                                                                                                                                           <NA>
## 2                                                                                                                                                                                                           <NA>
## 3                                                                                                                                                                                                           <NA>
## 4                                                                                                                                                                                                           <NA>
## 5                                                                                                                                                                                                           <NA>
## 6                                                                                                                                                                                                           <NA>
## 7                                                                                                                                                                                                           <NA>
## 8                                                                                                                                                                                                           <NA>
## 9                                                                                                                                                                                                           <NA>
## 10                                                                                                                                                                                                          <NA>
## 11                                                                                                                                                                                                          <NA>
## 12                                                                                                                                                                                                          <NA>
## 13                                                                                                                                                                                                          <NA>
## 14                                                                                                                                                                                                          <NA>
## 15                                                                                                                                                                                                          <NA>
## 16                                                                                                                                                                                                          <NA>
## 17                                                                                                                                                                                                          <NA>
## 18                                                                                                                                                Weight calculated from telemetry backpack (10g = 3% body mass)
## 19                                                                                                                                                                                                          <NA>
## 20                                                                                                                                                                                                          <NA>
## 21                                                                                                                                                                                                          <NA>
## 22                                                                                                                                                                                                          <NA>
## 23                                                                                                                                                                                                          <NA>
## 24                                                                                                                                                                                                          <NA>
## 25                                                                                                                                                                                                          <NA>
## 26                                                                                                                                                                                                          <NA>
## 27                                                                                                                                                                                                          <NA>
## 28                                                                                                                                                                                                          <NA>
## 29                                                                                                                                                                                                          <NA>
## 30                                                                                                                                                                                                          <NA>
## 31                                                                                                                                                                                                          <NA>
## 32                                                                                                                                                                                                          <NA>
## 33                                                                                                                                                                                                          <NA>
## 34                                                                                                                                                                                                          <NA>
## 35                                                                                                                                                                                                          <NA>
## 36                                                                                                                                                                                                          <NA>
## 37                                                                                                                                                                                                          <NA>
## 38                                                                                                                         Beck TDI, Brain CE. 1978. Weights of Colorado Sage Grouse. The Condor 80(2), 241-243.
## 39                                                                                                                                                                                                          <NA>
## 40                                                                                                                                                                                                          <NA>
## 41                                                                                                                                                                                                          <NA>
## 42                                                                                                                                                                                                          <NA>
## 43                                                                                                                                                                                                          <NA>
## 44                                                                                                                                                                                                          <NA>
## 45                                                                                                                                                                                                          <NA>
## 46                                        Keiss O, Granats J, Mednis A. 2004. Use of biometrical data to study Corncrake Crex crex population in Latvia. Acta Universitatis Latviensis, Biology 676, 119\x96126.
## 47                                                                                                                                                                                                          <NA>
## 48                                                                                                                                                                                                          <NA>
## 49                                                                                                                                                                                                          <NA>
## 50                                                                                                                                                                                                          <NA>
## 51                                                                                                                                                                                                          <NA>
## 52                                                                                                                                                                                                          <NA>
## 53                                                                                                                                                                                                          <NA>
## 54                                                                                                                                                                                                          <NA>
## 55                                                                                                                                                                                                          <NA>
## 56                                                                                                                                                                                                          <NA>
## 57  Sabat P, Ramirez-Otatola , Barcelo G, Salinas J, Bozinovic F. Comparative basal metabolic rate among passerines and the food habit hypothesis. Comparative Biochemistry and Physiology Part A 157, 35\x9640.
## 58                                                                                                                                                                                                          <NA>
## 59                                                                                                                                                                                                          <NA>
## 60                                                                                                                                                                                                          <NA>
## 61                                                                                                                                                                                                          <NA>
## 62                                                                                                                                                                                                          <NA>
## 63                                                                                                                                                                                                          <NA>
## 64                                                                                                                                                                                                          <NA>
## 65                                                                                                                                                                                                          <NA>
## 66                                                                                                                                                                                                          <NA>
## 67                                                                                                                                                                                                          <NA>
## 68                                                                                                                                                                                                          <NA>
## 69                                                                                                                                                                                                          <NA>
## 70                                                                                                                                                                                                          <NA>
## 71                                                                                                                                                                                                          <NA>
## 72                                                                                                                                                                                                          <NA>
## 73                                                                                                                                                                                                          <NA>
## 74                                                                                                                                                                                                          <NA>
## 75                                                                                                                                                                                                          <NA>
## 76                                                                                                                                                                                                          <NA>
## 77                                                                                                                                                                                                          <NA>
## 78                                                                                                                                                                                                          <NA>
## 79                                                                                                                                                                                                          <NA>
## 80                                                                                                                                                                                                          <NA>
## 81                                                                                                                                                                                                          <NA>
## 82                                                                                                                                                                                                          <NA>
## 83                                                                                                                                                                                                          <NA>
## 84                                                                                                                                                                                                          <NA>
## 85                                                                                                                                                                                                          <NA>
## 86                                                                                                                                                                                                          <NA>
## 87                                                                                                                                                                                                          <NA>
## 88                                                                                                                                                                                                          <NA>
## 89                                                                                                                                                                                                          <NA>
## 90                                                                                                                                                                                                          <NA>
## 91                                                                                                                                                                                                          <NA>
## 92                                                                                                                                                                                                          <NA>
## 93                                                                                                                                                                                                          <NA>
## 94                                                                                                                                                                                                          <NA>
## 95                                                                                                                                                                                                          <NA>
## 96                                                                                                                                                                                                          <NA>
## 97                                                                                                                                                                                                          <NA>
## 98                                                     Frith CB, Frith DW. 2001. Morphology, Moult and Survival in Three Sympatric Bowerbirds in Australian Wet Tropics Upland Rainforest. Corella 25(3): 41-60.
## 99                                                                                                                                                                                                          <NA>
## 100                                                                                                                                                                                                         <NA>
## 101                                                                                                                                                                                                         <NA>
## 102                                                                                                                                                                                                         <NA>
## 103                                                                                                                                                                                                         <NA>
## 104                                                                                                                                                                                                         <NA>
## 105                                                                                                                                                                                                         <NA>
## 106                                                                                                                                                                                                         <NA>
## 107                                                                                                                                                                                                         <NA>
## 108                                                                                                                                                                                                         <NA>
## 109                                                                                                                                                                                                         <NA>
## 110                                                                                                                                                                                                         <NA>
## 111                                                                                                                                                                                                         <NA>
## 112                                                                                                                                                                                                         <NA>
## 113                                                                                                                                                                                                         <NA>
## 114                                                                                                                                                                                                         <NA>
## 115                                                                                                                                                                                                         <NA>
## 116                                                                                                                                                                                                         <NA>
## 117                                                                                                                                                                                                         <NA>
## 118                                                                                                                                                                                                         <NA>
## 119                                                                                                                                                                                                         <NA>
## 120                                                                                                                                                                                                         <NA>
## 121                                                                                                                                                                                                         <NA>
## 122                                                                                                                                                                                                         <NA>
## 123                                                                                                                                                                                                         <NA>
## 124                                                                                                                                                                                                         <NA>
## 125                                                                                                                                                                                                         <NA>
## 126                                                                                                                                                                                                         <NA>
## 127                                                                                                                                                                                                         <NA>
## 128                                            Forsyth DM, Wilmhurst JM, Allen RB, Coomes DA. Impacts of introduced deer and extinct moa on New Zealand ecosystems. New Zealand Journal of Ecology 34(1), 48-65.
## 129                                            Forsyth DM, Wilmhurst JM, Allen RB, Coomes DA. Impacts of introduced deer and extinct moa on New Zealand ecosystems. New Zealand Journal of Ecology 34(1), 48-65.
## 130                                                                                                                                                                                                         <NA>
## 131                                                                                                                                                                                                         <NA>
## 132                                                                                                                                                                                                         <NA>
## 133                                                                                                                                                                                                         <NA>
## 134                                                                                                                                                                                                         <NA>
## 135                                                                                                                                                                                                         <NA>
## 136                                                                                                                                                                                                         <NA>
## 137                                                                                                                                                                                                         <NA>
## 138                                                                                                                                                                                                         <NA>
## 139                                                                                                                                                                                                         <NA>
## 140                                                                                                                                                                                                         <NA>
##      mean.hra.m2 log10.hra
## 1    27550000.00  7.440122
## 2    50240000.00  7.701050
## 3    78500000.00  7.894870
## 4    19620000.00  7.292699
## 5   117300000.00  8.069298
## 6    63570000.00  7.803252
## 7    45912000.00  7.661926
## 8      463900.00  5.666424
## 9      785000.00  5.894870
## 10    2460000.00  6.390935
## 11       2589.98  3.413296
## 12    2540000.00  6.404834
## 13   63585000.00  7.803355
## 14    1000000.00  6.000000
## 15   12560000.00  7.098990
## 16   12560000.00  7.098990
## 17   38460000.00  7.585009
## 18     550000.00  5.740363
## 19     499000.00  5.698101
## 20    2254095.45  6.352972
## 21   40000000.00  7.602060
## 22    7100000.00  6.851258
## 23     995525.10  5.998052
## 24    4249192.50  6.628306
## 25     639402.30  5.805774
## 26    2464531.65  6.391734
## 27    2521187.55  6.401605
## 28  200980000.00  8.303153
## 29   19625000.00  7.292810
## 30  241000000.00  8.382017
## 31     666000.00  5.823474
## 32   50000000.00  7.698970
## 33   25778434.50  7.411257
## 34  153860000.00  8.187126
## 35    1416397.50  6.151185
## 36    3000000.00  6.477121
## 37     103000.00  5.012837
## 38   18158215.95  7.259073
## 39      16996.77  4.230366
## 40      25899.84  4.413297
## 41      62000.00  4.792392
## 42    1975000.00  6.295567
## 43    5500000.00  6.740363
## 44   12030000.00  7.080266
## 45      90000.00  4.954243
## 46      43000.00  4.633468
## 47      44000.00  4.643453
## 48      30000.00  4.477121
## 49      42000.00  4.623249
## 50      82960.43  4.918871
## 51      60702.75  4.783208
## 52      48562.20  4.686298
## 53      47000.00  4.672098
## 54      14400.00  4.158362
## 55   28000000.00  7.447158
## 56     132332.00  5.121665
## 57      30900.00  4.489958
## 58      10926.50  4.038481
## 59       1052.18  3.022090
## 60      16187.40  4.209177
## 61      25899.84  4.413297
## 62      16996.77  4.230366
## 63      30756.06  4.487931
## 64    3140000.00  6.496930
## 65      42000.00  4.623249
## 66      10000.00  4.000000
## 67      30351.38  4.482178
## 68      30351.38  4.482178
## 69       1335.46  3.125631
## 70      15782.72  4.198182
## 71      75676.10  4.878959
## 72     635800.00  5.803321
## 73      80000.00  4.903090
## 74       4046.85  3.607117
## 75     785000.00  5.894870
## 76      10117.13  4.005057
## 77      10000.00  4.000000
## 78      15378.03  4.186901
## 79       4500.00  3.653213
## 80       7300.00  3.863323
## 81      14568.66  4.163420
## 82      14973.35  4.175319
## 83      24281.10  4.385268
## 84      22662.36  4.355305
## 85       7689.02  3.885871
## 86       5260.91  3.721061
## 87      14973.35  4.175319
## 88      10117.13  4.005057
## 89       5260.91  3.721061
## 90      33993.54  4.531396
## 91       7284.33  3.862390
## 92       6070.28  3.783209
## 93       1699.68  3.230367
## 94       1942.49  3.288359
## 95       6474.96  3.811237
## 96      10117.13  4.005057
## 97      35000.00  4.544068
## 98      95000.00  4.977724
## 99      16500.00  4.217484
## 100     19900.00  4.298853
## 101     21000.00  4.322219
## 102      3237.48  3.510207
## 103      3300.00  3.518514
## 104      2800.00  3.447158
## 105      4856.22  3.686298
## 106      1214.06  3.084240
## 107      4046.85  3.607117
## 108     10117.13  4.005057
## 109     10117.13  4.005057
## 110     44029.73  4.643746
## 111      1780.61  3.250569
## 112     15782.72  4.198182
## 113     83769.80  4.923087
## 114     14973.35  4.175319
## 115     11735.87  4.069515
## 116      1335.46  3.125631
## 117      7284.33  3.862390
## 118    193000.00  5.285557
## 119     97000.00  4.986772
## 120   3500000.00  6.544068
## 121   1038100.00  6.016239
## 122   5306600.00  6.724816
## 123    141500.00  5.150756
## 124    350000.00  5.544068
## 125   4521600.00  6.655292
## 126   1850000.00  6.267172
## 127    195000.00  5.290035
## 128   2450000.00  6.389166
## 129  23880000.00  7.378034
## 130   3140000.00  6.496930
## 131  19620000.00  7.292699
## 132    500000.00  5.698970
## 133  16000000.00  7.204120
## 134   2124596.25  6.327276
## 135   1250000.00  6.096910
## 136   4937157.00  6.693477
## 137    356932.17  5.552586
## 138   1500000.00  6.176091
## 139  84300000.00  7.925828
## 140     24281.10  4.385268
##                                                                                                                                                                                                                                                                                                                   hra.reference
## 1                                                                                                                                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 2                                                                                                                                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 3                                                                                                                                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 4                                                                                                                                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 5                                                                                                                    Martinez JE, Pagan I, Palazon JA, Calvo JF. 2007. Habitat use of booted eagles (Hieraaetus pennatus) in a Special Protection Area: implications for conservation. Biodiversity Conservation 16, 3481-3488.
## 6                                                                                                                                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 7                                                                                                             Namgail T, Takekawa JY, Balachandran S, Sathiyaselvam P, Mundkur T, Newman SH. 2014. Space use of wintering waterbirds in India: Influence of trophic ecology on home-range size. Current Zoology 60(5), 616-621.
## 8                                                                                                                   Miles JRG Miles, Potter MA, Fordham RA. 1997. Northern brown kiwi (Apteryx australis mantelli) in Tongariro National Park and Tongariro Forest \x97 ecology and threats. Science for Conservation 51, 1-23.
## 9                                                                                                                                        Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 10                                                                                                         Schwemmer P, Garthe S. 2011. Spatial and temporal patterns of habitat use by Eurasian oystercatchers (Haematopus ostralegus) in the eastern Wadden Sea revealed using GPS data loggers. Marine Biology 158, 541-550.
## 11                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 12                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 13                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 14                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 15                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 16                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 17                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 18                                                                                                Kelley SW, Ransom D, Butcher JA, Schulz GG, Surber BW, Punchak WE, Santamaria CA, Hurtado LA. 2011. Home range dynamics, habitat selection, and survival of Greater Roadrunners. Journal of Field Ornithology 82(2), 165-174.
## 19                                                                                                                                                                              Karubuan J, Carrasco L. 2008. Home Range and Habitat Preferences of the Banded Ground-cuckoo. The Wilson Journal of Ornithology 120(1):205-209.
## 20                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 21                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 22                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 23                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 24                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 25                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 26                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 27                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 28                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 29                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 30                                                                                                                                                               Dwyer JF, Fraser JD, Morrison JL. 2013. Range sizes and habitat use of non-breeding Crested Caracaras in Florida. Journal of Field Ornithology 84(3), 223-233.
## 31                                                                                                                                                  Thiollay J-M. 2008. Foraging, home range use and social behaviour of a group-living rainforest raptor, the Red-throated Caracara Daptrius americanus. Ibis 133(4), 382-393.
## 32                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 33                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 34                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 35                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 36                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 37                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 38                                                                                                                                                                            Eng RL, Schladweiler P. 1972. Sage Grouse Winter Movements and Habitat Use in Central Montana. The Journal of Wildlife Management 36(1), 141-146.
## 39                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 40                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 41                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 42                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 43                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 44  Patten, M. A., C. L. Pruett, and D. H. Wolfe. 2011. Home range size and movements of Greater Prairie-Chickens. Pp. 51\x9662 in B. K. Sandercock, K. Martin, and G. Segelbacher (editors). Ecology, conservation, and management of grouse. Studies in Avian Biology (no. 39), University of California Press, Berkeley, CA.
## 45                                                                   Karubian J, Carrasco L, Mena P, Olivio J, Cabrera D, Castillo F, Duraes R, El Ksabi N. 2011. nesting Biology, Home Range, and Habitat Use of the Brown Wood Rail (Aramides wolfi) in Northwest Ecuador. The Wilson Journal or Ornithology 123(1), 137-141.
## 46                                                                                                                                                                      Grabovsky VI. 1993.Spatial Distribution and Spacing Behaviour of Males in a Russion Corncrake (Crex crex) Population. Gibier Faune Sauvage 10, 259-279.
## 47                                                                                                                                                               Pickens BA, King SL. 2013. Microhabitat Selection, Demography and Correlates of Home Range Size for the King Rail (Rallus elegans). Waterbirds 36(3), 319-329.
## 48                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 49                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 50                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 51                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 52                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 53                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 54                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 55                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 56                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 57                        Nolazco S, Sanchez AM, Roper JJ. 2014. Tama\xf1o poblacional, distribuci\xf3n y \xe1mbito de hogar de la Cortarrama Peruana (Phytotoma raimondii) en el Santuario Hist\xf3rico Bosque de P\xf3mac, Lambayeque, Per\xfa. Bolet\xedn de la Uni\xf3n de Ornit\xf3logos del Per\xfa (UNOP), 9 (2): 5-19 .
## 58                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 59                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 60                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 61                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 62                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 63                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 64                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 65                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 66                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 67                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 68                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 69                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 70                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 71                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 72                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 73                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 74                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 75                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 76                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 77                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 78                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 79                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 80                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 81                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 82                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 83                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 84                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 85                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 86                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 87                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 88                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 89                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 90                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 91                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 92                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 93                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 94                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 95                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 96                                                                                                                                                                                                                                          Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 97                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 98                                                                                                                                                                    Frith CB, Frith DW. 2001. Morphology, Moult, and Survival in Three Sympatric Bowerirds in Australian Wet Tropics Upland Rainforest. Corella 25(3), 41-60.
## 99                                                                                                                                       Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 100                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 101                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 102                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 103                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 104                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 105                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 106                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 107                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 108                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 109                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 110                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 111                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 112                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 113                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 114                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 115                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 116                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 117                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 118                                                                                                                                                                      Gilbert G, Tyler G, Smith KW. 2005. Behaviour, home-range size and habitat use by male Great Bittern Botaurus stellaris in Britain. Ibis 147, 533-543.
## 119                                                                                                                                                                              Bogner HE, Baldassarre GA. 2002. Home Range, Movement, and Nesting of Least Bitterns in Western New York. The Wilson Bulletin 114(3), 297-308.
## 120                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 121                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 122                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 123                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 124                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 125                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 126                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 127                                                                                                                                                                                                      Farrimond M, Clout MN. 2006. Home range size of kakapo (Strigops habroptilus) on Codfish Island. Notornis 53, 150-152.
## 128                                                                                                                                           Bellis LM, Martella MB, Navarro JL, Vignolo PE. 2004. Home range of greater and lesser rhea in Argentina: relevance to conservation. Biodiversity and Conservation 13, 2589-2598.
## 129                                                                                                                                           Bellis LM, Martella MB, Navarro JL, Vignolo PE. 2004. Home range of greater and lesser rhea in Argentina: relevance to conservation. Biodiversity and Conservation 13, 2589-2598.
## 130                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 131                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 132                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 133                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 134                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 135                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 136                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 137                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
## 138                                                                                                                                      Ottaviani, D., S. C. Cairns, M. Oliverio, and L. Boitani. 2006. Body mass as a predictive variable of home-range size among Italian mammals and birds. Journal of Zoology 269:317-330.
## 139                                                                                                               Williams JB, Siegfried WR, Milton SJ, Adams NJ, Dean WRT, du Plessis MA, Jackson S. 1993. Field Metabolism, Water Requirements, and Foraging Behavior of Wild Ostriches in the Namib. Ecology 74(2), 390-404.
## 140                                                                                                                                                                                                                                         Schoener, T. W. 1968. Sizes of feeding territories among birds. Ecology 49:123-141.
##           realm thermoregulation locomotion trophic.guild dimension preymass
## 1   terrestrial        endotherm     flying     carnivore        3D   636.94
## 2   terrestrial        endotherm     flying     carnivore        3D   275.84
## 3   terrestrial        endotherm     flying     carnivore        3D   164.95
## 4   terrestrial        endotherm     flying     carnivore        3D       NA
## 5   terrestrial        endotherm     flying     carnivore        3D   365.17
## 6   terrestrial        endotherm     flying     carnivore        3D       NA
## 7   terrestrial        endotherm    walking     herbivore        2D       NA
## 8   terrestrial        endotherm    walking     carnivore        2D       NA
## 9   terrestrial        endotherm     flying     carnivore        3D       NA
## 10  terrestrial        endotherm    walking     carnivore        2D       NA
## 11  terrestrial        endotherm     flying     herbivore        3D       NA
## 12  terrestrial        endotherm     flying     herbivore        3D       NA
## 13  terrestrial        endotherm     flying     herbivore        3D       NA
## 14  terrestrial        endotherm     flying     carnivore        3D       NA
## 15  terrestrial        endotherm     flying     carnivore        3D       NA
## 16  terrestrial        endotherm     flying     carnivore        3D       NA
## 17  terrestrial        endotherm     flying     carnivore        3D       NA
## 18  terrestrial        endotherm    walking     carnivore        2D       NA
## 19  terrestrial        endotherm    walking     carnivore        2D       NA
## 20  terrestrial        endotherm     flying     carnivore        3D    88.99
## 21  terrestrial        endotherm     flying     carnivore        3D   327.00
## 22  terrestrial        endotherm     flying     carnivore        3D       NA
## 23  terrestrial        endotherm     flying     carnivore        3D    41.96
## 24  terrestrial        endotherm     flying     carnivore        3D   198.94
## 25  terrestrial        endotherm     flying     carnivore        3D    43.99
## 26  terrestrial        endotherm     flying     carnivore        3D   344.33
## 27  terrestrial        endotherm     flying     carnivore        3D    49.01
## 28  terrestrial        endotherm     flying     carnivore        3D       NA
## 29  terrestrial        endotherm     flying     carnivore        3D   527.40
## 30  terrestrial        endotherm    walking     carnivore        2D       NA
## 31  terrestrial        endotherm    walking     carnivore        2D       NA
## 32  terrestrial        endotherm     flying     carnivore        3D       NA
## 33  terrestrial        endotherm     flying     carnivore        3D    55.00
## 34  terrestrial        endotherm     flying     carnivore        3D   165.90
## 35  terrestrial        endotherm     flying     carnivore        3D    32.00
## 36  terrestrial        endotherm     flying     carnivore        3D    16.81
## 37  terrestrial        endotherm    walking     herbivore        2D       NA
## 38  terrestrial        endotherm    walking     herbivore        2D       NA
## 39  terrestrial        endotherm    walking     herbivore        2D       NA
## 40  terrestrial        endotherm    walking     herbivore        2D       NA
## 41  terrestrial        endotherm    walking     herbivore        2D       NA
## 42  terrestrial        endotherm    walking     herbivore        2D       NA
## 43  terrestrial        endotherm    walking     herbivore        2D       NA
## 44  terrestrial        endotherm    walking     herbivore        2D       NA
## 45  terrestrial        endotherm    walking     carnivore        2D       NA
## 46  terrestrial        endotherm    walking     herbivore        2D       NA
## 47  terrestrial        endotherm    walking     carnivore        2D       NA
## 48  terrestrial        endotherm     flying     carnivore        3D       NA
## 49  terrestrial        endotherm     flying     carnivore        3D       NA
## 50  terrestrial        endotherm     flying     carnivore        3D       NA
## 51  terrestrial        endotherm     flying     carnivore        3D       NA
## 52  terrestrial        endotherm     flying     carnivore        3D       NA
## 53  terrestrial        endotherm     flying     carnivore        3D       NA
## 54  terrestrial        endotherm     flying     carnivore        3D       NA
## 55  terrestrial        endotherm     flying     carnivore        3D       NA
## 56  terrestrial        endotherm     flying     herbivore        3D       NA
## 57  terrestrial        endotherm     flying     herbivore        3D       NA
## 58  terrestrial        endotherm     flying     carnivore        3D       NA
## 59  terrestrial        endotherm     flying     carnivore        3D       NA
## 60  terrestrial        endotherm     flying     herbivore        3D       NA
## 61  terrestrial        endotherm     flying     herbivore        3D       NA
## 62  terrestrial        endotherm     flying     carnivore        3D       NA
## 63  terrestrial        endotherm     flying     carnivore        3D       NA
## 64  terrestrial        endotherm     flying     herbivore        3D       NA
## 65  terrestrial        endotherm     flying     carnivore        3D       NA
## 66  terrestrial        endotherm     flying     carnivore        3D       NA
## 67  terrestrial        endotherm     flying     carnivore        3D       NA
## 68  terrestrial        endotherm     flying     carnivore        3D       NA
## 69  terrestrial        endotherm     flying     carnivore        3D       NA
## 70  terrestrial        endotherm     flying     carnivore        3D       NA
## 71  terrestrial        endotherm     flying     carnivore        3D       NA
## 72  terrestrial        endotherm     flying     carnivore        3D       NA
## 73  terrestrial        endotherm     flying     carnivore        3D       NA
## 74  terrestrial        endotherm     flying     carnivore        3D       NA
## 75  terrestrial        endotherm     flying     carnivore        3D       NA
## 76  terrestrial        endotherm     flying     carnivore        3D       NA
## 77  terrestrial        endotherm     flying     carnivore        3D       NA
## 78  terrestrial        endotherm     flying     carnivore        3D       NA
## 79  terrestrial        endotherm     flying     carnivore        3D       NA
## 80  terrestrial        endotherm     flying     carnivore        3D       NA
## 81  terrestrial        endotherm     flying     carnivore        3D       NA
## 82  terrestrial        endotherm     flying     carnivore        3D       NA
## 83  terrestrial        endotherm     flying     carnivore        3D       NA
## 84  terrestrial        endotherm     flying     carnivore        3D       NA
## 85  terrestrial        endotherm     flying     carnivore        3D       NA
## 86  terrestrial        endotherm     flying     carnivore        3D       NA
## 87  terrestrial        endotherm     flying     carnivore        3D       NA
## 88  terrestrial        endotherm     flying     carnivore        3D       NA
## 89  terrestrial        endotherm     flying     carnivore        3D       NA
## 90  terrestrial        endotherm     flying     carnivore        3D       NA
## 91  terrestrial        endotherm     flying     carnivore        3D       NA
## 92  terrestrial        endotherm     flying     carnivore        3D       NA
## 93  terrestrial        endotherm     flying     carnivore        3D       NA
## 94  terrestrial        endotherm     flying     carnivore        3D       NA
## 95  terrestrial        endotherm     flying     carnivore        3D       NA
## 96  terrestrial        endotherm     flying     carnivore        3D       NA
## 97  terrestrial        endotherm     flying     carnivore        3D       NA
## 98  terrestrial        endotherm    walking     herbivore        3D       NA
## 99  terrestrial        endotherm     flying     carnivore        3D       NA
## 100 terrestrial        endotherm     flying     carnivore        3D       NA
## 101 terrestrial        endotherm     flying     carnivore        3D       NA
## 102 terrestrial        endotherm     flying     carnivore        3D       NA
## 103 terrestrial        endotherm     flying     carnivore        3D       NA
## 104 terrestrial        endotherm     flying     carnivore        3D       NA
## 105 terrestrial        endotherm     flying     carnivore        3D       NA
## 106 terrestrial        endotherm     flying     carnivore        3D       NA
## 107 terrestrial        endotherm     flying     carnivore        3D       NA
## 108 terrestrial        endotherm     flying     carnivore        3D       NA
## 109 terrestrial        endotherm     flying     carnivore        3D       NA
## 110 terrestrial        endotherm     flying     carnivore        3D       NA
## 111 terrestrial        endotherm     flying     carnivore        3D       NA
## 112 terrestrial        endotherm     flying     carnivore        3D       NA
## 113 terrestrial        endotherm     flying     carnivore        3D       NA
## 114 terrestrial        endotherm     flying     carnivore        3D       NA
## 115 terrestrial        endotherm     flying     carnivore        3D       NA
## 116 terrestrial        endotherm     flying     carnivore        3D       NA
## 117 terrestrial        endotherm     flying     carnivore        3D       NA
## 118 terrestrial        endotherm    walking     carnivore        2D       NA
## 119 terrestrial        endotherm    walking     carnivore        2D       NA
## 120 terrestrial        endotherm     flying     carnivore        3D       NA
## 121 terrestrial        endotherm     flying     carnivore        3D       NA
## 122 terrestrial        endotherm     flying     carnivore        3D       NA
## 123 terrestrial        endotherm     flying     carnivore        3D       NA
## 124 terrestrial        endotherm     flying     carnivore        3D       NA
## 125 terrestrial        endotherm     flying     carnivore        3D       NA
## 126 terrestrial        endotherm     flying     carnivore        3D       NA
## 127 terrestrial        endotherm    walking     herbivore        2D       NA
## 128 terrestrial        endotherm    walking     herbivore        2D       NA
## 129 terrestrial        endotherm    walking     herbivore        2D       NA
## 130 terrestrial        endotherm     flying     carnivore        3D       NA
## 131 terrestrial        endotherm     flying     carnivore        3D    32.98
## 132 terrestrial        endotherm     flying     carnivore        3D    20.66
## 133 terrestrial        endotherm     flying     carnivore        3D   375.00
## 134 terrestrial        endotherm     flying     carnivore        3D   279.11
## 135 terrestrial        endotherm     flying     carnivore        3D    16.99
## 136 terrestrial        endotherm     flying     carnivore        3D       NA
## 137 terrestrial        endotherm     flying     carnivore        3D    29.61
## 138 terrestrial        endotherm     flying     carnivore        3D    19.39
## 139 terrestrial        endotherm    walking     herbivore        2D       NA
## 140 terrestrial        endotherm    walking     herbivore        2D       NA
##     log10.preymass      PPMR
## 1         2.804099  4.710000
## 2         2.440657  3.067000
## 3         2.217352 10.300000
## 4               NA        NA
## 5         2.562495  2.560000
## 6               NA        NA
## 7               NA        NA
## 8               NA        NA
## 9               NA        NA
## 10              NA        NA
## 11              NA        NA
## 12              NA        NA
## 13              NA        NA
## 14              NA        NA
## 15              NA        NA
## 16              NA        NA
## 17              NA        NA
## 18              NA        NA
## 19              NA        NA
## 20        1.949341  5.270000
## 21        2.514548  2.990000
## 22              NA        NA
## 23        1.622835  3.360000
## 24        2.298722  5.660000
## 25        1.643354 14.230000
## 26        2.536975  2.820000
## 27        1.690285 10.630000
## 28              NA        NA
## 29        2.722140  1.960000
## 30              NA        NA
## 31              NA        NA
## 32              NA        NA
## 33        1.740363 13.110000
## 34        2.219846  4.710000
## 35        1.505150  3.500000
## 36        1.225568 11.900000
## 37              NA        NA
## 38              NA        NA
## 39              NA        NA
## 40              NA        NA
## 41              NA        NA
## 42              NA        NA
## 43              NA        NA
## 44              NA        NA
## 45              NA        NA
## 46              NA        NA
## 47              NA        NA
## 48              NA        NA
## 49              NA        NA
## 50              NA        NA
## 51              NA        NA
## 52              NA        NA
## 53              NA        NA
## 54              NA        NA
## 55              NA        NA
## 56              NA        NA
## 57              NA        NA
## 58              NA        NA
## 59              NA        NA
## 60              NA        NA
## 61              NA        NA
## 62              NA        NA
## 63              NA        NA
## 64              NA        NA
## 65              NA        NA
## 66              NA        NA
## 67              NA        NA
## 68              NA        NA
## 69              NA        NA
## 70              NA        NA
## 71              NA        NA
## 72              NA        NA
## 73              NA        NA
## 74              NA        NA
## 75              NA        NA
## 76              NA        NA
## 77              NA        NA
## 78              NA        NA
## 79              NA        NA
## 80              NA        NA
## 81              NA        NA
## 82              NA        NA
## 83              NA        NA
## 84              NA        NA
## 85              NA        NA
## 86              NA        NA
## 87              NA        NA
## 88              NA        NA
## 89              NA        NA
## 90              NA        NA
## 91              NA        NA
## 92              NA        NA
## 93              NA        NA
## 94              NA        NA
## 95              NA        NA
## 96              NA        NA
## 97              NA        NA
## 98              NA        NA
## 99              NA        NA
## 100             NA        NA
## 101             NA        NA
## 102             NA        NA
## 103             NA        NA
## 104             NA        NA
## 105             NA        NA
## 106             NA        NA
## 107             NA        NA
## 108             NA        NA
## 109             NA        NA
## 110             NA        NA
## 111             NA        NA
## 112             NA        NA
## 113             NA        NA
## 114             NA        NA
## 115             NA        NA
## 116             NA        NA
## 117             NA        NA
## 118             NA        NA
## 119             NA        NA
## 120             NA        NA
## 121             NA        NA
## 122             NA        NA
## 123             NA        NA
## 124             NA        NA
## 125             NA        NA
## 126             NA        NA
## 127             NA        NA
## 128             NA        NA
## 129             NA        NA
## 130             NA        NA
## 131       1.518251  7.640000
## 132       1.315130  7.575700
## 133       2.574031  5.842667
## 134       2.445775  5.410000
## 135       1.230193  3.610000
## 136             NA        NA
## 137       1.471438 17.530000
## 138       1.287578 14.700000
## 139             NA        NA
## 140             NA        NA
##                                                                                                                                                                                                                                      prey.size.reference
## 1                                                                                     Gliwicz J. 2008. Body Size Relationships between Avian Predators and Their Rodent Prey in a North-American Sagebrush Community. Acta Ornithologica, 43(2):151-158.
## 2   Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 3   Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 4                                                                                                                                                                                                                                                   <NA>
## 5   Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 6                                                                                                                                                                                                                                                   <NA>
## 7                                                                                                                                                                                                                                                   <NA>
## 8                                                                                                                                                                                                                                                   <NA>
## 9                                                                                                                                                                                                                                                   <NA>
## 10                                                                                                                                                                                                                                                  <NA>
## 11                                                                                                                                                                                                                                                  <NA>
## 12                                                                                                                                                                                                                                                  <NA>
## 13                                                                                                                                                                                                                                                  <NA>
## 14                                                                                                                                                                                                                                                  <NA>
## 15                                                                                                                                                                                                                                                  <NA>
## 16                                                                                                                                                                                                                                                  <NA>
## 17                                                                                                                                                                                                                                                  <NA>
## 18                                                                                                                                                                                                                                                  <NA>
## 19                                                                                                                                                                                                                                                  <NA>
## 20                                                                                           Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 21                                                                                                                                                                  Schoener TW. 1968. Sizes of Feeding Territories among Birds. Ecology 49(1), 123-141.
## 22                                                                                                                                                                                                                                                  <NA>
## 23                                                                                                                                                                  Schoener TW. 1968. Sizes of Feeding Territories among Birds. Ecology 49(1), 123-141.
## 24                                                                                           Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 25                                                                                           Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 26                                                                                           Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 27                                                                                           Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 28                                                                                                                                                                                                                                                  <NA>
## 29  Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 30                                                                                                                                                                                                                                                  <NA>
## 31                                                                                                                                                                                                                                                  <NA>
## 32                                                                                                                                                                                                                                                  <NA>
## 33                                                                                           Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 34  Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 35                                                                                           Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 36  Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 37                                                                                                                                                                                                                                                  <NA>
## 38                                                                                                                                                                                                                                                  <NA>
## 39                                                                                                                                                                                                                                                  <NA>
## 40                                                                                                                                                                                                                                                  <NA>
## 41                                                                                                                                                                                                                                                  <NA>
## 42                                                                                                                                                                                                                                                  <NA>
## 43                                                                                                                                                                                                                                                  <NA>
## 44                                                                                                                                                                                                                                                  <NA>
## 45                                                                                                                                                                                                                                                  <NA>
## 46                                                                                                                                                                                                                                                  <NA>
## 47                                                                                                                                                                                                                                                  <NA>
## 48                                                                                                                                                                                                                                                  <NA>
## 49                                                                                                                                                                                                                                                  <NA>
## 50                                                                                                                                                                                                                                                  <NA>
## 51                                                                                                                                                                                                                                                  <NA>
## 52                                                                                                                                                                                                                                                  <NA>
## 53                                                                                                                                                                                                                                                  <NA>
## 54                                                                                                                                                                                                                                                  <NA>
## 55                                                                                                                                                                                                                                                  <NA>
## 56                                                                                                                                                                                                                                                  <NA>
## 57                                                                                                                                                                                                                                                  <NA>
## 58                                                                                                                                                                                                                                                  <NA>
## 59                                                                                                                                                                                                                                                  <NA>
## 60                                                                                                                                                                                                                                                  <NA>
## 61                                                                                                                                                                                                                                                  <NA>
## 62                                                                                                                                                                                                                                                  <NA>
## 63                                                                                                                                                                                                                                                  <NA>
## 64                                                                                                                                                                                                                                                  <NA>
## 65                                                                                                                                                                                                                                                  <NA>
## 66                                                                                                                                                                                                                                                  <NA>
## 67                                                                                                                                                                                                                                                  <NA>
## 68                                                                                                                                                                                                                                                  <NA>
## 69                                                                                                                                                                                                                                                  <NA>
## 70                                                                                                                                                                                                                                                  <NA>
## 71                                                                                                                                                                                                                                                  <NA>
## 72                                                                                                                                                                                                                                                  <NA>
## 73                                                                                                                                                                                                                                                  <NA>
## 74                                                                                                                                                                                                                                                  <NA>
## 75                                                                                                                                                                                                                                                  <NA>
## 76                                                                                                                                                                                                                                                  <NA>
## 77                                                                                                                                                                                                                                                  <NA>
## 78                                                                                                                                                                                                                                                  <NA>
## 79                                                                                                                                                                                                                                                  <NA>
## 80                                                                                                                                                                                                                                                  <NA>
## 81                                                                                                                                                                                                                                                  <NA>
## 82                                                                                                                                                                                                                                                  <NA>
## 83                                                                                                                                                                                                                                                  <NA>
## 84                                                                                                                                                                                                                                                  <NA>
## 85                                                                                                                                                                                                                                                  <NA>
## 86                                                                                                                                                                                                                                                  <NA>
## 87                                                                                                                                                                                                                                                  <NA>
## 88                                                                                                                                                                                                                                                  <NA>
## 89                                                                                                                                                                                                                                                  <NA>
## 90                                                                                                                                                                                                                                                  <NA>
## 91                                                                                                                                                                                                                                                  <NA>
## 92                                                                                                                                                                                                                                                  <NA>
## 93                                                                                                                                                                                                                                                  <NA>
## 94                                                                                                                                                                                                                                                  <NA>
## 95                                                                                                                                                                                                                                                  <NA>
## 96                                                                                                                                                                                                                                                  <NA>
## 97                                                                                                                                                                                                                                                  <NA>
## 98                                                                                                                                                                                                                                                  <NA>
## 99                                                                                                                                                                                                                                                  <NA>
## 100                                                                                                                                                                                                                                                 <NA>
## 101                                                                                                                                                                                                                                                 <NA>
## 102                                                                                                                                                                                                                                                 <NA>
## 103                                                                                                                                                                                                                                                 <NA>
## 104                                                                                                                                                                                                                                                 <NA>
## 105                                                                                                                                                                                                                                                 <NA>
## 106                                                                                                                                                                                                                                                 <NA>
## 107                                                                                                                                                                                                                                                 <NA>
## 108                                                                                                                                                                                                                                                 <NA>
## 109                                                                                                                                                                                                                                                 <NA>
## 110                                                                                                                                                                                                                                                 <NA>
## 111                                                                                                                                                                                                                                                 <NA>
## 112                                                                                                                                                                                                                                                 <NA>
## 113                                                                                                                                                                                                                                                 <NA>
## 114                                                                                                                                                                                                                                                 <NA>
## 115                                                                                                                                                                                                                                                 <NA>
## 116                                                                                                                                                                                                                                                 <NA>
## 117                                                                                                                                                                                                                                                 <NA>
## 118                                                                                                                                                                                                                                                 <NA>
## 119                                                                                                                                                                                                                                                 <NA>
## 120                                                                                                                                                                                                                                                 <NA>
## 121                                                                                                                                                                                                                                                 <NA>
## 122                                                                                                                                                                                                                                                 <NA>
## 123                                                                                                                                                                                                                                                 <NA>
## 124                                                                                                                                                                                                                                                 <NA>
## 125                                                                                                                                                                                                                                                 <NA>
## 126                                                                                                                                                                                                                                                 <NA>
## 127                                                                                                                                                                                                                                                 <NA>
## 128                                                                                                                                                                                                                                                 <NA>
## 129                                                                                                                                                                                                                                                 <NA>
## 130                                                                                                                                                                                                                                                 <NA>
## 131 Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 132 Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, and Consequences. Oecologia 71(3), 461-472.
## 133                                                                                                  Marchesi L, Sergio F, Pedrini P. 2002. Costs and benefits of breeding in human-altered landscapes for the Eagle Owl Bubo bubo. Ibis 144, E164-E177.
## 134                                                                                          Jaksic FM, Carothers JH. 1985. Ecological, Morphological, and Bioenergetic Correlates of Hunting Mode in Hawks and Owls. Ornis Scandinavica 16(3), 165-172.
## 135                                                                                    Slagsvold T, Sonerud GA. 2007. Prey size and ingestion rate in raptors: importance for sex roles and reversed sexual size dimorphism. J. Avian Biol. 38: 650 661.
## 136                                                                                                                                                                                                                                                 <NA>
## 137                                                                                  Galeotti P, Morimando F, Violani C. 2009. Feeding ecology of the tawny owls (Strix aluco) in urban habitats (northern Italy). Bolletino di zoologia 58(2), 143-150.
## 138  Jaksic FM, Delibes M.1987. A Comparative Analysis of Food-Niche Relationships and Trophic Guild Structure in TwoAssemblages of Vertebrate Predators Differing in Species Richness: Causes, Correlations, andConsequences. Oecologia 71(3), 461-472.
## 139                                                                                                                                                                                                                                                 <NA>
## 140                                                                                                                                                                                                                                                 <NA>
```
*The bird species with the largest homerange is the Caracara cheriway (Northern crested caracara) at 241000000m2. https://animaldiversity.org/accounts/Caracara_cheriway/*

## Push your final code to GitHub!
Please be sure that you check the `keep md` file in the knit preferences.   
