with complaint_location as (
    SELECT DISTINCT location_type, street_address,
    city, zip_code, borough,  cast(latitude as STRING) as latitude,
longitude
    FROM {{ref ('complaint_data')}}
)
select * from complaint_location
