{%- set source_model = "210_080_STG_CITIES" -%}
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
            inseecode::varchar(5) as inseecode,
            citycode::varchar(255) as citycode,
            zipcode::varchar(5) as zipcode,
            label::varchar(255) as label,
            latitude::double as latitude,
            longitude::double as longitude,
            departmentname::varchar(255) as departmentname,
            departmentnumber::varchar(3) as departmentnumber,
            regionname::varchar(255) as regionname,
            regiongeojsonname::varchar(255) as regiongeojsonname
        from get_valid_data
    )
select *
from cast_data

