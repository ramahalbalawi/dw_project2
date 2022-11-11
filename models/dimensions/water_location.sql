with water_locations as (
select distinct 
                longitude, 
                latitude,
                street_address, 
				case
                when city like '%Bronx%' then 'Bronx'
				else city
				end as city,
                zip_code,
                sample_site
from {{ref ('water_data')}}
)
select * from water_locations
