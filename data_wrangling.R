# install.packages("tidytuesdayR")
# install.packages("dplyr")

library(dplyr)

# to avoid exceeding API limits on GitHub, we'll save the breed_traits table to
# an RDS file. Once we've saved to RDS, we can comment out the next two lines
# as I've done here

# tuesdata <- tidytuesdayR::tt_load("2022-02-01")
# saveRDS(tuesdata$breed_traits, "breed_traits.rds")

# we're now reading the data from the RDS file we created, which is faster and
# avoid exceeding GitHub API limits as described in the link below:
# https://docs.github.com/en/graphql/overview/resource-limitations
breed_traits <- readRDS("breed_traits.rds")

select(breed_traits, "Breed")

select(breed_traits, "Coat Length")

select(breed_traits, 1, 3, 4)

select(breed_traits, "Breed", "Coat Length")

select(breed_traits, 1, 2, 6, 7, 8, 9, 10)

select(breed_traits, 1, 2, 6:10)

select(breed_traits, "Breed", "Affectionate With Family", "Coat Grooming Frequency":"Openness To Strangers")
