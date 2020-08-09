{% macro clone_database() %}

{ # /* 

Creates a clone of the target database. Default target is specified in the profiles.yml

*/ #}

{% set clone_statement %}
create or replace database {{ generate_database_name() }} clone {{ target.database }};
{% endset %}

{{ log('Running: ' ~ clone_statement, info=True) }}
{% do run_query(clone_statement) %}
{{ log("Done.", info=True) }}

{% endmacro %}