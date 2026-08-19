clear all

cd "$data\5. Data Merging_Project 2"

set more off


* --------------------------------------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------------------------------------
* -----------   Block I    CITO Scores  
* --------------------------------------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------------------------------------
use  "$data\2. Cito\cito",clear

merge 1:m rinpersoons rinpersoon using "$data\1. Ramadan_exposure_Update\dob_final", nogen keep ( match)
drop if date ==. // 1 dropped

drop *_ch
sort rinpersoons rinpersoon

// Count the number of unique ID
// Drop duplicates of Individual IDs (each ID now are duplicates for those with data on their children)
duplicates drop rinpersoons rinpersoon , force

gen ram_cat_short = 0 if certnot ==1
replace ram_cat_short = 2  if probnot ==1
replace ram_cat_short = 1  if ram_cat_short ==.
label define ram_cat_short 0 "0. Certainly NOT exposed" 1 "1. Certainly Exposed" 2 "2. Probably NOT exposed" 
label value ram_cat_short ram_cat_short
label var ram_cat_short "Ramadan exposure categories (short)"

gen ram_cat_sh_fa = 0 if certnot_fa ==1
replace ram_cat_sh_fa = 2 if  probnot_fa == 1 
replace ram_cat_sh_fa = 1 if ram_cat_sh_fa ==.
label define ram_cat_sh_fa 0 "0. Father Certainly NOT exposed" 1 "1. Father Certainly Exposed" 2 "2. Father Probably NOT exposed"
label value ram_cat_sh_fa ram_cat_sh_fa
label var ram_cat_sh_fa "Father's Ramadan exposure categories (short)"

gen ram_cat_sh_mo = 0 if certnot_mo ==1
replace ram_cat_sh_mo = 2 if probnot_mo == 1 
replace ram_cat_sh_mo = 1 if ram_cat_sh_mo ==.
label define ram_cat_sh_mo 0 "0. Mother Certainly NOT exposed" 1 "1. Mother Certainly Exposed" 2 "2. Mother Probably NOT exposed" 
label value ram_cat_sh_mo ram_cat_sh_mo
label var ram_cat_sh_mo "Mother's Ramadan exposure categories"

egen n_RINPERSOONMa = group ( RINPERSOONMa)

gen muslim_CBS_restricted = (muslim_CBS_mo ==1 & muslim_CBS_fa ==1 & muslim_CBS ==1)



label var year_fa "Father's year of birth"
label var month_fa "Father's month of birth"
label var day_fa "Father's day of birth"
label var year_mo "Mother's year of birth"
label var month_mo "Mother's month of birth"
label var day_mo "Mother's day of birth"


lab var year "Year of birth"
lab var month "Month of birth"
lab var day "Day of birth"
lab var date "Date of birth"
lab var date_fa "Father's date of birth"
lab var date_mo "Mother's date of birth"

*** Parental & maternal age at child birth
gen maternal_age = (date - date_mo)/365.25
gen paternal_age = (date - date_fa)/365.25
gen paternal_age_2 = paternal_age^2
gen maternal_age_2 = maternal_age^2
lab var maternal_age "Maternal age"
lab var paternal_age "Paternal age"

* --------------------------------------------------------------------------------------------------------------------
* Check the distribution of test scores across the testyears
* --------------------------------------------------------------------------------------------------------------------

replace total_score = . if total_score ==999
replace language_score =. if language_score == 999
replace language_zscore = . if language_zscore == 99.9999

replace math_score = . if math_score ==999
replace math_zscore = . if math_zscore == 99.9999

* Create percentile for the standardized score 
xtile standard_score_pct = standard_score , nq(100)

sort n_RINPERSOONMa
xtset n_RINPERSOONMa

duplicates tag n_RINPERSOONMa , gen(n_sibling)

egen standard_zscore = std(standard_score)



*-------------------------------------------------------------------------------------------------------------------- *
*Calculating approximate age at taking the test
*-------------------------------------------------------------------------------------------------------------------- *
// FRom 2015, CITO test taken in January or Feb, instead of in APril as previously before 2015
gen age_test = (test_year-year)+(2 - month)/12 if test_year >=2015
replace age_test = (test_year-year)+(4 - month)/12 if test_year <2015

*-------------------------------------------------------------------------------------------------------------------- *
*** Step 2  merge edu & HH income 
*-------------------------------------------------------------------------------------------------------------------- *
merge m:1 RINPERSOONSpa RINPERSOONpa using "$data\3. Income_Edu\edu" , keep (master match) keepusing (edu ) nogen
rename edu edu_pa
merge m:1 RINPERSOONSMa RINPERSOONMa using "$data\3. Income_Edu\edu" , keep (master match) keepusing (edu ) nogen
rename edu edu_ma

* Percentile of income (adjusted for size and composition) 
merge 1:1 rinpersoons rinpersoon using "$data\3. Income_Edu\income" , keep (master match) keepusing (perc_income_20* ) nogen

// Generate percentile income from row mean of income across years
egen perc_income = rowmean(perc_income_2011-perc_income_2024 )
drop perc_income_2011-perc_income_2024

// Fill in missing data with Income from parents (HH income)
merge m:1 RINPERSOONSpa RINPERSOONpa using "$data\3. Income_Edu\income" , keep (master match) keepusing (perc_income_20* ) nogen
egen perc_income_pa = rowmean(perc_income_2011-perc_income_2024 )
drop perc_income_2011-perc_income_2024

merge m:1 RINPERSOONSMa RINPERSOONMa using "$data\3. Income_Edu\income" , keep (master match) keepusing (perc_income_20* ) nogen
egen perc_income_mo = rowmean(perc_income_2011-perc_income_2024 )
drop perc_income_2011-perc_income_2024

replace perc_income = perc_income_pa if perc_income ==.
replace perc_income = perc_income_mo if perc_income ==.

drop perc_income_pa perc_income_mo
 
egen n_RINPERSOONGraMa_mo = group ( RINPERSOONGraMa_mo )
egen n_RINPERSOONGraMa_fa = group ( RINPERSOONGraMa_fa )

*-------------------------------------------------------------------------------------------------------------------- *
** Calculate the number cousin
*-------------------------------------------------------------------------------------------------------------------- *

duplicates tag n_RINPERSOONGraMa_mo , gen (n_cousin_mo)
duplicates tag n_RINPERSOONGraMa_fa , gen (n_cousin_fa)


replace n_sibling = . if n_sibling >9
replace n_cousin_mo = . if n_cousin_mo > 19
replace n_cousin_fa = . if n_cousin_fa > 17

keep if age_test < 15 &  age_test >=11

merge 1:1 rinpersoons rinpersoon using "$data\5. Data Merging_Project 1.3\project_1.3_reproductive", nogen keep (master match) keepusing (birth_order)

save project_2_cito, replace



* --------------------------------------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------------------------------------
* -----------   Block II   Special Education    
* --------------------------------------------------------------------------------------------------------------------------
* --------------------------------------------------------------------------------------------------------------------------


* --------------------------------------------------------------------------------------------------------------------------
* Preparing GBA data - making individual IDs unique (curently, each row in the data is record of the individual's children)
* --------------------------------------------------------------------------------------------------------------------------
use "$data\1. Ramadan_exposure_Update\dob_final", clear
drop *_ch
sort rinpersoons rinpersoon

// Count the number of unique ID
// Drop duplicates of Individual IDs (each ID now are duplicates for those with data on their children)
duplicates drop rinpersoons rinpersoon , force

* --------------------------------------------------------------------------------------------------------------------------
* Step 3: Merging with data on Special Education
* --------------------------------------------------------------------------------------------------------------------------
merge 1:m rinpersoons rinpersoon using "$data\4. Special Education\sp_edu", nogen keep ( master match)


* Calculate age at each survey year based on year of birth and year of survey
forvalues i = 2008/2024{
gen age_`i' = `i' - year
}

*** Those who were 11 from year 2008 to 2023 , and 9-11 years old in 2024  were born in 1996 - 2015 => only look at these children
drop if year < 1996 | year > 2015

* Children who were in Special Education at the age of 11 in year  2008 - 2024
gen sp_edu = .
forvalues i = 2008/2024{
replace sp_edu = 1 if age_`i' ==11  & survey_year_sp_edu == `i'
}

destring n_year_SBO, replace
destring n_year_SO, replace
destring n_year_VSO, replace


// For survey year 2024, take also children of 9 & 10 years old
replace sp_edu = 1 if survey_year_sp_edu ==2024 & (age_2024 == 9 | age_2024 ==10)

// Drop those duplicates of ID (among IDs with available value on sp_edu)
bysort rinpersoons rinpersoon: egen nomiss = total (!missing (sp_edu))
drop if missing(sp_edu) & nomiss > 0
drop nomiss


*** Set as attending Special Education if there is  record of VSO attendance at  12 years old and the number of years in SBO > 0 => these were likely to attend SBO  at 11 years old but were not recorded here
forvalues i = 2008/2024{
replace sp_edu = 1 if sp_edu ==. & survey_year_sp_edu == `i' & n_year_SBO > 0 & n_year_SBO !=. & type == "VSO" &    age_`i' ==12 
}

// Drop those duplicates of ID (among IDs with available value on sp_edu)
bysort rinpersoons rinpersoon: egen nomiss = total (!missing (sp_edu))
drop if missing(sp_edu) & nomiss > 0
drop nomiss


forvalues i = 2008/2024{
replace sp_edu = 1 if sp_edu ==. & survey_year_sp_edu == `i' & n_year_SBO > 1 & n_year_SBO !=. & type == "VSO" &    age_`i' ==13
}

// Drop those duplicates of ID (among IDs with available value on sp_edu)
bysort rinpersoons rinpersoon: egen nomiss = total (!missing (sp_edu))
drop if missing(sp_edu) & nomiss > 0
drop nomiss


forvalues i = 2008/2024{
replace sp_edu = 1 if sp_edu ==. & survey_year_sp_edu == `i' & n_year_SBO > 2 & n_year_SBO !=. & type == "VSO" &    age_`i' ==14 
}

// Drop those duplicates of ID (among IDs with available value on sp_edu)
bysort rinpersoons rinpersoon: egen nomiss = total (!missing (sp_edu))
drop if missing(sp_edu) & nomiss > 0
drop nomiss



sort rinpersoons rinpersoon


* Set as attending Special Education if there is  record of SO attendance  at 12 years old, and the number of years in SO >= 1 in the corresponding survey year => likely to be in SO at 11 years old

forvalues i = 2008/2024{
replace sp_edu = 1 if sp_edu ==. & survey_year_sp_edu == `i'  & type == "SO" &    age_`i' ==12 & n_year_SO >= 1 & n_year_SO !=.
}

// Drop those duplicates of ID (among IDs with available value on sp_edu)
bysort rinpersoons rinpersoon: egen nomiss = total (!missing (sp_edu))
drop if missing(sp_edu) & nomiss > 0
drop nomiss


**** 

// Generate the total number of years in SE for each individual
bysort rinpersoons rinpersoon: egen total_year_SBO = max(n_year_SBO) if survey_year_sp_edu != .
bysort rinpersoons rinpersoon: egen total_year_SO = max(n_year_SO) if survey_year_sp_edu != .
bysort rinpersoons rinpersoon: egen total_year_VSO = max(n_year_VSO) if survey_year_sp_edu != .


bysort rinpersoons rinpersoon: gen dup = _n 
drop if dup > 1 & sp_edu==.
drop dup

drop age_2008-age_2024

* --------------------------------------------------------------------------------------------------------------------------
* Step 4: Merging with data on General Education'S enrollment
* --------------------------------------------------------------------------------------------------------------------------
merge 1:m rinpersoons rinpersoon using "$data\8. Special Education\gen_edu", nogen keep ( master match)

* Variable to indicate if an enrollment was for SBO, SO or VSO in any of the enrollment available
gen enrollment_sp = .
replace enrollment_sp = 1 if enrollment_type == "51" | enrollment_type == "52" | enrollment_type == "53" 

* Calculate age at each survey year based on year of birth and year of survey
forvalues i = 2004/2024{
gen age_`i' = `i' - year
}

gen enroll_date = date(enrollment_date, "YMD")
gen enroll_day = day(enroll_date)
gen enroll_month = month(enroll_date)
gen enroll_year = year(enroll_date)

* Checking when an individual deregistered from a level of School
gen deregist_date = date(deregister_date, "YMD")
gen deregist_day = day(deregist_date)
gen deregist_month = month(deregist_date)
gen deregist_year = year(deregist_date)

drop enrollment_date  deregister_date


forvalues i = 2004/2024{
replace sp_edu = 1 if sp_edu ==. & enrollment_sp == 1 & enroll_year == `i' & age_`i' == 11
}

// After confirming that the special-education record is always first
bysort rinpersoons rinpersoon: gen dup = _n 
drop if dup > 1 
drop dup

* Keeping only those obs with records either in Special Education or General Education data
keep if survey_year_edu !=. | survey_year_sp_edu !=.

drop age_2004-age_2024

replace sp_edu =  0 if sp_edu ==.

* Percentile of income (adjusted for size and composition): prioritizing the latest data from 2023 
merge 1:1 rinpersoons rinpersoon using "$data\3. Income_Edu\income" , keep (master match) keepusing (perc_income_20* ) nogen

// Generate percentile income from row mean of income across years
egen perc_income = rowmean(perc_income_2011-perc_income_2024 )
drop perc_income_2011-perc_income_2024

// Fill in missing data with Income from parents (HH income)
merge m:1 RINPERSOONSpa RINPERSOONpa using "$data\3. Income_Edu\income" , keep (master match) keepusing (perc_income_20* ) nogen
egen perc_income_pa = rowmean(perc_income_2011-perc_income_2024 )
drop perc_income_2011-perc_income_2024

merge m:1 RINPERSOONSMa RINPERSOONMa using "$data\3. Income_Edu\income" , keep (master match) keepusing (perc_income_20* ) nogen
egen perc_income_mo = rowmean(perc_income_2011-perc_income_2024 )
drop perc_income_2011-perc_income_2024

replace perc_income = perc_income_pa if perc_income ==.
replace perc_income = perc_income_mo if perc_income ==.

merge m:1 RINPERSOONSpa RINPERSOONpa using "$data\3. Income_Edu\edu" , keep (master match) keepusing (edu ) nogen
rename edu edu_pa
merge m:1 RINPERSOONSMa RINPERSOONMa using "$data\3. Income_Edu\edu" , keep (master match) keepusing (edu ) nogen
rename edu edu_ma

gen paternal_age = (date - date_fa)/365.25
gen maternal_age = (date - date_mo)/365.25

lab var sp_edu "Attending Special Education"
lab var maternal_age "Age of mother at birth"
lab var paternal_age "Age of father at birth"

lab var perc_income "HH Income (percentile)"
lab var edu_pa "Father's Highest Attained Education"
lab var edu_ma "Mother's Highest Attained Education"


drop enrollment_sp-deregist_year
drop total_year_SBO-total_year_VSO

gen ram_cat_short = 0 if certnot ==1
replace ram_cat_short = 2  if probnot ==1
replace ram_cat_short = 1  if ram_cat_short ==.
label define ram_cat_short 0 "0. Certainly NOT exposed" 1 "1. Certainly Exposed" 2 "2. Probably NOT exposed" 
label value ram_cat_short ram_cat_short
label var ram_cat_short "Ramadan exposure categories (short)"

gen ram_cat_sh_fa = 0 if certnot_fa ==1
replace ram_cat_sh_fa = 2 if  probnot_fa == 1 
replace ram_cat_sh_fa = 1 if ram_cat_sh_fa ==.
label define ram_cat_sh_fa 0 "0. Father Certainly NOT exposed" 1 "1. Father Certainly Exposed" 2 "2. Father Probably NOT exposed"
label value ram_cat_sh_fa ram_cat_sh_fa
label var ram_cat_sh_fa "Father's Ramadan exposure categories (short)"

gen ram_cat_sh_mo = 0 if certnot_mo ==1
replace ram_cat_sh_mo = 2 if probnot_mo == 1 
replace ram_cat_sh_mo = 1 if ram_cat_sh_mo ==.
label define ram_cat_sh_mo 0 "0. Mother Certainly NOT exposed" 1 "1. Mother Certainly Exposed" 2 "2. Mother Probably NOT exposed" 
label value ram_cat_sh_mo ram_cat_sh_mo
label var ram_cat_sh_mo "Mother's Ramadan exposure categories"

egen n_RINPERSOONMa = group ( RINPERSOONMa)
duplicates tag n_RINPERSOONMa , gen (n_sibling)

gen muslim_CBS_restricted = (muslim_CBS_mo ==1 & muslim_CBS_fa ==1 & muslim_CBS ==1)

egen n_RINPERSOONGraMa_mo = group ( RINPERSOONGraMa_mo )
egen n_RINPERSOONGraMa_fa = group ( RINPERSOONGraMa_fa )
duplicates tag n_RINPERSOONGraMa_mo , gen (n_cousin_mo)
duplicates tag n_RINPERSOONGraMa_fa , gen (n_cousin_fa)
 

replace n_sibling = . if n_sibling > 11
replace n_cousin_mo = . if n_cousin_mo > 27
replace n_cousin_fa = . if n_cousin_fa > 26
gen maternal_age_2 = maternal_age * maternal_age

save project_2_special_edu, replace

