{% macro generate_database_name(custom_database_name=none, node=none) -%}

{# /*

Custom override of the generate_database_name built into dbt.

If the target is prod then dbt will attempt to build models in that database.
Otherwise, dbt will attempt to build models in CLONE_<USER>_<PR_?>_PROD

*/ #}

{%- if target.name in ['prod','production'] -%}
    {{ target.database }}
{%- else -%}
    clone_{{ get_user() }}_{{ env_var('PR_NUMBER','' ) }}_{{ target.database }}
{%- endif -%}

{%- endmacro -%}