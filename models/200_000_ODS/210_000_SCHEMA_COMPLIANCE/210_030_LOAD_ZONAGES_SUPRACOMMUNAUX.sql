with
    get_source as (
        select *
        from {{ source("DSA_ZONAGES_SUPRACOMMUNAUX", "ZONAGES_SUPRACOMMUNAUX") }}
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
            ze2020::varchar(5) as ze2020,
            uu2020::varchar(5) as uu2020,
            tuu2017::varchar(255) as tuu2017,
            tduu2017::varchar(255) as tduu2017,
            uustatut2017::varchar(255) as uustatut2017,
            aav2020::varchar(3) as aav2020,
            taav2017::varchar(255) as taav2017,
            tdaav2017::varchar(255) as tdaav2017,
            cateaav2020::varchar(255) as cateaav2020,
            bv2012::varchar(5) as bv2012,
            typo_degre_densite::varchar(255) as typo_degre_densite
        from get_source
    )
select *
from cast_data
