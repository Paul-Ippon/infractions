{%- set source_model = "210_030_STG_ZONAGES_SUPRACOMMUNAUX" -%}
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
            codgeo::varchar(5) as codegeo,
            nom_de_la_commune::varchar(255) as nom_de_la_commune,
            code_departement::varchar(3) as code_departement,
            code_region::varchar(2) as code_region,
            code_arrondissement::varchar(4) as code_arrondissement,
            code_canton::varchar(5) as code_canton,
            code_epci::varchar(9) as code_epci,
            nature_epci::varchar(255) as nature_epci,
            ze::varchar(5) as ze,
            uu::varchar(5) as uu,
            tuu::varchar(255) as tuu,
            tduu::varchar(255) as tduu,
            uustatut::varchar(255) as uustatut,
            aav::varchar(3) as aav,
            taav::varchar(255) as taav,
            tdaav::varchar(255) as tdaav,
            cateaav::varchar(255) as cateaav,
            bv::varchar(5) as bv,
            typo_degre_densite::varchar(255) as typo_degre_densite
        from get_valid_data
    )
select *
from cast_data
