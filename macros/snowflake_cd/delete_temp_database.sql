{% macro delete_temp_database() %}

{# /*

Deletes the target temporary database. CM change to reference target database so removing variable that didn't work for me
Also changing to add generate database name as opposed to target.database so it doesn't reference dev

*/ #}

{% set delete_statement %}
drop database if exists {{ generate_database_name() }}
{% endset %}
{{ log('Running: ' ~ delete_statement, info=True) }}
{%- if target.name in ['prod'] or '_' not in {{ generate_database_name() }} -%}
    {{ exceptions.raise_compiler_error("Error - cannot delete database " ~ {{ generate_database_name() }}) }}
{%- else -%}
    {% do run_query(delete_statement) %}
{%- endif -%}
{{ log("Done.", info=True) }}

{% endmacro %}