/*****************************************************************/
/* Do file for Section 1: Introduction and Descriptive Statistics */

// Section 1.2: Displaying Data

/* overview of your data file */
sysuse auto.dta
edit
describe

/* nominal variable */
tabulate foreign, generate(f)

graph pie f1 f2

graph hbar (sum) f1 f2

drop f1 f2  

/* interval variable */
histogram gear_ratio, width(.2) start(2.0) frequency title("Histogram of gear_ratio")
