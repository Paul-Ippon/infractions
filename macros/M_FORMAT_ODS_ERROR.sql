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
                '{{ invocation_id }}' as runuuid,
                '{{ run_started_at.astimezone(modules.pytz.timezone("Europe/Paris")).strftime("%Y-%m-%d %H:%M:%S.%f") }}'::timestamp as runstartedat,
                '{{ modules.datetime.datetime.now().astimezone(modules.pytz.timezone("Europe/Paris")).strftime("%Y-%m-%d %H:%M:%S.%f")  }}'::timestamp as logtimeutc,
                '{{ source_model }}' as sourcemodel,
                object_construct(*) as data
            from detect_error
    {% endset %}

    {{ return(m_format_ods_error) }}

{% endmacro %}
