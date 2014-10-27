/*****************************************************************/
/* Do file for Section 2:  t Test Flavors*/

// Section 2.1: Single Sample t Test
/* clear the current data in memory */
clear all
/* set the path to the folder where you download the data file */
cd (...) // fill (...) with the folder where holds the data file
/* load the 'pay per can' data */
use pay_per_can.dta
/* inspect your data */
edit
/* conduct single sample t test */
ttest weight == 47


// Section 2.2: Within Subject t Test
/* clear the current data in memory */
clear all
/* load the 'hypnosis' data */
use hypnosis.dta
/* inspect your data */
edit
/* conduct within subject t test */
ttest After_Treatment == Before_Treatment


// Section 2.3: Between Subject t Test
/* clear the current data in memory */
clear all
/* load the 'hiccups' data */
use hiccups.dta
/* inspect your data */
edit
/* conduct between subject t test */
ttest hiccup, by(medicine)

// Section 2.3: Label Your Independent Variable
label define med_label 0 "placebo" 1 "new drug"
label values medicine med_label
/* inspect your data */
edit
/* conduct between subject t test */
ttest hiccup, by(medicine)





