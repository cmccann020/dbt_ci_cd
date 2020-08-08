with department as (

    select * from {{ source('Adventureworks','deparment') }}

)

select * from deparment