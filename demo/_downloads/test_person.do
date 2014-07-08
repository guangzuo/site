// single test one individual
// Date: Apr.23, 2014
// Author: Guang Zuo
**********************************************************************************************************************
* 1. Keep the data for one specific person
** 1.1 Try x11101ll == 250001       white construction 25yrs since 1968
** 1.2 Try x11101ll == 2334004      white manufacturing 20yrs since 1968
** 1.3 Try x11101ll == 4003         white male 20yrs since 1972  educ = 9 years
** 1.4 Try x11101ll == 5003         white male 21yrs since 1983  educ = 12 years worked in manufacturing
** 1.5 Try x11101ll == 7003         white male 19yrs since 1973  educ = 12 years worked in manufacturing
**                                        becomes employed bt year 1981(26yrs) and 1986(31yrs) and started 
**                                        the job in manufacturing in year 1989 and then became permanently
**                                        disable since year 1997 (42yrs), miserable life
** 1.6 Try x11101ll == 13001        white male 42yrs since 1971  educ = 11 years worked in manufacturing and trade
**                                        he is lucky that he can hang in there (manufacturing) till 1983(54) and 
**                                        early retired in 1992 when he was 63yrs old
** 1.7 Try x11101ll == 18004        white male 20yrs since 1972  educ = 12 years worked in manufacturing till 1981
**                                        he then became construction worker since 1981, and income has declined 
**                                        dramatically (definitely an example of permanent shock)      
** 1.8 Try x11101ll == 18005        white male 19yrs since 1971  educ = 12 years worked in manufacturing his life time
**                                        till 1999 (46yrs), he then was laid off and engaged in agriculture activity.
**                                        this guy is so stubborn to hold on to manufacturing, a dying industry.
** 1.9 Try x11101ll == 40001        white male 38yrs since 1971  educ = 12 years worked in manufacturing till early 
**                                        retire in 1985 when he was just 54 yrs old. (an example failing to adapt the 
**                                        new economy)
** 1.10 Try x11101ll == 122004      white male 18yrs since 1985  educ = 12 years. He experienced the post-informational 
**                                        era where the world is more uncertain. 
** 1.11 Try x11101ll == 459001      white male 37yrs since 1971  educ = 12 years. He did really take the hit of inforrmational
**                                        revoluation, so if you look at his income profile, it shows to be very stable and
**                                        definitely less uncertainty.
** 1.12 Try x11101ll == 284001      white male 39yrs since 1971  educ = 16 years. He started his life in professional service
**                                        and really enjoy a decent life and retire when he was 60yrs in 1992.
** 1.13 Try x11101ll == 997003      white male 35yrs since 1977 educ = 12 years. He experienced the post-informational 
**                                        era where the world is more uncertain. 



clear
use psid_combined.dta
keep  if x11101ll == 5005
rename sex1968 sex

drop *1968 *1969 *1970
**********************************************************************************************************************
* 2. Reshape wide into long data
reshape long  x11102_ xsqnr_ age educ race indwgt empstatus industry relation inchead incwife wagehead faminc ///
              famwgt region homeowner housevalue familysize CPIURS, i(x11101ll sex) j(year)

// 2.1 generate real wage and real house value
gen real_wagehead = wagehead/CPIURS			  
gen real_housevalue = housevalue/CPIURS

**********************************************************************************************************************
* 3. plot the data to explore
// 3.1 real wage VS age
clear
use tmp_unbalanced.dta
edit

keep  if x11101ll == 6006

drop if year < 1981

graph twoway scatter real_wagehead age, name(pic4, replace)

graph twoway scatter real_faminc year, name(pic5, replace)
graph twoway scatter real_housevalue year, name(pic5, replace)

graph twoway scatter real_wagehead year, name(pic6, replace) 

* graph combine pic4 pic5 pic6

// 3.2 age VS year
graph twoway scatter age year

// 3.3 real house value VS age
graph twoway (scatter real_housevalue year, yaxis(1)) (scatter real_wagehead year, yaxis(2))


// 3.4 real house value VS real wage
graph twoway scatter real_housevalue real_wagehead








