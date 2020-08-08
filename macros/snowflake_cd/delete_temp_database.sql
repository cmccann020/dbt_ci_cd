{% macro delete_temp_database(temp_db_to_delete) %}

{# /*

Deletes the target temporary database

*/ #}

{% set delete_statement %}
drop database if exists {{ temp_db_to_delete }}
{% endset %}
{{ log('Running: ' ~ delete_statement, info=True) }}
{%- if temp_db_to_delete in ['test','raw','dev'] or '_' not in temp_db_to_delete -%}
    {{ exceptions.raise_compiler_error("Error - cannot delete database " ~ temp_db_to_delete) }}
{%- else -%}
    {% do run_query(delete_statement) %}
{%- endif -%}
{{ log("Done.", info=True) }}

{% endmacro %}