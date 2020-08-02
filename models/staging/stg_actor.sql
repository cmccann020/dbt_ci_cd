with actor as (

    select * from {{ source('Sakila','actor') }}

)

select * from actor