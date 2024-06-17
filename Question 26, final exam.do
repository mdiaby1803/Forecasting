******************************* Question 26 *******************************************


*(b) Transfer data to Stata and check for stationarity. Show that the data series is I(1), i.e,, first-difference stationary.

gen T=_n-67
tsset T, monthly

pperron FEDFUNDS
dfuller FEDFUNDS
gen DiffFEDFUNDS= d.FEDFUNDS
pperron DiffFEDFUNDS
dfuller DiffFEDFUNDS

*(c) Show line graphs, AC plots and PAC plots of both original and first-differenced series.

ac FEDFUNDS
pac FEDFUNDS
ac DiffFEDFUNDS
pac DiffFEDFUNDS

*(d) Check for the best ARIMA model.

arima FEDFUNDS , arima(1,1,0)
estat ic
arima FEDFUNDS , arima(1,1,1)
estat ic
arima FEDFUNDS , arima(2,1,0)
estat ic
arima FEDFUNDS , arima(2,1,1)
estat ic
arima FEDFUNDS , arima(3,1,0)
estat ic
arima FEDFUNDS , arima(3,1,1)
estat ic
arima FEDFUNDS , arima(4,1,0)
estat ic
arima FEDFUNDS , arima(4,1,1)
estat ic
arima FEDFUNDS , arima(5,1,0)
estat ic
arima FEDFUNDS , arima(5,1,1)
estat ic
arima FEDFUNDS , arima(6,1,0)
estat ic
arima FEDFUNDS , arima(6,1,1)
estat ic
arima FEDFUNDS , arima(6,1,2)
estat ic
arima FEDFUNDS , arima(5,1,2)
estat ic
arima FEDFUNDS , arima(4,1,2)
arima FEDFUNDS , arima(6,1,2)
estat ic
arima FEDFUNDS , arima(7,1,0)
estat ic
arima FEDFUNDS , arima(7,1,2)
estat ic
arima FEDFUNDS , arima(7,1,3)
estat ic
arima FEDFUNDS , arima(8,1,3)
estat ic
arima FEDFUNDS , arima(0,1,1)
estat ic
arima FEDFUNDS , arima(8,1,4)
estat ic
arima FEDFUNDS , arima(9,1,2)
estat ic
arima FEDFUNDS , arima(7,1,3)
estat ic
arima FEDFUNDS , arima(0,1,1)nocons
estat ic
arima FEDFUNDS , arima(0,1,1)
estat ic
arima FEDFUNDS , arima(7,1,3)
estat ic
arima FEDFUNDS , arima(0,1,1)nocons
estat ic

*(e) Use your preferred model to predict the Effective Fed Funds Rate until January 2026. This requires adding 27 more time periods (months) to your dataset which can be done as shown below and then predicting the values for future months using the model you just fitted.

arima FEDFUNDS , arima(0,1,1)nocons
set obs 859
replace T=_n-67 if T==.
predict F, dynamic(765) y

*(f) 	Draw line graphs of predicted and actual values of the Effective Fed Funds Rate.

// (i) for the entire period

tsline F FEDFUNDS

// (ii) for the period beginning January 2021

tsline F FEDFUNDS if _n>799
