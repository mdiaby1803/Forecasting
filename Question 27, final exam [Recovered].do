********************************* Questionn 27 ****************************************

import excel "C:\Users\meman\Downloads\fredgraph.xls", sheet("FRED Graph") firstrow clear

*(b) Rename the variables.

rename GASREGW retail
rename DCOILWTICO crude

*Set the time variable.

de observation_date
gen date2 = observation_date
format date2 %td
gen yer=year(date2)
gen wk=week(date2)
gen YW=yw(yer,wk)
duplicates drop YW, force
tsset YW, weekly
*(c)Looks if the two series are stationary and also look at their first-difference.

pperron crude
dfuller crude
pperron d.crude
dfuller d.crude
pperron retail
dfuller retail
pperron d.retail
dfuller d.retail

*(d) Fit an ARIMA(3,1,0)nocons is a good model to estimate crude, and looks also for better posibilities.

arima crude , arima(3,1,3)nocons
estat ic
arima crude , arima(3,1,3)nocons
estat ic
arima crude , arima(0,1,1)nocons
estat ic
arima crude , arima(1,1,1)nocons
estat ic
arima crude , arima(1,1,0)nocons
estat ic
arima crude , arima(2,1,1)nocons
estat ic
arima crude , arima(2,1,2)nocons
estat ic
arima crude , arima(1,1,2)nocons
estat ic
arima crude , arima(3,1,2)nocons
estat ic
arima crude , arima(3,1,3)nocons
estat ic
arima crude , arima(3,1,2)nocons
estat ic
arima crude , arima(3,1,3)nocons
estat ic
arima crude , arima(3,1,3)nocons
estat ic
arima crude , arima(3,1,2)nocons
estat ic
arima crude , arima(2,1,3)nocons
estat ic
arima crude , arima(4,1,3)nocons
estat ic
arima crude , arima(3,1,4)nocons
estat ic
arima crude , arima(4,1,4)nocons
estat ic
arima crude , arima(1,1,3)nocons
estat ic
arima crude , arima(3,1,1)nocons
estat ic
arima crude , arima(5,1,2)nocons
estat ic
arima crude , arima(5,1,3)nocons
estat ic
arima crude , arima(5,1,4)nocons
estat ic
arima crude , arima(5,1,5)nocons
estat ic
arima crude , arima(1,1,5)nocons
estat ic
arima crude , arima(2,1,5)nocons
estat ic
arima crude , arima(3,1,5)nocons
estat ic
arima crude , arima(4,1,5)nocons
estat ic
arima crude , arima(5,1,5)nocons
estat ic

*Forecast ARIMA(3,1,2)nocons and produce the graph.

arima crude , arima(3,1,2)nocons
set obs 1668
replace YW=YW[_n-1] + 1 in 1660/L
tsset YW, weekly
predict FC, dynamic(tw(2023w47)) y
tsline crude FC if _n>1638

*(e)Show that the first 4 lagged values and the current value of "d.crude" possibly predicts "d.retail".  

xcorr d.retail d.crude, table

*(f) Show using the AC and PAC graphs that an ARIMA(1,1,0) process or an ARIMA(3,1,0) process possibly explains the movements of "retail". Compare the two models using AIC and BIC. Also decide whether a constant term should be included or not. Use your ARIMAX(3,1,0) model to predict "retail" until the end of January 2024

ac d.retail
pac d.retail
arima retail , arima(1,1,0)nocons
estat ic
arima retail , arima(2,1,0)
estat ic
arima retail , arima(3,1,0)
estat ic
arima retail , arima(4,1,0)
estat ic
arima retail , arima(5,1,0)
estat ic
arima retail , arima(6,1,0)
estat ic
arima retail , arima(1,1,1)
estat ic
arima retail , arima(1,1,2)
estat ic
arima retail , arima(2,1,1)
estat ic
arima retail , arima(2,1,2)
estat ic
arima retail , arima(2,1,3)
arima retail , arima(3,1,3)
estat ic
arima retail , arima(3,1,0)nocons
estat ic
arima retail , arima(4,1,0)nocons
estat ic

* Forecast retail using ARIMA(3,1,0)nocons, and produce the graph =.

arima retail L1.d.crude L2.d.crude L3.d.crude L4.d.crude, arima(3,1,0)nocons
replace crude =FC if crude ==.
predict FC3, dynamic(tw(2023w47)) y
tsline retail FC3
tsline retail FC3 if _n>1638

*(g)	Estimate an ARIMAX(3,1,0) model without a constant term i.e., an ARIMA(3,1,0) model with additional covariates and without a constant term. Additional covariates to be included are the current value and the first 4 lagged values of "crude". 

* Forecast the ARIMAX model, and produce the graph.

arima retail L1.d.crude L2.d.crude L3.d.crude L4.d.crude, arima(3,1,0)
replace crude =FC if crude ==.
predict FC4, dynamic(tw(2023w47)) y
tsline retail FC4
tsline retail FC4 if _n>1638

*(h)	Use your ARIMAX(3,1,0) model to predict "retail" until the end of January 2024. Show the actual and two predicted values of "retail" (using ARIMA and ARIMAX) from July 2023 in a graph. 

arima retail, arima(3,1,0)nocons
replace crude =FC if crude ==.
predict FC5, dynamic(tw(2023w47)) y
tsline retail FC5
tsline retail FC5 FC4 if _n>1638


