{% macro m_format_ods_error(source_model) %}

    {% set m_format_ods_error %}
        with
            detect_error as (
                select *
                from {{ ref(source_model) }}
                where
                    {% for column in adapter.get_columns_in_relation(
                        ref(source_model)
                    ) -%}
                        {{ column.name ~ "::VARCHAR" }} = '{{ var("err_value") }}' {%- if not loop.last %} or {% endif -%}
                    {% endfor %}
            )
        select
            date_part(epoch, current_timestamp()) as logtimeutc,
            {{ "'" ~ source_model ~ "'" }} as targettablename,
            object_construct(*) as data
        from detect_error
    {% endset %}

    {% set results = dbt_utils.get_query_results_as_dict(m_format_ods_error) %}

    {% for key, value in results.items() %}
        {%- set var_not_used = results.update(
            {
                key: value
                | replace(",)", ")")
                | replace("(Decimal", "")
                | replace("'))", "')::timestamp")
            }
        ) -%}
        {{ value }} as {{ key }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}

    {{ return(results) }}

{% endmacro %}
