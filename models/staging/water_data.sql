with water_data as
    (select
         /*{{ dbt_date.convert_timezone("sample_date", "America/New_York") }},*/
        {{ dbt_utils.split_part(string_text="sample_date", delimiter_text="'T'", part_number=1) }} as created_at,
        zipcode as zip_code,
        street_address,
        city,
        latitude,
        longitude,
        residual_free_chlorine_mg_l as residual_free_chlorine,
        fluoride_mg_l as fluoride,
        coliform_quanti_tray_mpn_100ml as coliform,
        e_coli_quanti_tray_mpn_100ml as e_coli,
        sample_site
    from {{ source('nyc_311_complaints', 'water_data_v2') }}
    WHERE latitude IS NOT NULL AND longitude IS NOT NULL
)
select * from water_data