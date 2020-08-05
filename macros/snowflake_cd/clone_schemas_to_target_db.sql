{% macro clone_schemas_to_target_db(source_db, target_db, schemas) -%}

    {%- if "{{target_db}}" != var('prod_db') -%}
        CREATE TRANSIENT DATABASE IF NOT EXISTS {{target.database}};
        {% for schema_name in schemas %}
            CREATE OR REPLACE TRANSIENT SCHEMA {{target.database}}.{{generate_schema_name(schema_name)}} CLONE {{source_db}}.{{schema_name}};
        {% endfor %}

    {%- else -%}
        CAREFUL! YOU RAN THE clone_schemas_to_target_db() macro AGAINST PROD -- FORCED ERROR

    {%- endif -%}

{%- endmacro %}