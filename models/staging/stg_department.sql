with department as (

    select * from {{ source('Adventureworks','department') }}

)

select * from deparment