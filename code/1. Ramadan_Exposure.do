
clear all
set more off

* Restricted CBS source directories
global cbs_gba    "PATH_TO_CBS_GBAPERSOONTAB"
global cbs_parent "PATH_TO_CBS_KINDOUDERTAB"

cd "$data\1. Ramadan_exposure"


* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block A: **** Ramadan exposure identification ****
* ----------
* --------------------------------------------------------------------------------------------------------------------


*** Step 1: Calulation of the start and end dates of Ramadan, from which the overlap of the gestational period and Ramadan can later be determined
* --------------------------------------------------------------------------------------------------------------------

use ramadan_dates, clear
sort start_date
gen i = 1
gen n = _n
keep start_date i n
reshape wide start_date, i(i) j(n)
drop i
save startdate, replace

use ramadan_dates, clear
sort end_date
gen i = 1
gen n = _n
keep end_date i n
reshape wide end_date, i(i) j(n)
drop i
save enddate, replace

clear


*** Step 2: Generating a macrothat covers the number of days between {01.01.1916 and 31.12.2025}. 
* --------------------------------------------------------------------------------------------------------------------

dis date("12/31/2025", "MDY") - date("1/1/1916", "MDY")

local range 40177
set obs `range'

gen date = date("1/1/1916", "MDY") - 1 + _n

sort date


*** Step 3:  Calculating the number of days that the previous Ramadan ends and starts before a person' birth. 
* --------------------------------------------------------------------------------------------------------------------

** 3.a. End date of last Ramadan BEFORE birth
cross using enddate

//How long ago did each Ramadan ends?
forvalues i = 1/115 {
	quietly gen endago`i' = date - end_date`i'
	}
	
// We are now looking for the relevant Ramadan, which was the last one to end BEFORE the person's birth. Therefore, we take the minimum from all just created variables, but leave those out with a negative value (i.e. those that ended AFTER the birth.
forvalues i = 1/115 {
	quietly replace endago`i' = 9999999 if endago`i' < 0
	}
// The Ramadan that was the last one to end BEFORE the person's birth is the minimum number of days created 
gen ramendmin = min(endago1,endago2,endago3,endago4,endago5,endago6,endago7,endago8,endago9,endago10,endago11,endago12,endago13,endago14,endago15,endago16,endago17,endago18,endago19,endago20,endago21,endago22,endago23,endago24,endago25,endago26,endago27,endago28,endago29,endago30,endago31,endago32,endago33,endago34,endago35,endago36,endago37,endago38,endago39,endago40,endago41,endago42,endago43,endago44,endago45,endago46,endago47,endago48,endago49,endago50,endago51,endago52,endago53,endago54,endago55,endago56,endago57,endago58,endago59,endago60,endago61,endago62,endago63,endago64,endago65,endago66,endago67,endago68,endago69,endago70,endago71,endago72,endago73,endago74,endago75,endago76,endago77,endago78,endago79,endago80,endago81,endago82,endago83,endago84,endago85,endago86,endago87,endago88,endago89,endago90,endago91,endago92,endago93,endago94,endago95,endago96,endago97,endago98,endago99,endago100,endago101,endago102,endago103,endago104,endago105,endago106,endago107, endago108,endago109,endago110, endago111, endago112, endago113, endago114, endago115)

// Calculating the last day of Ramadan  that occured BEFORE the person's birth.
gen ramenddat = .
forvalues i = 1/115 {
	quietly replace ramenddat = end_date`i' if ramendmin == endago`i'
	}
replace ramenddat = . if ramendmin == 9999999 

** 3.b. Start date of Ramadan BEFORE birth(For explanation, see "a. End date of last Ramadan BEFORE birth ": the start follows the same logic.)*/
cross using startdate

//How long ago did each Ramadan starts BEFORE birth?
forvalues i = 1/115 {
	quietly gen startago`i' = date - start_date`i'
	}
forvalues i = 1/115 {
	quietly replace startago`i' = 9999999 if startago`i' < 0
		}
gen ramstartmin = min(startago1,startago2,startago3,startago4,startago5,startago6,startago7,startago8,startago9,startago10,startago11,startago12,startago13,startago14,startago15,startago16,startago17,startago18,startago19,startago20,startago21,startago22,startago23,startago24,startago25,startago26,startago27,startago28,startago29,startago30,startago31,startago32,startago33,startago34,startago35,startago36,startago37,startago38,startago39,startago40,startago41,startago42,startago43,startago44,startago45,startago46,startago47,startago48,startago49,startago50,startago51,startago52,startago53,startago54,startago55,startago56,startago57,startago58,startago59,startago60,startago61,startago62,startago63,startago64,startago65,startago66,startago67,startago68,startago69,startago70,startago71,startago72,startago73,startago74,startago75,startago76,startago77,startago78,startago79,startago80,startago81,startago82,startago83,startago84,startago85,startago86,startago87,startago88,startago89,startago90,startago91,startago92,startago93,startago94,startago95,startago96,startago97,startago98,startago99,startago100,startago101,startago102,startago103,startago104,startago105,startago106,startago107,startago108,startago109,startago110,startago111,startago112,startago113,startago114,startago115)

// What was the first day of Ramadan that occured BEFORE the person's birth?
gen ramstartdat = .
forvalues i = 1/115 {
	quietly replace ramstartdat = start_date`i' if ramstartmin == startago`i'
	}
	

// HOW LONG (in DAYS) WAS THE RELEVANT RAMADAN?
forvalues i = 1/115 {
	gen lengthRam`i' = end_date`i' - start_date`i' + 1
	}
gen lengthRam = .
forvalues i = 1/115 {
	quietly replace lengthRam = lengthRam`i' if ramendmin == endago`i' & (ramstartmin > ramendmin)
	}
forvalues i = 1/115 {
	replace lengthRam = lengthRam`i' if ramstartmin == startago`i' & (ramstartmin < ramendmin| ramendmin == 0)
	}
	
format ramenddat %d
format ramstartdat %d

*** Step 4: Identifying different categories of Ramadan exposure, including 2 versions: (1) "ram_cat" from van ewijk (2011); (2) "ram_cat_reproduction" used for Project 1.3 - Reproductive Health, which is based on the developmental proccess of human reproduction
* --------------------------------------------------------------------------------------------------------------------


* For those who were born during Ramadan, we need to look at the Ramadan that was the last one to START before birth. 
* For all others, we need to look at the Ramadan that was the last one to END before birth.

drop end_date1-end_date115 endago1-endago115
drop start_date1-start_date115 startago1-startago115
drop lengthRam1-lengthRam115

*********** van Ewijk 2011 ******************
* Different categories of exposure are divided: 1. COMPLETE RAMADAN DURING PREGNANCY; 2. NO RAMADAN DURING PREGNANCY; 3. BORN DURING RAMADAN and 4. CONCEIVED DURING RAMADAN (3. and 4. are partly exposed to Ramadan).

gen completeRam = 0 if date ~= .
gen noRam = 0 if date ~= .
gen bornRam = 0 if date ~= .
gen concRam = 0 if date ~= .

drop if ramendmin == 9999999

* Situation 1: complete Ramadan during pregnancy (i.e. BOTH the end, AND the start of Ramadan fell during pregnancy = within 266 days before birth).
replace completeRam = 1 if ramendmin < 266 & ramstartmin < 266
// This group includes those who were born on the date that Ramadan ends (ramendmin ==0) until those were born 237 days after that (ramendmin==237)
// Note that in this group, ramendmin < ramstartmin

// the number of Ramadan days overlap with pregnancy
gen numRam = lengthRam if completeRam == 1

* Situation 2: no Ramadan during pregnancy (i.e. both end, and start of Ramadan fell before pregnancy, i.e. > 266 days before birth.
replace numRam = 0 if ramendmin > 265 & ramstartmin > 265
replace noRam = 1 if ramendmin > 265 & ramstartmin > 265
replace numRam = 0 if noRam == 1
// Note that in this group, ramendmin < ramstartmin

* Situation 3: only the first part of Ramadan fell during pregnancy = born during Ramadan. (it is assumed that the mother could still have fasted on the day of delivery.)
replace bornRam = 1 if ramendmin > ramstartmin | ramendmin == 0
replace numRam = ramstartmin + 1 if bornRam == 1
// Note that in this group, ramendmin > ramstartmin, we need to look at the Ramadan that was the last one to START before birth. 
// This group also includes those who were born on the LAST day of the relevant Ramadan (completeRam == bornRam ==1)

* Situation 4: only end part of Ramadan during pregnancy = conceived during Ramadan. For these children, the end of last Ramadan was less than 266 days before birth. If the relevant Ramadan lasted e.g. 30 days, then the end of Ramadan was between 266 and (266-30) days before birth.*/

//For children who were conceived during Ramadan, the relevant Ramadan is not the one with the starting date that is closest to the date of birth, but the Ramadan with the END date that is closest BEFORE the date of birth.
replace concRam = 1 if ramendmin < 266 & (ramendmin >= (266 - lengthRam))
replace numRam = 266 - ramendmin if concRam == 1
// This group include also those who were conceived on the FIRST day of Ramadan were also exposed completely to Ramadan (completeRam == concRam ==1)


/* PREGNANCY IN TRIMESTERS - Those who were exposed to ramadan during the whole pregnancy (Situation 1 - completeRam == 1)
Trimester 1: day 1-89		(255 - 177 days before birth)
Trimester 2: day 90-178		(176 - 88 days before birth)
Trimester 3: day 179-266	(87 - 0 days before birth)
N.B. Trimester 3 is 88 days and trimester 1 and 2 are both 89 days.*/
/* Situation 1a: If Ramadan overlapped with pregnancy, it completely fell in trimester 1.*/
gen numtr1 = numRam if ramstartmin < 265 + lengthRam & ramendmin > 176
gen numtr2 = 0 if ramstartmin < 265 + lengthRam & ramendmin > 176
gen numtr3 = 0 if ramstartmin < 265 + lengthRam & ramendmin > 176
replace numtr1 = numRam if concRam == 1

/* Situation 1b: If Ramadan overlapped with pregnancy, it completely fell in trimester 2.*/
replace numtr1 = 0 if ramstartmin < 177 & ramendmin > 87
replace numtr2 = numRam if ramstartmin < 177 & ramendmin > 87
replace numtr3 = 0 if ramstartmin < 177 & ramendmin > 87

/* Situation 1c: If Ramadan overlapped with pregnancy, it completely fell in trimester 3.*/
replace numtr1 = 0 if ramstartmin < 88
replace numtr2 = 0 if ramstartmin < 88
replace numtr3 = numRam if ramstartmin < 88

/* Situation 1d: Ramadan fell partially in trimester 1 and partially in trimester 2.*/
replace numtr1 = ramstartmin - 176 if ramstartmin > 176 & ramendmin < 177
replace numtr2 = 177 - ramendmin if ramstartmin > 176 & ramendmin < 177
replace numtr3 = 0 if ramstartmin > 176 & ramendmin < 177

/* Situation 1e: Ramadan fell partially in trimester 2 and partially in trimester 3.*/
replace numtr1 = 0 if ramstartmin > 87 & ramendmin < 88
replace numtr2 = ramstartmin - 87 if ramstartmin > 87 & ramendmin < 88
replace numtr3 = 88 - ramendmin if ramstartmin > 87 & ramendmin < 88

/* Situation 1f: Pregnancy did not overlap with Ramadan (noRam ==1).*/
replace numtr1 = 0 if numRam == 0
replace numtr2 = 0 if numRam == 0
replace numtr3 = 0 if numRam == 0

assert noRam ==1 if numtr1 ==0 & numtr2 ==0 & numtr3==0

*** Among those who were not exposed to Ramadan (noRam ==1) ***
/* Certainly NOT exposed - those who at every circumstances NOT exposed */
gen cf = 0
replace cf = 1 if ramendmin > 285 & ramstartmin > 265

/* Probably NOT exposed - those who were conceived less than 21 days after the end of relevant Ramadan */
gen dum1_cf = 0
replace dum1_cf = 1 if cf == 0 & noRam == 1

*** Among those who were exposed to Ramadan either partly or completely  
gen certainly = 1-cf
replace certainly = 0 if dum1_cf == 1
rename dum1_cf probnot
renam cf certnot

assert probnot==0 if certainly ==1

* The variables below indicate whether Ramadan started in trimester 1, trimester 2 or trimester 3.
capture drop ramstarttr1 ramstarttr2 ramstarttr3
gen ramstarttr1 = 0
gen ramstarttr2 = 0
gen ramstarttr3 = 0
replace ramstarttr1 = 1 if numtr1 > 0 & concRam == 0
replace ramstarttr2 = 1 if numtr2 > 0 & numtr1 == 0
replace ramstarttr3 = 1 if numtr3 > 0 & numtr2 == 0 & bornRam == 0
// drop numtr* ramstartmin ramendmin  lengthRam completeRam noRam 

label var certnot "Certainly NOT exposed"
label var probnot "Probably NOT exposed"

label var certainly "Certainly Ram.during preg."
label var bornRam "Born during Ramadan"
label var ramstarttr3 "Ram. started in tr.3"
label var ramstarttr2 "Ram. started in tr.2"
label var ramstarttr1 "Ram. started in tr.1"
label var concRam "Conceived during Ramadan"
label var numRam "Number of Ram. days overlap with pregnancy"

gen ram_cat = .
replace ram_cat = 0 if certnot == 1
replace ram_cat = 1 if ramstarttr1 == 1
replace ram_cat = 2 if ramstarttr2 == 1
replace ram_cat = 3 if ramstarttr3 == 1
replace ram_cat = 4 if concRam == 1
replace ram_cat = 5 if bornRam == 1
replace ram_cat = 6 if probnot == 1

label define ram_cat 0 "Certainly NOT exposed" 1 "Ram. started in tr.1" 2 "Ram. started in tr.2" 3 "Ram. started in tr.3" 4 "Conceived during Ramadan" 5 "Born during Ramadan" 6 "Probably NOT exposed"
label value ram_cat ram_cat
label var ram_cat "Ramadan exposure categories of individual "

save Ramadan_exposure_final, replace

* Ramadan status of parents
use Ramadan_exposure_final, clear
rename(date - ram_cat_reproduction) (=_fa)
save Ramadan_exposure_final_fa, replace

use Ramadan_exposure_final, clear
rename(date - ram_cat_reproduction) (=_mo)
save Ramadan_exposure_final_mo, replace


* Ramadan status of children
use Ramadan_exposure_final, clear
rename(date - ram_cat_reproduction) (=_ch)
save Ramadan_exposure_final_child, replace

* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block B: **** Merging full date of birth & Ramadan exposure ****
* ----------
* --------------------------------------------------------------------------------------------------------------------


* --------------------------------------------------------------------------------------------------------------------
**** Step 1: Merging GBAPERSOONTAB from 2009 to 2024
* --------------------------------------------------------------------------------------------------------------------

* Year 2009
use "$cbs_gba\2009\geconverteerde data\GBAPERSOON2009TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

gen male = gbageslacht == "1"
lab var male "Male"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"


* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

destring mob yob, replace force

drop gbageboortedag gbageslacht


gen gba = 2009
lab var gba "Year of survey"
save gba_2009, replace


* Year 2010
use "$cbs_gba\2010\geconverteerde data\GBAPERSOON2010TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

gen male = gbageslacht == "1"
lab var male "Male"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"


drop gbageboortedag gbageslacht

* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

destring mob yob, replace force


gen gba = 2010
lab var gba "Year of survey"
save gba_2010, replace

* Year 2011
use "$cbs_gba\2011\geconverteerde data\GBAPERSOON2011TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

gen male = gbageslacht == "1"
lab var male "Male"


rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

drop gbageboortedag gbageslacht

* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

destring mob yob, replace force


gen gba = 2011
lab var gba "Year of survey"
save gba_2011, replace


* Year 2012
use "$cbs_gba\2012\geconverteerde data\GBAPERSOON2012TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

gen male = gbageslacht == "1"
lab var male "Male"


rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"



drop gbageboortedag gbageslacht

* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

destring mob yob, replace force


gen gba = 2012
lab var gba "Year of survey"
save gba_2012, replace


* Year 2013
use "$cbs_gba\2013\geconverteerde data\GBAPERSOON2013TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

gen male = gbageslacht == "1"
lab var male "Male"


rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

destring mob yob, replace force

* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2013
lab var gba "Year of survey"


drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht
save gba_2013, replace



* Year 2014
use "$cbs_gba\2014\geconverteerde data\GBAPERSOON2014TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"


* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2014
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht

destring mob yob, replace force
save gba_2014, replace



* Year 2015
use "$cbs_gba\2015\geconverteerde data\GBAPERSOON2015TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"
rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"


* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2015
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht

destring mob yob, replace force
save gba_2015, replace



* Year 2016
use "$cbs_gba\2016\geconverteerde data\GBAPERSOONTAB 2016V1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 

rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"


gen gba = 2016
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht

destring mob yob, replace force
save gba_2016, replace

* Year 2017
use "$cbs_gba\2017\geconverteerde data\GBAPERSOON2017TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2017
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht

destring mob yob, replace force
save gba_2017, replace

* Year 2018
use "$cbs_gba\2018\geconverteerde data\GBAPERSOON2018TABV2", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"


* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2018
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht

destring mob yob, replace force
save gba_2018, replace



* Year 2019
use "$cbs_gba\2019\geconverteerde data\GBAPERSOON2019TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"


* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2019
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht

destring mob yob, replace force
save gba_2019, replace



* Year 2020
use "$cbs_gba\2020\geconverteerde data\GBAPERSOON2020TABV3", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

* Migration background: CBS definition
rename gbaherkomstgroepering origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2020
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht gbaimputatiecode

destring mob yob, replace force
save gba_2020, replace


* Year 2021
use "$cbs_gba\2021\geconverteerde data\GBAPERSOON2021TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"

rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

* Migration background: CBS definition
// from 2021, gbaherkomstland, instead of gbaherkomstgroepering is the CBS definition of migration background
rename gbaherkomstland origin 
lab var origin "Migration background (CBS definition)" 

rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2021
lab var gba "Year of survey"

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht gbageboortelandnl gbaherkomstgroepering gbaimputatiecode

destring mob yob, replace force
save gba_2021, replace


* Year 2022
use "$cbs_gba\2022\geconverteerde data\GBAPERSOON2022TABV1", clear

rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"
rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

* Migration background: CBS definition
// from 2021, gbaherkomstland, instead of gbaherkomstgroepering is the CBS definition of migration background
rename gbaherkomstland origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2022
lab var gba "Year of survey"


tab gbaimputatiecode 


gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht gbageboortelandnl gbaherkomstgroepering gbaimputatiecode

destring mob yob, replace force
save gba_2022, replace

* Year 2023
use "$cbs_gba\2023\geconverteerde data\GBAPERSOON2023TABV1", clear

rename GBAGEBOORTELAND  birth_country
lab var birth_country "Country of birth"

rename GBAGEBOORTELANDMOEDER mother_birth_country
lab var mother_birth_country "Mother's country of birth"
rename  GBAGEBOORTELANDVADER  father_birth_country
lab var father_birth_country "Father's country of birth"

rename GBAGEBOORTEJAAR  yob
lab var yob "Year of birth"

rename GBAGEBOORTEMAAND  mob
lab var mob "Month of birth"

* Migration background: CBS definition
// from 2021, gbaherkomstland, instead of gbaherkomstgroepering is the CBS definition of migration background
rename GBAHERKOMSTLAND  origin 
lab var origin "Migration background (CBS definition)" 


rename GBAGENERATIE  generation
lab var generation "Generation of migration" 


rename GBAAANTALOUDERSBUITENLAND abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2023
lab var gba "Year of survey"



gen male = GBAGESLACHT == "1"
lab var male "Male"

drop GBAGESLACHT GBAHERKOMSTGROEPERING GBAGEBOORTEDAG GBAGESLACHTMOEDER GBAGESLACHTVADER GBAIMPUTATIECODE GBAGEBOORTEDAGMOEDER GBAGEBOORTELANDNL GBAGEBOORTEDAGVADER
rename RINPERSOONS rinpersoons
rename RINPERSOON rinpersoon

destring mob yob, replace force

rename GBAGEBOORTEJAARMOEDER yob_mother
lab var yob_mother "Mother's year of birth"
rename GBAGEBOORTEJAARVADER yob_father
lab var yob_father "Father's year of birth"
rename GBAGEBOORTEMAANDMOEDER mob_mother
rename GBAGEBOORTEMAANDVADER mob_father
lab var mob_mother "Mother's month of birth"
lab var mob_father "Father's month of birth"
save gba_2023, replace


* Year 2024
use "$cbs_gba\2024\geconverteerde data\GBAPERSOON2024TABV1", clear
rename gbageboorteland birth_country
lab var birth_country "Country of birth"

rename gbageboortelandmoeder mother_birth_country
lab var mother_birth_country "Mother's country of birth"
rename gbageboortelandvader father_birth_country
lab var father_birth_country "Father's country of birth"

rename gbageboortejaar yob
lab var yob "Year of birth"

rename gbageboortemaand mob
lab var mob "Month of birth"

* Migration background: CBS definition
// from 2021, gbaherkomstland, instead of gbaherkomstgroepering is the CBS definition of migration background
rename gbaherkomstland origin 
lab var origin "Migration background (CBS definition)" 


rename gbageneratie generation
lab var generation "Generation of migration" 


rename gbaaantaloudersbuitenland abroad_parents
lab var abroad_parents "Number of parents born abroad"

gen gba = 2024
lab var gba "Year of survey"


tab gbaimputatiecode 

gen male = gbageslacht == "1"
lab var male "Male"

drop gbageslachtmoeder gbageslachtvader gbageboortedagmoeder gbageboortedagvader gbageboortedag gbageslacht gbageboortelandnl gbaherkomstgroepering gbaimputatiecode

destring mob yob, replace force
save gba_2024, replace



* Merging:

use gba_2024, clear
merge 1:1 rinpersoon rinpersoons using gba_2023, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2022, nogen update  
merge 1:1 rinpersoon rinpersoons using gba_2021, nogen update // "update" missing values into the master data set without overwriting non-missing data in the master
merge 1:1 rinpersoon rinpersoons using gba_2020, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2019, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2018, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2017, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2016, nogen update force //"abroad_parents" was byte in the using data
merge 1:1 rinpersoon rinpersoons using gba_2015, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2014, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2013, nogen update

destring abroad_parents, replace
merge 1:1 rinpersoon rinpersoons using gba_2012, nogen update 
merge 1:1 rinpersoon rinpersoons using gba_2011, nogen update
merge 1:1 rinpersoon rinpersoons using gba_2010, nogen update force
merge 1:1 rinpersoon rinpersoons using gba_2009, nogen update force

tab gba

replace yob_mother = gbageboortejaarmoeder if yob_mother ==""
replace mob_mother = gbageboortemaandmoeder if mob_mother ==""
replace mob_father = gbageboortemaandvader if mob_father ==""
replace yob_father = gbageboortejaarvader if yob_father ==""
drop gbageboortejaarmoeder- gbageboortemaandvader


merge 1:1 rinpersoon rinpersoons using gba, nogen update force

forvalues year = 2009/2024 {
	erase gba_`year'.dta
}


*** Identify Muslim from "origin", CBS definition of migration ****
gen muslim_CBS = 0
replace muslim_CBS = 1 if origin == "5008" | origin == "5012" | origin == "5018" | origin == "5022" | origin == "5029"| origin == "5034"| origin == "5043"| origin == "5048"| origin == "5057"| origin == "5060"| origin == "5084"| origin == "5097"| origin == "5105"| origin == "6006"| origin == "6013"| origin == "6020"| origin == "6021"| origin == "6023"| origin == "6024"| origin == "6040"| origin == "6042"| origin == "6043"| origin == "6047"| origin == "6050"| origin == "6051"| origin == "6057"| origin == "6063"| origin == "7008"| origin == "7009"| origin == "7014"| origin == "7020"| origin == "7021"| origin == "7034"| origin == "7040"| origin == "7041"| origin == "7045"| origin == "7051"| origin == "7054"| origin == "7060"| origin == "7084"| origin == "9037"| origin == "9087"| origin == "9093"


gen origin_name = origin
replace origin_name = "Tunesië" if origin_name == "5008"
replace origin_name = "Iran" if origin_name == "5012"
replace origin_name = "Saoediarabië" if origin_name == "5018"
replace origin_name = "Marokko" if origin_name == "5022"
replace origin_name = "Mali" if origin_name == "5029"
replace origin_name = "Albanië" if origin_name == "5034"
replace origin_name = "Irak" if origin_name == "5043"
replace origin_name = "Jemen" if origin_name == "5048"
replace origin_name = "Bahrein" if origin_name == "5057"
replace origin_name = "Comoren" if origin_name == "5060"
replace origin_name = "Mayotte" if origin_name == "5084"
replace origin_name = "Azerbajdsjan" if origin_name == "5097"
replace origin_name = "Kosovo" if origin_name == "5105"
replace origin_name = "Libië" if origin_name == "6006"
replace origin_name = "Solia" if origin_name == "6013"
replace origin_name = "Mauritanië" if origin_name == "6020"
replace origin_name = "Kyrgyzstan" if origin_name == "6021"
replace origin_name = "Afganistan" if origin_name == "6023"
replace origin_name = "Indonesië" if origin_name == "6024"
replace origin_name = "Niger" if origin_name == "6040"
replace origin_name = "Jordanië" if origin_name == "6042"
replace origin_name = "Turkije" if origin_name == "6043"
replace origin_name = "Algerije" if origin_name == "6047"
replace origin_name = "Oezbekistan" if origin_name == "6050"
replace origin_name = "Sierra Leone" if origin_name == "6051"
replace origin_name = "Tadzjikistan" if origin_name == "6057"
replace origin_name = "Toerkmenistan" if origin_name == "6063"
replace origin_name = "Gambia" if origin_name == "7008"
replace origin_name = "Syrië" if origin_name == "7009"
replace origin_name = "Egypte" if origin_name == "7014"
replace origin_name = "Pakistan" if origin_name == "7020"
replace origin_name = "Senegal" if origin_name == "7021"
replace origin_name = "Soedan" if origin_name == "7034"
replace origin_name = "Guinee" if origin_name == "7040"
replace origin_name = "Maldiven" if origin_name == "7041"
replace origin_name = "Koeweit" if origin_name == "7045"
replace origin_name = "Oman" if origin_name == "7051"
replace origin_name = "Verenigde Arabische Emiraten" if origin_name == "7054"
replace origin_name = "Bangladesh" if origin_name == "7084"
replace origin_name = "Katar" if origin_name == "9037"
replace origin_name = "Djibouti" if origin_name == "9087"

// excluding Abania & Indonesia from Muslim group
replace muslim_CBS = 0 if origin == "5034" 
replace muslim_CBS = 0 if origin_name == "Indonesië"
lab var muslim_CBS "Muslim - CBS definition"

// Generate a muslim variable excluding high-income Muslim countries
gen muslim = muslim_CBS
replace muslim = 0 if  origin_name == "Turkije"
replace muslim = 0 if origin_name =="Bahrein"
replace muslim = 0 if origin_name =="Koeweit"
replace muslim = 0 if origin_name =="Gambia"
replace muslim = 0 if origin_name =="Katar"
replace muslim = 0 if origin_name =="Verenigde Arabische Emiraten"
replace muslim = 0 if origin_name =="Saoediarabië"
lab var muslim "Muslim (excl. High-income countries)"


* Identify Dutch background
gen dutch = 0
replace dutch = 1 if origin == "6030"
lab var dutch "Dutch background"


* Identify Non-Muslim migrants group
gen non_muslim = 0
replace non_muslim = 1 if dutch == 0 & muslim_CBS ==0

// Excluding high-income countries from the non_muslim group

replace origin_name = "Australië" if origin_name == "6016" 
replace origin_name = "België" if origin_name == "5010"
replace origin_name = "Brazilië" if origin_name == "6008"
replace origin_name = "Canada" if origin_name == "5001"
replace origin_name = "Chili" if origin_name == "5021"
replace origin_name = "China" if origin_name == "6022"
replace origin_name = "Denemarken" if origin_name == "5015"
replace origin_name = "Duitsland" if origin_name == "6029"
replace origin_name = "Estland" if origin_name == "7065"
replace origin_name = "Finland" if origin_name == "6002"
replace origin_name = "Frankrijk" if origin_name == "5002"
replace origin_name = "Griekenland" if origin_name == "6003"
replace origin_name = "Grootbrittannië" if origin_name == "6039"
replace origin_name = "Hongarije" if origin_name == "5017"
replace origin_name = "Ierland" if origin_name == "6007"
replace origin_name = "IJsland" if origin_name == "6011"
replace origin_name = "Israël" if origin_name == "6034"
replace origin_name = "Italië" if origin_name == "7044"
replace origin_name = "Japan" if origin_name == "7035"
replace origin_name = "Korea" if origin_name == "9068"
replace origin_name = "Letland" if origin_name == "7064"
replace origin_name = "Litouwen" if origin_name == "7066"
replace origin_name = "Luxemburg" if origin_name == "6018"
replace origin_name = "Mexico" if origin_name == "7006"
replace origin_name = "Nederland" if origin_name == "6030"
replace origin_name = "Nieuwzeeland" if origin_name == "5013"
replace origin_name = "Noorwegen" if origin_name == "6027"
replace origin_name = "Oostenrijk" if origin_name == "5009"
replace origin_name = "Polen" if origin_name == "7028"
replace origin_name = "Portugal" if origin_name == "7050"
replace origin_name = "Slovenië" if origin_name == "5049"
replace origin_name = "Slowakije" if origin_name == "6067"
replace origin_name = "Spanje" if origin_name == "6037"
replace origin_name = "Swaziland" if origin_name == "9036"
replace origin_name = "Tsjechië" if origin_name == "6066"
replace origin_name = "Verenigde Staten van Amerika" if origin_name == "6014"
replace origin_name = "Zweden" if origin_name == "5039"
replace origin_name = "Zwitserland" if origin_name == "5003"
replace origin_name = "Bondsrepubliek Duitsland" if origin_name == "9089" 
replace origin_name = "Zuidkorea" if origin_name == "6036"

// Additional high income countries
replace origin_name = "Hongkong" if origin_name == "7036" 
replace origin_name = "Monaco" if origin_name == "5032" 
replace origin_name = "Singapore" if origin_name == "5037" 
replace origin_name = "Taiwan" if origin_name == "5052" 

gen high_income = 0
replace high_income = 1 if real(origin_name) ==. & non_muslim ==1 & origin_name != "Albanië" & origin_name != "Indonesië"

// inclduing Aruba, Curacao, Bosnia_Herzegovina, South Africa  in the high-income group
replace high_income = 1 if origin == "6065" 
replace high_income = 1 if origin == "5014" 
replace high_income = 1 if origin == "5095" 
replace high_income = 1 if origin == "5107" 



replace non_muslim = 0 if high_income ==1

// Calculating the share of each non_muslim origin country within the non Muslim group
egen totalfreq = count(origin) if non_muslim ==1
bysort origin: egen origin_freq = count(origin) if non_muslim ==1
gen nomus_freq = origin_freq/totalfreq

// To see which origin country has the most share among the non-muslim sample
tab origin if nomus_freq > 0.01 & non_muslim ==1 

drop if origin == "0000"

replace origin_name = "Suriname" if origin_name == "5007"
replace origin_name = "Zuidafrika" if origin_name == "5014"
replace origin_name = "Ghana" if origin_name == "5024"
replace origin_name = "Filipijnen" if origin_name == "5027"
replace origin_name = "Colombia" if origin_name == "5033"
replace origin_name = "Rusland" if origin_name == "5053"
replace origin_name = "Aruba" if origin_name == "5095"
replace origin_name = "Curaçao" if origin_name == "5107"
replace origin_name = "Bosnië-Herzegovina" if origin_name == "6065"
replace origin_name = "Thailand" if origin_name == "7042"
replace origin_name = "India" if origin_name == "7046"
replace origin_name = "Viëtnam" if origin_name == "8024"
replace origin_name = "Servië" if origin_name == "5103"
replace origin_name = "Nigeria" if origin_name == "6005"
replace origin_name = "Oekraine" if origin_name == "6038"
replace origin_name = "Bulgarije" if origin_name == "7024"
replace origin_name = "Kaapverdië" if origin_name == "8025"
replace origin_name = "Dominicaanse Republiek" if origin_name == "7027"
replace origin_name = "Kroatië" if origin_name == "5051"
replace origin_name = "Etiopië" if origin_name == "5020"
replace origin_name = "Kroatië" if origin_name == "7047"
replace origin_name = "Nederlands Nieuwguinea" if origin_name == "7058"
replace origin_name = "Angola" if origin_name == "5026"
replace origin_name = "Libanon" if origin_name == "7043"
replace origin_name = "Eritrea" if origin_name == "9003" 
replace origin_name = "Nederlands Indië" if origin_name == "9030" // former colony of Netherlands (modern Indonesia)

* Generate another non_muslim variable excluding potential Muslim countries
gen non_muslim_exc = non_muslim
replace non_muslim_exc = 0 if origin_name == "Nederlands Indië" | origin_name == "Albanië" | origin_name == "Indonesië"
lab var non_muslim_exc "Non-Muslim excluding Albany, Indonesia, and Netherlands Indo"


lab var yob "Year of birth from GBA"
lab var mob "Month of birth from GBA"
lab var high_income "High-income countries"
lab var non_muslim "Non-Muslim migrants"

drop origin_freq nomus_freq totalfreq



save gba, replace

*** Step 2: Creating gba datasets for children, parents and grandparents
use gba, clear
rename  rinpersoons RINPERSOONSMa 
rename  rinpersoon RINPERSOONMa 
ren (birth_country-non_muslim_exc) (=_mo)
ren mother_birth_country_mo birth_country_grandmo_mo
ren father_birth_country_mo birth_country_grandfa_mo
ren abroad_parents_mo abroad_grandparents_mo
drop birth_country_mo yob_mo mob_mo male_mo
lab var birth_country_grandmo_mo "Maternal Grandmo's country of birth"
lab var birth_country_grandfa_mo "Maternal Grandfa's country of birth"
lab var abroad_grandparents_mo "Number of maternal grandparents born abroad"
lab var generation_mo "Mother's migration generation"
lab var origin_mo "Mother's origin"
lab var gba_mo "Year of survey (mother)"
lab var yob_mother_mo "Grandmo's year of birth (maternal)"
lab var mob_mother_mo "Grandmo's month of birth (maternal)"
lab var yob_father_mo "Grandfa's year of birth (maternal)"
lab var mob_father_mo "Grandfa's month of birth (maternal)"
ren yob_mother_mo yob_grandmo_mo
ren mob_mother_mo mob_grandmo_mo
ren yob_father_mo yob_grandfa_mo
ren mob_father_mo mob_grandfa_mo

save gba_mo, replace


use gba, clear
rename  rinpersoons RINPERSOONSpa 
rename  rinpersoon RINPERSOONpa 
ren (birth_country-non_muslim_exc) (=_fa)
ren mother_birth_country_fa birth_country_grandmo_fa
ren father_birth_country_fa birth_country_grandfa_fa
ren abroad_parents_fa abroad_grandparents_fa
drop birth_country_fa yob_fa mob_fa male_fa
lab var birth_country_grandmo_fa "Paternal Grandmo's country of birth"
lab var birth_country_grandfa_fa "Paternal Grandfa's country of birth"
lab var abroad_grandparents_fa "Number of paternal grandparents born abroad"
lab var generation_fa "Father's migration generation"
lab var origin_fa "Father's origin"
lab var gba_fa "Year of survey (father)"
lab var yob_mother_fa "Grandmo's year of birth (paternal)"
lab var mob_mother_fa "Grandmo's month of birth (paternal)"
lab var yob_father_fa "Grandfa's year of birth (paternal)"
lab var mob_father_fa "Grandfa's month of birth (paternal)"
ren yob_mother_fa yob_grandmo_fa
ren mob_mother_fa mob_grandmo_fa
ren yob_father_fa yob_grandfa_fa
ren mob_father_fa mob_grandfa_fa
save gba_fa, replace

*** Adding the children of individuals
use gba, clear
ren rinpersoons rinpersoonsChd
ren rinpersoon  rinpersoonChd
ren (birth_country-non_muslim_exc) (=_ch)
lab var birth_country_ch "Child's birth country"
lab var male_ch "Child is a male"
lab var  abroad_parents_ch "Number of parents born abroad (child)"
lab var generation_ch "Child's migration generation"
lab var origin_ch "Child's origin"
save gba_ch, replace

* Maternal Grandparents
use gba, clear
rename  rinpersoons RINPERSOONSGraMa_mo
rename  rinpersoon RINPERSOONGraMa_mo 
ren (birth_country-non_muslim_exc) (=_GraMa_mo)
lab var generation_GraMa_mo "Maternal Grandma's migration generation"
keep RINPERSOONSGraMa_mo RINPERSOONGraMa_mo birth_country_GraMa_mo generation_GraMa_mo muslim_CBS_GraMa_mo- non_muslim_exc_GraMa_mo
save gba_GraMa_mo, replace


use gba, clear
rename  rinpersoons RINPERSOONSGraPa_mo
rename  rinpersoon RINPERSOONGraPa_mo 
ren (birth_country-non_muslim_exc) (=_GraPa_mo)
lab var generation_GraPa_mo "Maternal Grandpa's migration generation"
keep RINPERSOONSGraPa_mo RINPERSOONGraPa_mo birth_country_GraPa_mo generation_GraPa_mo muslim_CBS_GraPa_mo-non_muslim_exc_GraPa_mo
save gba_GraPa_mo, replace

* Paternal grandparents
use gba, clear
rename  rinpersoons RINPERSOONSGraPa_fa
rename  rinpersoon RINPERSOONGraPa_fa
ren (birth_country-non_muslim_exc) (=_GraPa_fa)
lab var generation_GraPa_fa "Paternal Grandpa's migration generation"
keep RINPERSOONSGraPa_fa RINPERSOONGraPa_fa birth_country_GraPa_fa generation_GraPa_fa muslim_CBS_GraPa_fa- non_muslim_exc_GraPa_fa
save gba_GraPa_fa, replace

use gba, clear
rename  rinpersoons RINPERSOONSGraMa_fa
rename  rinpersoon RINPERSOONGraMa_fa 
ren (birth_country-non_muslim_exc) (=_GraMa_fa)
lab var generation_GraMa_fa "Paternal Grandma's migration generation"
keep RINPERSOONSGraMa_fa RINPERSOONGraMa_fa birth_country_GraMa_fa generation_GraMa_fa muslim_CBS_GraMa_fa- non_muslim_exc_GraMa_fa
save gba_GraMa_fa, replace

* --------------------------------------------------------------------------------------------------------------------
**** Step 3: Linking parents and children ****
* --------------------------------------------------------------------------------------------------------------------


clear
* Data set 2024
import spss using "$cbs_parent\KINDOUDER2024TABV1.sav"
drop XKOPPELNUMMER
save child_parent_2024 , replace

* Data set 2023
use "$cbs_parent\geconverteerde data\KINDOUDER2023TABV1.DTA", clear
drop xkoppelnummer
save child_parent_2023, replace

* Data set 2022
use "$cbs_parent\geconverteerde data\KINDOUDER2022TABV1.DTA", clear
drop xkoppelnummer
save child_parent_2022, replace

* Data set 2021
use "$cbs_parent\geconverteerde data\KINDOUDER2021TABV1.DTA", clear
drop xkoppelnummer
save child_parent_2021, replace

*** Note that the data in 2024 including all info from other previous years
erase child_parent_2023.dta
erase child_parent_2022.dta
erase child_parent_2021.dta

use child_parent_2024, clear


// Check the difference between child_parent (old data) and the new data:

*** Creating data sets to merge children & parents of the individual 

use child_parent_2024, clear
ren rinpersoons rinpersoonsChd_mo
ren rinpersoon  rinpersoonChd_mo
drop RINPERSOONSpa RINPERSOONpa
ren RINPERSOONSMa  rinpersoons
ren RINPERSOONMa  rinpersoon
save mother_child, replace

use child_parent_2024, clear
ren rinpersoons rinpersoonsChd_fa
ren rinpersoon  rinpersoonChd_fa
drop RINPERSOONSMa RINPERSOONMa
ren RINPERSOONSpa  rinpersoons
ren RINPERSOONpa rinpersoon
save father_child, replace

use child_parent_2024, clear
ren RINPERSOONMa RINPERSOONGraMa_mo
ren RINPERSOONSMa RINPERSOONSGraMa_mo
ren RINPERSOONpa RINPERSOONGraPa_mo
ren RINPERSOONSpa RINPERSOONSGraPa_mo
ren rinpersoons RINPERSOONSMa
ren rinpersoon RINPERSOONMa
save mother_grandparent, replace

use child_parent_2024, clear
ren RINPERSOONMa RINPERSOONGraMa_fa
ren RINPERSOONSMa RINPERSOONSGraMa_fa
ren RINPERSOONpa RINPERSOONGraPa_fa
ren RINPERSOONSpa RINPERSOONSGraPa_fa
ren rinpersoons RINPERSOONSpa
ren rinpersoon RINPERSOONpa
save father_grandparent, replace


**** Linking individuals and their parents + children 
use gba, clear

* Individuals with their parents
merge 1:1 rinpersoons rinpersoon using child_parent_2024, nogen keep (master match)

* Individuals with their children
// Female individuals
merge 1:m rinpersoons rinpersoon using mother_child, nogen keep (master match)
// Male individuals
merge m:m rinpersoons rinpersoon using father_child, nogen keep (master match)

* Individuals with their grandparents
// From mother side
merge m:m RINPERSOONSMa RINPERSOONMa using mother_grandparent, nogen keep (master match)
// From father side
merge m:m RINPERSOONpa RINPERSOONSpa using father_grandparent, nogen keep (master match)

keep if muslim_CBS == 1 | non_muslim_exc ==1

**** Merging the gba of parents and children ******

merge m:1 rinpersoonsChd rinpersoonChd using gba_ch, nogen keep(master match)
merge m:1 RINPERSOONSpa RINPERSOONpa using gba_fa, nogen keep(master match)
merge m:1 RINPERSOONSMa RINPERSOONMa using gba_mo, nogen keep(master match)
merge m:m RINPERSOONSGraMa_mo RINPERSOONGraMa_mo using gba_GraMa_mo, nogen keep(master match)
merge m:m RINPERSOONSGraPa_mo RINPERSOONGraPa_mo using gba_GraPa_mo, nogen keep(master match)
merge m:m RINPERSOONSGraMa_fa RINPERSOONGraMa_fa using gba_GraMa_fa, nogen keep(master match)
merge m:m RINPERSOONSGraPa_mo RINPERSOONGraPa_mo using gba_GraPa_mo, nogen keep(master match)

save gba_linked, replace

erase gba_ch.dta
erase gba_mo.dta
erase gba_fa.dta
erase gba_GraMa_mo.dta
erase gba_GraMa_fa.dta
erase gba_GraPa_fa.dta
erase gba_GraPa_mo.dta

* --------------------------------------------------------------------------------------------------------------------
**** Step 4: Merging Full DOBs ****
* --------------------------------------------------------------------------------------------------------------------


***** Preparing datasets for full DOB provided from CBS
use "$data\1. Ramadan_exposure\dob_full", clear
ren rinpersoons RINPERSOONSMa
ren rinpersoon RINPERSOONMa
ren ( year- date)(=_mo)
save "$data\1. Ramadan_exposure\dob_full_mo", replace

use "$data\1. Ramadan_exposure\dob_full", clear
ren rinpersoons RINPERSOONSpa
ren rinpersoon RINPERSOONpa
ren ( year- date)(=_fa)
save "$data\1. Ramadan_exposure\dob_full_fa", replace

use "$data\1. Ramadan_exposure\dob_full", clear
ren rinpersoons RINPERSOONSChd
ren rinpersoon RINPERSOONChd
ren ( year- date)(=_ch)
save "$data\1. Ramadan_exposure\dob_full_ch", replace

use "$data\1. Ramadan_exposure\dob_full", clear
ren rinpersoons RINPERSOONSGraMa_mo
ren rinpersoon RINPERSOONGraMa_mo
ren ( year- date)(=_GraMa_mo)
save "$data\1. Ramadan_exposure\dob_full_GraMa_mo", replace

use "$data\1. Ramadan_exposure\dob_full", clear
ren rinpersoons RINPERSOONSGraPa_mo
ren rinpersoon RINPERSOONGraPa_mo
ren ( year- date)(=_GraPa_mo)
save "$data\1. Ramadan_exposure\dob_full_GraPa_mo", replace

use "$data\1. Ramadan_exposure\dob_full", clear
ren rinpersoons RINPERSOONSGraMa_fa
ren rinpersoon RINPERSOONGraMa_fa
ren ( year- date)(=_GraMa_fa)
save "$data\1. Ramadan_exposure\dob_full_GraMa_fa", replace

use "$data\1. Ramadan_exposure\dob_full", clear
ren rinpersoons RINPERSOONSGraPa_fa
ren rinpersoon RINPERSOONGraPa_fa
ren ( year- date)(=_GraPa_fa)
save "$data\1. Ramadan_exposure\dob_full_GraPa_fa", replace



use "$data\1. Ramadan_exposure\gba_linked", clear

merge m:1 rinpersoons rinpersoon using "$data\1. Ramadan_exposure\dob_full", nogen keep ( master match)
merge m:1 RINPERSOONSMa RINPERSOONMa using "$data\1. Ramadan_exposure\dob_full_mo", nogen keep (match master)
merge m:1 RINPERSOONSpa RINPERSOONpa using "$data\1. Ramadan_exposure\dob_full_fa", nogen  keep (match master)
merge m:1 RINPERSOONSGraPa_mo RINPERSOONGraPa_mo using "$data\1. Ramadan_exposure\dob_full_GraPa_mo", nogen keep (master match)
merge m:1 RINPERSOONSGraMa_mo RINPERSOONGraMa_mo using "$data\1. Ramadan_exposure\dob_full_GraMa_mo", nogen keep (master match)
merge m:1 RINPERSOONSGraPa_fa RINPERSOONGraPa_fa using "$data\1. Ramadan_exposure\dob_full_GraPa_fa", nogen keep (master match)
merge m:1  RINPERSOONSGraMa_fa RINPERSOONGraMa_fa using "$data\1. Ramadan_exposure\dob_full_GraMa_fa", nogen keep (master match)
ren rinpersoonsChd  RINPERSOONSChd
ren rinpersoonChd  RINPERSOONChd
merge m:1 RINPERSOONSChd RINPERSOONChd using "$data\1. Ramadan_exposure\dob_full_ch", nogen keep (master match)



* --------------------------------------------------------------------------------------------------------------------
**** Step 5: Merging Ramadan exposure categories ****
* --------------------------------------------------------------------------------------------------------------------
merge m:1 date using Ramadan_exposure_final, nogen keep (master match)
merge m:1 date_mo using Ramadan_exposure_final_mo, nogen keep (master match)
merge m:1 date_fa using Ramadan_exposure_final_fa, nogen keep (master match)
merge m: date_ch using Ramadan_exposure_final_child, nogen keep (master match)

drop dutch non_muslim

replace high_income = 1 if muslim_CBS == 1 & muslim ==0

erase gba_linked.dta
erase gba.dta
erase child_parent_2024.dta
erase mother_child.dta
erase mother_grandparent.dta
erase father_child.dta
erase father_grandparent.dta
erase enddate.dta
erase startdate.dta

lab var yob_mother_ch "Mother's child's year of birth" 
lab var yob_father_ch "Father's child's year of birth"

lab var yob_ch "Child's year of birth"


save dob_final, replace 





