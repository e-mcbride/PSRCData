
<!-- README.md is generated from README.Rmd. Please edit that file -->

# PSRCData

Small R package to quickly import the [Puget Sound Region Council
Household Travel
Survey](https://www.psrc.org/household-travel-survey-program) data into
R with my modifications for usability. Made to use with my analysis
repository [PSRC.analysis](https://github.com/e-mcbride/PSRC.analysis).

## Installation

1.  Clone this repository
2.  In RStudio\*, open the PSRCData `.Rproj` file (NOT PSRC.analysis
    yet)
3.  Click the “Build” tab in the “Environment, History, Connections, …”
    panel in RStudio\*, then click “Install and Restart”.

\* *If you are not using RStudio Desktop, I cannot advise you on how to
build the PSRCData package.*

You are now set to use the PSRCData package in your projects! To read in
the data sets in your project, use the syntax `PSRCData::trdat`,
`PSRCData::prdat`, or `PSRCData::hhdat`. For example, to import the
travel diary data file as `travelData`:

``` r
travelData <- PSRCData::trdat
```

**NOTE** If modifications are made to the data files (either by pulling
updates from my repository or by making updates yourself), you will need
to rebuild the package by clicking “Install and Restart” again.
