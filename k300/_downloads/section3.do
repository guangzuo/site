/*****************************************************************/
/* Do file for Section 3:  Analysis of Variance (ANOVA) */

// Section 3.1: One-way Between-Subject ANOVA
/* clear the current data in memory */
clear all
/* set the path to the folder where you download the data file */
cd (...) // fill (...) with the folder where holds the data file
/* load the 'dog_fear' data */
use dog_fear.dta
/* inspect your data */
edit

/* add label to variable "dog_size" */
label define dog 0 "Small" 1 "Medium" 2 "Large", replace
label values dog_size dog

/* conduct one-way between-subject ANOVA test */
oneway fear dog_size

/* post-hoc test: Bonferroni and Scheffe */
oneway fear dog_size, bonferroni scheffe

/* more powerful command to do ANOVA test */
anova fear dog_size

/* install "tukeyhsd" */
findit tukeyhsd
findit qsturng
tukeyhsd dog_size


// Section 3.2: One-way Within-Subject ANOVA
/* clear the current data in memory */
clear all
/* load the 'memory' data */
use memory.dta
/* inspect your data */
edit

/* add labels to our variables */
label define part 1 "A" 2 "B" 3 "C" 4 "D" 5 "E" 6 "F", replace
label values participant part

label define pic 0 "Negative" 1 "Neutral" 2 "Positive", replace
label values picture pic

/* conduct one-way witin-subject ANOVA test */
anova recall participant picture, repeated(picture)

/* Tukey HSD post-hoc test */
tukeyhsd picture

// Section 3.3: Two-way Between-Subject ANOVA
/* clear the current data in memory */
clear all
/* load the 'decision' data */
use decision.dta
/* inspect your data */
edit

/* add labels to our variables */
label define factor_A 0 "conscious" 1 "unconscious", replace
label values conscious_A factor_A

label define factor_B 0 "low" 1 "medium" 2 "high", replace
label values complexity_B factor_B

/* conduct two-way between-subject ANOVA test */
anova decision conscious_A##complexity_B

/* mean plot to see interaction effect */
predict yhat   // generate means for each group
graph twoway (connect yhat complexity_B if conscious_A == 0) ///
	(connect yhat complexity_B if conscious_A == 1), ///
	legend(label (1 conscious) label(2 unconscious))


// Section 3.4: Three-way Between-Subject ANOVA
clear all

use decision_2.dta
/* inspect your data */
edit

/* add labels to our variables */
label define factor_C 0 "male" 1 "female", replace
label values sex_C factor_C

/* conduct three-way between-subject ANOVA test */
anova decision conscious_A##complexity_B##sex_C

/* three way interaction */

predict yhat  // generate means for each group
graph twoway (connect yhat complexity_B if conscious_A == 0 & sex_C == 0) ///
	(connect yhat complexity_B if conscious_A == 1 & sex_C == 0), ///
	legend(label (1 conscious) label(2 unconscious)) ///
	title("Male") saving(male)
	
graph twoway (connect yhat complexity_B if conscious_A == 0 & sex_C == 1) ///
	(connect yhat complexity_B if conscious_A == 1 & sex_C == 1), ///
	legend(label (1 conscious) label(2 unconscious)) ///
	title("Female") saving(female)
	
graph combine male.gph female.gph
	
	



