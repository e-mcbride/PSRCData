## code to prepare `DATASET` dataset goes here
library(dplyr)

raw <- "2017-2019-pr2-1-Household.csv"
RawPath <- here::here(paste0("data-raw/", raw))

PSRCZipPath <- here::here("data-raw/2017-2019-pr2-datafiles.zip")
PSRCDataURL <- "https://www.psrc.org/sites/default/files/2017-2019-pr2-datafiles.zip"

if(!file.exists(RawPath)) {
  if(!file.exists(PSRCZipPath)) {
    download.file(PSRCDataURL, PSRCZipPath)
  }
  unzip(PSRCZipPath, files = raw, exdir = here::here("data-raw/"))
}

raw_hh <- readr::read_csv(RawPath,
                   guess_max = 3500) #`guess_max` increases max # rows looked at to determine col type

hhdat <- raw_hh %>%
  mutate(hhid = as.character(hhid),
         hhsize = ordered(hhsize,
                          c("1 person",
                            "2 people",
                            "3 people",
                            "4 people",
                            "5 people",
                            "6 people",
                            "7 people",
                            "8 people",
                            "9 people")),
         hhincome_broad = ordered(hhincome_broad,
                                  c("Prefer not to answer",
                                    "Under $25,000",
                                    "$25,000-$49,999",
                                    "$50,000-$74,999",
                                    "$75,000-$99,999",
                                    "$100,000 or more")),
         hhincome_detailed = ordered(hhincome_detailed,
                                     c("Prefer not to answer",
                                       "Under $10,000",
                                       "$10,000-$24,999",
                                       "$25,000-$34,999",
                                       "$35,000-$49,999",
                                       "$50,000-$74,999",
                                       "$75,000-$99,999",
                                       "$100,000-$149,999",
                                       "$150,000-$199,999",
                                       "$200,000-$249,999",
                                       "$250,000 or more")),
         hhincome_followup = ordered(hhincome_followup,
                                     c("Prefer not to answer",
                                       "Under $25,000",
                                       "$25,000-$49,999",
                                       "$50,000-$74,999",
                                       "$75,000-$99,999",
                                       "$100,000 or more")),  # leaving out "Missing:skip logic" makes it NA
         lifecycle = ordered(lifecycle,
                             c("Household includes children under 5",
                               "Household includes children age 5-17",
                               "Household size = 1, Householder under age 35",
                               "Household size = 1, Householder age 35 - 64",
                               "Household size = 1, Householder age 65+",
                               "Household size > 1, Householder under age 35",
                               "Household size > 1, Householder age 35 - 64",
                               "Household size > 1, Householder age 65+")),
         dayofweek = ordered(dayofweek,
                             c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday")),
         rent_own = ordered(rent_own,
                            c("Own/paying mortgage",
                              "Rent",
                              "Provided by job or military",
                              "Other",
                              "Prefer not to answer")),
         res_type = ordered(res_type,
                            c("Single-family house (detached house)",
                              "Townhouse (attached house)",
                              "Building with 3 or fewer apartments/condos",
                              "Building with 4 or more apartments/condos",
                              "Mobile home/trailer",
                              "Dorm or institutional housing",
                              "Other (including boat, RV, van, etc.)")),

         across(starts_with("res_factors"),
                ~ ordered(.x,
                          c("Very unimportant",
                            "Somewhat unimportant",
                            "Neither or N/A",
                            "Somewhat important",
                            "Very important"))),
  )


usethis::use_data(hhdat, overwrite = TRUE, compress = "xz")
