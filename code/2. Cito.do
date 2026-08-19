

clear all
set more off

* Restricted CBS CITO data directory
global cbs_cito "PATH_TO_CBS_CITO_DATA"

cd "$data\2. Cito"

****** CITO Score *******

*** Merging test scores from different years

** For year 2006
use "$cbs_cito\CITOTAB2006V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt CitoLeerlingGewicht2010 CitoThuistaal 

gen test_year = 2006
lab var test_year "Year of test"
save cito_2006, replace


** For year 2007
use "$cbs_cito\CITOTAB2007V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt CitoLeerlingGewicht2010 CitoThuistaal 

gen test_year = 2007
lab var test_year "Year of test"
save cito_2007, replace


** For year 2008
use "$cbs_cito\CITOTAB2008V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt CitoLeerlingGewicht2010 CitoThuistaal 

gen test_year = 2008
lab var test_year "Year of test"
save cito_2008, replace


** For year 2009
use "$cbs_cito\CITOTAB2009V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt CitoLeerlingGewicht2010 CitoThuistaal 

gen test_year = 2009
lab var test_year "Year of test"
save cito_2009, replace


** For year 2010
use "$cbs_cito\CITOTAB2010V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt CitoLeerlingGewicht2010 CitoThuistaal 

gen test_year = 2010
lab var test_year "Year of test"
save cito_2010, replace


** For year 2011
use "$cbs_cito\CITOTAB2011V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt CitoLeerlingGewicht2010 CitoThuistaal 

gen test_year = 2011
lab var test_year "Year of test"
save cito_2011, replace


** For year 2012
use "$cbs_cito\CITOTAB2012V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt CitoLeerlingGewicht2010 CitoThuistaal 

gen test_year = 2012
lab var test_year "Year of test"
save cito_2012, replace


** For year 2013
use "$cbs_cito\CITOTAB2013V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt  CitoThuistaal  CitoLeerlingGewicht 

gen test_year = 2013
lab var test_year "Year of test"
save cito_2013, replace


** For year 2014
use "$cbs_cito\CITOTAB2014V2.DTA", clear
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt  CitoThuistaal  CitoLeerlingGewicht 

gen test_year = 2014
lab var test_year "Year of test"
save cito_2014, replace

** For year 2015
use "$cbs_cito\CITOTAB2015V3.DTA", clear
rename rinpersoon RINPersoon
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt  CitoThuistaal  CitoLeerlingGewicht 

gen test_year = 2015
lab var test_year "Year of test"
save cito_2015, replace

** For year 2016
use "$cbs_cito\CITOTAB2016V3.DTA", clear
rename rinpersoon RINPersoon
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop  CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt  CitoThuistaal  CitoLeerlingGewicht CitoBasisonderwijs

gen test_year = 2016
lab var test_year "Year of test"
save cito_2016, replace

** For year 2017
use "$cbs_cito\CITOTAB2017V4.DTA", clear
rename rinpersoon RINPersoon
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop   CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt  CitoThuistaal CitoLeerlingGewicht  CitoBasisonderwijs

gen test_year = 2017
lab var test_year "Year of test"

duplicates tag RINPersoon , gen (dup)
drop if dup ==1
drop dup
save cito_2017, replace

** For year 2018
use "$cbs_cito\CITOTAB2018V5.DTA", clear
rename rinpersoon RINPersoon
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop   CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt  CitoThuistaal CitoLeerlingGewicht  CitoBasisonderwijs
rename CitoToetsVariant test_variant
lab var test_variant "Type of test"

gen test_year = 2018
lab var test_year "Year of test"
duplicates tag RINPersoon , gen (dup)
drop if dup == 1
drop dup
save cito_2018, replace

** For year 2019
use "$cbs_cito\CITOTAB2019V3.DTA", clear
rename rinpersoon RINPersoon
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop   CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo CITOBRIN_crypt  CitoThuistaal  CitoLeerlingGewicht  CitoBasisonderwijs
rename CitoToetsVariant test_variant
lab var test_variant "Type of test"

gen test_year = 2019
lab var test_year "Year of test"
save cito_2019, replace

** For year 2021
use "$cbs_cito\CITOTAB2021V1.DTA", clear
rename rinpersoon RINPersoon
drop if RINPersoon == ""

rename CitoScoreTaal language_score
lab var language_score "Number of correct answers for Language section (0-100)"
rename CitoPercentieltaal language_percentile
lab var language_percentile "Percentile score of Language section"
rename CitoZScoreTaal language_zscore
lab var language_zscore "Z-score of Language section"

rename CitoScoreRekenenWiskunde math_score
lab var math_score "Number of correct answers in Math (0-60)"
rename CitoPercentielRekenenWiskunde math_percentile
lab var math_percentile "Percentile score of Math"
rename CitoZScoreRekenenWiskunde math_zscore
lab var math_zscore "Z-score of Math"

rename CitoScoreStudieVaardigheden info_processing_score
lab var info_processing_score "Number of correct answers in Information Processing (0-40)"
rename CitoPercentielStudievaardigh info_processing_percentile
lab var info_processing_percentile "Percentile score of Information Processing"
rename CitoZScoreStudievaardigh info_processing_zscore
lab var info_processing_zscore "Z-score in Information Processing"

rename CitoScoreWereldorientatie world_score
lab var world_score "Number of correct answers in World Orientation (0-90)"
rename CitoPercentielWereldorientatie world_percentile
lab var world_percentile "Percentile score of World Orientation"

rename CitoScoreTotaalExclWereldo total_score
lab var total_score "Total of correct asnwers excl. World Orientation (0-200)"
rename CitoPercentielTotalExclWereldo total_percentile
lab var total_percentile "Total percentile score excl. World Orientation"

rename CitoStandaardScore standard_score
lab var standard_score "Standardized number of correct answers excl. World Orientation (501-550)"
rename CitoAdviesLeerkracht teacher_recommendation
lab var teacher_recommendation "Advice from teacher (before test)"
drop   CitoToetsID CitoScoreTotaalInclWereldo CitoPercentielTotalInclWereldo  CitoThuistaal  CitoLeerlingGewicht  CitoBasisonderwijs CitoBRIN_crypt
rename CitoToetsVariant test_variant
lab var test_variant "Type of test"

gen test_year = 2021
lab var test_year "Year of test"
save cito_2021, replace

use cito_2021, clear
merge 1:1 RINPersoon using cito_2019, nogen
merge 1:1 RINPersoon using cito_2018, nogen
merge 1:1 RINPersoon using cito_2017, nogen
merge 1:1 RINPersoon using cito_2016, nogen
merge 1:1 RINPersoon using cito_2015, nogen
merge 1:1 RINPersoon using cito_2014, nogen
merge 1:1 RINPersoon using cito_2013, nogen
merge 1:1 RINPersoon using cito_2012, nogen
merge 1:1 RINPersoon using cito_2011, nogen
merge 1:1 RINPersoon using cito_2010, nogen
merge 1:1 RINPersoon using cito_2009, nogen
merge 1:1 RINPersoon using cito_2008, nogen
merge 1:1 RINPersoon using cito_2007, nogen
merge 1:1 RINPersoon using cito_2006, nogen

rename RINPersoon rinpersoon
replace rinpersoons = RINPersoonS if rinpersoons ==""
replace rinpersoons = RINPersoons if rinpersoons ==""
drop RINPersoonS RINPersoons
drop CitoBasisonderwijs
sort test_year
save cito, replace

forvalues year = 2006/2019 {
	erase cito_`year'.dta
}

erase cito_2021.dta

