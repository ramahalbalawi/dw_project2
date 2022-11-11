/* This is Location Dimension that will be used in the SK pipeline for Fact table records */
/* Note: there are missing values in street address */
/* Note: We are using FULL (OUTER) JOIN */

with complaint_loc as(
    select * from {{ref('complaint_location')}}
),
water_loc as (
    select * from {{ref('water_location')}}
),
location_dim as (
    SELECT location_type as Location_Type,
    coalesce (sample_site, "Not Applicable") as Sample_Site,
    COALESCE(complaint_loc.street_address, water_loc.street_address) as Street_Address,
    COALESCE(complaint_loc.city, water_loc.city) as City,
    COALESCE(CAST(complaint_loc.zip_code as STRING), water_loc.zip_code) as Zip_Code,
    borough as Borough, 
    COALESCE(complaint_loc.latitude, water_loc.latitude) as Latitude,
    COALESCE(complaint_loc.longitude, water_loc.longitude) as Longitude
FROM complaint_loc
FULL JOIN water_loc
on complaint_loc.latitude=water_loc.latitude and
complaint_loc.longitude=water_loc.longitude
)

SELECT row_number() OVER () AS location_dim_id, *
from location_dim