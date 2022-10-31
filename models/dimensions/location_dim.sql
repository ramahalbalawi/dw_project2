with complaint_loc as(
    select * from {{ref('complaint_location')}}
),
water_loc as (
    select * from {{ref('water_location')}}
),
location_dim as (
    SELECT location_type,
    COALESCE(complaint_loc.street_address, water_loc.street_address) as street_address,
    COALESCE(complaint_loc.city, water_loc.city) as city,
    COALESCE(complaint_loc.zip_code, water_loc.zip_code) as zip_code,
    borough, 
    COALESCE(complaint_loc.latitude, water_loc.latitude) as latitude,
    COALESCE(complaint_loc.longitude, water_loc.longitude) as longitude
FROM complaint_loc
FULL JOIN water_loc
on complaint_loc.latitude=water_loc.latitude and
complaint_loc.longitude=water_loc.longitude
)

SELECT row_number() OVER () AS location_dim_id, *
from location_dim