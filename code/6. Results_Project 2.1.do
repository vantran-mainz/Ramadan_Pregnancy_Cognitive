clear all

cd "$output\Project 2.1"

set more off


* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block I: CITO Scores - DiD ith Mother FE
* ----------
* --------------------------------------------------------------------------------------------------------------------
use  "$data\5. Data Merging_Project 2\project_2_cito", clear
xtset n_RINPERSOONMa
********************************
****  Regression ****
********************************
local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore  {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat_short##muslim_CBS male  maternal_age   i. month  i.test_year if n_sibling > 0  & n_sibling !=. , fe vce(cluster n_RINPERSOONMa )
	est sto CITO_F1_`j'_short
	}	

local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat##muslim_CBS male  maternal_age   i. month  i.test_year if n_sibling > 0  & n_sibling !=.   , fe vce(cluster n_RINPERSOONMa )
	est sto  CITO_F1_`j'
	}	
	


esttab CITO_F1_Standard_short CITO_F1_Math_short  CITO_F1_Language_short CITO_F1_Info_short  using Regression_CITO_short.rtf, replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})

esttab CITO_F1_Standard CITO_F1_Math  CITO_F1_Language CITO_F1_Info  using Regression_CITO.rtf,  replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})

*****************************************************************************************************
    *** Multiple Testing Bonferroni-Holm - to be run after every regression in the main analyses ***
*****************************************************************************************************

test 1.ram_cat#1.muslim_CBS 2.ram_cat#1.muslim_CBS 3.ram_cat#1.muslim_CBS 4.ram_cat#1.muslim_CBS 5.ram_cat#1.muslim_CBS 6.ram_cat#1.muslim_CBS, mtest(holm)
use  "$data\5. Data Merging_Project 2_Update\project_2_cito", clear
xtset n_RINPERSOONMa

xtreg standard_zscore i.ram_cat##muslim_CBS male  maternal_age   i. month  i.test_year if n_sibling > 0  & n_sibling !=. , fe vce(cluster n_RINPERSOONMa )
parmest , norestore
keep if parm == "1.ram_cat#1.muslim_CBS" | parm == "2.ram_cat#1.muslim_CBS" | parm == "3.ram_cat#1.muslim_CBS" | parm == "4.ram_cat#1.muslim_CBS" | parm == "5.ram_cat#1.muslim_CBS" | parm == "6.ram_cat#1.muslim_CBS"
sort p
gen rank = _n
count
local m = r(N)
gen double pholm_raw = (`m' - rank +1)*p
gen double pholm = pholm_raw
forvalues i=2/`m'{
quietly replace pholm = max(pholm[`i'-1], pholm) in `i'
}
replace pholm = cond(pholm > 1,1,pholm)
sort parm


// round adjusted values into 3 decimales 
foreach v of varlist   p pholm{
replace `v' = round(`v', 0.001)
}

// Adjusting format
foreach v of varlist  p pholm{
format `v' %9.3f
}

putdocx begin
putdocx paragraph

putdocx text ("Bonferroni-Holm"), bold font(14)

putdocx table tbl = data(parm  p pholm  ), border(all)

putdocx save "Multiple Testing",replace


********************************
**** Descriptive Statistics ****
********************************
xtreg standard_zscore muslim_CBS##i.ram_cat male  maternal_age   i. month  i.test_year if n_sibling > 0  & n_sibling !=. , fe vce(cluster n_RINPERSOONMa )
gen sample_CITO_F1 = e(sample)


**** Muslim sample****
* Total sample
eststo total: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==1


* Treated group
eststo treated: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==1 & ram_cat_short == 1

* COntrol group
eststo control: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==1 & ram_cat_short == 0

* Probably NOT exposed
eststo probnot: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==1 & ram_cat_short == 2

esttab total treated control probnot using Descriptive_Statistics_CITO_Muslim_F1.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest standard_zscore math_zscore language_zscore info_processing_zscore perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==1 & probnot==0, by (ram_cat_short) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_short  male  if probnot==0 & sample_CITO_F1 ==1 & muslim_CBS ==1, chi2



**** Non-Muslim sample****

* Total sample
eststo total: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==0


* Treated group
eststo treated: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==0 & ram_cat_short == 1

* COntrol group
eststo control: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==0 & ram_cat_short == 0

* Probably NOT exposed
eststo probnot: estpost summarize standard_zscore math_zscore language_zscore info_processing_zscore male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==0 & ram_cat_short == 2

esttab total treated control probnot using Descriptive_Statistics_CITO_NonMuslim_F1.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest standard_zscore math_zscore language_zscore info_processing_zscore perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_CITO_F1 ==1 & muslim_CBS ==0 & probnot==0, by (ram_cat_short) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_short  male  if probnot==0 & sample_CITO_F1 ==1 & muslim_CBS ==0, chi2

* --------------------------------------------------------------------------------------------------------------------
************** Robustness check: Subsample before 2015 only  **************
* --------------------------------------------------------------------------------------------------------------------
use  "$data\5. Data Merging_Project 2_Update\project_2_cito", clear
xtset n_RINPERSOONMa
********************************
****  Regression ****
********************************
local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore  {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat_short##muslim_CBS male  maternal_age   i. month  i.test_year if n_sibling > 0 & test_year<2015 , fe vce(cluster n_RINPERSOONMa )
	est sto CITO_F1_`j'_sh_robust
	}	

local score "Standard Math Language Info World"
foreach i of varlist  standard_zscore math_zscore language_zscore info_processing_zscore {
	gettoken j score:score
	quietly xtreg `i' i.ram_cat##muslim_CBS male  maternal_age   i. month  i.test_year if n_sibling > 0  & test_year<2015  , fe vce(cluster n_RINPERSOONMa )
	est sto  CITO_F1_`j'_robust
	}	
	


esttab CITO_F1_Standard_sh_robust CITO_F1_Math_sh_robust  CITO_F1_Language_sh_robust CITO_F1_Info_sh_robust  using Regression_CITO_short_robust.rtf, replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})

esttab CITO_F1_Standard_robust CITO_F1_Math_robust  CITO_F1_Language_robust CITO_F1_Info_robust  using Regression_CITO_robust.rtf,  replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})






* --------------------------------------------------------------------------------------------------------------------
* ----------
* ----------	Block II: Special Education - DiD with Mother FE
* ----------
* --------------------------------------------------------------------------------------------------------------------
use  "$data\5. Data Merging_Project 2\project_2_special_edu", clear

sort n_RINPERSOONMa
xtset n_RINPERSOONMa


********************************
**** Regression ****
********************************
clogit sp_edu i.ram_cat_short##muslim_CBS male maternal_age   i. month if n_sibling > 0   , or group(n_RINPERSOONMa ) vce(cluster n_RINPERSOONMa)
est sto SE_short_F1
clogit sp_edu i.ram_cat##muslim_CBS male maternal_age   i. month  if n_sibling > 0   , or group(n_RINPERSOONMa ) vce(cluster n_RINPERSOONMa)
est sto SE_F1

esttab SE_short_F1  SE_F1 using Regression_SE.rtf, eform replace cells(b(star fmt(%9.3f)) ci(par) se(par)) starlevels(* 0.05 ** 0.01 *** 0.001) stats (r2_a N, fmt(%9.3f %9.0fc) labels("R-Squared" "Observation")) legend label collabels(none) varlabels (_cons Constant) note (Robust standard errors in parentheses ) title ({b\ Regression_SE})


********************************
**** Descriptive Statistics ****
********************************
gen sample_SE_F1 = e(sample)

graph bar if sample_SE_F1 ==1, over (ram_cat) by(muslim_CBS)

**** Muslim sample****
* Total sample
eststo total: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==1


* Treated group
eststo treated: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==1 & ram_cat_short == 1

* COntrol group
eststo control: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==1 & ram_cat_short == 0

* Probably NOT exposed
eststo probnot: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==1 & ram_cat_short == 2

esttab total treated control probnot using Descriptive_Statistics_SE_Muslim_F1.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==1 & probnot==0, by (ram_cat_short) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_short sp_edu male  if probnot==0 & sample_SE_F1 ==1 & muslim_CBS ==1, chi2



**** Non-Muslim sample****

* Total sample
eststo total: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==0


* Treated group
eststo treated: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==0 & ram_cat_short == 1

* COntrol group
eststo control: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==0 & ram_cat_short == 0

* Probably NOT exposed
eststo probnot: estpost summarize sp_edu male perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==0 & ram_cat_short == 2

esttab total treated control probnot using Descriptive_Statistics_SE_NonMuslim_F1.rtf, replace main(mean %6.2f) aux(sd %6.2f) label abs mtitle("Total Sample"  "Exposed" "Non-Exposed" "Probably NOT exposed" note() legend   collabels(none)  title ({\b Table 1.Muslims} {\Descriptive Statistics)})

*** Test of differences
** t-test for  continuous variables
eststo ttest: estpost ttest perc_income maternal_age edu_ma paternal_age  edu_pa   if sample_SE_F1 ==1 & muslim_CBS ==0 & probnot==0, by (ram_cat_short) 
esttab ttest using ttest.rtf, replace main(t  %6.2f) aux(sd %6.2f) label abs mtitle("Difference") legend collabels(none)  title ({\b Table1.ttest})

** Chi2-test for dummy variables
tab2 ram_cat_short sp_edu male  if probnot==0 & sample_SE_F1 ==1 & muslim_CBS ==0, chi2



