/* Turn on macro debugging options */
options mprint mlogic symbolgen;

/* Logging macro */
%macro log_msg(step=, msg=);
    %put NOTE: [STEP: &step.] - &msg.;
%mend;

/* Macro to generate claim reports */
%macro generate_claim_report(start_dt=, end_dt=, claim_status=ALL, product_line=ALL);

    %log_msg(step=Start, msg=Generating claims report from &start_dt. to &end_dt.);

    /* Create filtered dataset based on input parameters */
    data work.filtered_claims;
        set claims_data.main;
        where claim_date between "&start_dt."d and "&end_dt."d;

        %if %upcase(&claim_status.) ne ALL %then %do;
            if upcase(status) = "%upcase(&claim_status.)";
        %end;

        %if %upcase(&product_line.) ne ALL %then %do;
            if upcase(product_line) = "%upcase(&product_line.)";
        %end;
    run;

    %log_msg(step=Filter, msg=Filtering complete. Starting summary report...);

    /* Summary Report */
    proc sql;
        create table work.claim_summary as
        select product_line,
               status,
               count(*) as claim_count,
               sum(claim_amount) as total_amount
        from work.filtered_claims
        group by product_line, status;
    quit;

    %log_msg(step=Summary, msg=Summary table created. Writing report output...);

    /* Output the report using ODS */
    ods pdf file="&product_line._claims_report_&start_dt._to_&end_dt..pdf" style=journal;
    title "Claims Report from &start_dt. to &end_dt.";
    proc print data=work.claim_summary noobs;
    run;
    ods pdf close;

    %log_msg(step=Complete, msg=Report generated successfully!);

%mend;

%generate_claim_report(
    start_dt=01JAN2024,
    end_dt=31MAR2024,
    claim_status=APPROVED,
    product_line=MEDICAL
);