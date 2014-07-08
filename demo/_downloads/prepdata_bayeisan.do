** This do file is to prepare the data for Bayesian estimation **
** Date: Jun 1, 2014 
** Author: Guang Zuo
clear
use wage_reg_resid.dta

sort x11101ll year


*********************************************************************************************************************
* 1. Aggregate the educational group into three groups
generate educ_grp = educgrp
recode educ_grp (1/3=1) (4/5=2) (6=3)

label define lbl_educ 1 "High School and less" 2 "Some College and College Degree" 3 "Graduate School"
label value educ_grp lbl_educ

save LogWageResidBayesian.dta


/** This part is to generate some plot
collapse (sd) stdresid = residual [aw=indwgt], by(year educ_grp)

reshape wide stdresid, i(year) j(educ_grp)

* normalize the residual data
forvalues i = 1/3{
	
	gen stdresid_norm`i' = stdresid`i'/stdresid`i'[1]
	
}


graph twoway (connected stdresid_norm1 year) (connected stdresid_norm2 year) (connected stdresid_norm3 year), ///
             legend(label(1 "High School and less") label(2 "Some College and College Degree") label(3 "Graduate School"))	///
			 title("Standard Deviation for Different Educational Group")
			 
**/

*********************************************************************************************************************
* 2			 	
		
// graph twoway (connected residual year) if x11101ll == 826001, sch(economist)


*********************************************************************************************************************
* 3. Aggregate the educational group into three groups in a different way
/* generate educ_grp2 = educgrp
recode educ_grp2 (1/2=1) (3/4=2) (5/6=3)

label define lbl_educ2 1 "Less than High School" 2 "High School or Some College" 3 "BA or Higher"
label value educ_grp2 lbl_educ2


/* This part is to generate some plot
collapse (sd) stdresid = residual [aw=indwgt], by(year educ_grp2)

reshape wide stdresid, i(year) j(educ_grp2)

* normalize the residual data
forvalues i = 1/3{
	
	gen stdresid_norm`i' = stdresid`i'/stdresid`i'[1]
	
}


graph twoway (connected stdresid_norm1 year) (connected stdresid_norm2 year) (connected stdresid_norm3 year), ///
             legend(label(1 "Less than High School") label(2 "High School or Some College") label(3 "BA or Higher"))	///
			 title("Standard Deviation for Different Educational Group")
			 
**/



