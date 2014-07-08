** This do file is to figure out individual's earning profile **
** Date: July 3, 2014 
** Author: Guang Zuo
*********************************************************************************************************************
* 1. import the data
clear
use tmp_unbalanced.dta

*********************************************************************************************************************
* 2. clean the data following Lochner(2014)
** 2.1 exclude individuals with zero weights
drop if indwgt == 0

** 2.2 keep the head of the family
keep if relation == 1 | relation == 10

** 2.3 aged from 30-59
keep if age >= 30 & age <= 83

** 2.4 keep those who have positive wage and salary income
keep if real_wagehead > 0

** 2.5 keep those who were not enrolled as a student
drop if empstatus == 5 & year <= 1975
drop if empstatus == 7 & year >= 1976

** 2.7 keep those who have at least two consecutive earning observations following Lopez-Daneri(2013)
by x11101ll: egen totl = count(x11101ll)
drop if totl < 2

** 2.8 keep those who have no missing values for years of education following Lopez-Daneri(2013)
drop if educ == 9 & year <= 1974
drop if educ == 9 & year >= 1985 & year <= 1990
drop if educ == 99 & year >= 1975 & year <= 1984
drop if educ == 99 & year >= 1991 & year <= 2011

** 2.9 exclude those from any PSID oversamples (SEO, Latino)
keep if coreid <= 3000

*********************************************************************************************************************
* 3. recode the data
** 3.1 create categorical variable regarding educational attainment
generate educgrp = educ
recode educgrp (min/2=1) (3=2) (4=3) (5/6=4) (7=5) (8=6) if year <= 1974
recode educgrp (min/2=1) (3=2) (4=3) (5/6=4) (7=5) (8=6) if year >= 1985 & year <= 1990
recode educgrp (min/8=1) (9/11=2) (12=3) (13/15=4) (16=5) (17=6) if year >= 1975 & year <= 1984
recode educgrp (min/8=1) (9/11=2) (12=3) (13/15=4) (16=5) (17=6) if year >= 1991

label define educ_lbl 1 "Elementary School" 2 "Some Hish School" 3 "High School Graduate" 4 "Some College"  ///
                      5 "College Graduate" 6 "Graduate School"
label value educgrp educ_lbl

** 3.2 generate the variable regarding individual's year of birth
by x11101ll: generate birth = year[1]-age[1]

** 3.3 focus on the hinderland in US
keep if region == 1 | region == 2 | region == 3 | region == 4
label define region_lbl 1 "Northeast" 2 "North Central" 3 "South" 4 "West"
label value region region_lbl

** 3.4 create categorical variable regarding the industry that heads were in 
gen industry_grp =  industry
recode industry_grp (17/28=1) (47/57=2) (67/77=3) (107/398=4) if year <= 2001
recode industry_grp (17/29=1) (37/49=2) (77=3) (107/399=4) if year >= 2003
replace industry_grp = 5 if (industry_grp ~= 1) & (industry_grp ~= 2) & (industry_grp ~= 3) & (industry_grp ~= 4)

label define ind_lbl 1 "Agriculture" 2 "Mining" 3 "Constructing" 4 "Manufacturing" 5 "Others"
label value industry_grp ind_lbl


*********************************************************************************************************************
* 4. inspect the earning profile
** 4.1 redefine the age
* suppose individual's working life is from 30 ~ 65, retirement life is from 66 ~ 83
* redefine variable j (period) so that j = 1 ~ 36 is for age 30 ~ 65; 
*                                      j = 37 ~ 54 is for age 66 ~ 83
gen j = age - 29
gen j2 = j^2
gen j3 = j^3

** 4.2 generate log wage variable
gen log_real_wagehead = log(real_wagehead)


** some inspection of the data
kdensity log_real_wagehead [aw = indwgt], normal

** regress log_real_wagehead ~ j + j^3 + educational dummies
regress log_real_wagehead j j2 if j <= 36 [pw=indwgt]
predict fv
graph twoway (scatter fv j if j <= 36)

** get the residual of the linear regression
predict res, residual
kdensity res if j <= 36 [aw = indwgt], normal












