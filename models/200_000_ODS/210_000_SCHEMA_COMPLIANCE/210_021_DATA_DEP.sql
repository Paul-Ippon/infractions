{%- set source_model = "210_020_STG_DATA_DEP" -%}
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
            classe::varchar(255) as classe,
            annee::varchar(2) as annee,
            codedepartement::varchar(3) as codedepartement,
            coderegion::varchar(2) as coderegion,
            unitedecompte::varchar(255) as unitedecompte,
            millpop::varchar(2) as millpop,
            milllog::varchar(2) as milllog,
            faits::int as faits,
            pop::int as pop,
            log::double as log,
            tauxpourmille::double as tauxpourmille
        from get_valid_data
    )
select *
from cast_data
