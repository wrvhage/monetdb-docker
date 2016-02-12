library(MonetDB.R)
library(dplyr)
library(nycflights13)

mdb <- src_monetdb('db',host='monetdb')
copy_to(mdb,flights,name='flights',temporary=TRUE)
mdb %>% src_tbls()

