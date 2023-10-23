SELECT
    row_number() OVER () AS status_dim_id, *
FROM
    (SELECT DISTINCT status
    FROM {{ref ('complaint_data')}})