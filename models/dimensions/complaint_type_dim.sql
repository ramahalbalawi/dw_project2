/* this model create the Complaint Type Dimension for the NYC 311 complaint data mart */
/* SK is generated */
/* From Data Profiling, there are no missing values (and distinct would take care of it, if any) */

SELECT 
    {{ dbt_utils.surrogate_key(['descriptor']) }} AS Complaint_Type_Dim_ID, *
FROM  
   ( SELECT DISTINCT complaint_type as Complaint_Type, descriptor as Descriptor
     FROM {{ref ('complaint_data')}}
    )
