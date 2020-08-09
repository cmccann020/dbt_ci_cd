{% macro delete_temp_database() %}

{# /*

Deletes the target temporary database. CM change to reference target database so removing variable that didn't work for me

*/ #}

{% set delete_statement %}
drop database if exists {{ target.database }}
{% endset %}
{{ log('Running: ' ~ delete_statement, info=True) }}
{%- if target.name in ['prod','dev'] or '_' not in target.database -%}
    {{ exceptions.raise_compiler_error("Error - cannot delete database " ~ target.database) }}
{%- else -%}
    {% do run_query(delete_statement) %}
{%- endif -%}
{{ log("Done.", info=True) }}

{% endmacro %}