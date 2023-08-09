{%- set source_model = "210_050_STG_CODE_LIBELLES" -%}
{%- set columns_in_relation = adapter.get_columns_in_relation(ref(source_model)) -%}


with
    get_source as (select * from {{ ref(source_model) }}),
    get_valid_data as (
        select *
        from get_source
        where
            {% for column in columns_in_relation -%}
                (
                    {{ column.name ~ "::VARCHAR" }} != '{{ var("err_value") }}'
                    or {{ column.name }} is null
                )
                {%- if not loop.last %} and {% endif -%}
            {% endfor %}
    ),
    cast_data as (
        select
            variable::varchar(32) as variable,
            code::varchar(2) as code,
            libelle::varchar(255) as libelle
        from get_valid_data
    )
select *
from cast_data
