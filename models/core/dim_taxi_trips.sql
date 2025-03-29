{{
    config(
        materialized='table'
    )
}}

with green_tripdata as (
    select *,
        'Green' as service_type
    from {{ ref("stg_green_tripdata") }}
),
yellow_tripdata as (
    select *,
        'Yellow' as service_type
    from {{ ref('stg_yellow_tripdata') }}
),
trips_unioned as (
    select * from green_tripdata
    union all
    select * from yellow_tripdata
),
dim_zones as (
    select * from {{ ref('dim_zones') }}
    where borough != 'Unknown'
)
select tu.tripid, 
    tu.vendorid, 
    tu.service_type,
    tu.ratecodeid, 
    tu.pickup_locationid, 
    puz.borough as pickup_borough, 
    puz.zone as pickup_zone, 
    tu.dropoff_locationid,
    doz.borough as dropoff_borough, 
    doz.zone as dropoff_zone,  
    tu.pickup_datetime, 
    tu.dropoff_datetime, 
    tu.store_and_fwd_flag, 
    tu.passenger_count, 
    tu.trip_distance, 
    tu.trip_type, 
    tu.fare_amount, 
    tu.extra, 
    tu.mta_tax, 
    tu.tip_amount, 
    tu.tolls_amount, 
    tu.ehail_fee, 
    tu.improvement_surcharge, 
    tu.total_amount, 
    tu.payment_type, 
    tu.payment_type_description
from trips_unioned as tu
inner join dim_zones as puz
on tu.pickup_locationid = puz.locationid
inner join dim_zones as doz
on tu.dropoff_locationid = doz.locationid