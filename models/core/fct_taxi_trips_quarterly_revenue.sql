{{
    config(
        materialized='table'
    )
}}

with trips_data as (
    select * from {{ ref('dim_taxi_trips') }}
),
quarterly_revenue as (
    select
        service_type,
        extract(year from pickup_datetime) as year,
        extract(quarter from pickup_datetime) as quarter,
        sum(total_amount) as revenue
    from trips_data
    where extract(year from pickup_datetime) in (2019, 2020)
    group by 1,2,3
),

yoy_growth as (
    select
        service_type,
        year,
        quarter,
        revenue,
        lag(revenue) over (partition by service_type, quarter order by year) AS prev_year_revenue,
        (revenue - lag(revenue) over (partition by service_type, quarter order by year)) / 
        NULLIF(lag(revenue) over (partition by service_type, quarter order by year), 0) AS yoy_growth
    from quarterly_revenue
)

select * from yoy_growth