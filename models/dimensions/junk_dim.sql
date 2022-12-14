with complaint_type as 
(
    select distinct complaint_type
     FROM {{ref ('complaint_data')}}
),
agency as(
    select distinct agency_name
    from {{ ref('complaint_data')}}
),
junk_dim as
(
    select * from complaint_type
    cross join agency
)
select row_number() OVER () AS junk_dim_id, *
from junk_dim