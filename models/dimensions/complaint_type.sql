SELECT 
    {{ dbt_utils.surrogate_key(['descriptor']) }} AS complaint_type_dim_id,
    complaint_type, descriptor
FROM  
   ( SELECT DISTINCT complaint_type, descriptor
     FROM {{ref ('complaint_data')}}
    )
