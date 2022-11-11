with all_complaints as (
    select * from {{ ref('complaint_data') }}
),
agency as (
    select * from {{ ref('agency_dim') }}
  ),
complaint_type as (
    select * from {{ ref('complaint_type_dim') }}
),
dates as (
    select * from {{ ref('date_dim') }}
),
status as(
    select * from {{ ref('status_dim')}}
),
join_tbl as (
    select agency.agency_dim_id,
            complaint_type.complaint_type_dim_id,
            dates.date_dim_id as date_dim_id,
            status.status_dim_id as Status_Dim_ID
    from all_complaints
    left join agency on all_complaints.agency = agency.agency
    left join complaint_type on all_complaints.complaint_type = complaint_type.complaint_type 
              AND all_complaints.descriptor = complaint_type.descriptor
    left join dates on all_complaints.created_date = dates.full_date
    left join status on all_complaints.status = status.status
)
select *, count(*) as Number_of_Complaints
from join_tbl
group by agency_dim_id, complaint_type_dim_id, date_dim_id, Status_Dim_ID