
with status_dim as ( 
select distinct status
from {{ source('nyc_311_complaints', 'nyc_311_water_complaints') }}
)
select row_number() over() as Status_Dim_ID, *
from status_dim