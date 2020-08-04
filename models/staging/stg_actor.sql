with rename_for_testing as (

    select * from {{ source('Sakila','actor') }}

)

select * from rename_for_testing