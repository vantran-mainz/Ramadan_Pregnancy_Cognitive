clear all

cd "$output\Project 2.2_Update"

set more off


* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block I A : CITO Scores - DiD with Maternal GrandMother FE
* ----------
* --------------------------------------------------------------------------------------------------------------------
use  "$data\5. Data Merging_Project 2\project_2_cito", clear

sort n_RINPERSOONGraMa_mo
xtset n_RINPERSOONGraMa_mo
**********************************
****  Regression ****
**********************************
local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore  {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat_sh_mo##muslim_CBS_restricted male maternal_age   i.month  i.month_mo   year_mo i. test_year if n_cousin_mo> 0 & n_cousin_mo !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )  , fe vce(cluster n_RINPERSOONGraMa_mo )
	est sto CITO_F2_`j'_short
	}	

local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat_mo##muslim_CBS_restricted  male maternal_age   i.month  i.month_mo   year_mo i. test_year  if n_cousin_mo> 0 & n_cousin_mo !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )    , fe vce(cluster n_RINPERSOONGraMa_mo)
	est sto  CITO_F2_`j'
	}	
	


esttab CITO_F2_Standard_short CITO_F2_Math_short  CITO_F2_Language_short CITO_F2_Info_short  using Regression_CITO_short.rtf, replace keep (*ram_cat_sh_mo*#1.muslim_CBS_restricted) cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})

esttab CITO_F2_Standard CITO_F2_Math  CITO_F2_Language CITO_F2_Info  using Regression_CITO.rtf,  replace keep (*ram_cat_mo*#1.muslim_CBS_restricted) cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})

********************************
**** Descriptive Statistics ****
********************************
xtreg standard_zscore i.ram_cat_mo##muslim_CBS_restricted  male maternal_age   i.month  i.month_mo   year_mo i. test_year  if n_cousin_mo> 0 & n_cousin_mo !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 ) , fe vce(cluster n_RINPERSOONGraMa_mo )
gen sample_CITO_F2_mo = e(sample)


**** Muslim sample****
* Total sample
eststo total: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==1


* Treated group
eststo treated: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_mo == 1

* COntrol group
eststo control: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_mo == 0

* Probably NOT exposed
eststo probnot: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_mo == 2

esttab total treated control probnot using Descriptive_Statistics_CITO_Muslim_F2.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest standard_zscore math_zscore language_zscore info_processing_zscore perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==1 & probnot_mo==0, by (ram_cat_sh_mo) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_mo  male  if probnot_mo==0 & sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==1, chi2



**** Non-Muslim sample****

* Total sample
eststo total: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==0


* Treated group
eststo treated: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_mo == 1

* COntrol group
eststo control: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_mo == 0

* Probably NOT exposed
eststo probnot: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_mo == 2

esttab total treated control probnot using Descriptive_Statistics_CITO_NonMuslim_F2.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest standard_zscore math_zscore language_zscore info_processing_zscore perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==0 & probnot_mo==0, by (ram_cat_sh_mo) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_mo  male  if probnot_mo==0 & sample_CITO_F2_mo ==1 & muslim_CBS_restricted ==0, chi2



* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block I A : CITO Scores - DiD with Paternal GrandMother FE
* ----------
* --------------------------------------------------------------------------------------------------------------------
use  "$data\5. Data Merging_Project 2\project_2_cito", clear

sort n_RINPERSOONGraMa_fa
xtset n_RINPERSOONGraMa_fa
**********************************
****  Regression ****
**********************************
local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore  {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat_sh_fa##muslim_CBS_restricted male maternal_age   i.month  i.month_fa   year_fa i. test_year if n_cousin_fa> 0 & n_cousin_fa !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )  , fe vce(cluster n_RINPERSOONGraMa_fa )
	est sto CITO_F2_`j'_short
	}	

local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat_fa##muslim_CBS_restricted  male maternal_age   i.month  i.month_fa   year_fa i. test_year  if n_cousin_fa> 0 & n_cousin_fa !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )    , fe vce(cluster n_RINPERSOONGraMa_fa)
	est sto  CITO_F2_`j'
	}	
	


esttab CITO_F2_Standard_short CITO_F2_Math_short  CITO_F2_Language_short CITO_F2_Info_short  using Regression_CITO_short.rtf, replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})

esttab CITO_F2_Standard CITO_F2_Math  CITO_F2_Language CITO_F2_Info  using Regression_CITO.rtf,  replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})

********************************
**** Descriptive Statistics ****
********************************
xtreg standard_zscore i.ram_cat_fa##muslim_CBS_restricted  male maternal_age   i.month  i.month_fa   year_fa i. test_year  if n_cousin_fa> 0 & n_cousin_fa !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 ) , fe vce(cluster n_RINPERSOONGraMa_fa )
gen sample_CITO_F2_fa = e(sample)


**** Muslim sample****
* Total sample
eststo total: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa ram_cat_fa  if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==1


* Treated group
eststo treated: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_fa == 1

* COntrol group
eststo control: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_fa == 0

* Probably NOT exposed
eststo probnot: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_fa == 2

esttab total treated control probnot using Descriptive_Statistics_CITO_Muslim_F2.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest standard_zscore math_zscore language_zscore info_processing_zscore perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==1 & probnot_fa==0, by (ram_cat_sh_fa) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_fa  male  if probnot_fa==0 & sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==1, chi2



**** Non-Muslim sample****

* Total sample
eststo total: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==0


* Treated group
eststo treated: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_fa == 1

* COntrol group
eststo control: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_fa == 0

* Probably NOT exposed
eststo probnot: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_fa == 2

esttab total treated control probnot using Descriptive_Statistics_CITO_NonMuslim_F2.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest standard_zscore math_zscore language_zscore info_processing_zscore perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==0 & probnot_fa==0, by (ram_cat_sh_fa) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_fa  male  if probnot_fa==0 & sample_CITO_F2_fa ==1 & muslim_CBS_restricted ==0, chi2



* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block II A: Special Education - DiD with Maternal GrandMother FE
* ----------
* --------------------------------------------------------------------------------------------------------------------
use  "$data\5. Data Merging_Project 2\project_2_special_edu", clear

sort n_RINPERSOONGraMa_mo
xtset n_RINPERSOONGraMa_mo


********************************
**** Regression ****
********************************
clogit sp_edu i.ram_cat_sh_mo##muslim_CBS_restricted male maternal_age   i.month  i.month_mo   year_mo if n_cousin_mo> 0 & n_cousin_mo !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )   , or group(n_RINPERSOONGraMa_mo ) vce(robust)
est sto SE_short_F2
clogit sp_edu i.ram_cat_mo##muslim_CBS_restricted male maternal_age   i.month  i.month_mo   year_mo if n_cousin_mo> 0 & n_cousin_mo !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )  , or group(n_RINPERSOONGraMa_mo ) vce(robust)
est sto SE_F2

esttab SE_short_F2  SE_F2 using Regression_SE.rtf, eform replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})


********************************
**** Descriptive Statistics ****
********************************
gen sample_SE_F2 = e(sample)

graph bar if sample_SE_F2 ==1, over (ram_cat_mo) by(muslim_CBS_restricted)

**** Muslim sample****
* Total sample
eststo total: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1


* Treated group
eststo treated: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_mo == 1

* COntrol group
eststo control: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_mo == 0

* Probably NOT exposed
eststo probnot: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_mo == 2

esttab total treated control probnot using Descriptive_Statistics_SE_Muslim_F1.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & probnot_mo==0, by (ram_cat_sh_mo) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_mo sp_edu male  if probnot_mo==0 & sample_SE_F2 ==1 & muslim_CBS_restricted ==1, chi2



**** Non-Muslim sample****

* Total sample
eststo total: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0


* Treated group
eststo treated: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_mo == 1

* COntrol group
eststo control: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_mo == 0

* Probably NOT exposed
eststo probnot: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_mo == 2

esttab total treated control probnot using Descriptive_Statistics_SE_NonMuslim_F2.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & probnot_mo==0, by (ram_cat_sh_mo) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_mo sp_edu male  if probnot_mo==0 & sample_SE_F2 ==1 & muslim_CBS_restricted ==0, chi2

* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block II B: Special Education - DiD with Paternal GrandMother FE
* ----------
* --------------------------------------------------------------------------------------------------------------------
use  "$data\5. Data Merging_Project 2\project_2_special_edu", clear

sort n_RINPERSOONGraMa_fa
xtset n_RINPERSOONGraMa_fa


********************************
**** Regression ****
********************************
clogit sp_edu i.ram_cat_sh_fa##muslim_CBS_restricted male maternal_age   i.month  i.month_fa   year_fa if n_cousin_fa> 0 & n_cousin_fa !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )   , or group(n_RINPERSOONGraMa_fa ) vce(robust)
est sto SE_short_F2
clogit sp_edu i.ram_cat_fa##muslim_CBS_restricted male maternal_age   i.month  i.month_fa   year_fa if n_cousin_fa> 0 & n_cousin_fa !=. & (muslim_CBS_restricted ==1 | non_muslim_exc ==1 )  , or group(n_RINPERSOONGraMa_fa ) vce(robust)
est sto SE_F2

esttab SE_short_F2  SE_F2 using Regression_SE.rtf, eform replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})


********************************
**** Descriptive Statistics ****
********************************
gen sample_SE_F2 = e(sample)

graph bar if sample_SE_F2 ==1, over (ram_cat_fa) by(muslim_CBS_restricted)

**** Muslim sample****
* Total sample
eststo total: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1


* Treated group
eststo treated: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_fa == 1

* COntrol group
eststo control: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_fa == 0

* Probably NOT exposed
eststo probnot: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & ram_cat_sh_fa == 2

esttab total treated control probnot using Descriptive_Statistics_SE_Muslim_F2.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==1 & probnot_fa==0, by (ram_cat_sh_fa) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_fa sp_edu male  if probnot_fa==0 & sample_SE_F2 ==1 & muslim_CBS_restricted ==1, chi2



**** Non-Muslim sample****

* Total sample
eststo total: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0


* Treated group
eststo treated: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_fa == 1

* COntrol group
eststo control: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_fa == 0

* Probably NOT exposed
eststo probnot: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & ram_cat_sh_fa == 2

esttab total treated control probnot using Descriptive_Statistics_SE_NonMuslim_F2.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F2 ==1 & muslim_CBS_restricted ==0 & probnot_fa==0, by (ram_cat_sh_fa) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_sh_fa sp_edu male  if probnot_fa==0 & sample_SE_F2 ==1 & muslim_CBS_restricted ==0, chi2



