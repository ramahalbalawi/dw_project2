/* this model create the Agency Dimension for the NYC 311 complaint data mart */
/* SK is generated */
/* From Data Profiling, there are no missing values (and distinct would take care of it, if any) */
SELECT
    row_number() OVER () AS Agency_Dim_ID, *
FROM
    (SELECT DISTINCT agency as Agency, agency_name as Agency_Name /* notice how the attribute names start with Capital letters; this will make reports look better */
    FROM {{ref ('complaint_data')}})