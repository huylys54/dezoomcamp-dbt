{{
    config(
        materialized='table'
    )
}}

with fhv_tripdata as (
    select *
    from {{ ref("stg_fhv_tripdata") }}
),
dim_zones as (
    select *
    from {{ ref("dim_zones") }}
    where borough != 'Unknown'
)

select
    fhv.dispatching_base_num,
    fhv.pickup_datetime,
    fhv.dropoff_datetime,
    extract(year from fhv.pickup_datetime) as year,
    extract(month from fhv.pickup_datetime) as month,
    fhv.pulocationid,
    puz.borough as pickup_borough,
    puz.zone as pickup_zone,
    fhv.dolocationid,
    doz.borough as dropoff_borough,
    doz.zone as dropoff_zone,
    fhv.sr_flag,
    fhv.affiliated_base_number
from fhv_tripdata as fhv
inner join dim_zones as puz
on fhv.pulocationid = puz.locationid
inner join dim_zones as doz
on fhv.dolocationid = doz.locationid