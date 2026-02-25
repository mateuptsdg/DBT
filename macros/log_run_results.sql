{% macro log_run_results(results) %}
  {% if execute %}
    {% for res in results %}
      insert into my_audit_schema.dbt_log (
        execution_id,
        model_name, 
        status, 
        execution_time, 
        run_at,
        run_by_user,
        profile_name
      )
      values (
        '{{ invocation_id }}',          
        '{{ res.node.name }}',
        '{{ res.status }}',
        {{ res.execution_time }},
        current_timestamp,
        '{{ target.user }}',              
        '{{ target.name }}'                
      );
    {% endfor %}
  {% endif %}
{% endmacro %}