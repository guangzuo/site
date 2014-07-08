** This do file is to plot residuals from a standard Mincerian wage regression **
** Date: May 19, 2014 
** Author: Guang Zuo
clear
use wage_reg_resid.dta

sort x11101ll year
*********************************************************************************************************************
* 1. use  data to plot residual across all educational group
collapse (p10) p10resid = residual (p25) p25resid = residual (median) medresid =  residual ///
         (p75) p75resid = residual (p90) p90resid = residual [aw=indwgt], by(year)

graph twoway (connected p10resid year) (connected p25resid year) (connected medresid year) (connected p75resid year) ///
             (connected p90resid year) ,title("Different Percentiles of Residuals After Regression")

*********************************************************************************************************************
* 2. changes in 90-10, 90-50, and 50-10 Ratios for Log Earning Residuals
gen p90p10 = p90resid - p10resid
gen p90p50 = p90resid - medresid
gen p50p10 = medresid - p10resid

gen p90p10_norm = p90p10 - p90p10[1]
gen p90p50_norm = p90p50 - p90p50[1]	
gen p50p10_norm = p50p10 - p50p10[1]
	 
graph twoway (connected p90p10_norm year) (connected p90p50_norm year) (connected p50p10_norm year)  


*********************************************************************************************************************
* 3. use  data to plot residual for different educational group
clear
use wage_reg_resid.dta

sort x11101ll year

collapse (p10) p10resid = residual (p25) p25resid = residual (median) medresid =  residual ///
         (p75) p75resid = residual (p90) p90resid = residual (sd) stdresid = residual [aw=indwgt], by(year educgrp)

reshape wide p10resid p25resid medresid p75resid p90resid stdresid, i(year) j(educgrp)

* normalize the residual data
forvalues i = 1/6{
	gen p90p10 = p90resid`i' - p10resid`i'
	gen p90p50 = p90resid`i' - medresid`i'
	gen p50p10 = medresid`i' - p10resid`i'
	
	
	gen p90p10_norm`i' = p90p10 - p90p10[1]
	gen p90p50_norm`i' = p90p50 - p90p50[1]	
	gen p50p10_norm`i' = p50p10 - p50p10[1]
	
	gen stdresid_norm`i' = stdresid`i'/stdresid`i'[1]
	
	drop p90p10
	drop p90p50
	drop p50p10
}
		 

graph twoway (connected p90p10_norm3 year) (connected p90p10_norm5 year) (connected p90p10_norm6 year), ///
             legend(label(1 "High School Graduate") label(2 "College Graduate") label(3 "Graduate School")) title("90-10 Ratio")		 
		 
graph twoway (connected p90p50_norm3 year) (connected p90p50_norm5 year) (connected p90p50_norm6 year), ///
             legend(label(1 "High School Graduate") label(2 "College Graduate") label(3 "Graduate School")) title("90-50 Ratio")		 
		 
graph twoway (connected p50p10_norm3 year) (connected p50p10_norm5 year) (connected p50p10_norm6 year), ///
             legend(label(1 "High School Graduate") label(2 "College Graduate") label(3 "Graduate School"))	title("50-10 Ratio")
			 
graph twoway (connected stdresid_norm4 year) (connected stdresid_norm5 year) (connected stdresid_norm6 year), ///
             legend(label(1 "Some College") label(2 "College Graduate") label(3 "Graduate School"))	///
			 title("Standard Deviation for Different Educational Group")
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 
			 