with dates_dim as
({{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2022-10-10' as date)",
    end_date="cast(date_add(current_date(), INTERVAL 1 DAY) as date)" )
}})
select row_number() OVER () AS Date_Dim_ID, 
    date_day as Full_Date,
    EXTRACT(DAYOFWEEK from date_day) as Day_Of_Week,
    EXTRACT(DAY from date_day) as Day, 
    EXTRACT(MONTH from date_day) as Month, 
    EXTRACT(YEAR from date_day) as Year
from dates_dim
order by 1