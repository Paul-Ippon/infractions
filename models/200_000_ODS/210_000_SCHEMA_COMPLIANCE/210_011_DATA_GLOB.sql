{%- set source_model = "210_010_STG_DATA_GLOB" -%}
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
            codgeo::varchar(5) as codgeo,
            annee::varchar(2) as annee,
            classe::varchar(255) as classe,
            unitedecompte::varchar(255) as unitedecompte,
            valeurpubliee::varchar(5) as valeurpubliee,
            faits::int as faits,
            tauxpourmille::double as tauxpourmille,
            complementinfoval::double as complementinfoval,
            complementinfotaux::double as complementinfotaux,
            pop::int as pop,
            millpop::tinyint as millpop,
            log::double as log,
            milllog::tinyint as milllog
        from get_valid_data
    )
select *
from cast_data
