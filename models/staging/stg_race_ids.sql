with 

source as (

    select * from {{ source('staging', 'race_ids') }}

),

renamed as (

    select
        raceid,
        year,
        round,
        circuitid,
        name,
        date,
        time

    from source

)

select * from renamed
