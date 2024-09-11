library(tidyverse)
library(torch)

cgm <- readRDS("projects/data/sugr/cgm.rds") %>%
  select(-date, -time, -index) %>%
  mutate(
    datetime = round_date(datetime, unit = "5 mins")
  ) %>%
  filter(!is.na(bg_sensor)) %>%
  distinct()
pmp <- readRDS("projects/data/sugr/pump.rds") %>%
  select(-date, -time, -index) %>%
  mutate(
    datetime = round_date(datetime, unit = "5 mins")
  ) %>%
  distinct()

dt <- left_join(cgm, pmp, by = c("file", "datetime", "wday")) %>%
  mutate(
    date = date(datetime),
    time = hms::as_hms(datetime),
    .after = datetime
  )