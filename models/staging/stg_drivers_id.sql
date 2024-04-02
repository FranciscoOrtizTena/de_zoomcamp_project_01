with 

source as (

    select * from {{ source('staging', 'drivers_id') }}

),

renamed as (

    select
        driverid,
        driverref,
        forename,
        surname,
        dob,
        nationality

    from source

)

select * from renamed
