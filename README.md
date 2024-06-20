# Forecasting
That is 2 questions of ny Final Exam for my forecasting and time series class.

Here is the questions:

Part III (25 points)
Q26
a) Download the Effective Fed Funds Rate (monthly) from St Louis Fed for the period from
1954/7 to 2023/10. (https://fred.stlouisfed.org/series/FEDFUNDS)
b) Transfer data to Stata and check for stationarity. Show that the data series is I(1), i.e,,
first-difference stationary.
The following Stata command will help you to specify the time variable correctly.
gen T=_n-67
tsset T, monthly
c) Show line graphs, AC plots and PAC plots of both original and first-differenced series
together with your interpretations.
d) Produce the ARIMA(p,d,q) model with lowest AIC and BIC values and express it using
backshift notation. (If AIC and BIC values suggest two different models, select one of
them and also report the other model).
12
12
e) Use your preferred model to predict the Effective Fed Funds Rate until January 2026.
This requires adding 27 more time periods (months) to your dataset which can be done as
shown below and then predicting the values for future months using the model you just
fitted.
set obs 859
replace T=_n-67 if T==.
predict F, dynamic(765) y
f) Draw line graphs of predicted and actual values of the Effective Fed Funds Rate (i) for
the entire period; and (ii) for the period beginning January 2021.
g) Compare your predictions with Fed’s own projections given here.
(https://fred.stlouisfed.org/series/FEDTARMD). Do you find your predictions to agree with
Fed’s own? If not, do you think you can better predict Effective Fed Funds Rate?
Part IV (35 points)
Q27
(a) Find the weekly data on “US regular all formulations gas price (GASREGW)” at the St
Louis Fed (FRED). Also add the data series “Crude Oil Prices: West Texas Intermediate
(WTI) - Cushing, Oklahoma, Dollars per Barrel, Not Seasonally
Adjusted (DCOILWTICO)” by using the “Edit graph -> Add line” option. Change the
frequency of the second data series to “weekly, ending Monday” and “end of period” so
that the measurement points are compatible with the first data series. Draw a timeseries
graph of the retail price of 40 gallons of gasoline and one barrel of crude oil using the
FRED graphing tools for the period from 01/06/1992 (1992week1) until 11/27/2023.
(b) Now download the two data series from 01/06/1992 (1992week1) until 11/27/2023 and
import to Stata. Name the two variables as “crude” and “retail”. Generate an appropriate
timeseries indicator.
You may use the following code if it helps:
gen date2 = date(var1, "YMD")
format date2 %td
gen yer=year(date2)
gen wk=week(date2)
gen YW=yw(yer,wk)
duplicates drop YW, force
tsset YW, weekly
13
13
c) Show that both variables, “crude” and “retail”, are first-difference stationary [I(1)].
d) Fit an ARIMA(3,1,3) model without a constant term for the “crude” data series. Check
whether you can fit a better ARIMA model which further reduces the AIC/ BIC values. If
that is possible, procced with that model. Based your model, predict “crude” until end
January 2024. Show the actual and predicted values of “crude” from July 2023 in a
graph.
Hint:
set obs 1668
replace YW=YW[_n-1] + 1 in 1660/L
tsset YW, weekly
predict FC, dynamic(tw(2023w47)) y
e) Show that the first 4 lagged values and the current value of “d.crude” possibly predicts
“d.retail”. (If you find a different result, feel free to show that.)
(Hint: The Stata command “xcorr d.relail d.crude, table” shows the
cross-correlation between different lags of the first differences of the two variables)
f) Show using the AC and PAC graphs that an ARIMA(1,1,0) process or an ARIMA(3,1,0)
process possibly explains the movements of “retail”. Compare the two models using AIC
and BIC. Also decide whether a constant term should be included or not. Use your
ARIMAX(3,1,0) model to predict “retail” until the end of January 2024.
g) Estimate an ARIMAX(3,1,0) model without a constant term i.e., an ARIMA(3,1,0) model
with additional covariates and without a constant term. Additional covariates to be
included are the current value and the first 4 lagged values of “crude”.
h) Use your ARIMAX(3,1,0) model to predict “retail” until the end of January 2024. Show
the actual and two predicted values of “retail” (using ARIMA and ARIMAX) from July
2023 in a graph.
Hint:
replace Crude=FC if Crude==.


## License

This project is licensed under a custom license. See the [LICENSE](LICENSE) file for details.

## Copyright

© 2024 Meman Diaby. All rights reserved.

Permission is granted for non-commercial use and replication with proper citation.

