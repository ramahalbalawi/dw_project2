with water_dataset as (
    select * from {{ ref('water_data') }}
)
select e_coli, (case when e_coli = "<1" then "0" else e_coli end) as e_coli_transformed
from water_dataset