{% macro clone_prod_and_update_permissions(clone_db, role_to_own, schemas) -%}

    {%- if target.database == var('prod_db') -%}
        CREATE OR REPLACE TRANSIENT DATABASE {{clone_db}};
        GRANT ALL PRIVILEGES ON DATABASE {{clone_db}} TO ROLE {{role_to_own}};

        {% for schema_name in schemas %}
            {{clone_schema_from_prod(clone_db, var('prod_db'), schema_name, role_to_own)}}
        {% endfor %}

        USE DATABASE {{ target.database }};

    {%- else -%}
        SELECT 1

    {%- endif -%}

{%- endmacro %}{% macro clone_schema_from_prod(clone_db, prod_db, schema_name, role_to_own) -%}

    CREATE OR REPLACE TRANSIENT SCHEMA {{clone_db}}.{{generate_schema_name(schema_name)}} CLONE {{prod_db}}.{{schema_name}};
    GRANT ALL PRIVILEGES ON SCHEMA {{clone_db}}.{{generate_schema_name(schema_name)}} TO ROLE {{role_to_own}};
    GRANT OWNERSHIP ON ALL TABLES IN SCHEMA {{clone_db}}.{{generate_schema_name(schema_name)}} TO ROLE {{role_to_own}} REVOKE CURRENT GRANTS;
    GRANT OWNERSHIP ON ALL VIEWS IN SCHEMA {{clone_db}}.{{generate_schema_name(schema_name)}} TO ROLE {{role_to_own}} REVOKE CURRENT GRANTS;

{%- endmacro %}