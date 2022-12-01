# install.packages("tidytuesdayR")
# install.packages("dplyr")
# install.packages("janitor")
# install.packages("ggplot2")

library(janitor)
library(dplyr)
library(ggplot2)

# tuesdata <- tidytuesdayR::tt_load("2022-02-01") |>
#   saveRDS("all_good_dogs.rds")

all_dogs <- readRDS("all_good_dogs.rds")

(breed_traits <- all_dogs$breed_traits |>
  clean_names())

(breed_ranks <- all_dogs$breed_rank |>
  clean_names())

(traits_with_ranks <- left_join(breed_traits, breed_ranks, by = "breed"))

(breed_traits <- all_dogs$breed_traits |>
  clean_names() |>
  mutate(key = make_clean_names(breed)))

(breed_ranks <- all_dogs$breed_rank |>
  clean_names() |>
  mutate(key = make_clean_names(breed)) |>
  select(-breed))

(traits_with_ranks <- left_join(breed_traits, breed_ranks, by = "key"))

(traits_with_ranks |>
  filter(is.na(links)) |>
  nrow())

(anti_join(breed_traits, breed_ranks, by = "key") |>
  nrow())

(breed_traits <- all_dogs$breed_traits |>
  clean_names() |>
  mutate(
    key = make_clean_names(breed),
    all_traits_score = rowSums(across(where(is.double)), na.rm = TRUE),
    negative_traits_score = rowSums(across(c(shedding_level:drooling_level, barking_level)), na.rm = TRUE),
    weighted_score = all_traits_score - (2 * negative_traits_score)
    ))

(breed_ranks <- all_dogs$breed_rank |>
  clean_names() |>
  mutate(
    key = make_clean_names(breed),
    avg_rank = rowMeans(across(where(is.double)), na.rm = TRUE) |> round()
    ) |>
  select(-breed))

(traits_with_ranks <- left_join(breed_traits, breed_ranks, by = "key"))

(traits_with_ranks |>
  filter(weighted_score > 0) |>
  ggplot(aes(x = weighted_score, y = -avg_rank)) +
  geom_point() +
  theme_minimal())
