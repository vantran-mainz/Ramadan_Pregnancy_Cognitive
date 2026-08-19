clear all
set more off

* Restricted CBS source directories
global cbs_special_education "PATH_TO_CBS_INSCHRWECTAB"
global cbs_enrollment        "PATH_TO_CBS_ONDERWIJSINSCHRTAB"

cd "$data\4. Special Education"



* --------------------------------------------------------------------------------------------------------------------*/
* --------------------------------------------------------------------------------------------------------------------
* Special Education: each RIN record is unique
* --------------------------------------------------------------------------------------------------------------------
* 2008
use "$cbs_special_education\INSCHRWECTAB2008V2", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind wecsrtonderwijs wecsrtspeconderwijs wecsrtverblijf-weccatinschr
gen survey_year = 2008
drop if rinpersoon ==""
save sp_edu_2008, replace

* 2009
use "$cbs_special_education\INSCHRWECTAB2009V2", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind wecsrtonderwijs wecsrtspeconderwijs wecsrtverblijf-weccatinschr
gen survey_year = 2009
drop if rinpersoon ==""
save sp_edu_2009, replace

* 2010
use "$cbs_special_education\INSCHRWECTAB2010V2", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind wecsrtonderwijs wecsrtspeconderwijs wecsrtverblijf-weccatinschr
gen survey_year = 2010
drop if rinpersoon ==""
save sp_edu_2010, replace

* 2011
use "$cbs_special_education\INSCHRWECTAB2011V3", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr
gen survey_year = 2011
drop if rinpersoon ==""
save sp_edu_2011, replace

* 2012
use "$cbs_special_education\INSCHRWECTAB2012V2", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr
gen survey_year = 2012
drop if rinpersoon ==""
save sp_edu_2012, replace

* 2013
use "$cbs_special_education\INSCHRWECTAB2013V3", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr
gen survey_year = 2013
drop if rinpersoon ==""
save sp_edu_2013, replace

* 2014
use "$cbs_special_education\INSCHRWECTAB2014V6", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2014
drop if rinpersoon ==""
save sp_edu_2014, replace

* 2015
use "$cbs_special_education\INSCHRWECTAB2015V6", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2015
drop if rinpersoon ==""
save sp_edu_2015, replace

* 2016
use "$cbs_special_education\INSCHRWECTAB2016V6", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2016
drop if rinpersoon ==""
save sp_edu_2016, replace

* 2017
use "$cbs_special_education\INSCHRWECTAB2017V6", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2017
drop if rinpersoon ==""
save sp_edu_2017, replace

* 2018
use "$cbs_special_education\INSCHRWECTAB2018V6", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2018
drop if rinpersoon ==""
save sp_edu_2018, replace

* 2019
use "$cbs_special_education\INSCHRWECTAB2019V4", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2019
drop if rinpersoon ==""
save sp_edu_2019, replace

* 2020
use "$cbs_special_education\INSCHRWECTAB2020V2", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2020
drop if rinpersoon ==""
save sp_edu_2020, replace

* 2021
use "$cbs_special_education\INSCHRWECTAB2021V2", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2021
drop if rinpersoon ==""
save sp_edu_2021, replace

* 2022
use "$cbs_special_education\INSCHRWECTAB2022V1", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2022
drop if rinpersoon ==""
save sp_edu_2022, replace
* 2023
use "$cbs_special_education\INSCHRWECTAB2023V2", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2023
drop if rinpersoon ==""
save sp_edu_2023, replace

* 2024
use "$cbs_special_education\INSCHRWECTAB2024V1", clear
keep rinpersoons rinpersoon wecbrinvest wecverblijfsjaar wecsoortind-weccatinschr wecondvest weccluster wecbijzins wecbekcattot wecuprichting wecupleerjaar
gen survey_year = 2024
drop if rinpersoon ==""
save sp_edu_2024, replace

use sp_edu_2008, clear
append using sp_edu_2009
append using sp_edu_2010
append using sp_edu_2011
append using sp_edu_2012
append using sp_edu_2013
append using sp_edu_2014
append using sp_edu_2015
append using sp_edu_2016
append using sp_edu_2017
append using sp_edu_2018
append using sp_edu_2019
append using sp_edu_2020
append using sp_edu_2021
append using sp_edu_2022
append using sp_edu_2023
append using sp_edu_2024
rename wecverblijfsjaar n_year
lab var n_year "The total number of enrollment years"
rename wecsoortind disability
lab var disability "Indicator of disability before 2014"
ren wecsrtonderwijs edu_type
lab var edu_type "Education attended within (V)SO system before 2014"
ren wectypepo type
lab var type "Type of Special Education"
ren wecsrtverblijf residence
lab var residence "Place staying outside of school"
ren wecverblijfsjrbo n_year_BO
lab var n_year_BO "Number of years enrolled in BO"
ren wecverblijfsjrsbo n_year_SBO
lab var n_year_SBO "Number of years enrolled in SBO"
ren wecverblijfsjrso n_year_SO
lab var n_year_SO "Number of years enrolled in SO"
ren wecverblijfsjrvso n_year_VSO
lab var n_year_VSO "Number of years enrolled in VSO"
ren wecverblijfsjrinst n_year_SO_VSO
lab var n_year_SO_VSO "Total numner of years enrolled in SO & VSO"
ren wecdenominatie denomination
lab var denomination "Philosophy of the institution"
ren weccatinschr registration
lab var registration "Categories of registration"
ren wecondvest disability_new
lab var disability_new "Indicator of disability from 2014"
ren wecbijzins registration_new
lab var registration_new "Categories of registration from 2014"
ren wecbekcattot funding
lab var funding "Funding categories"

ren survey_year survey_year_sp_edu

drop wecbrinvest wecsrtspeconderwijs wecgroepsgrootte wecuprichting wecupleerjaar weccluster
// NOte that weccluster & wecondvest have similar values

save sp_edu, replace

forvalues year = 2008/2024 {
	erase sp_edu_`year'.dta
}

* --------------------------------------------------------------------------------------------------------------------
* General Education System - Characteristics of enrollment
* --------------------------------------------------------------------------------------------------------------------

* 2000
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2000V2", clear
drop if rinpersoon ==""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2000
save gen_edu_2000, replace

* 2001
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2001V2", clear
drop if rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2001
save gen_edu_2001, replace

* 2002
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2002V2", clear
drop if rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2002
save gen_edu_2002, replace

* 2003
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2003V2", clear
drop if rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2003
save gen_edu_2003, replace

* 2004
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2004V2", clear
drop if rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2004
save gen_edu_2004, replace

* 2005
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2005V2", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2005
save gen_edu_2005, replace

* 2006
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2006V2", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2006
save gen_edu_2006, replace

* 2007
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2007V2", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2007
save gen_edu_2007, replace

* 2008
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2008V2", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2008
save gen_edu_2008, replace

* 2009
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2009V2", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2009
save gen_edu_2009, replace

* 2010
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2010V3", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2010
save gen_edu_2010, replace

* 2011
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2011V4", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2011
save gen_edu_2011, replace

* 2012
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2012V5", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2012
save gen_edu_2012, replace

* 2013
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2013V4", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2013
save gen_edu_2013, replace

* 2014
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2014V3", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2014
save gen_edu_2014, replace

* 2015
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2015V3", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2015
save gen_edu_2015, replace

* 2016
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2016V3", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2016
save gen_edu_2016, replace

* 2017
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2017V3", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2017
save gen_edu_2017, replace

* 2018
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2018V4", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2018
save gen_edu_2018, replace

* 2019
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2019V4", clear
drop if  rinpersoon == ""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2019
save gen_edu_2019, replace

* 2020
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2020V2", clear
drop if rinpersoon ==""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2020
save gen_edu_2020, replace

* 2021
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2021V2", clear
drop if rinpersoon ==""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2021
save gen_edu_2021, replace

* 2022
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2022V2", clear
drop if rinpersoon ==""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2022
save gen_edu_2022, replace

* 2023
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2023V2", clear
drop if rinpersoon ==""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2023
save gen_edu_2023, replace

* 2024
use "$cbs_enrollment\ONDERWIJSINSCHRTAB2024V1", clear
drop if rinpersoon ==""
drop ONDERWIJSNR_crypt BRIN_crypt oplnr VEBRINFIN_crypt vecontacturen bekostiging vobrinvest
gen survey_year_edu = 2024
save gen_edu_2024, replace

*** From 2015 to 2024, in which enrollment into Special Education were recorded

append using gen_edu_2023
append using gen_edu_2022
append using gen_edu_2021
append using gen_edu_2020
append using gen_edu_2019
append using gen_edu_2018
append using gen_edu_2017
append using gen_edu_2016
append using gen_edu_2015
append using gen_edu_2014
append using gen_edu_2013
append using gen_edu_2012
append using gen_edu_2011
append using gen_edu_2010
append using gen_edu_2009
append using gen_edu_2008
append using gen_edu_2007
append using gen_edu_2006
append using gen_edu_2005
append using gen_edu_2004
append using gen_edu_2003
append using gen_edu_2002
append using gen_edu_2001
append using gen_edu_2000


ren hoofdinschr main_enroll
lab var main_enroll "Main enrollment"
ren   aanvinschr enrollment_date
ren  typeonderwijs enrollment_type
lab var survey_year_edu "Survey year of Enrollment"
lab var enrollment_type "Type of enrollment"
ren eindinschr deregister_date
lab var deregister_date "Date of Deregistration"

keep rinpersoons rinpersoon enrollment_date enrollment_type survey_year_edu main_enroll deregister_date


save gen_edu, replace


forvalues year = 2000/2024 {
	erase gen_edu_`year'.dta
}







