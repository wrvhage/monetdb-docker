FROM rocker/hadleyverse
MAINTAINER "Willem Robert van Hage" w.vanhage@esciencecenter.nl

RUN install2.r --error \
    -r "https://cran.rstudio.com" \
    -r "http://www.bioconductor.org/packages/release/bioc" \
    MonetDB.R

COPY monetdb_test.R /home/rstudio/monetdb_test.R
