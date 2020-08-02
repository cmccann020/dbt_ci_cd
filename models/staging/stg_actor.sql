with actor as (

    select * from {{ source('sakila','actor') }}

)

select * from actor