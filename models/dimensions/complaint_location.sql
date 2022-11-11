/* this model create location dimension for the NYC 311 complaint data mart */
/* Notice: No SK was generated */
/* Missing values will be handled when the final Location Dimension is created */

{% set borough_map =
    {"MANHATTAN": "Manhattan", "BROOKLYN": "Brooklyn", "BRONX": "Bronx", "STATEN ISLAND": "Staten Island", "QUEENS": "Queens"} %}


with complaint_location as (
    SELECT DISTINCT location_type, street_address, 
    city, zip_code,   
    CASE borough
    {% for key, value in borough_map.items() %}
        WHEN '{{ key }}' THEN '{{ value }}'
    {% endfor %}
    END as borough,
    latitude,
longitude
    FROM {{ref ('complaint_data')}}
)
select * from complaint_location
