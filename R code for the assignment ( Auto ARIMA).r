#Question 26

# Load required libraries
library(forecast)
library(ggplot2)
library(tseries)
library(readr)

# Download the data
fed_funds <- read_csv('https://fred.stlouisfed.org/series/FEDFUNDS/downloaddata/FEDFUNDS.csv')
fed_funds <- fed_funds[fed_funds$DATE >= '1954-07-01' & fed_funds$DATE <= '2023-10-01', ]

# Convert to time series
fed_funds_ts <- ts(fed_funds$VALUE, start=c(1954, 7), frequency=12)

# Check for stationarity
adf.test(fed_funds_ts)

# Line graph
autoplot(fed_funds_ts) + ggtitle("Effective Fed Funds Rate")

# ACF and PACF plots
ggAcf(fed_funds_ts) + ggtitle("ACF of Effective Fed Funds Rate")
ggPacf(fed_funds_ts) + ggtitle("PACF of Effective Fed Funds Rate")

# First difference the series and check for stationarity again
diff_fed_funds_ts <- diff(fed_funds_ts)
adf.test(diff_fed_funds_ts)

# Plots for differenced series
autoplot(diff_fed_funds_ts) + ggtitle("Differenced Effective Fed Funds Rate")
ggAcf(diff_fed_funds_ts) + ggtitle("ACF of Differenced Effective Fed Funds Rate")
ggPacf(diff_fed_funds_ts) + ggtitle("PACF of Differenced Effective Fed Funds Rate")

# Use auto.arima to find the best model
auto_fit <- auto.arima(fed_funds_ts)
summary(auto_fit)

# Predict future values
future_forecast <- forecast(auto_fit, h=27)
autoplot(future_forecast) + ggtitle("Forecast of Effective Fed Funds Rate")

# Graph for the entire period
autoplot(forecast(auto_fit, h=27)) + ggtitle("Actual vs Predicted Effective Fed Funds Rate")

# Graph for the period beginning January 2021
autoplot(window(forecast(auto_fit, h=27), start=c(2021, 1))) + ggtitle("Actual vs Predicted Effective Fed Funds Rate from January 2021")

# Download Fed's projections
fed_projections <- read_csv('https://fred.stlouisfed.org/series/FEDTARMD/downloaddata/FEDTARMD.csv')

# Merge and compare
fed_funds$Predictions <- c(fed_funds$VALUE, future_forecast$mean)
fed_funds <- merge(fed_funds, fed_projections, by.x='DATE', by.y='DATE', all.x=TRUE)
ggplot(fed_funds, aes(x=as.Date(DATE))) +
  geom_line(aes(y=VALUE, color='Actual')) +
  geom_line(aes(y=Predictions, color='Predicted')) +
  geom_line(aes(y=VALUE.y, color='Fed Projections')) +
  ggtitle("Comparison of Predictions with Fed's Projections")

  #Question 27

  # Load required libraries
library(forecast)
library(ggplot2)
library(tseries)
library(readr)

# Download the data
gas_prices <- read_csv('https://fred.stlouisfed.org/series/GASREGW/downloaddata/GASREGW.csv')
crude_prices <- read_csv('https://fred.stlouisfed.org/series/DCOILWTICO/downloaddata/DCOILWTICO.csv')

# Adjust frequency and merge datasets
gas_prices$DATE <- as.Date(gas_prices$DATE)
crude_prices$DATE <- as.Date(crude_prices$DATE)
data <- merge(gas_prices, crude_prices, by='DATE', all=TRUE)

# Create time series objects
gas_ts <- ts(data$GASREGW, start=c(1992, 1), frequency=52)
crude_ts <- ts(data$DCOILWTICO, start=c(1992, 1), frequency=52)

# Plot the time series
autoplot(gas_ts) + 
  autolayer(crude_ts, series='Crude Oil Prices') + 
  ggtitle("Retail Gas Prices and Crude Oil Prices")

# Check for stationarity
adf.test(gas_ts)
adf.test(crude_ts)

# Differencing
diff_gas_ts <- diff(gas_ts)
diff_crude_ts <- diff(crude_ts)

adf.test(diff_gas_ts)
adf.test(diff_crude_ts)

# Use auto.arima for crude data
auto_fit_crude <- auto.arima(crude_ts, d=1)
summary(auto_fit_crude)

# Forecast crude prices
forecast_crude <- forecast(auto_fit_crude, h=8)
autoplot(forecast_crude) + ggtitle("Forecast of Crude Oil Prices")

# Cross-correlation
ccf(diff_gas_ts, diff_crude_ts) + ggtitle("Cross-correlation between Differenced Gas and Crude Prices")

# Use auto.arima for gas data
auto_fit_gas <- auto.arima(gas_ts, d=1)
summary(auto_fit_gas)

# Compare models
auto_fit_gas_alt <- auto.arima(gas_ts, d=1, max.p=3, max.q=0)
summary(auto_fit_gas_alt)

# Fit ARIMAX model
arimax_fit <- auto.arima(gas_ts, xreg=crude_ts)
summary(arimax_fit)

# Predict retail prices using ARIMAX
forecast_arimax <- forecast(arimax_fit, xreg=crude_ts, h=8)

# Plot predictions
autoplot(forecast_arimax) + 
  autolayer(window(gas_ts, start=c(2023, 27)), series='Actual') + 
  autolayer(forecast_crude$mean, series='Crude Forecast') + 
  ggtitle("Actual vs Predicted Retail Gas Prices using ARIMAX")

