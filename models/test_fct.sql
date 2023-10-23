with all_complaints as (
    select * from {{ ref('complaint_data') }}
),
agency as (
    select * from {{ ref('agency_dim') }}
  ),
complaint_type as (
    select * from {{ ref('complaint_type') }}
),
join_tbl as (
    select agency.agency_dim_id,
            complaint_type.complaint_type_dim_id
    from all_complaints
    left join agency on all_complaints.agency = agency.agency
    left join complaint_type on all_complaints.complaint_type = complaint_type.complaint_type 
              AND all_complaints.descriptor = complaint_type.descriptor
)
select *, count(*) as Number_of_Complaints
from join_tbl
group by agency_dim_id, complaint_type_dim_id
