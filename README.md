**SAS Healthcare Claims Reporting Project**
**Project Overview**
This SAS project focuses on analyzing healthcare claims data and generating monthly reports for stakeholders such as insurance analysts, compliance officers, and healthcare providers. The data includes claim transactions from patients processed by various providers.

The project demonstrates data ingestion, transformation, summarization, and report generation using Base SAS, PROC SQL, and ODS EXCEL.
**Data Description**
**Input File:** claims_data.csv
**Sample columns include:**
**Column Name**  	**Description**
claim_id	        Unique identifier for each claim
member_id	        Member (patient) ID
provider_id	      Provider's unique ID
claim_date	      Date the claim was submitted
claim_amount	    Amount billed in the claim
claim_status	    Status of the claim (Paid/Denied)

**Key Features**
•	Import raw CSV data using PROC IMPORT
•	Clean and format date fields for processing
•	Add derived fields like month and year
•	Generate multiple summary tables using PROC SQL
•	Export multi-sheet Excel report using ODS EXCEL
**Folder Structure**
**sas_claims_reporting/**
claims_data.csv           # Input dataset (sample)
claims_reporting.sas      # Main SAS program
claims_report.xlsx        # Output report (Excel)
**How to Run**
1.	Place claims_data.csv in your SAS working folder
2.	Open claims_reporting.sas in SAS Studio / Base SAS /SAS EG
3.	Update the file paths if needed
4.	Run the script to generate:
  - monthly_summary
  - provider_summary
  - denied_claims
  - claims_report.xlsx (with all 3 tables)

**Macro_Demo_CLaims_Report_Generator.sas code** automates the generation of healthcare claims summary reports using SAS macros. It demonstrates the use of parameterized macros, debugging techniques, conditional filtering, ODS reporting, and logging.

**Skills Highlighted**
•	Base SAS: DATA Step, INFILE, PROC IMPORT, FORMAT
•	SQL Processing: PROC SQL joins, groupings, and filters
•	Automation: Monthly metrics generation
•	Reporting: ODS EXCEL for multi-tab Excel export
* Dynamic filtering based on:
    Date range
    Claim status (e.g., APPROVED, DENIED, PENDING)
    Product line (e.g., MEDICAL, DENTAL)
* Logging framework for execution traceability
* PDF report output using ODS
* Macro-level debugging with MPRINT, MLOGIC, and SYMBOLGEN

**Use Case Scenarios**
•	Healthcare claim audits and compliance tracking
•	Provider performance monitoring
•	Insurance fraud detection (via denial patterns)
•	Trend reporting for executives

**Author**
Parthiban Kandavel
Advanced SAS Certified Programmer | Data Engineer (Python/Snowflake/DBT/Informatica/SAS/Control m/APache Airflow/Cloud)
LinkedIn: https://www.linkedin.com/in/parthi261728
GitHub: https://github.com/ParthibanKandavel
