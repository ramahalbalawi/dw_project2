with water_locations as (
select distinct 
                longitude, 
                latitude,
                street_address, 
                city, 
                zip_code
from {{ref ('water_data')}}
)
select * from water_locations