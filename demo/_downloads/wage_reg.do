** This do file is to run a standard Mincerian wage regression **
** Date: May 19, 2014 
** Author: Guang Zuo
clear
use wage_reg.dta


*********************************************************************************************************************
* 1. A standard Mincerian wage regression following Lochner(2014)
sort year x11101ll

** regress log_real_wagehead against age + age3 + educational dummies
gen residual = . // generate a place to hold residuals

levelsof year, local(lvls)
foreach l of local lvls {
	regress log_real_wagehead age age3 i.educgrp if year == `l' [pw=indwgt]
	predict res_`l' if year == `l', residual
	replace residual = res_`l' if year == `l'
	drop res_`l'
}


save wage_reg_resid.dta, replace
