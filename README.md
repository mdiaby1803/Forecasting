# Forecasting and Time Series Final Exam Solutions

This repository contains solutions for two questions from the final exam for a forecasting and time series class. The solutions involve downloading data from the St. Louis Fed, performing time series analysis, and fitting ARIMA models using Stata.

## Contents

- [Part III: Effective Fed Funds Rate Analysis](#part-iii-effective-fed-funds-rate-analysis)
- [Part IV: US Gas and Crude Oil Prices Analysis](#part-iv-us-gas-and-crude-oil-prices-analysis)
- [License](#license)

## Part III: Effective Fed Funds Rate Analysis

### Q26 

#### a) Data Download
Download the Effective Fed Funds Rate (monthly) from St. Louis Fed for the period from July 1954 to October 2023. [FEDFUNDS](https://fred.stlouisfed.org/series/FEDFUNDS)

#### b) Data Transfer and Stationarity Check
1. Transfer the data to Stata.
2. Check for stationarity to show that the data series is I(1), i.e., first-difference stationary.
3. Use the following Stata command to specify the time variable correctly:
    ```stata
    gen T=_n-67
    tsset T, monthly
    ```

#### c) Graphical Analysis
1. Show line graphs, AC plots, and PAC plots of both the original and first-differenced series.
2. Provide interpretations for these plots.

#### d) ARIMA Model Selection
1. Produce the ARIMA(p,d,q) model with the lowest AIC and BIC values.
2. Express the selected model using backshift notation.
3. If AIC and BIC values suggest different models, select one and report the other as well.

#### e) Forecasting
1. Use the preferred model to predict the Effective Fed Funds Rate until January 2026.
2. Add 27 more time periods (months) to the dataset using the following Stata commands:
    ```stata
    set obs 859
    replace T=_n-67 if T==.
    predict F, dynamic(765) y
    ```

#### f) Graphical Comparison
Draw line graphs of predicted and actual values of the Effective Fed Funds Rate:
1. For the entire period.
2. For the period beginning January 2021.

#### g) Comparison with Fed Projections
1. Compare the predictions with the Fed’s own projections from [here](https://fred.stlouisfed.org/series/FEDTARMD).
2. Discuss whether your predictions agree with the Fed's projections and justify your answer.

## Part IV: US Gas and Crude Oil Prices Analysis

### Q27 

#### a) Data Download and Graphing
1. Find the weekly data on “US regular all formulations gas price (GASREGW)” and “Crude Oil Prices: West Texas Intermediate (WTI) - Cushing, Oklahoma, Dollars per Barrel, Not Seasonally Adjusted (DCOILWTICO)” from St. Louis Fed.
2. Change the frequency of the second data series to “weekly, ending Monday” and “end of period” to match the first data series.
3. Draw a time series graph of the retail price of 40 gallons of gasoline and one barrel of crude oil for the period from January 6, 1992 (1992week1) to November 27, 2023.

#### b) Data Transfer and Preparation in Stata
1. Download the two data series and import them to Stata.
2. Name the variables as “crude” and “retail”.
3. Generate an appropriate time series indicator using the following Stata code:
    ```stata
    gen date2 = date(var1, "YMD")
    format date2 %td
    gen yer = year(date2)
    gen wk = week(date2)
    gen YW = yw(yer,wk)
    duplicates drop YW, force
    tsset YW, weekly
    ```

#### c) Stationarity Check
Show that both variables, “crude” and “retail”, are first-difference stationary [I(1)].

#### d) ARIMA Model for Crude Data
1. Fit an ARIMA(3,1,3) model without a constant term for the “crude” data series.
2. Check if a better ARIMA model can be fitted to reduce AIC/BIC values.
3. Predict “crude” until the end of January 2024.
4. Show the actual and predicted values of “crude” from July 2023 in a graph.

#### e) Cross-Correlation Analysis
Show that the first 4 lagged values and the current value of “d.crude” possibly predict “d.retail”. Use the following Stata command to show cross-correlation:
    ```stata
    xcorr d.retail d.crude, table
    ```

#### f) ARIMA Model for Retail Data
1. Show using the AC and PAC graphs that an ARIMA(1,1,0) or ARIMA(3,1,0) process possibly explains the movements of “retail”.
2. Compare the two models using AIC and BIC and decide whether a constant term should be included or not.
3. Use the preferred ARIMAX(3,1,0) model to predict “retail” until the end of January 2024.

#### g) ARIMAX Model with Additional Covariates
Estimate an ARIMAX(3,1,0) model without a constant term but with additional covariates (current value and the first 4 lagged values of “crude”).

#### h) Forecasting and Graphical Comparison
1. Use the ARIMAX(3,1,0) model to predict “retail” until the end of January 2024.
2. Show the actual and two predicted values of “retail” (using ARIMA and ARIMAX) from July 2023 in a graph.


## License

This project is licensed under a custom license. See the [LICENSE](LICENSE) file for details.

## Copyright

© 2024 Meman Diaby. All rights reserved.

Permission is granted for non-commercial use and replication with proper citation.

