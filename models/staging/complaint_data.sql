with complaints as 
    (select
        cast(created_date as date) as created_date,
        agency,
        agency_name,
        complaint_type,
        descriptor,
        location_type,
        incident_zip as zip_code,
        incident_address as street_address,
        city,
        borough,
        latitude,
        longitude,
        open_data_channel_type,
        status,
        unique_key
    from {{ source('nyc_311_complaints', 'nyc_311_water_complaints') }}
    WHERE latitude IS NOT NULL AND longitude IS NOT NULL
)
select * from complaints