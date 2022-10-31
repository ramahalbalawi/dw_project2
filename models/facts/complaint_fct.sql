with all_complaints as (
    select * from {{ ref('complaint_data') }}
),
agency as (
    select * from {{ ref('agency_dim') }}
  ),
complaint_type as (
    select * from {{ ref('complaint_type') }}
),
location as (
    select * from {{ ref('complaint_location') }}
),
dates as (
    select * from {{ ref('date_dim') }}
),
join_tbl as (
    select agency.agency_dim_id,
            complaint_type.complaint_type_dim_id,
            location.location_dim_id,
            dates.date_dim_id as date_dim_id,
    from all_complaints
    left join agency on all_complaints.agency = agency.agency
    left join complaint_type on all_complaints.complaint_type = complaint_type.complaint_type 
              AND all_complaints.descriptor = complaint_type.descriptor
    left join location on (all_complaints.location_type = location.location_type 
              or (all_complaints.location_type is null and location.location_type is null))
              AND (all_complaints.incident_address = location.street_address
              or (all_complaints.incident_address is null and location.street_address is null))
              AND (all_complaints.city = location.city 
              or (all_complaints.city is null and location.city is null))
              AND (all_complaints.zip_code = location.zip_code 
              or (all_complaints.zip_code is null and location.zip_code is null))
              AND (all_complaints.borough = location.borough 
              or (all_complaints.borough is null and location.borough is null))
              AND all_complaints.latitude = location.latitude
              AND all_complaints.longitude = location.longitude
    left join dates on all_complaints.created_date = dates.full_date
)
select *, count(*) as Number_of_Complaints
from joined
group by agency_dim_id, complaint_type_dim_id,
location_dim_id, date_dim_id