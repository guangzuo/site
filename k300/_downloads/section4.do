/*****************************************************************/
/* Do file for Section 4:  Linear Regression */

// Section 4.1: Simple Linear Regression
/* clear the current data in memory */
clear all
/* set the path to the folder where you download the data file */
cd (...) // fill (...) with the folder where holds the data file
/* load the 'dog_fear' data */
use depression_alcohol.dta
/* inspect your data */
edit

/* generate scatter plot and best fitting line  */
graph twoway (scatter alcohol depression) (lfit depression alcohol)

/* conduct linear regression */
regress alcohol depression

// Section 4.2: Multiple Linear Regression and ANOVA
clear all
/* set the path to the folder where you download the data file */
cd (...) // fill (...) with the folder where holds the data file
/* Shoplifting Vs Music Type (One-Way Between ANOVA and Linear Regression)*/
use between_regression.dta
/* inspect your data */
edit

// conduct one way between anova
anova shoplifting music

// linear regression
xi : regress shoplifting i.music

// testing whether music type affects shoplifting
test _Imusic_2 _Imusic_3

/* Shoplifting Vs Music Type (One-Way Between ANOVA and Linear Regression)*/
use within_regression.dta
/* inspect your data */
edit

// conduct one way within anova
anova shoplifting music participant, repeated(music)

// linear regression
xi : regress shoplifting i.music i.participant
// testing whether music type affects shoplifting
test _Imusic_2 _Imusic_3
