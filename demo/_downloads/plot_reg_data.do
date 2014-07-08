** This do file is to do some explortory data analysis **
** Date: May 19, 2014 
** Author: Guang Zuo
clear
use wage_reg.dta

*********************************************************************************************************************
* 1. use real_wage_head data to plot across all educational group
collapse (p10) p10wage = log_real_wagehead (median) medwage =  log_real_wagehead (p90) p90wage = log_real_wagehead ///
         (p99) p99wage = log_real_wagehead (sd) sdwage = log_real_wagehead [aw=indwgt], by(year)
gen p10wage_norm = p10wage/p10wage[1]
gen medwage_norm = medwage/medwage[1]
gen p90wage_norm = p90wage/p90wage[1]
gen p99wage_norm = p99wage/p99wage[1]

graph twoway (connected p10wage_norm year) (connected medwage_norm year) (connected p90wage_norm year) ///
             (connected p99wage_norm year) ,title("Different Percentiles of Log Wage Head")

			 
graph twoway connected sdwage year,title("Standard Deviation of Log Wage Head")		 


*********************************************************************************************************************
* 2. plot for different educational group
clear
use wage_reg.dta

collapse (p50) stds = log_real_wagehead [aw=indwgt], by(year educgrp)

reshape wide stds, i(year) j(educgrp)

* normalize the standard deviation data
forvalues i = 1/6{
	gen std`i' = stds`i'/stds`i'[1]
}



graph twoway (connected std2 year) (connected std3 year) (connected std4 year) ///
             (connected std5 year) (connected std6 year), ///
			 legend(label(1 "Some Hish School") label(2 "High School Graduate") label(3 "Some College") ///
			 label(4 "College Graduate") label(5 "Graduate School"))


*********************************************************************************************************************
* 3. plot for different industry group
clear
use wage_reg.dta

collapse (p50) medindustry = log_real_wagehead [aw=indwgt], by(year industry_grp)
reshape wide medindustry, i(year) j(industry_grp)

* normalize the standard deviation data
forvalues i = 1/5{
	gen med`i' = medindustry`i'/medindustry`i'[1]
}

graph twoway (connected med2 year) (connected med3 year) (connected med4 year) (connected med5 year), ///
             legend(label(1 "Mining") label(2 "Constructing") label(3 "Manufacturing") label(4 "Others"))


*********************************************************************************************************************
* 4. plot for different regional group
clear
use wage_reg.dta

collapse (sd) medregion = log_real_wagehead [aw=indwgt], by(year region)
reshape wide medregion, i(year) j(region)

* normalize the standard deviation data
forvalues i = 1/4{
	gen med`i' = medregion`i'/medregion`i'[1]
}

graph twoway (connected med1 year) (connected med2 year) (connected med3 year) (connected med4 year), ///
             legend(label(1 "Northeast") label(2 "North Central") label(3 "South") label(4 "West"))









