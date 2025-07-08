/* Step 1: Import CSV File */
proc import datafile="/folders/myfolders/claims_data.csv"
    out=claims_data
    dbms=csv
    replace;
    guessingrows=1000;
run;

/* Step 2: Format Dates */
data claims_data_clean;
    set claims_data;
    claim_dt = input(put(claim_date, $10.), yymmdd10.);
    format claim_dt date9.;
run;

/* Step 3: Create Month and Year Columns */
data claims_with_month;
    set claims_data_clean;
    month = put(claim_dt, monyy7.);
run;

/* Step 4: Summary Report - Monthly Claims */
proc sql;
    create table monthly_summary as
    select 
        month,
        count(*) as total_claims,
        sum(claim_amount) as total_amount,
        mean(claim_amount) as avg_amount
    from claims_with_month
    group by month;
quit;

/* Step 5: Provider-level Summary */
proc sql;
    create table provider_summary as
    select 
        provider_id,
        month,
        count(*) as claim_count,
        sum(claim_amount) as total_claim_amt,
        mean(claim_amount) as avg_claim_amt
    from claims_with_month
    group by provider_id, month;
quit;

/* Step 6: Denied Claims Summary */
proc sql;
    create table denied_claims as
    select 
        month,
        count(*) as denied_count,
        sum(claim_amount) as denied_amt
    from claims_with_month
    where upcase(claim_status) = "DENIED"
    group by month;
quit;

/* Step 7: Generate Excel Report */
ods excel file="/folders/myfolders/claims_report.xlsx";

title "Monthly Claims Summary";
proc print data=monthly_summary; run;

title "Provider-wise Monthly Summary";
proc print data=provider_summary; run;

title "Denied Claims Monthly Summary";
proc print data=denied_claims; run;

ods excel close;