{% macro destroy_current_env() %}

    {% set sql -%}
        drop schema if exists {{ target.database }}.{{ target.schema }} cascade;
    {%- endset %}

    {{ dbt_utils.log_info("Dropping target schema.") }}

    {% do run_query(sql) %}

    {{ dbt_utils.log_info("Dropped target schema.") }}

{% endmacro %}