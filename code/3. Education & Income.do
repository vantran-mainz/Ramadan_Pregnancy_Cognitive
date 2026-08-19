clear all
set more off

* Restricted CBS source directories
global cbs_income    "PATH_TO_CBS_INHATAB"
global cbs_education "PATH_TO_CBS_HOOGSTEOPLTAB"

cd "$data\3. Income_Edu"



* ------------------------------------------------------------------------------------------------------------------------
* ***** Income from INHATAB *****
* NOTE: rinpersoonhkw is the HH ID, each of the HHID inlcudes several IDs of individuals who are the members of the HH. All IDs are unique, no duplicates
* ------------------------------------------------------------------------------------------------------------------------

* 2011
use "$cbs_income\INHA2011TABV3", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2011)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2011", nogen keep (master match)

save income_2011, replace

* 2012
use "$cbs_income\INHA2012TABV3", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2012)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2012", nogen keep (master match)

save income_2012, replace

* 2013
use "$cbs_income\INHA2013TABV3", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2013)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2013", nogen keep (master match)

save income_2013, replace

* 2014
use "$cbs_income\INHA2014TABV1", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2014)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2014", nogen keep (master match)

save income_2014, replace

* 2015
use "$cbs_income\INHA2015TABV1", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2015)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2015", nogen keep (master match)

save income_2015, replace

* 2016
use "$cbs_income\INHA2016TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2016)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2016", nogen keep (master match)

save income_2016, replace

* 2017
use "$cbs_income\INHA2017TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2017)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2017", nogen keep (master match)

save income_2017, replace

* 2018
use "$cbs_income\INHA2018TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2018)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2018", nogen keep (master match)

save income_2018, replace

* 2019
use "$cbs_income\INHA2019TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2019)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2019V2", nogen keep (master match)

save income_2019, replace

* 2020
use "$cbs_income\INHA2020TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2020)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2020V2", nogen keep (master match)

save income_2020, replace


* 2021
use "$cbs_income\INHA2021TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2021)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2019V2", nogen keep (master match)

save income_2021, replace

* 2022
use "$cbs_income\INHA2022TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"

keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2022)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2022V2", nogen keep (master match)

save income_2022, replace

* 2023

use "$cbs_income\INHA2023TABV2", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"


keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2023)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2023V2", nogen keep (master match)

save income_2023, replace

* 2024
use "$cbs_income\INHA2024TABV1", clear
rename inhgestinkh income
labe var income "Standardized HH income (adjusted for size and composition)"
rename INHP100HGEST perc_income
lab var perc_income "Percentile standardized HH income (adjusted for size and composition)"
ren inhsamhh composition
lab var composition "Household composition"
rename INHP100HGESTES perc_income_excl
lab var perc_income_excl "Percentile standardized HH income (excluding student HH)"
ren inhpopiiv type_hh
lab var type_hh "Type of household"


keep rinpersoonshkw rinpersoonhkw income perc_income perc_income_excl type_hh composition

rename (income perc_income perc_income_excl type_hh composition) (=_2024)

merge 1:m rinpersoonshkw rinpersoonhkw using "$cbs_income\KOPPELPERSOONHUISHOUDEN2024V1", nogen keep (master match)
save income_2024, replace


*** Merging income 
use income_2011, clear
rename (rinpersoonshkw rinpersoonhkw) (=_2011)
forvalues i = 2012/2024 {
	merge m:m rinpersoons rinpersoon using income_`i', nogen 
	rename (rinpersoonshkw rinpersoonhkw) (=_`i')
}


* Set to missing if the Hh is Institutional HH or HHs with unknown income 
forvalues i = 2011/2024{
replace perc_income_`i' = . if perc_income_`i' <0
}


gen RINPERSOONSpa = rinpersoons
gen RINPERSOONpa = rinpersoon
gen RINPERSOONMa = rinpersoon
gen RINPERSOONSMa = rinpersoons

save income, replace

forvalues i = 2011/2024 {
erase income_`i'.dta
}


* ------------------------------------------------------------------------------------------------------------------------
* ***** Education from HOOGSTEOPLTAB (SOI2021) *****
* NOTE: This is the highest educational level completed at the time of survey
* ------------------------------------------------------------------------------------------------------------------------

* 2024
use "$cbs_education\2024\HOOGSTEOPL2024TABV1", clear
rename OPLNIVSOI2021AGG4HBmetNIRWO edu_2024
keep rinpersoons rinpersoon edu_2024
save edu_2024, replace

* 2023
use "$cbs_education\2023\HOOGSTEOPL2023TABV2", clear
rename OPLNIVSOI2021AGG4HBmetNIRWO edu_2023
keep rinpersoons rinpersoon edu_2023 
save edu_2023, replace

* 2022
use "$cbs_education\2022\HOOGSTEOPL2022TABV2", clear
rename OPLNIVSOI2021AGG4HBmetNIRWO edu_2022
keep rinpersoons rinpersoon edu_2022 
save edu_2022, replace

* 2021
use "$cbs_education\2021\HOOGSTEOPL2021TABV2", clear
rename OPLNIVSOI2021AGG4HBmetNIRWO edu_2021
keep rinpersoons rinpersoon edu_2021
save edu_2021, replace

* 2020
use "$cbs_education\2020\HOOGSTEOPL2020TABV2", clear
rename OPLNIVSOI2021AGG4HBmetNIRWO edu_2020
keep rinpersoons rinpersoon edu_2020
save edu_2020, replace

* 2019
use "$cbs_education\2019\HOOGSTEOPL2019TABV2", clear
rename OPLNIVSOI2021AGG4HBmetNIRWO edu_2019
keep rinpersoons rinpersoon edu_2019
save edu_2019, replace


// From 2018, there is only educational level under SOI2016
* 2018
use "$cbs_education\2018\HOOGSTEOPL2018TABV3", clear
rename OPLNIVSOI2016AGG4HBMETNIRWO edu_2018
keep rinpersoons rinpersoon edu_2018
save edu_2018, replace

* 2017
use "$cbs_education\2017\HOOGSTEOPL2017TABV3", clear
rename OPLNIVSOI2016AGG4HBMETNIRWO edu_2017
keep rinpersoons rinpersoon edu_2017 
save edu_2017, replace

* 2016
use "$cbs_education\2016\HOOGSTEOPL2016TABV2", clear
rename OPLNIVSOI2016AGG4HBMETNIRWO edu_2016
keep rinpersoons rinpersoon edu_2016
save edu_2016, replace

* 2015
use "$cbs_education\2015\HOOGSTEOPL2015TABV3", clear
rename OPLNIVSOI2016AGG4HBMETNIRWO edu_2015
keep rinpersoons rinpersoon edu_2015
save edu_2015, replace

* 2014
use "$cbs_education\2014\HOOGSTEOPL2014TABV3", clear
rename OPLNIVSOI2016AGG4HBMETNIRWO edu_2014
keep rinpersoons rinpersoon edu_2014 
save edu_2014, replace

* 2013
use "$cbs_education\2013\HOOGSTEOPL2013TABV3", clear
rename OPLNIVSOI2016AGG4HBMETNIRWO edu_2013
keep rinpersoons rinpersoon edu_2013
save edu_2013, replace

// From 2012 backwards,  education is only available under the variable OPLNRHB, which is differently defined compared to the SOI2021 or SOI 2016

forvalues i = 2014/2024 {
merge 1:1 rinpersoons rinpersoon using edu_`i', nogen
}



destring edu_2013-edu_2024, replace
egen edu = rowmax(edu_2013-edu_2024)
replace edu = 1 if edu ==1111
replace edu = 2 if edu ==1112
replace edu = 3 if edu ==1211
replace edu = 4 if edu ==1212
replace edu = 5 if edu ==1213
replace edu= 6 if edu ==1221
replace edu = 7 if edu ==1222
replace edu = 8 if edu ==2111
replace edu = 9 if edu ==2112
replace edu = 10 if edu ==2121
replace edu = 11 if edu ==2131
replace edu = 12 if edu ==2132
replace edu = 13 if edu ==3111
replace edu= 14 if edu ==3112
replace edu = 15 if edu ==3113
replace edu = 16 if edu ==3211
replace edu = 17 if edu ==3212
replace edu= 18 if edu ==3213

gen RINPERSOONSpa = rinpersoons
gen RINPERSOONpa = rinpersoon
gen RINPERSOONMa = rinpersoon
gen RINPERSOONSMa = rinpersoons


save edu, replace

forvalues year = 2013/2024 {
	erase edu_`year'.dta
}
