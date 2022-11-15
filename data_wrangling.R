# install.packages("tidytuesdayR")
# install.packages("dplyr")
# install.packages("janitor")

library(janitor)
library(dplyr)

# to avoid exceeding API limits on GitHub, we'll save the breed_traits table to
# an RDS file. Once we've saved to RDS, we can comment out the next two lines
# as I've done here

# tuesdata <- tidytuesdayR::tt_load("2022-02-01")
# saveRDS(tuesdata$breed_traits, "breed_traits.rds")

# we're now reading the data from the RDS file we created, which is faster and
# avoid exceeding GitHub API limits as described in the link below:
# https://docs.github.com/en/graphql/overview/resource-limitations

# we're also passing the output of readRDS to clean_names, a function from the
# janitor package. This makes the column names lowercase, and replaced spaces with
# underscores (_). Useful for referring to in dplyr functions.
breed_traits <- clean_names(readRDS("breed_traits.rds"))

# selecting columns from the breed_traits object by name or by position
select(breed_traits, breed)
select(breed_traits, coat_length)
select(breed_traits, 1, 3, 4)
select(breed_traits, breed, coat_length)
select(breed_traits, 1, 2, 6, 7, 8, 9, 10)
select(breed_traits, 1, 2, 6:10)
select(breed_traits, breed, affectionate_with_family, coat_grooming_frequency:openness_to_strangers)

# filtering rows from the breed_traits object, using AND (&), OR (|), NOT (!=)
filter(breed_traits, drooling_level == 5)
filter(breed_traits, drooling_level == 5 & coat_length == "Short")
filter(breed_traits, drooling_level == 5 | drooling_level == 4)
filter(breed_traits, drooling_level != 5)
filter(breed_traits, !drooling_level %in% c(1,3,5))
filter(breed_traits, drooling_level %in% c(3,4,5) & coat_length == "Short")

# interestingly, dog breeds at the bottom of the alphabet all have an
# affectionate_with_family rating of 5
arrange(breed_traits, desc(breed), drooling_level)

# filter then arrange via the pipe
breed_traits |> 
  filter(drooling_level == 5) |> 
  arrange(breed)
