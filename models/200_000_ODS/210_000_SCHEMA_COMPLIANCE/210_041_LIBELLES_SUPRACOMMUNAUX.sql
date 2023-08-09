{%- set source_model = "210_040_STG_LIBELLES_SUPRACOMMUNAUX" -%}
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
            nivgeo::varchar(7) as nivgeo,
            codgeo::varchar(9) as codgeo,
            libgeo::varchar(255) as libgeo,
            nb_com::smallint as nb_com
        from get_valid_data
    )
select *
from cast_data
