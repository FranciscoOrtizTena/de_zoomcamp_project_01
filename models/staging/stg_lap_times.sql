with 

source as (

    select * from {{ source('staging', 'lap_times') }}

),

renamed as (

    select
        raceid,
        driverid,
        lap,
        position,
        time,
        milliseconds

    from source

)

select * from renamed
