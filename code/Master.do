/********************************************************************
Project: Ramadan during pregnancy and cognitive outcomes across generations

 Purpose: Master do-file for reproducing the analyses reported in
          the manuscript and Supplementary Material

 Authors: Van My Tran, Reyn van Ewijk, Fabienne Pradella

 Version: 1.0.0
 Date:    August 2026

 IMPORTANT:
 The analyses use restricted-access administrative microdata from
 Statistics Netherlands (CBS). The underlying microdata are not
 included in the public repository and can only be accessed within
 the secure CBS microdata environment.
********************************************************************/

version 18.0
clear all
macro drop _all

/********************************************************************
 1. DEFINE PROJECT DIRECTORIES
********************************************************************/

global Ramadan_CITO 1

if $Ramadan_CITO==1 {
	global data "$project\data"
	global code "$project\code"
	global output "$project\output"
}

capture log close 
log using "$output\master.txt",  text replace

/********************************************************************
 2. DATA AND SAMPLE CONSTRUCTION
********************************************************************/

do "$code\1. Ramadan_Exposure.do"

do "$code\2. Cito.do"

do "$code\3. Education & Income.do"

do "$code\4. Special Education.do"

do "$code\5. Data Merging_Project 2.do"


/********************************************************************
 3. F1 ANALYSES
********************************************************************/

do "$code\6. Results_Project 2.1.do"


/********************************************************************
 4. F2 ANALYSES
********************************************************************/

do "$code\6. Results_Project 2.2.do"

log close
