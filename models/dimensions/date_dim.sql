with dates_dim as
({{ dbt_utils.date_spine(
    datepart="day",
    start_date="cast('2016-01-01' as date)",
    end_date="cast(date_add(current_date(), INTERVAL 1 DAY) as date)" )
}})
select row_number() OVER () AS Date_Dim_ID, 
    CAST(date_day AS DATE) as Date_Value,
    EXTRACT(DAYOFWEEK from date_day) as Day_Of_Week,
    EXTRACT(DAY from date_day) as Day, 
    {{ dbt_date.month_name("date_day", short=false) }} as Month_Name,
    EXTRACT(YEAR from date_day) as Year,
    {{ dbt_date.day_name("date_day", short=false) }} as Day_Of_Week_Name
from dates_dim
order by 1