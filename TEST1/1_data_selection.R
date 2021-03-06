# ----------------------------------------------------------------------------------------
# R Script to select and train the Deep Learning model on Financial Asset Time Series Data
# ----------------------------------------------------------------------------------------
# ## Manually select data into big matrix with label of 6 classes
# ----------------------------------------------------------------------------------------
#
# Supervised Deep Learning Classification Modelling
#
# load libraries to use and custom functions
library(tidyverse)
library(h2o)
library(lubridate)
library(plotly)
source("to_m.R")

#### Read asset prices and indicators ==========================================
# load prices of 28 currencies
prices <- read_csv("AI_CP15.csv", col_names = F)
prices$X1 <- ymd_hms(prices$X1)
# load macd indicator of 28 currencies
macd <- read_csv("AI_Macd15.csv", col_names = F)
macd$X1 <- ymd_hms(macd$X1)

#### Manually Selecting data... =================================================
# Market Periods
# 1. Bull normal, BUN
# 2. Bull volatile, BUV
# 3. Bear normal, BEN
# 4. Bear volatile, BEV
# 5. Sideways quiet, RAN
# 6. Sideways volatile, RAV

##########################################################################
## ---------- # 1. Bull normal, BUN ---------------
##########################################################################
# Choose the asset corresponding to this period /find by replacing 'y' argument/
ggplot(prices, aes(X1, X5))+geom_line()

# Extract approximate date and choose only relevant columns
price_df <- prices %>% filter(X1 > "2017-12-15", X1 < "2018-01-20") %>% select(X1, X5)

# Visualize it to confirm 
ggplot(price_df, aes(X1, X5))+geom_line()

# Extract corresponding piece of indicator dataframe:
macd_df <- macd %>% select(X1, X5) %>% inner_join(price_df, by = c("X1" = "X1"))

# Visualize both things together
ggplot(macd_df, aes(X1, X5.y, col = X5.x))+geom_line()

# transform to matrix, number of columns will correspond to model sensitivity e.g. 100 columns ~ 24 Hours
macd_m <- macd_df %>% select(X5.x) %>% to_m(64)
#########################################################################
# add new column to this matrix with value BUN
macd_m_1 <- transform(macd_m, M_T = "BUN")
##########################################################################


##########################################################################
## ---------- # 2. Bull volatile, BUV ---------------
##########################################################################
# Choose the asset corresponding to this period /find by replacing 'y' argument/
ggplot(prices, aes(X1, X15))+geom_line()

# Extract approximate date and choose only relevant columns
price_df <- prices %>% filter(X1 > "2018-03-10", X1 < "2018-03-20") %>% select(X1, X15)

# Visualize it to confirm 
ggplot(price_df, aes(X1, X15))+geom_line()

# Extract corresponding piece of macd dataframe:
macd_df <- macd %>% select(X1, X15) %>% inner_join(price_df, by = c("X1" = "X1"))

# Visualize both things together
ggplot(macd_df, aes(X1, X15.y, col = X15.x))+geom_line()

# transform to matrix, number of columns will correspond to model sensitivity e.g. 100 columns ~ 24 Hours
macd_m <- macd_df %>% select(X15.x) %>% to_m(64)

#########################################################################
macd_m_2 <- transform(macd_m, M_T = "BUV") 
#########################################################################


##########################################################################
## ---------- # 3. Bear normal, BEN ---------------
##########################################################################
# Choose the asset corresponding to this period /find by replacing 'y' argument/
ggplot(prices, aes(X1, X29))+geom_line()

# Extract approximate date and choose only relevant columns
price_df <- prices %>% filter(X1 > "2018-01-10", X1 < "2018-02-15") %>% select(X1, X29)

# Visualize it to confirm 
ggplot(price_df, aes(X1, X29))+geom_line()

# Extract corresponding piece of macd dataframe:
macd_df <- macd %>% select(X1, X29) %>% inner_join(price_df, by = c("X1" = "X1"))

# Visualize both things together
ggplot(macd_df, aes(X1, X29.y, col = X29.x))+geom_line()

# transform to matrix, number of columns will correspond to model sensitivity e.g. 100 columns ~ 24 Hours
macd_m <- macd_df %>% select(X29.x) %>% to_m(64)

#########################################################################
macd_m_3 <- transform(macd_m, M_T = "BEN")
#########################################################################


##########################################################################
## ---------- # 4. Bear volatile, BEV ---------------
##########################################################################
# Choose the asset corresponding to this period /find by replacing 'y' argument/
ggplot(prices, aes(X1, X7))+geom_line()

# Extract approximate date and choose only relevant columns
price_df <- prices %>% filter(X1 > "2018-01-22", X1 < "2018-01-29") %>% select(X1, X7)

# Visualize it to confirm 
ggplot(price_df, aes(X1, X7))+geom_line()

# Extract corresponding piece of macd dataframe:
macd_df <- macd %>% select(X1, X7) %>% inner_join(price_df, by = c("X1" = "X1"))

# Visualize both things together
ggplot(macd_df, aes(X1, X7.y, col = X7.x))+geom_line()

# transform to matrix, number of columns will correspond to model sensitivity e.g. 100 columns ~ 24 Hours
macd_m <- macd_df %>% select(X7.x) %>% to_m(64)

#########################################################################
macd_m_4 <- transform(macd_m, M_T = "BEV")
#########################################################################


##########################################################################
## ---------- # 5. Sideways quiet, RAN ---------------
##########################################################################
# Choose the asset corresponding to this period /find by replacing 'y' argument/
ggplot(prices, aes(X1, X2))+geom_line()

# Extract approximate date and choose only relevant columns
price_df <- prices %>% filter(X1 > "2018-03-20", X1 < "2018-04-10") %>% select(X1, X2)

# Visualize it to confirm 
ggplot(price_df, aes(X1, X2))+geom_line()

# Extract corresponding piece of macd dataframe:
macd_df <- macd %>% select(X1, X2) %>% inner_join(price_df, by = c("X1" = "X1"))

# Visualize both things together
ggplot(macd_df, aes(X1, X2.y, col = X2.x))+geom_line()

# transform to matrix, number of columns will correspond to model sensitivity e.g. 100 columns ~ 24 Hours
macd_m <- macd_df %>% select(X2.x) %>% to_m(64)

#########################################################################
macd_m_5 <- transform(macd_m, M_T = "RAN") 
#########################################################################

##########################################################################
## ---------- # 6. Sideways volatile, RAV ---------------
##########################################################################
# Choose the asset corresponding to this period /find by replacing 'y' argument/
ggplot(prices, aes(X1, X9))+geom_line()

# Extract approximate date and choose only relevant columns
price_df <- prices %>% filter(X1 > "2018-01-01", X1 < "2018-11-20") %>% select(X1, X9)

# Visualize it to confirm 
ggplot(price_df, aes(X1, X9))+geom_line()

# Extract corresponding piece of macd dataframe:
macd_df <- macd %>% select(X1, X9) %>% inner_join(price_df, by = c("X1" = "X1"))

# Visualize both things together
ggplot(macd_df, aes(X1, X9.y, col = X9.x))+geom_line()

# transform to matrix, number of columns will correspond to model sensitivity e.g. 100 columns ~ 24 Hours
macd_m <- macd_df %>% select(X9.x) %>% to_m(64)

#########################################################################
macd_m_6 <- transform(macd_m, M_T = "RAV")
#########################################################################
#########################################################################
#########################################################################

# Combine all of that :)
macd_ML2 <- rbind(macd_m_1,macd_m_2,macd_m_3,macd_m_4,macd_m_5,macd_m_6)

### NOTE Number of rows Matrices needs to be roughly equal

# Record data into the folder
write_rds(macd_ML2, "TEST1/data_initial/macd_ML2.rds")

## Visualize new matrix in 3D
plot_ly(z = as.matrix(macd_ML2[,1:64]), type = "surface")

#### End