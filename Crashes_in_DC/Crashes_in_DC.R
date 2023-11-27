library(sf)
library(tidyverse)
library(visdat)
library(tigris)
library(dplyr)
library(mapview)

#CRASH ANALYSIS#
#***********************************************************#
studyarea_crashes_before <- st_read("Crashes_in_DC/StudyArea_19to20.shp") %>%
  mutate(period = "before", yearbinary = 0, treatment = 2)
studyarea_crashes_after <- st_read("Crashes_in_DC/StudyArea_21to23.shp")%>%
  mutate(period = "after", yearbinary = 1, treatment = 2)

studycor_crashes_before <- st_read("Crashes_in_DC/StudyCorridor_19to20.shp") %>%
  mutate(period = "before", yearbinary = 0, treatment = 1)
studycor_crashes_after <- st_read("Crashes_in_DC/StudyCorridor_21to23.shp")%>%
  mutate(period = "after", yearbinary = 1, treatment = 1)
controls_crashes_before <- st_read("Crashes_in_DC/Controls_19to20.shp")%>%
  mutate(period = "before", yearbinary = 0, treatment = 0)
controls_crashes_after <- st_read("Crashes_in_DC/Controls_21to23.shp")%>%
  mutate(period = "after", yearbinary = 1, treatment = 0)

AllCrashes <- rbind(studycor_crashes_before, studycor_crashes_after, controls_crashes_after, controls_crashes_before, studyarea_crashes_after, studyarea_crashes_before) %>%
  mutate(bike=ifelse(TOTAL_BICY>0, 1, 0), walk=ifelse(TOTAL_PEDE>0, 1, 0)) %>%
  group_by(treatment, yearbinary, walk, bike) %>%
  summarise(n=n())
  

