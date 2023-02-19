---
title:"Is Survivor Racist?"
output: html_document
date: "2023-01-23"
---
  
```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

## Libraries

```{r}
install.packages('survivoR')
library(survivoR)
library(dplyr)
library(ggplot2)
```

```{r}
# Join the castaway tables
castaways = inner_join(
  castaways,
  castaway_details,
  by = "castaway_id",
  keep = FALSE,
)

# If Ethnicity is null, copy POC over
castaways = castaways %>%
    mutate(ethnicity = coalesce(ethnicity,poc))
# If race is null, copy ethnicity over
castaways = castaways %>%
    mutate(race = coalesce(race,ethnicity))
    
# Make a new colum where race has fewer options
castaways = castaways %>%
mutate(Race_c = case_when(
  race == 'Hispanic or Latino' |
  race == "Native American" |
  race == 'Hispanic' |
  race == "Brazilian" |
  race == 'Chilean American' |
  race == "Venezuelan American" |
  race == 'Cuban American' |
  race == "Puerto Rican American" |
  race == 'Mexican American' |
  race == 'Peruvian American' |
  race == 'Colombian American' |
  race == 'Panamanian American' 
  ~ "Hispanic or Latino, Native American",
  race == "Asian American" ~ "Asian", 
  race == "Asian, Black" ~ "Asian", 
  race == "Jewish" ~ "White", 
  race == "POC" ~ "Black", 
  TRUE ~ race
  ))

```

```{r}
# Create season, race counts
castaways_race_counts = castaways %>%
  group_by(season, Race_c) %>%
  summarize(int=n()) %>%
  mutate(freq = formattable::percent(cnt / sum(cnt))) %>%
  arrange(desc(freq))

# Area chart now
options(repr.plot.width=24, repr.plot.height=8)

g = ggplot(castaways_race_counts, aes(x=season, y=freq, fill=Race_c)) +
geom_area()
ggsave("survivor_race.jpg", height = 7, widhth = 15)

# Figure out how many  contestants each season has
castaways = castaways %>%
  group_by(season) %>%
  mutate(cnt=n())

# Calculate Percentages
castaways['place'] = castaways['order'] /  castaways['cnt']
ggplot(castaways, aes(x=Race_c, y=place, fill=Race_c)) +
  geom_violin(trim = FALSE)+
  geom_jitter(position=position_jitter(0.1))
ggsave("survivor_race_2.jpg", height = 7, widhth = 15)

```

