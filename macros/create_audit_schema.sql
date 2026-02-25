{% macro create_audit_log_table() %}

    {% set audit_schema = 'my_audit_schema' %}
    {% set audit_table = 'dbt_log' %}
    create schema if not exists {{ audit_schema }};

    create table if not exists {{ audit_schema }}.{{ audit_table }} (
        execution_id     varchar(255),
        model_name       varchar(255),
        status           varchar(50),
        execution_time   float,
        run_at           timestamp,
        run_by_user      varchar(255),
        profile_name     varchar(255)
    );

    grant usage on schema {{ audit_schema }} to role DBT_TRANSFORMER_ROLE;
    grant insert, select on {{ audit_schema }}.{{ audit_table }} to role DBT_TRANSFORMER_ROLE;
    
    grant usage on schema {{ audit_schema }} to role BI_READER_ROLE;
    grant select on {{ audit_schema }}.{{ audit_table }} to role BI_READER_ROLE;

{% endmacro %}