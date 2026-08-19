# Ramadan_Pregnancy_Cognitive
Replication code for the study on Ramadan during pregnancy and offspring neurodevelopmental outcomes using restricted-access Dutch administrative data.

## Overview
This repository contains the statistical code used for the analyses
reported in: "Ramadan during pregnancy and cognitive outcomes across generations in a natural experiment using register data"

## Repository structure
- `code/`: Stata programs for data preparation and analysis
- `data/`: Data-access information; no microdata are included
- `output/`: Description of the tables and figures created by the code

## Data availability
The analyses use non-public microdata from Statistics Netherlands
(CBS). The microdata cannot be redistributed through this repository.

Under certain conditions, eligible research institutions can apply
for access through CBS Microdata Services

Results based on calculations by the Faculty of Law and Economics of Johannes Gutenberg University Mainz
using non-public microdata from Statistics Netherlands.

## Software requirements
The analyses were conducted using:
- Stata/MP 18
- Operating environment: CBS Remote Access environment

## Running the code
The programs should be executed in the following order:
1. `Master.do`: Runs the complete analytical workflow
2.  Data and sample construction
  - `1. Ramadan_Exposure.do`
  - `2. Cito.do`
  - `3. Education & Income.do`
  - `4. Special Education.do`
  - `5. Data Merging_Project 2.do`
3. `6. Results_Project 2.1.do`: F1 analyses
4. `6. Results_Project 2.2.do`: F2 analyses
    
## Reproducibility limitations
Because the underlying microdata are confidential and access-restricted,
the analyses cannot be executed using the repository alone. The repository
documents the complete analytical workflow but does not provide access to
the underlying data.


## Copyright
Copyright © 2026 Van Tran. All rights reserved.

No license is granted for the reuse, modification, or redistribution
of this code beyond the permissions provided by applicable law and
the GitHub Terms of Service. Please contact the author to request
permission.

## Funding and acknowledgements
This research was funded by the German Research Foundation (DFG), grant number 260639091

## Contact
Name: Reyn van Ewijk
Address: Jakob-Welder-Weg 4, 55128 Mainz, Germany
Phone number: +49 (0) 6131 / 39 - 24790
Email: vanewijk@uni-mainz.de 
